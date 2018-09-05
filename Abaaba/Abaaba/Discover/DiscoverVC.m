//
//  DiscoverVC.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "DiscoverVC.h"
#import "ABAScrollView.h"
#import "DiscoverTool.h"
#import "DiscoverModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DiscoverDetailVC.h"
#import "ABAMainNavigationBar.h"
#import "DiscoverTableViewCell.h"

@interface DiscoverVC ()
<ABAscrollViewViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) DiscoverModel *discoverModel;
@property (nonatomic, strong) ABAScrollView *bannerView;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation DiscoverVC

- (ABAScrollView *)bannerView{
    if (!_bannerView) {
        ABAScrollView *bannerView = [[ABAScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mainNavBar.frame), self.view.width, 150)];
        bannerView.delegate = self;
        self.bannerView = bannerView;
    }
    return _bannerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --- 设置视图

- (void)setupView{
    self.mainNavBar.frame = CGRectMake(0, 0, self.view.width, 65);
    self.mainNavBar.leftTitle = @"发现";
    self.mainNavBar.hideDivid = YES;
    CGFloat height = self.view.height - CGRectGetMaxY(self.mainNavBar.frame);
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mainNavBar.frame), self.view.width, height)];
    tableView.tableHeaderView = self.bannerView;
    //去掉多于的分割线
    UIView *view = [[UIView alloc] init];
    tableView.tableFooterView = view;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark -- tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.discoverModel) {
        return 0;
    }
    return self.discoverModel.content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableViewCell *cell = [DiscoverTableViewCell discoverCell];
    cell.item = self.discoverModel.content[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DiscoverTableViewCell cellHieght];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushDetailVC:self.discoverModel.content[indexPath.row]];
}

#pragma mark -- 加载数据

- (void)loadData{
    [DiscoverTool getDiscoverContent:nil finished:^(DiscoverModel *result, NSError *error) {
        self.discoverModel = result;
        [self updateData];
    }];
}

- (void)updateData{
    NSMutableArray *bannerViews = [NSMutableArray arrayWithCapacity:3];
    for (BannerItem *item in self.discoverModel.banner) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.mini_img] placeholderImage:[UIImage imageNamed:@""]];
        [bannerViews addObject:imageView];
    }
    self.bannerView.imageViewArray = bannerViews;
    [self.bannerView shouldAutoShow:YES];
}

#pragma mark -- bannerView delegate
- (void)didClickPage:(ABAScrollView *)view atIndex:(NSInteger)index;{
    [self pushDetailVC:self.discoverModel.banner[index - 1]];
}

#pragma mark - 私有方法

- (void)pushDetailVC:(BannerItem *)item{
    DiscoverDetailVC *detailVC = [[DiscoverDetailVC alloc] init];
    detailVC.detail = item;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
