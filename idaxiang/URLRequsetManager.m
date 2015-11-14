//
//  URLRequsetManager.m
//  idaxiang
//
//  Created by David on 15/9/8.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "URLRequsetManager.h"
#import "DaXiangLoadingView.h"

@implementation URLRequsetManager

/**
 *  单例模式
 */
+(id)shareManager
{
    static URLRequsetManager *_u = nil;
    if (!_u)
    {
        _u = [[URLRequsetManager alloc] init];
    }
    
    return _u;
}

/**
 *  添加loadingView
 *
 *  @return DaXiangLoadingView
 */
-(DaXiangLoadingView*)addLoadingView
{
    
    return [DaXiangLoadingView shareView];
}

/**
 *  开始请求数据
 */
-(void)startRequset
{
    
    self.data  = [NSMutableData data];
    NSURL *url = [NSURL URLWithString:self.url];
    
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data.length = 0;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_callBack)
    {
        [[DaXiangLoadingView shareView] removeLoadingView];
        _callBack(YES,self.data);
    }
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_callBack)
    {
         [[DaXiangLoadingView shareView] stopActivityView];
        _callBack(NO,nil);
    }
}
@end










