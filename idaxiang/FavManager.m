//
//  FavManager.m
//  idaxiang
//
//  Created by David on 15/9/9.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "FavManager.h"
#import "FMDatabase.h"
#import "DaXiangModel.h"
@implementation FavManager
{
    FMDatabase *_fmDB;
}
/**
 *  收藏管理单例模式
 */
+(id)shareManager
{
    static FavManager *_f = nil;
    if (!_f)
    {
        _f = [[FavManager alloc] init];

    }
    
    return _f;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        //创建存储路径
        NSString *path  = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"DaXaing"];
        
        _fmDB = [[FMDatabase alloc] initWithPath:path];
        
        BOOL success = [_fmDB open];
        
        if (success)
        {
            NSString *sql = @"create table if not exists DaXiangText(nid varchar(32),title varchar(128),summary varchar(500))";
            if (![_fmDB executeUpdate:sql])
            {
                NSLog(@"创建数据失败");
            }
        }
        
    }
    
    return self;
}


/**
 *  添加收藏
 */
-(void)savaModel:(DaXiangModel*)model
{
    NSString *sql = @"insert into DaXiangText(nid,title,summary)values(?,?,?)";
    BOOL success = [_fmDB executeUpdate:sql,model.nid,model.title,model.summary];
    if (success)
    {
        NSLog(@"收藏成功");
    }
}

/**
 *  取消收藏
 */
-(void)deleteModel:(DaXiangModel*)model
{
     NSString *sql = @"delete from DaXiangText where nid=?";
    BOOL success = [_fmDB executeUpdate:sql,model.nid];
    if (success)
    {
        NSLog(@"删除成功");
    }
    
}
/**
 *  判断收藏是否存在
 */
-(BOOL)modelExists:(id)name
{
    NSString *nidStr;
    
    if ([name isKindOfClass:[DaXiangModel class]])
    {
        nidStr = [(DaXiangModel*)name nid];
    }
    else
    {
        nidStr = name;
    }
    
    NSString *sql = @"select * from DaXiangText where nid=?";
    FMResultSet *result = [_fmDB executeQuery:sql,nidStr];
    return [result next];
    
    return YES;
}


/**
 *  得到所有收藏
 */
-(NSMutableArray*)getAllModel
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSString *sql = @"select * from DaXiangText";
    FMResultSet *result = [_fmDB executeQuery:sql];
    while ([result next])
    {
        NSString *nidStr = [result stringForColumn:@"nid"];
        NSString *titleStr = [result stringForColumn:@"title"];
        NSString *summaryStr = [result stringForColumn:@"summary"];
        
        DaXiangModel *model = [[DaXiangModel alloc] init];
        
        model.nid = nidStr;
        model.title = titleStr;
        model.summary = summaryStr;
        
        [arr addObject:model];
    }
    
    
    return arr;
    
}


//nid
//summary
//titleStr
@end
