//
//  PCECHomeView.h
//  Photocus
//
//  Created by zrz on 12-12-10.
//  Copyright (c) 2012年 Dingzai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTExpandContentView.h"

@interface EPECHomeView : MTExpandContentView

/**
 *  @param event 1,2,3
 */

@property (nonatomic, copy) void (^eventBlock)(EPECHomeView *sender, int event);

@end
