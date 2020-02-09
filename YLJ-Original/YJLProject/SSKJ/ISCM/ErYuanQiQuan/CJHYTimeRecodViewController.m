
#import "CJHYTimeRecodViewController.h"
#import "CJHYTimePosionViewController.h"
#import "CJHYTimeTradeDealVc.h"

@interface CJHYTimeRecodViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIButton *newsBtn;
@property(nonatomic, strong)UIButton *noticeBtn;
@property(nonatomic, strong)UIView *blueView;

@property(nonatomic, strong)CJHYTimePosionViewController *newsVc;
@property(nonatomic, strong)CJHYTimeTradeDealVc *noticeVc;

@end

@implementation CJHYTimeRecodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgationBackgroundColor:[UIColor whiteColor] alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    
    int tag = 100;
    for (UIButton *btn in @[self.newsBtn, self.noticeBtn]) {
        btn.tag = tag++;
    }
    self.newsBtn.selected = YES;
    
    [self scrollView];
    [self blueView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
   
}


#pragma mark - event response
- (void)newsBtnAction:(UIButton *)sender{
    [self changeOffset:(sender.tag - 100) * ScreenWidth];
    sender.selected = YES;
    self.blueView.centerX = sender.centerX;
}

- (void)noticeBtnAction:(UIButton *)sender{
    [self changeOffset:(sender.tag - 100) * ScreenWidth];
    sender.selected = YES;
    self.blueView.centerX = sender.centerX;
    [self.noticeVc headerRefresh];
    
}


#pragma mark - private methods

- (void)changeOffset:(CGFloat)value{
    
    
    _newsBtn.selected = NO;
    _noticeBtn.selected = NO;
    
    CGPoint offsize = self.scrollView.contentOffset;
    offsize.x = value;
    [self.scrollView setContentOffset:offsize];
}


#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if (scrollView.contentOffset.x <= 0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }
    
    _newsBtn.selected = NO;
    _noticeBtn.selected = NO;
    
    UIButton *btn = [self.view viewWithTag:offset.x/ScreenWidth + 100];
    btn.selected = YES;
    
    self.blueView.centerX = btn.centerX;
    
}



#pragma mark - lazy load

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(@0);
            make.top.equalTo(self.topView.mas_bottom).offset(ScaleW(0));
        }];
        
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight - ScaleW(80));
        //        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.delegate = self;
        
        //持仓
        self.newsVc = [CJHYTimePosionViewController new];
        
        [self addChildViewController:self.newsVc];
        
        [_scrollView addSubview:self.newsVc.view];
        
        
         //已完成
        self.noticeVc = [CJHYTimeTradeDealVc new];
        
        [self addChildViewController:self.noticeVc];
        
        [_scrollView addSubview:self.noticeVc.view];
        
       
        [self.newsVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenHeight - Height_NavBar));
        }];
       
        [self.noticeVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.newsVc.view);
            make.left.equalTo(self.newsVc.view.mas_right);
            make.size.equalTo(self.newsVc.view);
        }];
        
        
    }
    return _scrollView;
}

- (UIButton *)newsBtn{
    if (_newsBtn == nil) {
        _newsBtn = [WLTools allocButton:SSKJLocalized(@"持仓", nil) textColor:kTitleColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        _newsBtn.titleLabel.font = systemScaleFont(18);
        [_newsBtn setTitleColor:kBtnBgColor forState:UIControlStateSelected];
        [_newsBtn addTarget:self action:@selector(newsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_newsBtn];
//        UIImageView *backImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_back"]];
//        backImg.left = ScaleW(15);
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn btn:backBtn font:ScaleW(0) textColor:kMainColor text:@"" image:[UIImage imageNamed:KleftImg2] sel:@selector(backBtnAction:) taget:self];
        
        [_newsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(@0);
        }];
        [_newsBtn addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_newsBtn).offset(10);
            make.width.equalTo(@45);
            
        }];
        
    }
    return _newsBtn;
}

- (UIButton *)noticeBtn{
    if (_noticeBtn == nil) {
        _noticeBtn = [WLTools allocButton:SSKJLocalized(@"成交", nil) textColor:kTitleColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        _noticeBtn.titleLabel.font = systemScaleFont(18);
        [_noticeBtn setTitleColor:kBtnBgColor forState:UIControlStateSelected];
        [_noticeBtn addTarget:self action:@selector(noticeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_noticeBtn];
        [_noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.bottom.equalTo(@0);
            make.left.equalTo(self.newsBtn.mas_right);
            make.width.equalTo(self.newsBtn);
            
        }];
    }
    return _noticeBtn;
}

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [UIView new];
        _topView.backgroundColor = kMBBgColor;
        [self.view addSubview:_topView];
        
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@0);
            make.height.equalTo(@(Height_NavBar));
        }];
    }
    return _topView;
}

- (UIView *)blueView{
    if (_blueView == nil) {
        _blueView = [UIView new];
        _blueView.backgroundColor = kBtnBgColor;
        [self.topView addSubview:_blueView];
        
        [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.height.equalTo(@(ScaleW(3)));
            make.width.equalTo(@(ScaleW(20)));
            make.centerX.equalTo(self.newsBtn);
        }];
    }
    return _blueView;
}

-(void)backBtnAction:(UIButton *)sender

{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
