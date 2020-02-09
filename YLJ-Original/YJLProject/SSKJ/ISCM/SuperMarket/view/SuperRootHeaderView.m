//
//  SuperRootHeaderView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SuperRootHeaderView.h"
#import "SDCycleScrollView.h"
#import "XBTextLoopView.h"
#import "Homlist_CollectionViewCell.h"
#import "MyButton.h"
@interface SuperRootHeaderView()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) SDCycleScrollView *headerView;
@property (nonatomic, strong) UICollectionView *headerList;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *noticeView;
@property (nonatomic, strong) XBTextLoopView *rodlodText;


@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imagArray;

@property (nonatomic, strong) UIView *bommLine;

@property (nonatomic, strong) UIButton *gotoShopBtton;

@property (nonatomic, strong) UILabel *sectionLabel;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *noticeLabel; //最新公告

@property (nonatomic, strong) UIButton *moreNoticeBtn; //更多公告

@property (nonatomic, strong) UIImageView *labaImg; //公告喇叭




@end

@implementation SuperRootHeaderView

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(300)+Height_NavBar);
        [self addSubview:self.headerImg];
        [self addSubview:self.headerView];
        [self addSubview:self.headerList];
        [self addSubview:self.lineView];
        [self addSubview:self.noticeView];
        [self addSubview:self.bommLine];
        [self addSubview:self.gotoShopBtton];
        [self addSubview:self.backView];
        self.backgroundColor = kNavBGColor;
        self.height = self.backView.bottom;
        
        [self setupNaviView];
        
        //self.noticeArray = @[@"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"];
    }
    return self;
}
-(void)leftAction:(UIButton*)sender{
    
    
    if (self.naviClickBlock) {
        
        self.naviClickBlock(0);
        
    }
}
-(void)rightAction:(UIButton*)sender{
    
    if (self.naviClickBlock) {
        
        self.naviClickBlock(2);
        
    }
}
-(void)setupNaviView{
    UIButton *leftBtn = [MyButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, Height_StatusBar+ScaleW(2), ScaleW(40), ScaleW(20));
    [leftBtn btn:leftBtn font:ScaleW(15) textColor:kMainWihteColor text:nil image:[UIImage imageNamed:KLeftImgName] sel:@selector(leftAction:) taget:self];
    
    
    
//    [self addSubview:leftBtn];
    
    MyButton *rightBt = [[MyButton alloc]initWithFrame:CGRectMake(self.width-ScaleW(55), leftBtn.top-ScaleW(10), ScaleW(50), ScaleW(30))];
   
    
    rightBt.imgWidth=ScaleW(18);
    rightBt.imgHeight=ScaleW(18);
    
    rightBt.imgtop=0;
    
    
    rightBt.titleLabel.font=systemFont(11);
    
    [rightBt setImage:[UIImage imageNamed:@"dianpu"] forState:UIControlStateNormal];
    
    [rightBt setTitle:SSKJLocalized(@"我的店铺", nil) forState:UIControlStateNormal];
    

    [rightBt addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    rightBt.titleLabel.textAlignment=NSTextAlignmentCenter;

    rightBt.titleLabel.font = systemFont(10);
    
    [self addSubview:rightBt];
    
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), leftBtn.top, self.width-(rightBt.width+ScaleW(15)) -ScaleW(15), ScaleW(32))];
    style.layer.cornerRadius = style.height/2;
    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 0.2;
    
    [self addSubview:style];
    
//    UIButton *centerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    centerbtn.frame = CGRectMake(0, 0 , style.width, ScaleW(32));
//    [centerbtn addTarget:self action:@selector(findAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    centerbtn.layer.cornerRadius = ScaleW(16);
//    centerbtn.backgroundColor = [UIColor clearColor];
//     [style addSubview:centerbtn];
//

    
    UITapGestureRecognizer *tapFind=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(findAction)];
    
    style.userInteractionEnabled=YES;
    
    [style addGestureRecognizer:tapFind];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake( ScaleW(15) +ScaleW(11), style.top+ScaleW(7), ScaleW(18), ScaleW(18))];
    
    image.image = [UIImage imageNamed:@"icon_sousuo"];
    
    
     [self addSubview:image];
    
    UILabel *label1 = [WLTools allocLabel:SSKJLocalized(@"搜索", nil) font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(image.right + ScaleW(15), image.top, ScaleW(100), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
   
    label1.centerY=image.centerY;
    
    [self addSubview:label1];
  
   
    
}

-(void)findAction{
    
    if (self.naviClickBlock) {
        
        self.naviClickBlock(1);
        
    }
}
-(UIImageView *)headerImg
{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(130)+Height_StatusBar)];
        _headerImg.image = [UIImage imageNamed:@"new_shop_header_icon"];
        
        _headerImg.userInteractionEnabled=YES;
        
    }
    return _headerImg;
}



#pragma mark - 头部轮播视图
-(SDCycleScrollView *)headerView
{
    if (_headerView==nil)
    {
        UIImage *imageHeight=[UIImage imageNamed:@"bannerDefultShop"];
        
        _headerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(15),Height_NavBar, ScreenWidth - ScaleW(30), ScaleW(150)) delegate:self placeholderImage:imageHeight];
        
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        _headerView.delegate = self;
        
        _headerView.layer.cornerRadius = ScaleW(10);
        
        _headerView.layer.masksToBounds = YES;
        
        _headerView.backgroundColor = kNavBGColor;
        
        _headerView.autoScrollTimeInterval = 3.0;
        
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        _headerView.currentPageDotColor = kMainRedColor;
        
        _headerView.pageDotColor = kMainWihteColor;
        
        _headerView.currentPageDotImage = [UIImage imageNamed:@"banner_selected"];
        
        _headerView.pageDotImage = [UIImage imageNamed:@"banner_normal"];
        
        [self addSubview:_headerView];
        
    }
    
    return _headerView;
}
-(UICollectionView *)headerList
{
    if (!_headerList) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _headerList = [[UICollectionView alloc]initWithFrame:CGRectMake(ScaleW(0), _headerView.bottom + ScaleW(10), ScreenWidth, ScaleW(172)) collectionViewLayout:layout];
        _headerList.delegate = self;
        _headerList.dataSource = self;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width=(ScreenWidth)/5.0;
        
        layout.itemSize = CGSizeMake(width, ScaleW(83));
//        layout.sectionInset = UIEdgeInsetsMake(0, ScaleW(13), 0, ScaleW(-13));
        _headerList.backgroundColor = kNavBGColor;
        _headerList.pagingEnabled = YES;
        [_headerList registerClass:[Homlist_CollectionViewCell class] forCellWithReuseIdentifier:@"Homlist_CollectionViewCell"];
        _headerList.showsHorizontalScrollIndicator = NO;
    }
    return _headerList;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(6) + _headerList.bottom, ScreenWidth - ScaleW(30), ScaleW(1))];
        [self addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self).offset(ScaleW(15));
        make.top.equalTo(self->_headerList.mas_bottom).offset(ScaleW(6));
            make.right.equalTo(self).offset(-ScaleW(15));
            make.height.mas_equalTo(1);
            

        }];
        _lineView.backgroundColor = kMainLineColor;
    }
    return _lineView;
}

-(UIView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _lineView.bottom, ScreenWidth - ScaleW(30), ScaleW(40))];
        [self addSubview:_noticeView];
        
        [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(ScaleW(15));
        make.top.equalTo(self->_lineView.mas_bottom).offset(ScaleW(0));
            make.right.equalTo(self).offset(-ScaleW(15));
            make.height.mas_equalTo(ScaleW(40));
            
            
        }];
        _labaImg=[WLTools allocImageView:CGRectMake(0, ScaleW(13), ScaleW(17), ScaleW(14)) image:[UIImage imageNamed:@"laba_shop"]];
        
//        _labaImg.centerY=_noticeView.centerY;
        
        [_noticeView addSubview:_labaImg];
        
//        self.noticeLabel = [WLTools allocLabel:@"商城头条" font:systemFont(13) textColor:RGBCOLOR(100,100,100) frame:CGRectMake(ScaleW(34), ScaleW(13), ScaleW(180), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
////        _noticeLabel.centerY=_noticeView.centerY;
//
//        [_noticeView addSubview:self.noticeLabel];

        self.moreNoticeBtn = [ WLTools allocButton:SSKJLocalized(@"更多 >", nil) textColor:kGreenTextColor nom_bg:nil hei_bg:nil frame:CGRectMake(_noticeView.width-ScaleW(50), ScaleW(13), ScaleW(50), ScaleW(14))];
        
        self.moreNoticeBtn.titleLabel.font=systemFont(13);
//        _moreNoticeBtn.centerY=_noticeView.centerY;

        [_moreNoticeBtn addTarget:self action:@selector(moreNoiceClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_noticeView addSubview:_moreNoticeBtn];
        
        _noticeView.backgroundColor = kNavBGColor;
        
    }
    return _noticeView;
    
}
//g公告列表
-(void)moreNoiceClick:(UIButton*)sender{
    
    if (self.notifacationBlock) {
        
        self.notifacationBlock();
        
    }
}
-(UIView *)bommLine
{
    if (!_bommLine) {
        _bommLine = [[UIView alloc]initWithFrame:CGRectMake(0, _noticeView.bottom, ScreenWidth, ScaleW(10))];
        _bommLine.backgroundColor = kMainColor;
        [self addSubview:_bommLine];
        
        [_bommLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(ScaleW(0));
            make.top.equalTo(self->_noticeView.mas_bottom).offset(ScaleW(0));
            make.right.equalTo(self).offset(-ScaleW(0));
            make.height.mas_equalTo(ScaleW(10));
            
            
        }];
    }
    return _bommLine;
}

-(UIButton *)gotoShopBtton
{
    if (!_gotoShopBtton)
    {
        _gotoShopBtton = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoShopBtton.frame = CGRectMake(ScaleW(15), ScaleW(15) + _bommLine.bottom, ScreenWidth - ScaleW(30), ScaleW(105));
        [self addSubview:_gotoShopBtton];
        
        [_gotoShopBtton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(ScaleW(15));
            make.top.equalTo(self->_bommLine.mas_bottom).offset(ScaleW(15));
            make.right.equalTo(self).offset(-ScaleW(15));
            make.height.mas_equalTo(ScaleW(105));
            
            
        }];
       [_gotoShopBtton btn:_gotoShopBtton font:ScaleW(0) textColor:kMainBackgroundColor text:@"" image:nil sel:@selector(gotoShopBtton:) taget:self];
        [_gotoShopBtton setBackgroundImage:[UIImage imageNamed:@"guanggao_shop"] forState:(UIControlStateNormal)];
        
         UILabel *hotTitle = [WLTools allocLabel:SSKJLocalized(@"诚信店铺 震撼来袭", nil) font:systemBoldFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(127), ScaleW(54), ScaleW(130), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
        [_gotoShopBtton addSubview:hotTitle];
        
        
        UILabel *hotTitle1 = [WLTools allocLabel:SSKJLocalized(@"YEC商城甄选海量优质商家", nil) font:systemFont(ScaleW(12)) textColor:kMainTextColor frame:CGRectMake(ScaleW(127), ScaleW(78), ScaleW(150), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
        [_gotoShopBtton addSubview:hotTitle1];
        
        
    }
    return _gotoShopBtton;
}

-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10) + _gotoShopBtton.bottom, ScreenWidth, ScaleW(59))];
        
        _backView.backgroundColor = kNavBGColor;
        
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        [_backView addSubview:line];
        
        line.backgroundColor=kMainColor;
        
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, _backView.height-1, ScreenWidth,1)];
        [_backView addSubview:line2];
        
        line2.backgroundColor=kNavBGColor;
        
        UILabel *hotTitle = [WLTools allocLabel:SSKJLocalized(@"热门商品", nil) font:systemBoldFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(34), ScaleW(60), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        UILabel *subTile = [WLTools allocLabel:SSKJLocalized(@"（海量特价商品）", nil) font:systemFont(ScaleW(10)) textColor:kSubSubTxtColor frame:CGRectMake(hotTitle.right, ScaleW(34), ScaleW(100), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        [_backView addSubview:hotTitle];
        [_backView addSubview:subTile];
        [_backView addSubview:self.moreBtn];
    }
    return _backView;
}

-(UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame = CGRectMake(ScreenWidth - ScaleW(75),ScaleW(36), ScaleW(75), ScaleW(13));
        [_moreBtn btn:_moreBtn font:ScaleW(13) textColor:kMainWihteColor text:SSKJLocalized(@"更多 >", nil) image:nil sel:@selector(moreBtnAction:) taget:self];
    }
    return _moreBtn;
}

#pragma mark collectionViewdelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Homlist_CollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Homlist_CollectionViewCell" forIndexPath:indexPath];

    [collectionCell.headerImg sd_setImageWithURL:[NSURL URLWithString:_imagArray[indexPath.row]]];
    
    NSLog(@"imgURl::::%@",_imagArray[indexPath.row]);
                                     
    collectionCell.bottomLabel.text = self.titleArray[indexPath.row];
    
    return collectionCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.kindsArray[indexPath.row];
    !self.cateReteBlock?:self.cateReteBlock(dic);
}
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[SSKJLocalized(@"海外", nil),SSKJLocalized(@"百货", nil),SSKJLocalized(@"健康", nil),SSKJLocalized(@"美食", nil),SSKJLocalized(@"美妆", nil),SSKJLocalized(@"礼包", nil),SSKJLocalized(@"电器", nil),SSKJLocalized(@"母婴", nil),SSKJLocalized(@"外卖", nil),SSKJLocalized(@"美妆", nil)].mutableCopy;
    
    }
    return _titleArray;
}
-(NSMutableArray *)imagArray
{
    if (!_imagArray) {
        _imagArray = [NSMutableArray array];
//        for (int i = 0; i < 10; i ++) {
//            NSString *imagName = [NSString stringWithFormat:@"%d",i + 1];
//            [_imagArray addObject:imagName];
//        }
    }
    return _imagArray;
}
-(void)setNoticeArray:(NSArray *)noticeArray
{
    _noticeArray = noticeArray;
    [_rodlodText removeFromSuperview];
    WS(weakSelf);
    
    NSMutableArray *title = [NSMutableArray array];
    for (NSDictionary *dic in _noticeArray) {
//        "notice_id": "1",
//        "notice_title": "小喇叭消息1",
//        "notice_content": "小喇叭消息1的内容是我！！"
        [title addObject:dic[@"notice_title"]];
    }
    _rodlodText = [XBTextLoopView textLoopViewWith:title loopInterval:5.f initWithFrame:CGRectMake(_labaImg.right+ScaleW(20), 0, ScreenWidth -ScaleW(100), _noticeView.height) selectBlock:^(NSString *selectString, NSInteger index) {
        !weakSelf.notifacationBlock?:self.notifacationBlock();
    }];
    [_noticeView addSubview:_rodlodText];
}
-(void)gotoShopBtton:(UIButton *)sender
{
    !self.gotoBaussBlock?:self.gotoBaussBlock();
}
-(void)moreBtnAction:(UIButton *)sender
{
    !self.hotBlock?:self.hotBlock();
}
-(void)setBannerArray:(NSMutableArray *)bannerArray
{
    _bannerArray = bannerArray;
    
    NSMutableArray *urlArray = [NSMutableArray array];
    
    for (NSDictionary *dic in _bannerArray) {
        [urlArray addObject:[WLTools imageURLWithURL:dic[@"pic_url"]]];
    }
    
    self.headerView.imageURLStringsGroup = urlArray;
    
}

-(void)setKindsArray:(NSMutableArray *)kindsArray
{
    _kindsArray = kindsArray;
    
    [self.titleArray removeAllObjects];
    [self.imagArray removeAllObjects];
    for (NSDictionary *dic in kindsArray) {

        [self.titleArray addObject:dic[@"type_name"]];
        
        [self.imagArray addObject:[WLTools imageURLWithURL:dic[@"icon"]]];
         
        
        
    }
   
    [self.headerList reloadData];
    
}
@end
