//
//  SideWinViewController.m
//  idaxiang
//
//  Created by David on 15/9/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "SideWinViewController.h"
#import "InfoViewController.h"
#import "FavManager.h"
#import "DaXiangCell.h"
#import "DaXiangModel.h"
#import "DetailViewController.h"
#import "UIView+Extension.h"
#define currentWidth  [UIApplication sharedApplication].keyWindow.width * 250 / 320

@interface SideWinViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation SideWinViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setFrame:CGRectMake(0, 0, currentWidth, self.view.frame.size.height)];
    [self prepareData];
    
    [self uiConfig];
    
    [self tableViewConfig];
    
   
  
    NSNotificationCenter *notCenter = [NSNotificationCenter defaultCenter];
    
    [notCenter addObserver:self selector:@selector(notAction) name:@"favAction" object:nil];

}

-(void)notAction
{
    [self prepareData];
    
    [_tableView reloadData];
}

-(void)prepareData
{
    _dataArray = [[FavManager shareManager]getAllModel];
}

-(void)tableViewConfig
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    frame.size.height -= 64;
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f];
    
    _tableView.bounces = NO;
    
    [self.view addSubview:_tableView];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    DaXiangCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DaXiangCell" owner:self options:nil]firstObject];
    }
  
    cell.model = _dataArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    DetailViewController *detailVC = [[DetailViewController alloc] init];
//    
//    detailVC.nid = [_dataArray[indexPath.row] nid];
//    detailVC.summary = [_dataArray[indexPath.row] summary];
//    detailVC.titleStr = [_dataArray[indexPath.row] title];
//    detailVC.model = _dataArray[indexPath.row];
//    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:_dataArray[indexPath.row],@"model", nil];
    
    NSNotification *notCenter = [NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
    
    [[NSNotificationCenter defaultCenter] postNotification: notCenter];
    
}


-(void)uiConfig
{
    
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, currentWidth, self.view.frame.size.height)];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ui_navigationbar_flag"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的收藏" style:UIBarButtonItemStylePlain target:nil action: nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.enabled  = NO;
    
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
    //[self.navigationController.navigationBar addSubview:setButton];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ui_navigationbar_flag"]];
    imageView.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    UILabel *favLab  = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 60, 30)];
    favLab.text  = @"我的收藏";
    favLab.textColor = [UIColor whiteColor];
    favLab.font = [UIFont systemFontOfSize:14];
    favLab.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:favLab];
    
    UIButton *setButton =[[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 40, 7, 30, 30)];
    [setButton addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    
    [setButton setBackgroundImage:[UIImage imageNamed:@"setting_normal"] forState:UIControlStateNormal];
    setButton.contentMode = UIViewContentModeScaleAspectFit;
    
    [imageView addSubview:setButton];
}


-(void)setAction
{
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    
    [self.navigationController pushViewController:infoVC animated:YES];
    
}

@end





