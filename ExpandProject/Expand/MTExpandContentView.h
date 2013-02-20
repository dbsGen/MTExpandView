//
//  PCExtentionContentView.h
//  Photocus
//
//  Created by zrz on 12-12-10.
//  Copyright (c) 2012年 Dingzai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTExpandContentView : UIView

- (void)openWithHeight:(CGFloat)height;
- (void)close;

@property (nonatomic, readonly) UIView  *contentView;

@end
