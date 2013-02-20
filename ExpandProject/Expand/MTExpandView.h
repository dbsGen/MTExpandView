//
//  PCExtentionView.h
//  Photocus
//
//  Created by zrz on 12-12-10.
//  Copyright (c) 2012年 Dingzai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTExpandContentView.h"

@interface MTExpandView : UIView

- (void)showInView:(UIView *)view
           toPoint:(CGPoint)point;
- (void)miss;

@property (nonatomic, strong) MTExpandContentView *contentView;
@property (nonatomic, assign) CGFloat   heightless;

@end
