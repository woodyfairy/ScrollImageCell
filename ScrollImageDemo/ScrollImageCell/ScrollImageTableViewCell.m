//
//  ScrollAdTableViewCell.m
//  ScrollAdTest
//
//  Created by 吴冬炀 on 2018/3/27.
//  Copyright © 2018年 吴冬炀. All rights reserved.
//

#import "ScrollImageTableViewCell.h"

@interface ScrollImageTableViewCell()
//@property(nonatomic, assign)float cellWidth;
//@property(nonatomic, assign)float cellHeight;
@property(nonatomic, assign) BOOL addedObserver;//防止重复添加Observer
@end

@implementation ScrollImageTableViewCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//}
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
        
        _addedObserver = NO;
    }
    return self;
}
-(void)setTableView:(UITableView *)tableView{
    if (_addedObserver) {
        [_tableView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _tableView = tableView;//绑定所属tableview
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
    _addedObserver = YES;
}
-(float)cellHeight{
    return self.frame.size.height;//实时获取高度，防止重用cell或者重设高度导致的变化
}
-(float)cellWidth{
    return self.frame.size.width;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self resetImagePos];
}

-(void)dealloc{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];//销毁时去掉监听
}

-(void)resetImageSize{
    if (self.backgroundImageView.image) {
        CGSize size = self.backgroundImageView.image.size;
        float imageHeight = size.height/size.width * self.cellWidth;
        [self.backgroundImageView setFrame:CGRectMake(0, 0, self.cellWidth, MAX(imageHeight, self.cellHeight))];
    }
}
-(void)resetImagePos{
    float posScaling = (self.frame.origin.y - self.tableView.contentOffset.y) / (self.tableView.frame.size.height - self.cellHeight);
    //NSLog(@"posScaling:%f", posScaling);
    float imageViewY;
    imageViewY = - (self.backgroundImageView.frame.size.height - self.cellHeight) * posScaling;
    if (self.backgroundImageView.frame.size.height > self.tableView.frame.size.height) {
        //当图片高度大于tableView的高度时，移动到两端时固定不动，否则会漏底
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
