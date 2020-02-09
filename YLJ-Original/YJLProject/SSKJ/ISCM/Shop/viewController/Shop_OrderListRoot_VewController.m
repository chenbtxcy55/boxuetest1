//
//  Shop_OrderListRoot_VewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_OrderListRoot_VewController.h"
#import "Shop_OrderListViewController.h"

#import "FBDeal_Segment_Control.h"
@interface  Shop_OrderListRoot_VewController()<UIScrollViewDelegate>
@property (nonatomic, strong) FBDeal_Segment_Control *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *stausArray;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *vcArray;


@end

@implementation Shop_OrderListRoot_VewController

-(NSArray *)stausArray
{
   
//all(全部),wait_pay(待付款),already_pay(待收货),already_complete（已完成）
    return @[@"all",@"wait_pay",@"already_pay",@"already_complete"];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    [self addChildControllers];
    self.title = SSKJLocalized(@"订单管理", nil);
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)leftBtnAction:(id)sender{
    
    NSLog(@"vccount:::%ld",self.navigationController.viewControllers.count);
    
    if (self.navigationController.viewControllers.count>4) {
        
        UIViewController *vc =self.navigationController.viewControllers[self.navigationController.viewControllers.count-4];
        
        [self.navigationController popToViewController:vc animated:YES];
        
    }
    else{
          [self.navigationController popViewControllerAnimated:YES];
        
    }
}
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[SSKJLocalized(@"全部", nil),SSKJLocalized(@"待付款", nil),SSKJLocalized(@"待收货", nil),SSKJLocalized(@"已完成", nil)];
    }
    return _titleArray;
}
-(FBDeal_Segment_Control *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[FBDeal_Segment_Control alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50)) titles:@[SSKJLocalized(@"全部", nil),SSKJLocalized(@"待支付", nil),SSKJLocalized(@"待收货", nil),SSKJLocalized(@"已完成", nil)] normalColor:kSubTxtColor selectedColor:kGreenColor fontSize:ScaleW(13.5)];
        WS(weakSelf);
        _segmentControl.lineView.image = nil;
        
        
        _segmentControl.backgroundColor = kBgColor353750;
        
        _segmentControl.selectedIndexBlock = ^BOOL(NSInteger index) {
            
//            if (index == 2 && !kLogin) {
//                [weakSelf presentLoginController];
//                return NO;
//            }
            NSLog(@"%ld",index);
            [weakSelf.scrollView scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, ScreenWidth, weakSelf.scrollView.height) animated:YES];
            Shop_OrderListViewController *vc=(     Shop_OrderListViewController *)self->_vcArray[index];
            
            [vc refreshData];
            
            return YES;
        };
    }
    return _segmentControl;
}
-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.segmentControl.height, ScreenWidth, ScreenHeight - self.segmentControl.bottom - Height_TabBar)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 5, _scrollView.height);
        _scrollView.delegate = self;
    }
    return _scrollView;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    self.segmentControl.selectedIndex = index;
    
    
}
-(void)addChildControllers
{
    
    NSArray *titlesArray = @[SSKJLocalized(@"全部", nil),SSKJLocalized(@"未支付", nil),SSKJLocalized(@"待收货", nil),SSKJLocalized(@"已完成", nil)];
    
    for (int i = 0; i < titlesArray.count; i ++) {
        Shop_OrderListViewController *vc = [[Shop_OrderListViewController alloc]init];
        vc.view.frame = CGRectMake(i * ScreenWidth, 0 , ScreenWidth, ScreenHeight - Height_TabBar - self.segmentControl.bottom);
        [self.scrollView addSubview:vc.view];
        vc.type = i;
        vc.title = titlesArray[i];
        vc.statusString = self.stausArray[i];
        [vc refreshData];
        
        [self addChildViewController:vc];
        
    }
    
    _vcArray = self.childViewControllers;
    
   
}
@end
