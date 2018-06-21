//
//  ScrollAdTableViewCell.h
//  ScrollAdTest
//
//  Created by 吴冬炀 on 2018/3/27.
//  Copyright © 2018年 吴冬炀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollImageTableViewCell : UITableViewCell
@property(nonatomic, weak) UITableView *tableView;//创建时必须指定所属tableview，用来位置计算。
@property(nonatomic, strong)UIImageView *backgroundImageView;
-(void)refresh;//在更新图片时调用

@end
