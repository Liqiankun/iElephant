 //
//  ViewController.m
//  idaxiang
//
//  Created by David on 15/9/6.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "ViewController.h"
#import "DaXiangModel.h"
#import "DaXiangCell.h"
#import "DetailViewController.h"
#import "UIView+Extension.h"
#import "BannerView.h"
#import "SideWinViewController.h"
#import "MJRefresh.h"
#define keyWinX [UIApplication sharedApplication].keyWindow.center.x
#define keyWin  self.navigationController.view.superview
#define currentWidth self.view.frame.size.width * 250 / 320
@interface ViewController ()<NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableData *_data;
    UIView *_loadingView;
    UIView *_centerLoadingView;
    UILabel *_loadingLab;
    UIActivityIndicatorView *_activity;
    BOOL _isShowing;
    UIView *_sideView;
    UIBarButtonItem *_leftItem;
    UISwipeGestureRecognizer *_leftSwipe,*_rightSwipe;
    BOOL _isRefreshing;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uiConfig];
    
    [self prepareData];
    
    [self PanGestureRecognizer];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f];
    
    NSNotificationCenter *notCenter = [NSNotificationCenter defaultCenter];
    
    [notCenter addObserver:self selector:@selector(notAction:) name:@"tongzhi" object:nil];
 
}




-(void)notAction:(NSNotification*)model
{
    if (_isShowing)
    {
        [self rightMoving];
    }

    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    detailVC.model = model.userInfo[@"model"];
    [self.navigationController pushViewController:detailVC animated:YES];
}



-(void)prepareData
{
   
    _dataArray = [[NSMutableArray  alloc] init];
    _data  = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://backend.idaxiang.org/api/views/articles_view?args%5B0%5D=all&args%5B1%5D=all&created=&created_1=&limit=0"];
    NSURLRequest *rqs = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:rqs delegate:self];
    
    if (!_isRefreshing)
    {
        [self dataUIConfig];
    }
    
    
}

-(void)uiConfig
{
    
    //设置navBar背景颜色
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.93f green:0.93f blue:0.91f alpha:1.00f]];
   
    UIImage *iamge = [UIImage imageNamed:@"title_background"];
     iamge = [iamge resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 50)];
    
    [self.navigationController.navigationBar setBackgroundImage:iamge forBarMetrics:UIBarMetricsDefault];
    
    CGRect frame = self.view.frame;
    frame.size.height -= 64;
    
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.91f alpha:1.00f];
    
    [self.view addSubview:_tableView];
    
    self.view.userInteractionEnabled = YES;
    
    
    
    //下拉刷新
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshControlAction)];
    
    
    //设置leftBarButtonItem
     UIImage *image =  [[UIImage imageNamed:@"Sidebar_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   _leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(itemAction:)];
   
 
    self.navigationItem.leftBarButtonItem = _leftItem;
    
     BannerView *headerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.width * 0.624)];
    headerView.userInteractionEnabled = YES;
    _tableView.tableHeaderView = headerView;
    
    //设置分隔线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor colorWithRed:0.80f green:0.81f blue:0.80f alpha:1.00f];    
    //sideView;
    _sideView = [[UIView alloc] initWithFrame:CGRectMake(-140, 0, 140, self.view.frame.size.height)];
    _sideView.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f];
    
    [self.view addSubview:_sideView];
  
}

/**
 *  下拉刷新
 */
-(void)refreshControlAction
{
    //当刷新的时候_tableView的用户交互为NO防止点击cell造成的程序崩溃
    _tableView.userInteractionEnabled = NO;
    
    //如果是_isRefreshing状态不添加loadingView
    _isRefreshing = YES;
    [self prepareData];
}



#pragma mark -- UIPanGestrueRecognizer
-(void)PanGestureRecognizer
{
    _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
    _leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
    _rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:_leftSwipe];
    
    [self.view addGestureRecognizer:_rightSwipe];
    
}

-(void)leftSwipe
{
    if (_isShowing)
    {
        [self rightMoving];
    }
}

-(void)rightSwipe
{
    if (!_isShowing)
    {
        [self leftMoving];
    }

}


#pragma mark -- UIBarButtonItemAction
-(void)itemAction:(UIBarButtonItem*)item
{
    if (!_isShowing)
    {
        
        
        [self leftMoving];
        //消息中心
        
        
        NSNotification *notCenter = [NSNotification notificationWithName:@"favAction" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification: notCenter];
        
    }
    else
    {
        [self rightMoving];
    }
    
}


/**
 *  leftMoving
 */

-(void)leftMoving
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        
        keyWin.transform = CGAffineTransformTranslate(keyWin.transform, currentWidth, 0);
        self.view.userInteractionEnabled = YES;
    }];
    _isShowing = YES;
}

/**
 *  rightMoving
 */

-(void)rightMoving
{
    [UIView animateWithDuration:0.5 animations:^{
        
        keyWin.transform = CGAffineTransformScale(keyWin.transform, 1.0, 1.0);
        keyWin.transform = CGAffineTransformTranslate(keyWin.transform, -currentWidth, 0);
        self.view.userInteractionEnabled = YES;
    }];
    _isShowing = NO;
}

-(void)dataUIConfig
{
    _loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
    _loadingView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.91f alpha:1.00f];
    [self.view addSubview:_loadingView];
    
    _centerLoadingView = [[UIView alloc] initWithFrame:CGRectMake(_loadingView.center.x - 75, _loadingView.center.y - 40, 150, 80)];
    _centerLoadingView.backgroundColor = [UIColor colorWithRed:0.19f green:0.19f blue:0.19f alpha:1.00f];
    
    _centerLoadingView.layer.cornerRadius = 8;
    
    [_loadingView addSubview:_centerLoadingView];
    
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    _activity.center = CGPointMake(_loadingView.center.x, _loadingView.center.y - 10);
    [_activity startAnimating];
    
    [_loadingView addSubview: _activity];
    
    _loadingView.userInteractionEnabled  = YES;
    _loadingLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, 150, 30)];
    _loadingLab.textAlignment = NSTextAlignmentCenter;
    _loadingLab.text = @"加载中";
    _loadingLab.font = [UIFont boldSystemFontOfSize:15];
    _loadingLab.textColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
    
    _leftItem.enabled = NO;
    
    [_centerLoadingView addSubview:_loadingLab];
}

#pragma mark -- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    DaXiangCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DaXiangCell" owner:self options:nil]lastObject];
    }
    
    cell.model = _dataArray[indexPath.row];
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    detailVC.model = _dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark -- NSURLConenctionDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _data.length = 0;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *dic in result) {

            DaXiangModel *model = [[DaXiangModel alloc] init];
            
            model.changed = dic[@"changed"];
            model.nid = dic[@"nid"];
            model.summary = dic[@"summary"];
            model.username = dic[@"username"];
            model.useruid = dic[@"userid"];
            model.title = dic[@"title"];
    
            [_dataArray addObject:model];
           
            
        }
        
        [_loadingView removeFromSuperview];
        _leftItem.enabled = YES;
    }
    //_isRefreshing回复成NO
    _isRefreshing = NO;
    //_tableView的用户交互设置成YES;
    _tableView.userInteractionEnabled = YES;
    //结束刷新转态
    [_tableView.header endRefreshing];
    [_tableView reloadData];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_activity stopAnimating];
    _activity.hidesWhenStopped = NO;
    _loadingLab.text = @"数据加载失败";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prepareData)];

    [_loadingView addGestureRecognizer:tap];
}


@end
