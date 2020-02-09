//
//  CXShop_ViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "CXShop_ViewController.h"
#import "Shop_GoodsOwner_ViewController.h"
#import "CXTableViewCell.h"

@interface CXShop_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataAray;
@property (nonatomic, strong) NSString *currentFliePath;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation CXShop_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"诚信店铺", nil);
    [self.view addSubview:self.tableView];
     self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requstListRequst];
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        
    }
    return _dataArr;
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(10),ScreenWidth, ScreenHeight - ScaleW(10)-(Height_TabBar-49) ) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setCornerRadius:ScaleW(10)];
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
        
        // [_tableView registerClass:[JB_FBC_DealHall_Cell class] forCellReuseIdentifier:cellid];
        // WS(weakSelf);
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //           // [weakSelf headerRefresh];
        //        }];
        
        //        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //           // [weakSelf footerRefresh];
        //        }];
        
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return ScaleW(0.001);
    }
    return ScaleW(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
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
    CXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CXTableViewCell" owner:nil options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.intoShopLab.text = SSKJLocalized(@"进入店铺>", nil);
    
    NSDictionary *dic = self.dataArr[indexPath.row];

//    "id": "2",
//    "name": "店铺2名称",
//    "detail": "店铺2的地址是河南省郑州市高新区",
//    "pic": "\/Uploads\/app\/banner\/2019\/09-10\/5d77680f1f2c087607.jpg"
    cell.titleContentLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
    
    cell.textContent.text = [NSString stringWithFormat:@"%@",dic[@"detail"]];
    
    [cell.shopImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:[dic objectForKey:@"pic"]]]];
    
    return cell;
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.row];
    NSString *cate_id = dic[@"id"];
    NSMutableDictionary *dicMute = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dicMute setObject:cate_id forKey:@"store_id"];
    Shop_GoodsOwner_ViewController *vc = [[Shop_GoodsOwner_ViewController alloc]init];
    vc.dataDic = dicMute;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)requstListRequst
{
 
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kowner_shop_user_shop_index RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [self.dataArr removeAllObjects];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
//            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:[netWorkModel.data objectForKey:@"store"]];
            
           
                                          
            for (NSDictionary *dic in [netWorkModel.data  objectForKey:@"store"]) {
                
                [self.dataArr addObject:dic];
                
            }
            
           
            
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        
        if (self.dataArr.count == 0) {
            
            [SSKJ_NoDataView showNoData:NO toView:self.view offY:0];
            
        }
         [self.tableView reloadData];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}



@end

