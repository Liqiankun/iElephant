//
//  URLConenctionManager.m
//  idaxiang
//
//  Created by David on 15/9/8.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "URLConenctionManager.h"
#import  "URLRequsetManager.h"
@implementation URLConenctionManager

-(void)getURL:(NSString*)url needCache:(BOOL)cache complete:(void(^)(BOOL success,NSData *data))callBack andView:(UIView *)view
{
    URLRequsetManager *rqsManager  = [URLRequsetManager shareManager];
    
    rqsManager.url = url;
    rqsManager.cache  = cache;
    rqsManager.callBack = callBack;
    
    [view addSubview:[rqsManager addLoadingView]];
    [rqsManager startRequset];
}
@end
