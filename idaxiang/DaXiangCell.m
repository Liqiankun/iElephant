//
//  DaXiangCell.m
//  idaxiang
//
//  Created by David on 15/9/6.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "DaXiangCell.h"

@implementation DaXiangCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.91f alpha:1.00f];
    _detailLab.textColor = [UIColor colorWithRed:0.64f green:0.64f blue:0.62f alpha:1.00f];
    _dateLab.textColor = [UIColor colorWithRed:0.64f green:0.64f blue:0.62f alpha:1.00f];
}

-(void)setModel:(DaXiangModel *)model
{
    _model = model;
    _titleLab.text = model.title;
    _dateLab.text = [[model.changed substringFromIndex:5] substringToIndex:5];
    _detailLab.text = model.summary;
    
}

@end
