//
//  PCExtentionContentView.m
//  Photocus
//
//  Created by zrz on 12-12-10.
//  Copyright (c) 2012年 Dingzai. All rights reserved.
//

#import "MTExpandContentView.h"
#import <QuartzCore/QuartzCore.h>
#import "MTGradientView.h"
#import "UIView+Ex.h"

#define kShadowLength   20.0f

@implementation MTExpandContentView {
    MTGradientView  *_upShadowLayer,
                    *_downShadowLayer;
    UIButton        *_control;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_contentView];
        
        _upShadowLayer = [[MTGradientView alloc] init];
        _upShadowLayer.gradientLayer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.7].CGColor,
                                    (id)[UIColor clearColor].CGColor];
        _upShadowLayer.gradientLayer.startPoint = CGPointMake(0, 0.0f);
        _upShadowLayer.gradientLayer.endPoint = CGPointMake(0, 1.0f);
        [self addSubview:_upShadowLayer];
        
        _downShadowLayer = [[MTGradientView alloc] init];
        _downShadowLayer.gradientLayer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.7].CGColor,
                                    (id)[UIColor clearColor].CGColor];
        _downShadowLayer.gradientLayer.startPoint = CGPointMake(.5f, 1.0f);
        _downShadowLayer.gradientLayer.endPoint = CGPointMake(.5f, 0.0f);
        [self addSubview:_downShadowLayer];
        
        _upShadowLayer.frame = CGRectMake(0, 0, frame.size.width, kShadowLength);
        _downShadowLayer.frame = CGRectMake(0, frame.size.height - kShadowLength,
                                            frame.size.width, kShadowLength);
        
        _control = [[UIButton alloc] initWithFrame:self.bounds];
        [_contentView addSubview:_control];
        [_control addTarget:self
                     action:@selector(bgClicked)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _control.frame = _contentView.frame = self.bounds;
    _upShadowLayer.frame = CGRectMake(0, 0, frame.size.width, kShadowLength);
    _downShadowLayer.frame = CGRectMake(0, frame.size.height - kShadowLength,
                                        frame.size.width, kShadowLength);
}

- (void)openWithHeight:(CGFloat)height
{
    _downShadowLayer.y = height - kShadowLength;
}

- (void)close
{
    _downShadowLayer.y = - kShadowLength;
}

- (void)bgClicked
{
    NSLog(@"ASS ♂YOU ♂CAN");
}

@end
