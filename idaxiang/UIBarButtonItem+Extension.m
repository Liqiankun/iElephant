//
//  UIBarButtonItem+Extension.m
//  idaxiang
//
//  Created by David on 15/9/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem*)itemWithImage:(NSString*)image andSelectedImage:(NSString*)selectedImage andAction:(SEL)action andTarget:(id)target
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    
    [button addTarget:target action:(SEL)action forControlEvents:UIControlEventTouchUpInside];
    
    CGSize size = button.currentBackgroundImage.size;
    
    button.frame = CGRectMake(0, 0, size.width, size.height);
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

//-(void)itemWithImage:(NSString*)image
//{
//    [self setImage: [UIImage imageNamed:image]];
//}



@end
