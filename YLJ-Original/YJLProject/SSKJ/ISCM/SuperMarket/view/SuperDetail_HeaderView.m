//
//  SuperDetail_HeaderView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SuperDetail_HeaderView.h"
#define kimgTag(a) a + 1000
@interface SuperDetail_HeaderView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *headerView;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UILabel *lineView;

@property (nonatomic, strong) UILabel *buyCountLabel;


@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *reduceBtn;


@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *shopDetail;

@property (nonatomic, strong) UIImageView *contenImg;

@property (nonatomic, assign) NSInteger currentCount;

@property (nonatomic, strong) UIView *imagViewsView;

@property (nonatomic, strong) UIButton *keShouView; //可售view

@property (nonatomic, strong) UIButton *daiShouView; //待售view

@property (nonatomic, strong) UILabel *kPriceLabel;

@property (nonatomic, strong) UILabel *keShouLabel;

@property (nonatomic, strong) UILabel *dPriceLabel;

@property (nonatomic, strong) UILabel *daiShouLabel;


@end
@implementation SuperDetail_HeaderView

-(instancetype)init
{
    if (self = [super init]) {
        [self viewConfig];
        
    }
    return self;
}
-(void)viewConfig
{
    self.backgroundColor = kBgColor353750;
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(200));
    [self addSubview:self.headerView];
    [self addSubview:self.countLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.priceLabel];
//    [self addSubview:self.keShouView];
//    [self addSubview:self.daiShouView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.buyCountLabel];
    [self addSubview:self.addBtn];
    [self addSubview:self.reduceBtn];
    [self addSubview:self.currentCountLabel];
    [self addSubview:self.bottomLine];
    [self addSubview:self.shopDetail];
//    [self addSubview:self.contenImg];
//    [self addSubview:self.imagViewsView];
    self.height = self.shopDetail.bottom;
    self.currentCount = 0;
   // [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:0.5];
    self.daiShouView.backgroundColor=[UIColor whiteColor];
    
    self.daiShouView.layer.borderWidth=1;
    
    self.daiShouView.layer.borderColor=kMainBlueColor.CGColor;
    
    self.daiShouLabel.textColor=kMainBlueColor;
    
    self.dPriceLabel.textColor=kMainBlueColor;
    
    
    self.keShouView.backgroundColor=kMainBlueColor;
    
    self.keShouView.layer.borderWidth=0;
    
    self.keShouLabel.textColor=[UIColor whiteColor];
    
    self.kPriceLabel.textColor=[UIColor whiteColor];
    
}
-(void)dismissView
{
    // [MBProgressHUD hideHUDForView:self animated:YES];
}

-(SDCycleScrollView *)headerView
{
    if (_headerView==nil)
    {
        UIImage *imageHeight=[UIImage imageNamed:@"bannerDefult"];
        
        _headerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(0),ScaleW(0), ScreenWidth, ScreenWidth) delegate:self placeholderImage:nil];
        
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        _headerView.delegate = self;
        
        
        _headerView.backgroundColor = kSubBackgroundColor;
        
        _headerView.autoScrollTimeInterval = 3.0;
        
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        
        _headerView.currentPageDotColor = kMainRedColor;
        
        _headerView.pageDotColor = kMainWihteColor;
        
        _headerView.currentPageDotImage = [UIImage imageNamed:@"banner_selected"];
        
        _headerView.pageDotImage = [UIImage imageNamed:@"banner_normal"];
        
        [self addSubview:_headerView];
        
      }
    
   return _headerView;
}

-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [WLTools allocLabel:@"0/0" font:systemFont(ScaleW(10)) textColor:kSubClearBackColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(28), ScaleW(340), ScaleW(28), ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _countLabel;
    
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"--------------------------------------------------------------------------------------------------------" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), _headerView.bottom + ScaleW(15), ScaleW(345), ScaleW(36)) textAlignment:(NSTextAlignmentLeft)];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        
        NSInteger num = ScaleW(13)*180 /(ScreenWidth-ScaleW(30));
        
        CGFloat height=num*ScaleW(16);
        
        _detailLabel = [WLTools allocLabel:@"--------------------------------------------------------------------------------------------------------" font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), _titleLabel.bottom + ScaleW(10), ScreenWidth-ScaleW(30), height) textAlignment:(NSTextAlignmentLeft)];
        _detailLabel.numberOfLines = 0;
        _detailLabel.lineBreakMode=NSLineBreakByCharWrapping;
        
    }
    return _detailLabel;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"价格: ¥ 0.00" font:systemFont(ScaleW(15)) textColor:kMainRedColor frame:CGRectMake(ScaleW(15), ScaleW(21) + _detailLabel.bottom, ScreenWidth-ScaleW(30), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
}
-(UIButton *)keShouView{
    
    CGFloat space=ScaleW(15);
    
    CGFloat width = (ScreenWidth -3*space)/2.0;
    
    if (nil == _keShouView) {
        
        _keShouView = [[UIButton alloc]initWithFrame:CGRectMake(space, _detailLabel.bottom+ScaleW(15), width, ScaleW(65))];
        
        _keShouView.layer.cornerRadius = 5;
        
        _keShouView.layer.borderColor = [[UIColor colorWithRed:80.0f/255.0f green:113.0f/255.0f blue:210.0f/255.0f alpha:1.0f] CGColor];
        
        _keShouView.layer.borderWidth = 1;
        
        _keShouView.clipsToBounds=YES;
        
        self.kPriceLabel = [WLTools allocLabel:@"--" font:systemFont(17) textColor:kMainBlueColor frame:CGRectMake(5, ScaleW(18), width-10, ScaleW(18)) textAlignment:NSTextAlignmentCenter];
        
        [_keShouView addSubview:self.kPriceLabel];
        
        self.keShouLabel = [WLTools allocLabel:SSKJLocalized(@"可售", nil) font:systemFont(13) textColor:kMainBlueColor frame:CGRectMake(5, ScaleW(41), width-10, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
        
        [_keShouView addSubview:self.keShouLabel];
        
        [_keShouView addTarget:self action:@selector(btn1click:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return _keShouView;
    
}
-(void)btn1click:(UIButton*)sender{
    
    
    self.daiShouView.backgroundColor=[UIColor whiteColor];
    
    self.daiShouView.layer.borderWidth=1;
    
    self.daiShouView.layer.borderColor=kMainBlueColor.CGColor;
    
    self.daiShouLabel.textColor=kMainBlueColor;
    
    self.dPriceLabel.textColor=kMainBlueColor;

    
    self.keShouView.backgroundColor=kMainBlueColor;
    
    self.keShouView.layer.borderWidth=0;
    
    self.keShouLabel.textColor=[UIColor whiteColor];
    
    self.kPriceLabel.textColor=[UIColor whiteColor];
    
    if (self.typeBlock) {
        
        self.typeBlock(1);
        
    }

    
}
-(void)btn2click:(UIButton*)sender{
    
    self.keShouView.backgroundColor=[UIColor whiteColor];
    
    self.keShouView.layer.borderWidth=1;
    
    self.keShouView.layer.borderColor=kMainBlueColor.CGColor;
    
    self.keShouLabel.textColor=kMainBlueColor;
    
    self.kPriceLabel.textColor=kMainBlueColor;
    
    
    self.daiShouView.backgroundColor=kMainBlueColor;
    
    self.daiShouView.layer.borderWidth=0;
    
    self.dPriceLabel.textColor=[UIColor whiteColor];
    
    self.daiShouLabel.textColor=[UIColor whiteColor];
    
    if (self.typeBlock) {
        
        self.typeBlock(2);
        
    }
}
-(UIButton *)daiShouView{
    
    CGFloat space=ScaleW(15);
    
    CGFloat width = (ScreenWidth -3*space)/2.0;
    
    if (nil == _daiShouView) {
        
        _daiShouView = [[UIButton alloc]initWithFrame:CGRectMake(space+(width+space), _detailLabel.bottom+ScaleW(15), width, ScaleW(65))];
        
        _daiShouView.layer.cornerRadius = 5;
        
        _daiShouView.backgroundColor=kMainBlueColor;
        
        
        _daiShouView.clipsToBounds=YES;
        
        self.dPriceLabel = [WLTools allocLabel:@"--" font:systemFont(17) textColor:[UIColor whiteColor] frame:CGRectMake(5, ScaleW(18), width-10, ScaleW(18)) textAlignment:NSTextAlignmentCenter];
        
        [_daiShouView addSubview:self.dPriceLabel];
        
        self.daiShouLabel = [WLTools allocLabel:SSKJLocalized(@"待售", nil) font:systemFont(13) textColor:[UIColor whiteColor] frame:CGRectMake(5, ScaleW(41), width-10, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
        
        [_daiShouView addSubview:self.daiShouLabel];
        
        [_daiShouView addTarget:self action:@selector(btn2click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _daiShouView;
    
}
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"库存0个    0人付款" font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(ScaleW(15), _priceLabel.bottom+ScaleW(15), ScreenWidth - _keShouView.left - ScaleW(15), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, _messageLabel.bottom+ScaleW(15), ScreenWidth, 1)];
        
        label.backgroundColor=kLineGrayColor;
        
        
        [self addSubview:label];
        
    }
    return _messageLabel;
}

-(UILabel *)buyCountLabel
{
    if (!_buyCountLabel) {
        _buyCountLabel = [WLTools allocLabel:SSKJLocalized(@"购买数量", nil) font:systemFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), _messageLabel.bottom + ScaleW(15), ScreenWidth/2.f, ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _buyCountLabel;
}
-(UIButton *)reduceBtn
{
    if (!_reduceBtn) {
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceBtn.frame = CGRectMake(ScaleW(278), 0, ScaleW(22), ScaleW(22));
        _reduceBtn.centerY = _buyCountLabel.centerY;
        [_reduceBtn setBackgroundImage:[UIImage imageNamed:@"shop_delete_btn_new"] forState:(UIControlStateNormal)];
        [_reduceBtn addTarget:self action:@selector(addReduceBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _reduceBtn;
}
-(UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(ScaleW(278), 0, ScaleW(22), ScaleW(22));
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"shop_add_btn"] forState:(UIControlStateNormal)];
        _addBtn.centerY = _buyCountLabel.centerY;
        _addBtn.right = ScreenWidth - ScaleW(14);
        
        [_addBtn addTarget:self action:@selector(addReduceBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}
-(UILabel *)currentCountLabel

{
    if (!_currentCountLabel) {
        _currentCountLabel = [WLTools allocLabel:@"1" font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(_reduceBtn.right, 0, _addBtn.left - _reduceBtn.right, ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _currentCountLabel.centerY = _addBtn.centerY;
        
    }
    return _currentCountLabel;
}
-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, _buyCountLabel.bottom, ScreenWidth, ScaleW(10))];
        _bottomLine.backgroundColor = kMainLineColor;
    }
    return _bottomLine;
}
-(UILabel *)shopDetail
{
    if (!_shopDetail) {
        _shopDetail = [WLTools allocLabel:SSKJLocalized(@"商品详情", nil) font:systemFont(ScaleW(16)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), _bottomLine.bottom, ScreenWidth/2.f, ScaleW(55)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _shopDetail;
}
-(UIImageView *)contenImg
{
    if (!_contenImg) {
        _contenImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, _shopDetail.bottom, ScreenWidth, ScaleW(400))];
        _contenImg.backgroundColor = kBgColor353750;
    }
    return _contenImg;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
 _countLabel.width =  [_countLabel returnWidth:[NSString stringWithFormat:@"%ld/%ld",index +1,cycleScrollView.imageURLStringsGroup.count] font:ScaleW(5)] + ScaleW(8);
    _countLabel.right = ScreenWidth - ScaleW(15);
    _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",index +1,cycleScrollView.imageURLStringsGroup.count];
};
-(void)addReduceBtn:(UIButton *)sender
{
    if (sender == self.reduceBtn) {
         self.currentCount --;
    }else
    {
        if (self.currentCount == [_dataDic[@"skus"] integerValue]) {
            
            showAlert(@"库存不足");
            
            return;
            
        }
        self.currentCount ++;
    }
    if (self.currentCount <= 0) {
        self.currentCount =0;
    }
    
    self.currentCountLabel.text = [NSString stringWithFormat:@"%ld",self.currentCount];
    
}

-(void)setDataDic:(NSDictionary *)dataDic

{
    _dataDic = dataDic;

    _titleLabel.text = _dataDic[@"goods_name"];
    
    _detailLabel.text = [NSString stringWithFormat:@"%@",_dataDic[@"details"]];
    
    _kPriceLabel.text = [NSString stringWithFormat:@"%@ ",_dataDic[@"can_sell_price"]];

     _dPriceLabel.text = [NSString stringWithFormat:@"%@ ",_dataDic[@"wait_sell_price"]];
    
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@",_dataDic[@"rmb_price"]];
    
    _messageLabel.text = [NSString stringWithFormat:@"%@%@%@    %ld%@",SSKJLocalized(@"库存", nil),_dataDic[@"skus"],SSKJLocalized(@"个", nil),[[NSString stringWithFormat:@"%@",_dataDic[@"sale_num"]] integerValue],SSKJLocalized(@"人付款", nil)];
    
    for (UIView *v  in self.imagViewsView.subviews) {
        
        [v removeFromSuperview];
        
    }
//
    
    NSMutableArray *imgArray=[NSMutableArray new];
    
    for (NSString *url in [_dataDic objectForKey:@"pic_urls"]) {
        
        [imgArray addObject:[WLTools imageURLWithURL:url]];
        
        
    }
    
    _headerView.imageURLStringsGroup=imgArray;
    
    
//    NSArray *detaiImgs=[dataDic objectForKey:@"detail_pic_urls"];
    
    
//    _imagViewsView.top = self.contenImg.top;
//    __block UIImageView *imageView;
//
//    for (int i = 0; i < [_dataDic[@"pic_urls"] count]; i++) {
//        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, i *_contenImg.height, Screen_Width, _headerView.height)];
//        NSString *string = _dataDic[@"pic_urls"][i];
//        img.tag = kimgTag(i);
//        WS(weakSelf);
//
//        [img sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:string]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
////            img.height = image.size.height*(ScreenWidth/image.size.width);
//            weakSelf.imagViewsView.height += image.size.height*(ScreenWidth/image.size.width);
//            [weakSelf.imagViewsView addSubview:img];
//
//            if (i == 0) {
////                [img mas_makeConstraints:^(MASConstraintMaker *make) {
////                    make.top.mas_equalTo(0);
////                    make.width.mas_equalTo(ScreenWidth); make.height.mas_equalTo(image.size.height*(ScreenWidth/image.size.width));
////                }];
//                img.top = 0;
//                img.left = 0;
//                img.width = ScreenWidth;
//                img.height = image.size.height*(ScreenWidth/image.size.width);
//            }else{
////                [img mas_makeConstraints:^(MASConstraintMaker *make) {
////                    make.top.equalTo(imageView.mas_bottom);
////                    make.width.mas_equalTo(ScreenWidth); make.height.mas_equalTo(image.size.height*(ScreenWidth/image.size.width));
////                }];
//                img.top = imageView.bottom;
//                img.left = 0;
//                img.width = ScreenWidth;
//                img.height = image.size.height*(ScreenWidth/image.size.width);
//            }
//
//            imageView = img;
//
////            weakSelf.imagViewsView.height = img.bottom;
//
//            weakSelf.height = weakSelf.imagViewsView.bottom;
//
//            if (weakSelf.reloadBlock) {
//                weakSelf.reloadBlock();
//                [weakSelf reloadFrameImgs];
//            }
//        }];
//
//
//
//
//    }
//    for (NSString *string  in _dataDic[@"pic_urls"]) {
//
//        [_contenImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [WLTools imageURLWithURL:string]]]];
//
//    }
//    CGFloat d =  _shopDetail.bottom;
//    CGFloat f = ([_dataDic[@"pic_urls"] count])*_imagViewsView.height;
    
}
-(UIView *)imagViewsView{
    if (!_imagViewsView) {
        _imagViewsView = [[UIView alloc]initWithFrame:self.contenImg.frame];
        _imagViewsView.height = 0;
        
    }
    return _imagViewsView;
}
-(void)reloadFrameImgs
{
     for (int i = 0; i < [_dataDic[@"pic_urls"] count]; i++) {
   UIImageView *img = [self.imagViewsView viewWithTag:kimgTag(i)];
         
         if (i == 0) {
             img.top = 0;
            
         }else
         {
              UIImageView *lastImg = [self.imagViewsView viewWithTag:kimgTag(i-1)];
             img.top = lastImg.bottom;
         }
     }
}
@end
