//
//  SKAssetManagementVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKAssetManagementVC.h"
#import "UIButton+LXMImagePosition.h"
//cell
#import "SKAssetsInfoCell.h"


//controll
#import "SKMyChargeVC.h"
#import "SKMyExtractVC.h"
#import "SKMyExchangeVC.h"
#import "SKBillingRecordsVC.h"
#import "SKAssetManagementModel.h"
#import "SKBillingEhTRecordVC.h"

@interface SKAssetManagementVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)UIImageView * headerImageView;


@property(nonatomic,strong)NSMutableArray * myDataArr;


@property(nonatomic,strong)UILabel *bigAmount;

@property(nonatomic,strong)UILabel *smallAmount;


@property (nonatomic, copy) NSString *useEHT;
@property (nonatomic, copy) NSString *useISCM;
@property (nonatomic, assign) bool useOnOff;



@end

@implementation SKAssetManagementVC

-(NSMutableArray*)myDataArr
{
    if (_myDataArr == nil) {
        
        _myDataArr = [NSMutableArray array];
    }
    
    return _myDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
}
-(void)initView
{
    [self topView];
    
    [self.view addSubview:self.mainTableView];
    
    
}

-(void)topView
{
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170+45 + Height_StatusBar)];
    headerImageView.image =[UIImage imageNamed:@"my_bgView"];
    
    headerImageView.userInteractionEnabled = YES;
    
    self.headerImageView = headerImageView;
    
    [self.view addSubview:headerImageView];
    
    
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    backBtn.frame = CGRectMake(0, Height_StatusBar, 44, 44);
    
//    backBtn.backgroundColor =SKRandomColor;
    [backBtn setImage:[UIImage imageNamed:@"left_my_baise"] forState:UIControlStateNormal] ;
    
    [backBtn addTarget:self action:@selector(bankEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [headerImageView addSubview:backBtn];

    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(60, Height_StatusBar, ScreenWidth - 120, 44)];
    titleLab.text = @"资产管理";
   
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font =systemBoldFont(18);
    
    titleLab.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    
    [headerImageView addSubview:titleLab];
    
    
    
    UILabel *bigAmount = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(42), titleLab.bottom + 37, ScreenWidth - ScaleW(42)-20, 22)];
    
    bigAmount.textAlignment = NSTextAlignmentLeft;
   
    bigAmount.textColor = [UIColor whiteColor];
    
    [headerImageView addSubview:bigAmount];
    
    self.bigAmount = bigAmount;
    
    
    UILabel *smallAmount = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(42), bigAmount.bottom + 10, ScreenWidth - ScaleW(42) -20, 10)];
//    smallAmount.text = @"≈122689.32 CNY";
    smallAmount.textAlignment = NSTextAlignmentLeft;
    smallAmount.font =systemFont(12);
    
    smallAmount.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.5f];
   
    [headerImageView addSubview:smallAmount];
    
    self.smallAmount = smallAmount;
    
    
    UIView * btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, headerImageView.height - 45, ScreenWidth, 45)];
    
    btnBgView.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:217.0f/255.0f blue:247.0f/255.0f alpha:0.13f];
//    btnBgView.alpha = 0.13;

    [headerImageView addSubview:btnBgView];
    
    
    NSArray * titleArr =@[SSKJLocalized(@"充币", nil),SSKJLocalized(@"提币", nil),SSKJLocalized(@"兑换", nil)];
    NSArray * imageArr =@[@"icon_my_chongbi",@"icon_my_tibi",@"my_duihuan"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenWidth/3 * i, 0, ScreenWidth/3, 45);
        
        [button addTarget:self action:@selector(typeEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
      
        button.titleLabel.font = systemFont(14);
        [button setTitleColor:[UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        
        button.tag = 33223344 + i;
        
        [button setImagePosition:LXMImagePositionLeft spacing:7];
        [btnBgView addSubview:button];
        
        if (i!=2) {
         
            UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.width*(i +1), (button.height-20)/2, 1, 20)];
            lineImageView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            lineImageView.alpha = 0.3;
            
            [btnBgView addSubview:lineImageView];

        }
        
        
    }
    
    
}
-(void)typeEvent:(UIButton*)sender
{
    switch (sender.tag -33223344) {
        case 0:
            {
                
#pragma mark --- 充币
                SKMyChargeVC * myChangeVC = [SKMyChargeVC new];
                
                [self.navigationController pushViewController:myChangeVC animated:YES];
            }
            break;
        case 1:
        {
#pragma mark --- 提币
            SKMyExtractVC * myExtractVC = [SKMyExtractVC new];
            
            myExtractVC.useISCM = self.useISCM;
            
            myExtractVC.useEHT = self.useEHT;
            
            [self.navigationController pushViewController:myExtractVC animated:YES];

        }
            break;
        case 2:
        {
#pragma mark --- 兑换币
            
            if (self.useOnOff) {
                SKMyExchangeVC * myExchangeVC =[SKMyExchangeVC new];
                
                [self.navigationController pushViewController:myExchangeVC animated:YES];
            }
            else{
                
                [MBProgressHUD showError:SSKJLocalized(@"该功能维护中", nil)];
            }
        
            
        }
            break;
            
        default:
            break;
    }
    
    
}
-(void)bankEvent
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self requestOnOff];
    [self requestList];
}
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headerImageView.bottom, ScreenWidth, ScreenHeight-self.headerImageView.height) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = WLColor(246, 247, 251, 1);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        [_mainTableView registerClass:[SKAssetsInfoCell class] forCellReuseIdentifier:@"SKAssetsInfoCell"];
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        WS(weakSelf);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestList];
        }];
        
//        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf requestList];
//        }];
//        
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
    
    SKAssetManagementModel * model = self.myDataArr[indexPath.row];

    if ([model.type isEqualToString:@"ETH"]) {
        
        return 100;

    }
    else
    {
        return 113;

    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKAssetsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKAssetsInfoCell"];
    WS(weakSelf);
    
    cell.moneyDetailBLock = ^{
        
        SKBillingRecordsVC * billVC =[SKBillingRecordsVC new];
        
        [weakSelf.navigationController pushViewController:billVC animated:YES];
        
    };
    cell.moneyDetailENTBLock  = ^{
        
        SKBillingEhTRecordVC * billVC =[SKBillingEhTRecordVC new];
        
        [weakSelf.navigationController pushViewController:billVC animated:YES];
        
    };
    
    cell.model = self.myDataArr[indexPath.row];
    
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
    return CGFLOAT_MIN;
}
//kIscm_Recognize_asset_Api

-(void)requestList
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_Recognize_asset_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.mainTableView.mj_header endRefreshing];
        
        
        if (net_model.status.integerValue == 200) {
            
            [weakSelf.myDataArr removeAllObjects];
            
            weakSelf.smallAmount.text =  [NSString stringWithFormat:@"≈%@ CNY",net_model.data[@"rmb_ttl"]];
            
            NSString *ttlStr = [NSString stringWithFormat:@"%@",net_model.data[@"ttl"]];
            NSArray * ttlArr = [ttlStr componentsSeparatedByString:@"."];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:ttlStr];
            
            
            [attributedString addAttribute:NSFontAttributeName value:systemBoldFont(24) range:[ttlStr rangeOfString:ttlArr[0]]];
            
            [attributedString addAttribute:NSFontAttributeName value:systemBoldFont(15) range:[ttlStr rangeOfString:ttlArr[1]]];
            weakSelf.bigAmount.attributedText = attributedString;
            
            NSDictionary * dic = net_model.data[@"ETH"];
            SKAssetManagementModel * model = [SKAssetManagementModel new];
            
            weakSelf.useEHT =  dic[@"usable"];
            model.type = @"ETH";
            model.usableETH = [NSNumber numberWithInt:[dic[@"usable"] intValue] ];
            model.frostETH = [NSNumber numberWithInt:[dic[@"frost"] intValue] ];

            [weakSelf.myDataArr addObject:model];
          
            {
                
                NSDictionary * dic = net_model.data[@"ISCM"];
                SKAssetManagementModel * model = [SKAssetManagementModel new];
                
                model.type = @"ISCM";
                model.usableISCM =  [NSNumber  numberWithInt:[dic[@"usable"] intValue]];
                model.frostISCM = [NSNumber  numberWithInt:[dic[@"frost"] intValue]];
                model.daishou =[NSString stringWithFormat:@"%@", dic[@"daishou"] ];
                model.keshou = [NSString stringWithFormat:@"%@", dic[@"keshou"]];
                weakSelf.useISCM = [NSString stringWithFormat:@"%@", dic[@"usable"]];
                [weakSelf.myDataArr addObject:model];

            }
      
            [weakSelf.mainTableView reloadData];
            
            
        }else{
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakSelf.mainTableView.mj_header endRefreshing];

        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}

#pragma mark -- 兑换开关
-(void)requestOnOff
{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_czOnOff_Api RequestType:RequestTypePost Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
           
            weakSelf.useOnOff = netWorkModel.data;
            
        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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
