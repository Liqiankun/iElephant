//
//  FavManager.h
//  idaxiang
//
//  Created by David on 15/9/9.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaXiangModel;
@interface FavManager : UIButton

+(id)shareManager;

-(void)savaModel:(DaXiangModel*)model;

-(void)deleteModel:(DaXiangModel*)model;

-(BOOL)modelExists:(id)name;

-(NSMutableArray*)getAllModel;

@end
