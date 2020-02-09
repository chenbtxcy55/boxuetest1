

#import "ShopShop_RootOrderViewController.h"
#import "ShopShop_ListViewController.h"

#import "FBDeal_Segment_Control.h"
@interface  ShopShop_RootOrderViewController()<UIScrollViewDelegate>
@property (nonatomic, strong) FBDeal_Segment_Control *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *stausArray;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *vcArray;


@end

@implementation ShopShop_RootOrderViewController

-(NSArray *)stausArray
{
    //unpay未付款cancel已取消wait_fahuo待发货wait_shouhuo待收货finish已完成，user_delete用户删除，shop_delete店铺删除，all_delete用户和店铺都删除
    // @[@"全部",@"未支付",@"未发货",@"待收货",@"已完成"]
    
    return @[@"",@"unpay",@"wait_fahuo",@"finish"];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    [self addChildControllers];
    self.title = SSKJLocalized(@"订单管理", nil);
}

-(NSArray *)titleArray
{
    if (!_titleArray) {
          _titleArray = @[SSKJLocalized(@"全部", nil),SSKJLocalized(@"未支付", nil),SSKJLocalized(@"待收货", nil),SSKJLocalized(@"已发货", nil),SSKJLocalized(@"已完成", nil)];
    }
    return _titleArray;
}
-(FBDeal_Segment_Control *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[FBDeal_Segment_Control alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50)) titles:@[SSKJLocalized(@"全部", nil),SSKJLocalized(@"未支付", nil),SSKJLocalized(@"待收货", nil),SSKJLocalized(@"已发货", nil),SSKJLocalized(@"已完成", nil)] normalColor:kSubTxtColor selectedColor:kSubTxtColor fontSize:ScaleW(13.5)];
        
        WS(weakSelf);
        _segmentControl.lineView.image = nil;
        
        
        _segmentControl.backgroundColor = kNavBGColor;
        
        _segmentControl.selectedIndexBlock = ^BOOL(NSInteger index) {
            
            //            if (index == 2 && !kLogin) {
            //                [weakSelf presentLoginController];
            //                return NO;
            //            }
            NSLog(@"%ld",index);
            [weakSelf.scrollView scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, ScreenWidth, weakSelf.scrollView.height) animated:YES];
            ShopShop_ListViewController *vc=(     ShopShop_ListViewController *)self->_vcArray[index];
            
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
        _scrollView.backgroundColor =  kMainColor;
    }
    return _scrollView;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    self.segmentControl.selectedIndex = index;
    
    ShopShop_ListViewController *vc=(     ShopShop_ListViewController *)self->_vcArray[index];
    
    [vc refreshData];
}
-(void)addChildControllers
{
    
    NSArray *titlesArray = @[@"全部",@"未支付",@"待发货",@"已发货",@"已完成"];
    
    for (int i = 0; i < titlesArray.count; i ++) {
        ShopShop_ListViewController *vc = [[ShopShop_ListViewController alloc]init];
        vc.view.frame = CGRectMake(i * ScreenWidth, 0 , ScreenWidth, ScreenHeight - Height_TabBar - self.segmentControl.bottom);
        [self.scrollView addSubview:vc.view];
        vc.selectedIndex = i;
        vc.title = SSKJLocalized(titlesArray[i], nil);
        [self addChildViewController:vc];

        
        
    }
    
    _vcArray = self.childViewControllers;
}
@end
