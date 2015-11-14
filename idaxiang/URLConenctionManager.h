//
//  URLConenctionManager.h
//  idaxiang
//
//  Created by David on 15/9/8.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DaXiangLoadingView.h"
@interface URLConenctionManager : NSObject
@property(nonatomic,strong)DaXiangLoadingView *loadingView;

-(void)getURL:(NSString*)url needCache:(BOOL)cache complete:(void(^)(BOOL success,NSData *data))callBack andView:(UIView*)view;
@end
