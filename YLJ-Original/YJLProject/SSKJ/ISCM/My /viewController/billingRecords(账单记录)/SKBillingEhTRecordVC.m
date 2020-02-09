//
//  SKBillingEhTRecordVC.m
//  SSKJ
//
//  Created by 孙克强 on 2019/7/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKBillingEhTRecordVC.h"
#import "BillingRecordsCell.h"
#import "JMDropMenu.h"

@interface SKBillingEhTRecordVC ()<UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,assign)int  page;

@property(nonatomic,strong)NSMutableArray * myDataArr;



@end

@implementation SKBillingEhTRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    self.page = 1;

    [self initView];
}
-(NSMutableArray *)myDataArr
{
    if (_myDataArr == nil) {
        
        _myDataArr =[NSMutableArray array];
    }
    
    return _myDataArr;
}

-(void)initView
{
    
    [self.view addSubview:self.mainTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self requestRecordList];
    self.title = SSKJLocalized(@"账单记录", nil);
    
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = WLColor(246, 247, 251, 1);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[BillingRecordsCell class] forCellReuseIdentifier:@"BillingRecordsCell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        WS(weakSelf);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weakSelf.page = 1;
            [weakSelf requestRecordList];
            
        }];
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.page ++;
            [weakSelf requestRecordList];
        }];
    }
    return _mainTableView;
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.myDataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dic = self.myDataArr[indexPath.row];
    NSString * text = dic[@"memo"];
    CGFloat height = [text boundingRectWithSize:CGSizeMake(ScaleW(238), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemScaleFont(14)} context:nil].size.height;
    return ScaleW(18*2 + 13*3 + 17*3) + (height >17?height:17);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BillingRecordsCell * cell =[tableView dequeueReusableCellWithIdentifier:@"BillingRecordsCell"];
    
    NSDictionary * dic = self.myDataArr[indexPath.row];

    
    
    [cell setValuedataSoure:dic type:1];
    return cell;
    
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [UIView new];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return CGFLOAT_MIN;
}
-(void)requestRecordList
{
    //#define kIscm_re_asset_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/re_asset"]
 
    NSDictionary *params = @{
                             @"pid":@(3),
                             @"p":@(1),
                             @"size":@(10)
                             };
    
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_re_asset_Api RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            
            
            if (weakSelf.page == 1) {
                [weakSelf.myDataArr removeAllObjects];
                
            }
            
            [weakSelf.myDataArr addObjectsFromArray:net_model.data[@"res"]];
            
            [SSKJ_NoDataView showNoData:self.myDataArr.count toView:weakSelf.mainTableView offY:0];
            [weakSelf.mainTableView reloadData];

            
        }else{
            
            [MBProgressHUD showError:net_model.msg];
        }
        [self endRefresh];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [self endRefresh];
        
    }];
}
-(void)endRefresh
{
    [_mainTableView.mj_footer endRefreshing];
    [_mainTableView.mj_header endRefreshing];

}

@end
