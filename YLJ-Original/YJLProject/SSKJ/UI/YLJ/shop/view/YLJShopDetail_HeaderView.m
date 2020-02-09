//
//  YLJShopDetail_HeaderView.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJShopDetail_HeaderView.h"
#import "UILabel+WJFUN.h"
@interface YLJShopDetail_HeaderView()
<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *headerView;
@property (nonatomic,strong) UILabel *titleNavLabel;
@property (nonatomic,strong) UIButton *leftNavBtn;
@property (nonatomic,strong) UIButton *rightNavBtn;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *contentLabel;

@end
@implementation YLJShopDetail_HeaderView

-(instancetype)init
{
    if (self = [super init]) {
        [self viewConfig];
        
    }
    return self;
}
-(void)viewConfig
{
    self.backgroundColor = kMainWihteColor;
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(360));
    [self addSubview:self.headerView];
//    [self addSubview:self.titleNavLabel];
//    [self addSubview:self.leftNavBtn];
//    [self addSubview:self.rightNavBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.contentLabel];
    self.height = self.contentLabel.bottom;

//    [self testResetHeight];
}
- (void) testResetHeight {
    NSString *str = @"武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤武动乾坤";
    self.contentLabel.text = str;
    self.contentLabel.height = [WLTools getStringHeight:str fontSize:ScaleW(12) witdh:ScreenWidth - ScaleW(30)];
    NSLog(@"%f",self.contentLabel.height);
    self.height = self.contentLabel.bottom;
}

- (void)setSModel:(LA_MainShopHotListModel *)sModel {
    self.titleLabel.text = sModel.goods_name;
//    NSString *price;
//    if (sModel.rmb_price.length > 0) {
//        price = sModel.rmb_price;
//        self.priceLabel.text = [NSString stringWithFormat:@"%.2f余额",price.doubleValue];
//
//    }
//    if (sModel.can_sell_price.length > 0) {
//        price = sModel.can_sell_price;
//        self.priceLabel.text = [NSString stringWithFormat:@"%.2f 购物券",price.doubleValue];
//    }
    self.priceLabel.text = [WLTools setTotalPriceWithJifen:sModel.can_sell_price andPrice:sModel.rmb_price];
    [self.priceLabel sizeToFit];
    self.countLabel.text = [NSString stringWithFormat:@"库存%@件",sModel.skus];
    [self.countLabel sizeToFit];
    self.countLabel.left = ScreenWidth - ScaleW(15) - self.countLabel.size.width;
    NSMutableArray *mutableArray = @[].mutableCopy;
    for (NSString *url in sModel.detail_pic_urls) {
        NSString *nUrlStr = [WLTools imageURLWithURL:url];
        [mutableArray addObject:nUrlStr];
    }
//    NSString *urlStr = sModel.thumbnail_pic;
//    NSString *nUrlStr = [WLTools imageURLWithURL:urlStr];
    NSArray *testArray = mutableArray.copy;
//    [self.headerView sd_setImageWithURL:[NSURL URLWithString:nUrlStr] placeholderImage:[UIImage imageNamed:@"suolueTu"]];
    self.headerView.imageURLStringsGroup = testArray;
    
//    self.contentLabel.attributedText = [self getanOther:sModel.details];
    self.contentLabel.attributedText = [self setAttributedString:sModel.details font:systemFont(12) lineSpacing:ScaleW(10)];
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel sizeToFit];
    CGRect rect = self.contentLabel.frame;
//    rect.size.height = [self getAttriHeightWithLabel:self.contentLabel width:self.bounds.size.width];
    rect.size.height = [self getHTMLHeightByStr:sModel.details font:systemFont(ScaleW(12)) lineSpacing:ScaleW(10) width:ScreenWidth];
    self.contentLabel.textColor = kMainTextColor;
    self.contentLabel.frame = rect;
    self.height = self.contentLabel.bottom;
}

-(NSMutableAttributedString *)setAttributedString:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    //如果有换行，把\n替换成<br/>
    //如果有需要把换行加上
    //    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    //设置HTML图片的宽度
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    //设置富文本字的大小
    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [htmlString length])];
    
    return htmlString;
    
}

-(NSAttributedString *)getanOther:(NSString *)string
{
    NSAttributedString *trimmedString =   [self strToAttriWithStr:string];
    
    return trimmedString;
    
}

/**
 *  富文本转html字符串
 */
- (NSString *)attriToStrWithAttri:(NSAttributedString *)attri{
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    
    NSData *htmlData = [attri dataFromRange:NSMakeRange(0, attri.length)
                         documentAttributes:tempDic
                                      error:nil];
    
    return [[NSString alloc] initWithData:htmlData
                                 encoding:NSUTF8StringEncoding];
}

/**
 *  字符串转富文本
 */
- (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr{
    return [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
}

/**
 *获得富文本的高度
 **/
-(CGFloat)getAttriHeightWithLabel:(UILabel *)label width:(CGFloat)width {
    CGFloat height = [label.attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;//针对富文本
    return height;
}
/**
 计算html字符串高度
 
 @param str html 未处理的字符串
 @param font 字体设置
 @param lineSpacing 行高设置
 @param width 容器宽度设置
 @return 富文本高度
 */
-(CGFloat )getHTMLHeightByStr:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width
{
    //    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",[UIScreen mainScreen].bounds.size.width,str];
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [htmlString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, htmlString.length)];
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [htmlString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [htmlString length])];
    
    CGSize contextSize = [htmlString boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return contextSize.height ;
    
    
}

-(SDCycleScrollView *)headerView
{
    if (_headerView==nil)
    {
        
        _headerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(0),ScaleW(0), ScreenWidth, ScaleW(360)) delegate:self placeholderImage:[UIImage imageNamed:@"shop_default"]];
        
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        _headerView.delegate = self;
        
//        _headerView.backgroundColor = kRedColor;
        
        _headerView.autoScrollTimeInterval = 3.0;
        
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        
        _headerView.currentPageDotColor = kTheMeColor;
        
        _headerView.pageDotColor = kMainWihteColor;
        
        _headerView.currentPageDotImage = [UIImage imageNamed:@"banner_selected"];
        
        _headerView.pageDotImage = [UIImage imageNamed:@"banner_normal"];
        
        [self addSubview:_headerView];
        
    }
    
    return _headerView;
}
- (UILabel *)titleNavLabel {
    if (!_titleNavLabel) {
        _titleNavLabel = [WLTools allocLabel:SSKJLocalized(@"商品详情", nil) font:systemFont(ScaleW(18)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(0), ScaleW(34), ScaleW(85), ScaleW(18)) textAlignment:NSTextAlignmentCenter];
        _titleNavLabel.centerX = self.centerX;
    }
    return _titleNavLabel;
}

- (UIButton *)leftNavBtn {
    if (!_leftNavBtn) {
        _leftNavBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(5), 0, ScaleW(60), ScaleW(44))];
        [_leftNavBtn setImage:[UIImage imageNamed:@"commentWhite"] forState:UIControlStateNormal];
        _leftNavBtn.centerY = self.titleNavLabel.centerY;
    }
    return _leftNavBtn;
    
}

- (UIButton *)rightNavBtn {
    if (!_rightNavBtn) {
        _rightNavBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:[UIImage imageNamed:@"lange_EN"] frame:CGRectMake(ScreenWidth - ScaleW(25) - ScaleW(15), 0, ScaleW(25), ScaleW(44))];
        _rightNavBtn.centerY = self.titleNavLabel.centerY;
    }
    [_rightNavBtn setImage:[UIImage imageNamed:@"lange_EN"] forState:UIControlStateNormal];
    return _rightNavBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"一次购买三件可享8折优惠,95#汽油5L一次一次购买三件可享8折优惠,95#汽油5L一次一次购买三件可享8折优惠,95#汽油5L一次一次购买三件可享8折优惠,95#汽油5L一次" font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.headerView.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(37)) textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"126.50 购物券" font:systemFont(ScaleW(20)) textColor:kTheMeColor frame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom + ScaleW(26), ScaleW(130), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        [_priceLabel text:@" 购物券" color:kTheMeColor font:systemFont(16)];
        _priceLabel.numberOfLines = 1;
    }
    return _priceLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [WLTools allocLabel:@"库存1452件" font:systemFont(ScaleW(14)) textColor:kGrayTitleColor frame:CGRectMake(ScaleW(290), 0, ScaleW(160), ScaleW(14)) textAlignment:NSTextAlignmentRight];
        _countLabel.centerY = self.priceLabel.centerY;
    }
    return _countLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [WLTools allocLabel:SSKJLocalized(@"商品详情", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(0,self.priceLabel.bottom + ScaleW(40),ScreenWidth,ScaleW(14)) textAlignment:(NSTextAlignmentCenter)];
        _detailLabel.numberOfLines = 0;
        _detailLabel.lineBreakMode=NSLineBreakByCharWrapping;
        
    }
    return _detailLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.frame = CGRectMake(0, self.detailLabel.bottom + ScaleW(2), ScaleW(55), ScaleW(1));
        _lineView.centerX = self.centerX;
        _lineView.backgroundColor = kTheMeColor;
    }
    return _lineView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [WLTools allocLabel:@"------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" font:systemFont(12) textColor:kGrayTitleColor frame:CGRectMake(self.priceLabel.x, self.lineView.bottom + ScaleW(14), ScreenWidth - ScaleW(30), ScaleW(100)) textAlignment:NSTextAlignmentLeft];
        _contentLabel.lineBreakMode=NSLineBreakByCharWrapping;
    }
    return _contentLabel;
}

@end
