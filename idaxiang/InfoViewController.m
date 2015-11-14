//
//  InfoViewController.m
//  idaxiang
//
//  Created by David on 15/9/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "InfoViewController.h"
#import "UIView+Extension.h"
#define  viewWidth [UIApplication sharedApplication].keyWindow.width * 250 / 320
@interface InfoViewController ()<UIAlertViewDelegate>
{
    NSInteger _currentPage;
    UISlider *_slider;
    UILabel *_cacheLab;
}
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view setFrame:CGRectMake(0, 0, viewWidth, self.view.frame.size.height)];
    self.view.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ui_navigationbar_flag"]];
    imageView.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);
    [self.view addSubview:imageView];
   
    imageView.userInteractionEnabled = YES;
    
    UIButton *backButton =[[UIButton alloc] initWithFrame:CGRectMake(10, 7, 30, 30)];
    [backButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton setBackgroundImage:[[UIImage imageNamed:@"backButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    backButton.contentMode = UIViewContentModeScaleAspectFit;
    [imageView addSubview:backButton];
    
    UIButton *button;
    NSArray *imageArray = @[@"active-setting_cell-1", @"active-setting_cell-2",@"active-setting_cell-3"];
    NSArray *titleArray = @[@"电子邮件",@"微信公众号",@"大象官方微博"];
    for (int i = 0; i < imageArray.count; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        CGSize size = button.currentBackgroundImage.size;
        button.frame = CGRectMake(0, 180 + i * size.height , size.width, size.height);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.64f green:0.64f blue:0.64f alpha:1.00f] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        button.centerX = viewWidth * 0.5 ;
    }
  
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 155,100, 20)];
    lab.text = @"联系我们";
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f];
    [self.view addSubview:lab];
    
    lab.x = CGRectGetMinX(button.frame);
    
    UILabel *setLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 20)];
    setLab.text = @"系统设置";
    setLab.x = CGRectGetMinX(button.frame);
    setLab.font = [UIFont systemFontOfSize:14];
    setLab.textColor = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f];
    [self.view addSubview:setLab];
    
    UIImageView *setView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting-cell"]];
    
    CGSize cellSize = setView.image.size;
    setView.frame = CGRectMake(10, 95, cellSize.width, cellSize.height);
    setView.userInteractionEnabled = YES;
    [self.view addSubview:setView];
    
    setView.centerX = button.centerX;
    
    //setView里边的lab和button
   _cacheLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, cellSize.height - 10)];
    
    _cacheLab.text = [NSString stringWithFormat:@"缓存大小:%dKB",arc4random()/250 %250];
    _cacheLab.font = [UIFont systemFontOfSize:13];
    _cacheLab.textColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    
    [setView addSubview:_cacheLab];
    
    
    UIButton *deleteButton = [[UIButton alloc] init];
    deleteButton.frame = CGRectMake(cellSize.width - 10 - 60, 10, 60, cellSize.height - 20);
    [deleteButton setTitle: @"清除缓存" forState:UIControlStateNormal];
    deleteButton.titleLabel.textColor = [UIColor colorWithRed:0.38f green:0.38f blue:0.38f alpha:1.00f];
    deleteButton.backgroundColor = [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:1.00f];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:13];
    deleteButton.layer.cornerRadius = 8;
    
    [deleteButton addTarget:self action:@selector(deleteCache) forControlEvents:UIControlEventTouchUpInside];
    [setView addSubview:deleteButton];
    
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLab.text = @"设置中心";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.center = CGPointMake(imageView.center.x, 22);
    titleLab.textColor = [UIColor colorWithRed:0.92f green:0.89f blue:0.89f alpha:1.00f];
    [imageView addSubview:titleLab];
}

-(void)deleteCache
{
    [self performSelector:@selector(deleteCacheData) withObject:nil afterDelay:0.5];
}

-(void)deleteCacheData
{
    _cacheLab.text =  @"缓存大小:0KB";
}

-(void)buttonAction:(UIButton*)button
{
    NSInteger index = button.tag - 100;
    
    
    
    _currentPage = index;
    
    NSArray *titleArray = @[@"电子邮件地址",@"微信账号",@"新浪微博"];
    NSArray *detailArray = @[@"发送邮件给大象公会，交流你对文章的看法",@"在微信中搜索大象公会，关注大象公会公众号",@"关注大象公会的微博账号"];
    NSArray *copyArray = @[@"复制邮箱地址",@"复制微信号",@"复制微博号"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titleArray[index] message:detailArray[index] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:copyArray[index], nil];
    [alertView show];
}


#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *arr = @[@"info@idaxiang.org",@"大象公会",@"大象公会"];
    if (buttonIndex == 1)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = arr[_currentPage];
    }
    
}



-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
