//
//  ABRootRecodViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ABRootRecodViewController.h"
#import "FBDeal_Segment_Control.h"
#import "JB_FBC_OrderList_ViewController.h"
@interface ABRootRecodViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) FBDeal_Segment_Control *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation ABRootRecodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[SSKJLocalized(@"全部", nil),SSKJLocalized(@"待付款", nil),SSKJLocalized(@"待放币", nil),SSKJLocalized(@"申诉", nil),SSKJLocalized(@"已取消", nil),SSKJLocalized(@"已完成", nil)];
    }
    return _titleArray;
}
-(void)setUI
{

    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    
    [self addChildControllers];
    

    
}
-(void)addChildControllers
{
   
    for (int i = 0; i <self.titleArray.count; i ++ ) {
        JB_FBC_OrderList_ViewController *vc = [[JB_FBC_OrderList_ViewController alloc]init];
        [self.scrollView addSubview:vc.view];
        vc.index = i;
         vc.view.frame = CGRectMake(i*ScreenWidth, 0 , ScreenWidth, self.scrollView.height);
        [self addChildViewController:vc];
    }
   
    
    
    //    // 记录
    //    JB_FBC_OrderList_ViewController *vc2 = [[JB_FBC_OrderList_ViewController alloc]init];
    //    vc2.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - Height_TabBar - self.segmentControl.bottom - Height_NavBar);
    //    [self.scrollView addSubview:vc2.view];
    //    [self addChildViewController:vc2];
}

-(FBDeal_Segment_Control *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[FBDeal_Segment_Control alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50)) titles:@[SSKJLocalized(@"全部", nil),SSKJLocalized(@"待付款", nil),SSKJLocalized(@"待放币", nil),SSKJLocalized(@"申诉", nil),SSKJLocalized(@"已取消", nil),SSKJLocalized(@"已完成", nil)] normalColor:kMainTextColor selectedColor:kMainRedColor fontSize:ScaleW(13.5)];
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^BOOL(NSInteger index) {
            
            [weakSelf.scrollView setContentOffset:CGPointMake(index*ScreenWidth, 0) animated:YES];
            return YES;
        };
    }
    return _segmentControl;
}
-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScreenHeight - self.segmentControl.bottom  - Height_NavBar)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.titleArray.count*ScreenWidth, 0);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    self.segmentControl.selectedIndex = index;
    
    
}

@end
