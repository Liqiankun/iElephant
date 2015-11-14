//
//  DaXiangLoadingView.h
//  idaxiang
//
//  Created by David on 15/9/8.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaXiangLoadingView : UIView
@property(nonatomic,strong)UIView *loadingView;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIActivityIndicatorView *activity;
@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,copy)void(^callBack)();

+(id)shareView;

/**
 *  停下activity
 */
-(void)stopActivityView;

/**
 *  去掉loadingView
 */
-(void)removeLoadingView;
@end
