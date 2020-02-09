//
//  FBRecodDetailViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBRecodDetailViewController.h"
#import "FBRecodDetailHeaderView.h"
@interface FBRecodDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FBRecodDetailHeaderView *headerView;
@end

@implementation FBRecodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self.view addSubview:self.tableView];
}

-(FBRecodDetailHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[FBRecodDetailHeaderView alloc]init];
    }
    return _headerView;
}
-(void)setNavigationView
{
    UIImageView *contenImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Bituneex"]];
    self.navigationItem.titleView = contenImg;
}




-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.backgroundColor = [UIColor clearColor];
        //_tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.tableHeaderView = self.headerView;
        
    }
    
    return _tableView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(0.01);
}



@end
