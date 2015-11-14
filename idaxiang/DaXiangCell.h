//
//  DaXiangCell.h
//  idaxiang
//
//  Created by David on 15/9/6.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaXiangModel.h"
@interface DaXiangCell : UITableViewCell
@property(nonatomic,strong)DaXiangModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end
