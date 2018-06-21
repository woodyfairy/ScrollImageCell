//
//  ViewController.m
//  ScrollAdTest
//
//  Created by 吴冬炀 on 2018/3/27.
//  Copyright © 2018年 吴冬炀. All rights reserved.
//

#import "ViewController.h"
#import "ScrollImageTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NSIndexPath *> *arrImageInexPath;
@property (nonatomic, strong) NSArray<NSString *> *arrImageUrl;
@property (nonatomic, strong) NSArray<NSString *> *arrHeight;
@end

@implementation ViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setEstimatedRowHeight:0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.arrImageInexPath = @[[NSIndexPath indexPathForRow:2 inSection:0],
                    [NSIndexPath indexPathForRow:5 inSection:0],
                    [NSIndexPath indexPathForRow:6 inSection:0],
                    [NSIndexPath indexPathForRow:9 inSection:0],
                    [NSIndexPath indexPathForRow:15 inSection:0]];
    self.arrImageUrl = @[//@"http://pic2.ooopic.com/12/25/53/68bOOOPIC44.jpg",
                         //@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1529578316701&di=193a4953fe041ac8f62472dbddea3d53&imgtype=0&src=http%3A%2F%2Ff6.topitme.com%2F6%2F17%2F70%2F112729126012c70176o.jpg",
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522129641375&di=e9ba812fb51aa5511b1231d5112bb6e8&imgtype=0&src=http%3A%2F%2Fstatic01.coloros.com%2Fbbs%2Fdata%2Fattachment%2Fforum%2F201705%2F09%2F182242ab29j2zaef6lo4jd.png",
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1529579490739&di=1586078d8419106171e62771660893ee&imgtype=0&src=http%3A%2F%2Fim6.leaderhero.com%2Fwallpaper%2F217%2Feedd995803a1477ebc0e285fff887f3e.jpg",
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522124434950&di=1edea673252fcf36b81ac005be23dc53&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F016e945959e844a8012193a3a09a33.jpg",
                         @"http://pic35.photophoto.cn/20150401/0017031031675987_b.jpg",
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1529578656870&di=1de5ff8e691452c995c3ad958131c20e&imgtype=0&src=http%3A%2F%2Fimglf0.ph.126.net%2F5LC-a2y00ZDpdYysYmwPUg%3D%3D%2F6598065924252867834.jpg"];
    self.arrHeight = @[@350,@250,@90,@200,@100];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i < self.arrImageInexPath.count; i ++) {
        if (self.arrImageInexPath[i] == indexPath) {
            return self.arrHeight[i].floatValue;
        }
    }
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i < self.arrImageInexPath.count; i ++) {
        if (self.arrImageInexPath[i] == indexPath) {
            NSString *scrollCellID = @"scrollCellID";
            ScrollImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollCellID];
            if (!cell) {
                cell = [[ScrollImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:scrollCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //NEED
                [cell setTableView:tableView];
            }
            
            cell.textLabel.text = [NSString stringWithFormat:@"Background: %ld", indexPath.row];
            NSString *url = self.arrImageUrl[i];
            [cell.backgroundImageView sd_setImageWithURL:[NSURL URLWithString: url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (cell) {
                    //NEED
                    [cell refresh];//在更新图片时调用
                }
            }];
            return cell;
        }
    }
    
    //other Cells
    NSString *defaultCellID = @"defaultCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.5)];
        [view setBackgroundColor:[UIColor lightGrayColor]];
        [cell addSubview:view];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Cell: %ld", indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
