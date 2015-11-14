//
//  DaXiangLoadingView.m
//  idaxiang
//
//  Created by David on 15/9/8.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "DaXiangLoadingView.h"
#define MainWin [UIApplication sharedApplication].keyWindow
@implementation DaXiangLoadingView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.loadingView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:self.loadingView];
        
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = [UIColor colorWithRed:0.19f green:0.19f blue:0.19f alpha:1.00f];
        self.backView.layer.cornerRadius = 8;
        self.backView.frame = CGRectMake(self.center.x - 75, self.center.y - 40, 150, 80);
        [self addSubview:self.backView];
        
        
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activity.center = CGPointMake(self.center.x, self.center.y - 10);
        [self.activity startAnimating];
        [self addSubview:self.activity];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, 150, 30)];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.text = @"加载中";
        self.titleLab.font = [UIFont boldSystemFontOfSize:15];
        self.titleLab.textColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
        [self.backView addSubview:self.titleLab];
        
        
        
    }
    
    return self;
}

+(id)shareView
{
    static DaXiangLoadingView *_d = nil;
    if (!_d)
    {
        _d = [[DaXiangLoadingView alloc] initWithFrame:MainWin.frame];
    }
    return _d;
}


/**
 *  停下activity
 */
-(void)stopActivityView
{
    self.titleLab.text = @"数据加载失败";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
}
/**
 *  tapAction
 */
-(void)tapAction
{
    self.titleLab.text = @"加载中";
    if (_callBack)
    {
        _callBack();
    }
    
}

/**
 *  去掉loadingView
 */
-(void)removeLoadingView
{
    [self removeFromSuperview];
}

@end
