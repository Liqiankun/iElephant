//
//  URLRequsetManager.h
//  idaxiang
//
//  Created by David on 15/9/8.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DaXiangLoadingView.h"
@interface URLRequsetManager : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,copy) void(^callBack)(BOOL success,NSData *data);
@property(nonatomic,copy)NSString *url;
@property(nonatomic,assign)BOOL cache;

@property(nonatomic,strong)NSMutableData *data;

@property(nonatomic,strong)DaXiangLoadingView *loadingView;
/**
 *  单例模式
 */
+(id)shareManager;

/**
 *  开始请求数据
 */
-(void)startRequset;


/**
 *  添加加载页面
 *
 *  @param view loadingView要加载的父视图
 */
-(DaXiangLoadingView*)addLoadingView;
@end
