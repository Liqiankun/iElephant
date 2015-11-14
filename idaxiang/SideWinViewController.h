//
//  SideWinViewController.h
//  idaxiang
//
//  Created by David on 15/9/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaXiangModel;
@interface SideWinViewController : UIViewController
@property(nonatomic,assign) void(^callBack)(DaXiangModel *model);
@end
