//
//  DaXiangNavigationController.m
//  idaxiang
//
//  Created by David on 15/9/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "DaXiangNavigationController.h"

@interface DaXiangNavigationController ()

@end

@implementation DaXiangNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
   
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count == 1)
    {
        [self setToolbarHidden:YES];
    }
    else
    {
        [self setToolbarHidden:NO];
    }
}

-(UIViewController*)popViewControllerAnimated:(BOOL)animated
{
    [super popViewControllerAnimated:animated];
       if (self.viewControllers.count == 1)
    {
        [self setToolbarHidden:YES];
    }
    else
    {
        [self setToolbarHidden:NO];
    }
    return self.viewControllers[0];

}

@end
