//
//  ScrollAdTableViewCell.h
//  ScrollAdTest
//
//  Created by 吴冬炀 on 2018/3/27.
//  Copyright © 2018年 吴冬炀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollImageTableViewCell : UITableViewCell
-(void)setTableView:(UITableView *)tableView andCellHeight:(float)height;
@property(nonatomic, strong)UIImageView *backgroundImageView;
-(void)refresh;

@end
