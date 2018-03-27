//
//  ScrollAdTableViewCell.m
//  ScrollAdTest
//
//  Created by 吴冬炀 on 2018/3/27.
//  Copyright © 2018年 吴冬炀. All rights reserved.
//

#import "ScrollImageTableViewCell.h"

@interface ScrollImageTableViewCell()
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, assign)float cellWidth;
@property(nonatomic, assign)float cellHeight;
@end

@implementation ScrollImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:self.backgroundImageView];
        [self insertSubview:self.backgroundImageView atIndex:0];
        self.textLabel.textColor = [UIColor whiteColor];
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
//        [self.imageView setImage:[UIImage imageNamed:@"weyAD"]];
//        NSLog(@"image:%@", self.imageView.image);
        
        //self.backgroundColor = [UIColor greenColor];
        //self.imageView.alpha = 0.5f;
    }
    return self;
}
-(void)setTableView:(UITableView *)tableView andCellHeight:(float)height{
    self.tableView = tableView;
    self.cellHeight = height;
    self.cellWidth = tableView.frame.size.width;
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self resetImagePos];
}

-(void)dealloc{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}


-(void)resetImageSize{
    if (self.backgroundImageView.image) {
        CGSize size = self.backgroundImageView.image.size;
        float imageHeight = size.height/size.width * _cellWidth;
        [self.backgroundImageView setFrame:CGRectMake(0, 0, _cellWidth, MAX(imageHeight, self.cellHeight))];
        //NSLog(@"size:%f,%f", self.backgroundImageView.frame.size.width, self.backgroundImageView.frame.size.height);
    }
}
-(void)resetImagePos{
    float posScaling = (self.frame.origin.y - self.tableView.contentOffset.y) / (self.tableView.frame.size.height - self.cellHeight);
    //NSLog(@"posScaling:%f", posScaling);
    float imageViewY;
    imageViewY = - (self.backgroundImageView.frame.size.height - self.cellHeight) * posScaling;
    if (self.backgroundImageView.frame.size.height > self.tableView.frame.size.height) {
        if (posScaling < 0) {
            imageViewY = - (self.frame.origin.y - self.tableView.contentOffset.y);
        }else if (posScaling > 1){
            //imageViewY = -(cell.imageView.frame.size.height - cell.cellHeight) - (cell.frame.origin.y - tableView.contentOffset.y - (self.tableView.frame.size.height - cell.cellHeight));
            //imageViewY = -cell.imageView.frame.size.height - cell.frame.origin.y + tableView.contentOffset.y + self.tableView.frame.size.height;
            imageViewY = self.tableView.frame.size.height - self.backgroundImageView.frame.size.height - (self.frame.origin.y - self.tableView.contentOffset.y);
        }
    }
    [self.backgroundImageView setFrame:CGRectMake(0, imageViewY, self.backgroundImageView.frame.size.width, self.backgroundImageView.frame.size.height)];
}
-(void)refresh{
    [self resetImageSize];
    [self resetImagePos];
}

@end
