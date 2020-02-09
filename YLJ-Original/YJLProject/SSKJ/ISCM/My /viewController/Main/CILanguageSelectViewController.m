//
//  CILanguageSelectViewController.m
//  ZYW_MIT
//
//  Created by terre sea on 2019/9/3.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "CILanguageSelectViewController.h"
#import "AppDelegate.h"
#import "CISetupTableViewCell.h"
#import "SSKJ_TabbarController.h"

static NSString *cellid = @"UITableViewCell";

@interface CILanguageSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSString *selectStr;
@end

@implementation CILanguageSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor= kNavBGColor;
    self.title = SSKJLocalized(@"语言切换", nil);
    self.titleArray = [NSMutableArray arrayWithObjects:@"中文",@"English",nil];
    self.selectStr = [[SSKJLocalized sharedInstance] currentLanguage];
    [self.view addSubview:self.tableView];
    
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(125)) style:UITableViewStyleGrouped];
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        style.layer.backgroundColor = kMainColor.CGColor;
        style.alpha = 1;
        
        _tableView.tableHeaderView =style;
        
        //        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight  - Height_NavBar - self.contractView.height - ScaleW(20) ) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 10;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        //        _tableView.tableFooterView = self.logOutView;
        
        _tableView.separatorColor = kLineBgColor;
        
        _tableView.backgroundColor = kNavBGColor;
        
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        
        
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(5);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CISetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[CISetupTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        cell.backgroundColor = kNavBGColor;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = kMainWihteColor;
        cell.detailTextLabel.textColor = kMainWihteColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor=kTextBlueColor;
        UIView *view=[UIView new];
        [cell.contentView addSubview:view];
        view.backgroundColor=kLineGrayColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(cell.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    NSString *title = self.titleArray[indexPath.row];
    [cell.iconImageView setHidden:YES];
    if ([self.selectStr isEqualToString:@"en"]) {
        if(indexPath.row == 1) {
            [cell.iconImageView setHidden:NO];
        }
    } else {
        if(indexPath.row == 0) {
            [cell.iconImageView setHidden:NO];
        }
    }
    cell.textLabel.text = title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title;
    
    if (indexPath.row == 0) {
        title = @"中文";
        [[SSKJLocalized sharedInstance]setLanguage:@"zh-Hans"];
        self.selectStr = @"zh-Hans";
    }else{
        title = @"English";
        [[SSKJLocalized sharedInstance]setLanguage:@"en"];
        self.selectStr = @"en";
    }
    [self.tableView reloadData];

//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [delegate goToMain];
    
    SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
}

@end
