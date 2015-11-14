//
//  DaXiangModel.h
//  idaxiang
//
//  Created by David on 15/9/6.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#define __string(__name__) @property(nonatomic,copy)NSString *__name__;
@interface DaXiangModel : NSObject
__string(changed)
__string(nid)
__string(summary)
__string(title)
__string(username)
__string(useruid)
@end
