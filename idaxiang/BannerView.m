//
//  BannerView.m
//  idaxiang
//
//  Created by David on 15/9/7.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "BannerView.h"
#import "DaXiangModel.h"
#import "UIImageView+WebCache.h"
@implementation BannerView

-(instancetype)initWithFrame:(CGRect)frame
{
   self =  [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        NSArray *imageArr = @[@"daOne",@"daTwo",@"daThree",@"daFour"];
        
        for (int i = 0; i < imageArr.count; i++){
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.frame = CGRectMake( i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            imageV.image = [UIImage imageNamed:imageArr[i]];
            imageV.userInteractionEnabled = YES;
            [_scrollView addSubview:imageV];
        }
        
        _scrollView.contentSize = CGSizeMake(imageArr.count * self.frame.size.width, self.frame.size.height);
        
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.delegate = self;
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.numberOfPages = imageArr.count;
        _pageControl.currentPage = 0;
        
        _pageControl.center = CGPointMake(self.center.x, self.frame.size.height * 19/ 20);
        
        
        
        [self addSubview:_scrollView];

        [self addSubview:_pageControl];

    }
    
    return self;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
    
    _pageControl.currentPage = index;
   
}

@end
