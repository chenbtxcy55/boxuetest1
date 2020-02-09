

#import "Super_Notifacation_ViewController.h"
#import "SuperNotifaTableViewCell.h"
#import "JB_WebView_Controller.h"
#import "NoticeModel.h"

#define pageSize @"30"
@interface Super_Notifacation_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *noticeArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation Super_Notifacation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"公告", nil);
    if (_isShop) {
        
        self.title=SSKJLocalized(@"商城公告", nil);
    }
    [self.view addSubview:self.tableView];
   
    
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight  - Height_NavBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
        
        
        
        _tableView.backgroundColor = kMainColor;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf footerRefresh];
//        }];
        
    }
    return _tableView;
}
#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requestRecordList];
    
}

-(void)footerRefresh
{
    [self requestRecordList];
}
//AB_Shop_owner_goods_index
-(void)requestRecordList{
    //AB_Shop_slide_list_post
    
    
//    NSDictionary *pamas = @{@"p":@(self.page),@"size":pageSize};
    
    NSString *url;
    
    if (_isShop) {
        
        url=KShopNoticeUrl;
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
            
            WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([netWorkModel.status integerValue] == SUCCESSED) {
                
                [self handleRecordListWith:netWorkModel];
                
            }else{
                [MBProgressHUD showError:netWorkModel.msg];
            }
            // [MBProgressHUD showError:netWorkModel.msg];
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    else{
        url=kIscm_user_zixunApi;
        NSDictionary *pamas = @{@"p":@(self.page),@"size":pageSize};
        
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
            
            WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([netWorkModel.status integerValue] == SUCCESSED) {
                
                [self handleRecordListWith:netWorkModel];
                
            }else{
                [MBProgressHUD showError:netWorkModel.msg];
            }
            // [MBProgressHUD showError:netWorkModel.msg];
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
}
-(void)handleRecordListWith:(WL_Network_Model *)net_model
{
    
    
    NSArray *array ;
    
    if (_isShop) {
        
        array = [NoticeModel mj_objectArrayWithKeyValuesArray:net_model.data[@"notices"]];
    }
    else{
        NSLog(@"data:::::%@",net_model.data);
        
        if ([[net_model.data allKeys] containsObject:@"res"]) {
            
            NSArray *array2=net_model.data[@"res"];
            
            array = [NoticeModel mj_objectArrayWithKeyValuesArray:array2];
        }
      
    }
    if (array.count != pageSize.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (self.page == 1) {
        [self.noticeArray removeAllObjects];
    }
    
    [self.noticeArray addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.noticeArray.count toView:self.tableView offY:0];
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
    self.page++;
    
}
-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.noticeArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(100);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return ScaleW(0.001);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(0))];
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
    NoticeModel *model  = [self.noticeArray objectAtIndex:indexPath.row];
    
    SuperNotifaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperNotifaTableViewCell"];
    if (cell == nil) {
        cell = [[SuperNotifaTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"SuperNotifaTableViewCell"];
  
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.messageLabel.text =model.title;
    cell.dateLabel.text  = [WLTools convertTimestamp:model.create_time.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (model.push_time) {
        
        cell.dateLabel.text=[NSString stringWithFormat:@"%@",model.push_time];
        
    }
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }
    NoticeModel *model = self.noticeArray[indexPath.row];
    
    JB_WebView_Controller *vc = [[JB_WebView_Controller alloc]init];
    vc.protocolType = PROTOCOLTYPEPABOUT;
    vc.idString = model.ID;
    
    if (_isShop) {
        
        vc.nmodel=model;
        
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefresh];
}

-(NSMutableArray *)noticeArray{
    if (!_noticeArray) {
        _noticeArray = [NSMutableArray array];
    }
    return _noticeArray;
}
@end
