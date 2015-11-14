//
//  DetailViewController.m
//  idaxiang
//
//  Created by David on 15/9/6.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "DetailViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "FavManager.h"
#define currentWidth self.view.frame.size.width * 250 / 320
@interface DetailViewController ()<NSURLConnectionDataDelegate>
{
    UIWebView *_webView;
    NSMutableData *_data;
    NSString *_urlStr;
    CGFloat _cellHeight;
    UITableView *_tableView;
    NSString *_htmlStr;
    UIView *_headerView;
    UILabel *_titleTab;
    UILabel *_summaryTab;
    UIImageView *_toolBar;
    BOOL _hadFaved;
    UIBarButtonItem *_toolBarItemOne;
    NSString *_imageUrl;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
    
    [self uiConfig];
 
}

-(void)prepareData
{
    _urlStr =[NSString stringWithFormat:@"http://backend.idaxiang.org/api/views/articles_node?args%@5B0%@5D=%@",@"%",@"%",_model.nid];
    
    _data = [[NSMutableData alloc] init];
    NSURLRequest *rqs = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    

   [NSURLConnection connectionWithRequest:rqs delegate:self];
}

-(void)uiConfig
{
    UIImage *image =  [[UIImage imageNamed:@"backButton_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(itemAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _hadFaved = [[FavManager shareManager]modelExists:_model.nid];
    
    //UIWebVeiw
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 45)];
    _webView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.91f alpha:1.00f];
    [self.view addSubview:_webView];
    
    //设置toolBar的背景图片
    [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"toolBar"] forToolbarPosition:0 barMetrics:UIBarMetricsDefault];
    
    _toolBarItemOne = [UIBarButtonItem itemWithImage:_hadFaved? @"bookmarked_black":@"bookmark" andSelectedImage:nil andAction:@selector(favAction:) andTarget:self];
    
    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
  
    UIBarButtonItem *toolBarItemTwo = [UIBarButtonItem itemWithImage:@"shareButton" andSelectedImage:nil andAction:@selector(shareAction:) andTarget:self];
    
    UIBarButtonItem *toolBarItemThree = [UIBarButtonItem itemWithImage:@"fontSetting" andSelectedImage:@"fontSetting_black" andAction:@selector(fontAction:) andTarget:self];
    
    self.toolbarItems = @[_toolBarItemOne,spaceBarItem,toolBarItemThree,spaceBarItem,toolBarItemTwo];
 
}


#pragma mark -- UIBarButtonItemAction
-(void)favAction:(UIBarButtonItem*)item
{
    UIButton *button = (UIButton*)item;
    DaXiangModel *model = [[DaXiangModel alloc] init];
    model.nid = _model.nid;
    model.summary = _model.summary;
    model.title = _model.title;
    
    if (_hadFaved)
    {
        [[FavManager shareManager]deleteModel:model];
    }
    else
    {
        [[FavManager shareManager]savaModel:model];
    }
    _hadFaved = !_hadFaved;
    
    [button setImage:_hadFaved?[UIImage imageNamed:@"bookmarked_black"]:[UIImage imageNamed:@"bookmark" ] forState:UIControlStateNormal];
    
  
    
}

-(void)shareAction:(UIBarButtonItem*)item
{
    UIButton *button = (UIButton*)item;
    button.selected = !button.selected;
    
}

-(void)fontAction:(UIBarButtonItem*)item
{
    UIButton *button = (UIButton*)item;
    button.selected = !button.selected;
    
    _webView.backgroundColor = [UIColor redColor];
}

-(void)itemAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
            _htmlStr = dic[@"body"];
            _imageUrl = dic[@"mainimage"];
            NSString *headOne = [NSString stringWithFormat:@"<h1>%@</h1>",_model.title];

            //NSString *js2 = @"<style type='text/css'>img{width:%@px;height:%@px;} h1{ font-size:21px;} body{font-size:15px;} h2{font-size:18px;} .article-info{font-size:14px;}</style>";
            
            NSString *str = [NSString stringWithFormat:@"<style type='text/css'>img{width:%fpx;height:%fpx;} h1{ font-size:21px;} body{font-size:15px;} h2{font-size:18px;} .article-info{font-size:14px;}</style>",self.view.frame.size.width -10,(self.view.frame.size.width - 10) * 2/3];
        
            NSString *final = [headOne stringByAppendingString:_htmlStr];
            NSString *finalStr = [str stringByAppendingString:final];
            
            
            [_webView loadHTMLString:finalStr baseURL:nil];
   
        }
    }
  
    
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}
@end
