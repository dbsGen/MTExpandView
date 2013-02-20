//
//  EPViewController.m
//  ExtensionProject
//
//  Created by zrz on 13-2-17.
//  Copyright (c) 2013年 zrz(Gen). All rights reserved.
//

#import "EPViewController.h"
#import "MTExpandView.h"
#import "EPECHomeView.h"

@interface EPViewController ()

@end

@implementation EPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clicked:(UIButton *)sender
{
    CGRect frame = sender.frame;
    CGPoint p = [sender convertPoint:CGPointMake(frame.size.width / 2, frame.size.height + 2)
                            toView:self.view];
    
    
    MTExpandView *view = [[MTExpandView alloc] init];
    EPECHomeView *homeView = [[EPECHomeView alloc] init];
    view.contentView = homeView;
    
    __unsafe_unretained id exView = view;
    
    homeView.eventBlock = ^(id sender, int event){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Clicked %d", event]
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
        [exView miss];
    };
    
    [view showInView:self.view
             toPoint:p];
}

@end
