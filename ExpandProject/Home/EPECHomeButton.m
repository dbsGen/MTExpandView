//
//  PCECHomeButton.m
//  Photocus
//
//  Created by zrz on 12-12-12.
//  Copyright (c) 2012年 Dingzai. All rights reserved.
//

#import "EPECHomeButton.h"

@implementation EPECHomeButton {
    UIImageView *m_imageView;
    UILabel     *m_textLabel;
}

@synthesize imageView = m_imageView, titleLabel = m_textLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 60, 60)];
        [self addSubview:m_imageView];
        
        m_textLabel = [[UILabel  alloc] initWithFrame:CGRectMake(0,52,70,20)];
        m_textLabel.backgroundColor = [UIColor clearColor];
        m_textLabel.textColor = [UIColor whiteColor];
        m_textLabel.shadowColor = [UIColor blackColor];
        m_textLabel.shadowOffset = CGSizeMake(0, 1);
        [self insertSubview:m_textLabel belowSubview:m_imageView];
        m_textLabel.textAlignment = NSTextAlignmentCenter;
        m_textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return self;
}

@end
