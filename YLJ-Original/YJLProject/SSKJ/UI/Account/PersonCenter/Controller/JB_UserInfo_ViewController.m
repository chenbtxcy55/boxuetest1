//
//  My_UserInfo_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "JB_UserInfo_ViewController.h"
#import "JB_Info_Cell.h"

@interface JB_UserInfo_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation JB_UserInfo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"个人中心", nil);
    self.view.backgroundColor = kMainBackgroundColor;
    [self setUI];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:10];
    [self.dataSource addObject:@[SSKJLocalized(@"账号：", nil),
                                 SSKJLocalized(@"交易ID：", nil),
                                 SSKJLocalized(@"姓名：", nil),
                                 SSKJLocalized(@"身份证号：", nil)]];
    SSKJ_UserInfo_Model *userInfoModel = [SSKJ_User_Tool sharedUserTool].userInfoModel;
    NSString *phone = kPhoneNumber?:@"--";
    NSString *account = userInfoModel.uid?:@"--";
    NSString *userName = userInfoModel.name?:@"--";
    NSString *idCard = userInfoModel.idcard?:@"--";
    
    NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:10];
    [valueArray addObject:phone];
    [valueArray addObject:account];
    [valueArray addObject:userName];
    [valueArray addObject:idCard];
    [self.dataSource addObject:valueArray];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)setUI
{
    [self.view addSubview:self.tableView];
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(10)) style:UITableViewStylePlain];
        _tableView.backgroundColor = kMainBackgroundColor;
        _tableView.separatorColor = kMainBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[JB_Info_Cell class] forCellReuseIdentifier:NSStringFromClass([self class])];
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
        
        
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        _tableView.separatorColor = kLineGrayColor;
    }
    return _tableView;
}



#pragma mark - UITableViewDelegate UITableViewDatsSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArray = self.dataSource.firstObject;
    NSArray *valueArray = self.dataSource.lastObject;
    NSString *title = titleArray[indexPath.row];
    NSString *value = valueArray[indexPath.row];
    
    JB_Info_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    [cell setCellWithTitle:title value:value];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
