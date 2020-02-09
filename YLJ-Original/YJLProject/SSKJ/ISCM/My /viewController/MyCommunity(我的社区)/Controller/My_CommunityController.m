//
//  My_CommunityController.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 我的社区
 */
#import "My_CommunityController.h"
#import "My_Community_heardView.h"
#import "MyDirectPushViewController.h"//我的直推
#import "NinaPagerView.h"
#import "My_Community_lockController.h"//锁仓释放
#import "My_CommunityDividViewController.h"//加权分红
#import "My_CommunityServiceViewController.h"//服务费

@interface My_CommunityController ()<NinaPagerViewDelegate>
@property (nonatomic,strong)MyDirectPushViewController *systemVC;

@property (nonatomic,strong)MyDirectPushViewController *tradingVc;

@property (nonatomic,strong)My_Community_heardView *heardView;
@property (nonatomic, strong) NinaPagerView *ninaPagerView;

@end

@implementation My_CommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"我的社区", nil);
    [self.view addSubview:self.heardView];
    [self ninaPagerView];
    [self requstHeardViewData];
    
}
- (NinaPagerView *) ninaPagerView
{
    
    if (!_ninaPagerView)
    {
        //行业资讯
        self.systemVC = [[MyDirectPushViewController alloc]init];
        My_Community_lockController *lockV = [[My_Community_lockController alloc] init];
        My_CommunityDividViewController *fenHong = [[My_CommunityDividViewController alloc] init];
        My_CommunityServiceViewController *fuWu = [[My_CommunityServiceViewController alloc] init];
        NSArray *controllers=@[self.systemVC,lockV,fenHong,fuWu
                               ];
        
        NSArray *titleArray =@[SSKJLocalized(@"我的直推", nil),SSKJLocalized(@"锁仓释放", nil),SSKJLocalized(@"加权分红", nil),SSKJLocalized(@"服务费", nil)
                               ];
        _ninaPagerView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, ScaleW(150), ScreenWidth, ScreenHeight  - Height_NavBar - ScaleW(150)) WithTitles:titleArray WithObjects:controllers];
        
        _ninaPagerView.topTabBackGroundColor = kNavBGColor;
        
        _ninaPagerView.topTabHeight = ScaleW(40);
        
        _ninaPagerView.titleFont = 15;
        
        _ninaPagerView.sliderBlockColor = kNavBGColor;
        
        _ninaPagerView.underlineColor = UIColorFromRGB(0x5ba56f);
        
        _ninaPagerView.selectTitleColor = UIColorFromRGB(0x5ba56f);
        
        _ninaPagerView.nina_autoBottomLineEnable = YES;
        
        _ninaPagerView.nina_scrollEnabled = YES;
        
        _ninaPagerView.delegate = self;
        
        _ninaPagerView.selectBottomLinePer = 1;
        
        [self.view addSubview:_ninaPagerView];
        
    }
    return _ninaPagerView;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)ninaCurrentPageIndex:(NSInteger)currentPage currentObject:(id)currentObject lastObject:(id)lastObject
{
    
    
    
    
}
- (My_Community_heardView *)heardView{
    if (!_heardView) {
        _heardView = [[My_Community_heardView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, ScaleW(150))];
    }
    return _heardView;
}

-(void)requstHeardViewData{
    
    WS(weakSelf);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_community_count_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
//            @property (nonatomic,strong)UILabel *tOneLab;//社区人数
//            @property (nonatomic,strong)UILabel *tTwoLab;//锁仓
//            @property (nonatomic,strong)UILabel *tThreeLab;//释放
//            @property (nonatomic,strong)UILabel *tFoutLab;//加权
//
//            @property (nonatomic,strong)UILabel *bOneLab;//大区
//            @property (nonatomic,strong)UILabel *bTwoLab;//当月业绩
//            @property (nonatomic,strong)UILabel *bThreeLab;//累计业绩
//            @property (nonatomic,strong)UILabel *bFoutLab;//服务费奖励
            weakSelf.heardView.tOneLab.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[netWorkModel.data[@"team_count"] doubleValue] afterPointNumber:4]];
            weakSelf.heardView.tTwoLab.text = [NSString stringWithFormat:@"%@", [WLTools noroundingStringWith:[netWorkModel.data[@"lock_num"] doubleValue] afterPointNumber:4]];
            weakSelf.heardView.tThreeLab.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[netWorkModel.data[@"rate"] doubleValue] afterPointNumber:4]];
            weakSelf.heardView.tFoutLab.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[netWorkModel.data[@"weighted_reward_count"] doubleValue] afterPointNumber:4]];
            weakSelf.heardView.bOneLab.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[netWorkModel.data[@"total_yec"] doubleValue] afterPointNumber:4]];
            weakSelf.heardView.bTwoLab.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[netWorkModel.data[@"now_mounth_usdt_num"] doubleValue] afterPointNumber:4]];
            weakSelf.heardView.bThreeLab.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[netWorkModel.data[@"sum_usdt_num"] doubleValue] afterPointNumber:4]];
            weakSelf.heardView.bFoutLab.text = [NSString stringWithFormat:@"%@",[WLTools noroundingStringWith:[netWorkModel.data[@"server_fee_count"] doubleValue] afterPointNumber:4]];

        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
