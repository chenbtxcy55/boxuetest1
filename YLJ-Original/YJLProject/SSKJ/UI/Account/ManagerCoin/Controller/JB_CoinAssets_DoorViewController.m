//
//  JB_CoinAssets_DoorViewController.m
//  SSKJ
//
//  Created by James on 2019/5/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_CoinAssets_DoorViewController.h"
#import "FBDeal_Segment_Control.h"
#import "HeBi_TiBi_Record_ViewController.h"
#import "JB_AccountOtherViewController.h"
@interface JB_CoinAssets_DoorViewController ()
@property (nonatomic, strong) FBDeal_Segment_Control *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation JB_CoinAssets_DoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"账单记录", nil);
    [self setUI];
    
    [self addControllers];
    
    [self selectControllerIndex:0];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
}

-(void)setUI
{
    [self.view addSubview:self.segmentControl];
}

#pragma mark - UI
-(FBDeal_Segment_Control *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[FBDeal_Segment_Control alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(42)) titles:@[SSKJLocalized(@"充币", nil),SSKJLocalized(@"提币", nil),SSKJLocalized(@"其他", nil)] normalColor:kTextDarkBlueColor selectedColor:kTextLightBlueColor fontSize:ScaleW(15)];
        _segmentControl.backgroundColor = kSubBackgroundColor;
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index) {
            [weakSelf selectControllerIndex:index];
            return YES;
        };
    }
    return _segmentControl;
}

-(void)addControllers
{
    HeBi_TiBi_Record_ViewController *vc = [[HeBi_TiBi_Record_ViewController alloc]init];
    vc.dealType = DealTypeChongbi;
    vc.view.frame = CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScreenHeight - self.segmentControl.bottom);
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    HeBi_TiBi_Record_ViewController *vc1 = [[HeBi_TiBi_Record_ViewController alloc]init];
    vc1.dealType = DealTypeTibi;
    vc1.view.frame = CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScreenHeight - self.segmentControl.bottom);
    [self addChildViewController:vc1];
    [self.view addSubview:vc1.view];
    
    JB_AccountOtherViewController *vc2 = [[JB_AccountOtherViewController alloc]init];
    vc2.view.frame = CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScreenHeight - self.segmentControl.bottom);
    vc2.mainTableView.height = ScreenHeight-Height_NavBar-self.segmentControl.height;
    [self addChildViewController:vc2];
    [self.view addSubview:vc2.view];
}


-(void)selectControllerIndex:(NSInteger)index
{
    self.selectedIndex = index;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        if (i == index) {
            [self.view addSubview:vc.view];
        }else{
            [vc.view removeFromSuperview];
        }
    }
    
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
