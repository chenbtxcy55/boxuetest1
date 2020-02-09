//
//  SKMyCharge_RecordVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMyCharge_RecordVC.h"
#import "SKMyCharge_RecordCell.h"

@interface SKMyCharge_RecordVC ()<UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSMutableArray * myDataArr;

@end

@implementation SKMyCharge_RecordVC

-(NSMutableArray *)myDataArr
{
    if (_myDataArr == nil) {
        _myDataArr =[NSMutableArray array];
    }
    return _myDataArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
    [self.navigationController setNavigationBarHidden:NO];
    
    self.page = 1;
    
//    [self requestRecordList];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self requestRecordList];

    self.title = SSKJLocalized(@"充币记录", nil);
    
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
        [_mainTableView registerClass:[SKMyCharge_RecordCell class] forCellReuseIdentifier:@"SKMyCharge_RecordCell"];
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
    
    return 18*2 + 16*2 +14;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SKMyCharge_RecordCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SKMyCharge_RecordCell"];
    
    NSDictionary * myDic = self.myDataArr[indexPath.row];
    
    
    cell.getMoneyAddressContent.text = myDic[@"chongzhi_url"];
    cell.getMoneyAmountContent.text = myDic[@"price"];

    
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
    

    NSDictionary *params = @{
                             @"pid":@(3),
                             @"type":@"recharge",
                             @"p":@(1),
                             @"size":@(10)
                             };
    
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_Recognize_record_Api RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {

            
            if (weakSelf.page == 1) {
                [weakSelf.myDataArr removeAllObjects];
                
            }
           
            [weakSelf.myDataArr addObjectsFromArray:net_model.data[@"res"]];
            [SSKJ_NoDataView showNoData:weakSelf.myDataArr.count toView:weakSelf.mainTableView offY:0];
            [weakSelf.mainTableView reloadData];

        }else{
            
            [MBProgressHUD showError:net_model.msg];
        }
        [weakSelf endRefresh];

    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf endRefresh];
        
    }];
}
-(void)endRefresh
{
    [_mainTableView.mj_header endRefreshing];
    [_mainTableView.mj_footer endRefreshing];

    
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
