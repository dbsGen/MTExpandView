//
//  PCECHomeView.m
//  Photocus
//
//  Created by zrz on 12-12-10.
//  Copyright (c) 2012年 Dingzai. All rights reserved.
//

#import "EPECHomeView.h"
#import "EPECHomeButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation EPECHomeView {
    EPECHomeButton  *_photoButton,
                    *_albumButton,
                    *_textButton;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photoButton = [[EPECHomeButton alloc] initWithFrame:CGRectMake(22, 17, 60, 60)];
        _photoButton.imageView.image = [UIImage imageNamed:@"icon"];
        _photoButton.imageView.highlightedImage = [UIImage imageNamed:@"icon"];
        [_photoButton addTarget:self
                         action:@selector(photoClicked)
               forControlEvents:UIControlEventTouchUpInside];
        _photoButton.titleLabel.text = @"Photo";
        [self.contentView addSubview:_photoButton];
        
        _albumButton = [[EPECHomeButton alloc] initWithFrame:CGRectMake(128, 17, 60, 60)];
        _albumButton.imageView.image = [UIImage imageNamed:@"icon"];
        _albumButton.imageView.highlightedImage = [UIImage imageNamed:@"icon"];
        [_albumButton addTarget:self
                         action:@selector(albumClicked)
               forControlEvents:UIControlEventTouchUpInside];
        _albumButton.titleLabel.text = @"Import";
        [self.contentView addSubview:_albumButton];
        
        _textButton = [[EPECHomeButton alloc] initWithFrame:CGRectMake(236, 17, 60, 60)];
        _textButton.imageView.image = [UIImage imageNamed:@"icon"];
        _textButton.imageView.highlightedImage = [UIImage imageNamed:@"icon"];
        [_textButton addTarget:self
                        action:@selector(textClicked)
              forControlEvents:UIControlEventTouchUpInside];
        _textButton.titleLabel.text = @"Text";
        [self.contentView addSubview:_textButton];

    }
    return self;
}

- (void)photoClicked
{
    if (self.eventBlock) {
        self.eventBlock(self, 1);
    }
}

- (void)albumClicked
{
    if (self.eventBlock) {
        self.eventBlock(self, 2);
    }
}

- (void)textClicked
{
    if (self.eventBlock) {
        self.eventBlock(self, 3);
    }
}

- (void)openWithHeight:(CGFloat)height
{
    [super openWithHeight:height];
    
#define kAniamtionDuration 0.2
    
    CABasicAnimation *alphaAniamtion = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAniamtion.fromValue = [NSNumber numberWithFloat:0.5];
    alphaAniamtion.toValue = [NSNumber numberWithFloat:1];
    alphaAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    alphaAniamtion.duration = kAniamtionDuration;
    
    CATransform3D t08 = CATransform3DMakeScale(0.1, 0.1, 1);
    _albumButton.layer.transform = t08;
    _textButton.layer.transform = t08;
    _photoButton.layer.transform = t08;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = @[[NSValue valueWithCATransform3D:t08],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                        [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    animation.keyTimes = @[@0.0f, @0.4f, @1.0f];
    animation.duration = kAniamtionDuration;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[alphaAniamtion, animation];
    animationGroup.duration = kAniamtionDuration;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _photoButton.layer.transform = CATransform3DIdentity;
        [_photoButton.layer addAnimation:animationGroup
                                  forKey:@""];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            _albumButton.layer.transform = CATransform3DIdentity;
            [_albumButton.layer addAnimation:animationGroup
                                      forKey:@""];
        });
        
        
        dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
        dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
            _textButton.layer.transform = CATransform3DIdentity;
            [_textButton.layer addAnimation:animationGroup
                                     forKey:@""];
        });
    });
}

- (void)delayAnimation:(CAKeyframeAnimation *)aniamtion
{
    
}

@end
