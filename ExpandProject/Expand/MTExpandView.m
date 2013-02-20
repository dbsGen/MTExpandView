//
//  PCExtentionView.m
//  Photocus
//
//  Created by zrz on 12-12-10.
//  Copyright (c) 2012年 Dingzai. All rights reserved.
//

#import "MTExpandView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Ex.h"

@implementation MTExpandView {
    UIImageView *_upView;
    UIImageView *_downView,
                *_downCover;
    UIView      *_bottomView;
    CAShapeLayer        *_upMaskLayer, *_downMaskLayer;
    CGMutablePathRef    _startPath, _endPath;
    CGFloat     _top;
    UIView      *_tapView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor grayColor];
        _tapView = [[UIView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(miss)];
        [_tapView addGestureRecognizer:tap];
        [self addSubview:_tapView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _tapView.frame = self.bounds;
}

- (void)mackMaskLayerWith:(UIView *)view point:(CGPoint)point
{
    CGRect bounds = view.bounds;
    _upMaskLayer = [[CAShapeLayer alloc] init];
    _upMaskLayer.frame = CGRectMake(0, 0, bounds.size.width, point.y + 9);
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint ps[7];
    ps[0] = CGPointMake(0, 0);
    ps[1] = CGPointMake(bounds.size.width, 0);
    ps[2] = CGPointMake(bounds.size.width, point.y + 9);
    ps[3] = CGPointMake(point.x + 6, point.y + 9);
    ps[4] = CGPointMake(point.x, point.y + 3.5);
    ps[5] = CGPointMake(point.x - 6, point.y + 9);
    ps[6] = CGPointMake(0, point.y + 9);
    
    CGPathAddLines(path, NULL, ps, 7);
    _upMaskLayer.path = path;
    CGPathRelease(path);
    _upMaskLayer.fillColor = [UIColor blackColor].CGColor;
    
    _downMaskLayer = [[CAShapeLayer alloc] init];
    _downMaskLayer.frame = bounds;
    
    _startPath = CGPathCreateMutable();
    
    ps[0] = CGPointMake(0, point.y + 9);
    ps[1] = CGPointMake(point.x - 6, point.y + 9);
    ps[2] = CGPointMake(point.x, point.y + 3.5);
    ps[3] = CGPointMake(point.x + 6, point.y + 9);
    ps[4] = CGPointMake(bounds.size.width, point.y + 9);
    ps[5] = CGPointMake(bounds.size.width, bounds.size.height);
    ps[6] = CGPointMake(0, bounds.size.height);
    CGPathAddLines(_startPath, NULL, ps, 7);
    
    
    _endPath = CGPathCreateMutable();
    
    ps[0] = CGPointMake(0, point.y + 9);
    ps[1] = CGPointMake(point.x - 6, point.y + 9);
    ps[2] = CGPointMake(point.x, point.y + 9);
    ps[3] = CGPointMake(point.x + 6, point.y + 9);
    ps[4] = CGPointMake(bounds.size.width, point.y + 9);
    ps[5] = CGPointMake(bounds.size.width, bounds.size.height);
    ps[6] = CGPointMake(0, bounds.size.height);
    CGPathAddLines(_endPath, NULL, ps, 7);
    
    _downMaskLayer.path = _startPath;
    _downMaskLayer.fillColor = [UIColor blackColor].CGColor;
}

- (void)dealloc
{
    if (_startPath)CGPathRelease(_startPath);
    if (_endPath)CGPathRelease(_endPath);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)showInView:(UIView *)view toPoint:(CGPoint)point
{
    CGRect bounds = view.bounds;
    if (!_heightless) {
        _heightless = bounds.size.height;
    }
    self.frame = bounds;
    CGFloat top = point.y + 3;
    _top = top;
    if (!_downView) {
        _downView = [[UIImageView alloc] init];
        [self addSubview:_downView];
    }
    _downView.frame = bounds;
    
    if (!_upView) {
        _upView = [[UIImageView alloc] init];
        [self addSubview:_upView];
    }
    _upView.frame = bounds;
    if (!_downCover) {
        _downCover = [[UIImageView alloc] init];
        _downCover.backgroundColor = [UIColor whiteColor];
    }
    _downCover.frame = _downView.frame;
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self addSubview:_bottomView];
        _bottomView.userInteractionEnabled = NO;
    }
    _bottomView.frame = bounds;
    [_bottomView addSubview:_downView];
    [_bottomView addSubview:_downCover];
    
    [self makeButtonViewWithView:view below:top];
//    self.alpha = 0;
    _downCover.alpha = 0;
    [view addSubview:self];
    [self mackMaskLayerWith:view point:point];
    _upView.layer.mask = _upMaskLayer;
    _bottomView.layer.mask = _downMaskLayer;
    
    [self insertSubview:self.contentView
           aboveSubview:_tapView];
    [self.contentView close];
    self.contentView.frame = CGRectMake(0, _top, bounds.size.width, 120);
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationCurveEaseIn
                     animations:^
     {
         if (_top + 130 > bounds.size.height) {
             self.contentView.frame = CGRectMake(0, _heightless - 110, bounds.size.width, 120);
             _upView.y = _heightless - _top - 110;
             _bottomView.y = _heightless - _top - 10;
         }else {
             self.contentView.frame = CGRectMake(0, _top, bounds.size.width, 120);
             _bottomView.y = 100;
         }
         [self.contentView openWithHeight:110];
         _downCover.alpha = 0.5;
     } completion:nil];
    CABasicAnimation *transition = [CABasicAnimation animationWithKeyPath:@"path"];
    _downMaskLayer.path = _endPath;
    transition.fromValue = (__bridge id)(_startPath);
    transition.toValue = (__bridge id)(_endPath);
    transition.duration = 0.25;
    [_downMaskLayer addAnimation:transition
                          forKey:@""];
}

- (void)makeButtonViewWithView:(UIView *)view below:(CGFloat)top
{
    CGRect bounds = view.bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 scale * bounds.size.width,
                                                 scale * bounds.size.height,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedFirst);
    CGContextScaleCTM(context, 1*scale, -1*scale);
    CGContextTranslateCTM(context, 0, -bounds.size.height);
    [view.layer renderInContext:context];
    CGImageRef cgimage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage:cgimage
                                         scale:scale
                                   orientation:UIImageOrientationUp];
    
    _upView.image = image;
    _downView.image = image;
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cgimage);
    
    //_downCover.image = [_downView.image adjust:1 g:1 b:1];
}

- (void)miss
{
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationCurveEaseIn
                     animations:^
     {
         _upView.y = 0;
         _bottomView.y = 0;
         _downCover.alpha = 0;
         self.contentView.frame = CGRectMake(0, _top, self.bounds.size.width, 120);
         [self.contentView close];
     } completion:^(BOOL finished) {
         [self removeFromSuperview];
     }];
    CABasicAnimation *transition = [CABasicAnimation animationWithKeyPath:@"path"];
    _downMaskLayer.path = _startPath;
    transition.fromValue = (__bridge id)(_endPath);
    transition.toValue = (__bridge id)(_startPath);
    transition.duration = 0.25;
    [_downMaskLayer addAnimation:transition
                          forKey:@""];
}

@end
