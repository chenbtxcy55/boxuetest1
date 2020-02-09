//
//  JB_Account_AssetRecord_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_AssetRecord_ViewController.h"
#import "JB_Account_Licai_OrderList_ViewController.h"
#import "JB_PledgeRecordListViewController.h"
#import "FBDeal_Segment_Control.h"

@interface JB_Account_AssetRecord_ViewController ()
@property (nonatomic, strong) FBDeal_Segment_Control *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation JB_Account_AssetRecord_ViewController

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
    self.navigationController.navigationBar.translucent = NO;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;

}

-(void)setUI
{
    [self.view addSubview:self.segmentControl];
}

#pragma mark - UI
-(FBDeal_Segment_Control *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[FBDeal_Segment_Control alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(42)) titles:@[SSKJLocalized(@"理财", nil),SSKJLocalized(@"抵押扣款", nil)] normalColor:kTextDarkBlueColor selectedColor:kTextLightBlueColor fontSize:ScaleW(15)];
        _segmentControl.backgroundColor = kSubBackgroundColor;
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^BOOL(NSInteger index) {
            [weakSelf selectControllerIndex:index];
            return YES;
        };
    }
    return _segmentControl;
}

-(void)addControllers
{
    JB_Account_Licai_OrderList_ViewController *vc = [[JB_Account_Licai_OrderList_ViewController alloc]init];
    vc.isChildVc = YES;
    vc.view.frame = CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScreenHeight - self.segmentControl.bottom);
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    JB_PledgeRecordListViewController *vc1 = [[JB_PledgeRecordListViewController alloc]init];
    vc1.hiddenHeaderView = YES;
    vc1.view.frame = CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScreenHeight - self.segmentControl.bottom);
    [self addChildViewController:vc1];
    [self.view addSubview:vc1.view];
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
