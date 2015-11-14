//
//  UIBarButtonItem+Extension.h
//  idaxiang
//
//  Created by David on 15/9/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem*)itemWithImage:(NSString*)image andSelectedImage:(NSString*)selectedImage andAction:(SEL)action andTarget:(id)target;

//-(void)itemWithImage:(NSString*)image;

@end
