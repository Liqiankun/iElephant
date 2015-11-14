//
//  DetailViewController.h
//  idaxiang
//
//  Created by David on 15/9/6.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaXiangModel.h"
@interface DetailViewController : UIViewController
@property(nonatomic,copy)NSString *nid;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,strong)DaXiangModel *model;
@end
