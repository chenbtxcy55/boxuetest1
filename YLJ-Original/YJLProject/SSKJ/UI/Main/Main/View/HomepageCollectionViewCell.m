


#import "HomepageCollectionViewCell.h"

@interface HomepageCollectionViewCell()
@property (nonatomic, strong) UILabel  *cionName;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, strong) UILabel *cnyLabel;
@end
@implementation HomepageCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self viewConfig];
        self.contentView.backgroundColor =kBgColor353750;
    }
    return self;
}
-(void)viewConfig
{
    [self cionName];
    [self priceLabel];
    [self percentLabel];
    [self cnyLabel];
}
-(UILabel *)cionName
{
    if (!_cionName) {
        _cionName = [WLTools allocLabel:@"--" font:systemBoldFont(ScaleW(11)) textColor:kMainTextColor frame:CGRectMake(0, ScaleW(21), self.width, ScaleW(11)) textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_cionName];
        
    }
    return _cionName;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"--" font:systemBoldFont(ScaleW(17)) textColor:GREEN_HEX_COLOR frame:CGRectMake(0, _cionName.bottom + ScaleW(11), _cionName.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_priceLabel];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}
-(UILabel *)percentLabel
{
    if (!_percentLabel) {
        _percentLabel = [WLTools allocLabel:@"--" font:systemFont(ScaleW(12)) textColor:GREEN_HEX_COLOR frame:CGRectMake(0, _priceLabel.bottom + ScaleW(10), _priceLabel.width, ScaleW(10)) textAlignment:NSTextAlignmentCenter];
       
        [self.contentView addSubview:_percentLabel];
    }
    return _percentLabel;
}
-(UILabel *)cnyLabel
{
    if (!_cnyLabel) {
        _cnyLabel = [WLTools allocLabel:@"--" font:systemFont(ScaleW(14)) textColor:kTextColorb2b9e7 frame:CGRectMake(0, _percentLabel.bottom + ScaleW(10), _percentLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentCenter];
        _cnyLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_cnyLabel];
    }
    return _cnyLabel;
}
//-(void)setModel:(Market_Main_List_Model *)model
//{
//    _model = model;
//
//    _cionName.text = model.stockProductVO.name?:@"";
//
//
//    if (model.stockProductVO.price) {
//        _priceLabel.text = [NSString stringWithFormat:@"%.4f",[model.stockProductVO.price doubleValue]];
//    }else
//    {
//        _priceLabel.text = @"";
//    }
//    if ([model.stockProductVO.changeRate containsString:@"-"])
//    {
//
//
//        self.percentLabel.text = model.stockProductVO.changeRate;
//
//        self.priceLabel.textColor = HeightTextColor;
//
//        self.percentLabel.textColor = HeightTextColor;
//    }
//    else
//    {
//        if (model.stockProductVO.changeRate) {
//            self.percentLabel.text = [NSString stringWithFormat:@"+%@",model.stockProductVO.changeRate];
//        }else
//        {
//            self.percentLabel.text = @"";
//        }
//
//        self.priceLabel.textColor = HeightTextColor;
//
//        self.percentLabel.textColor = HeightTextColor;
//
//    }
//
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
//    WS(weakSelf);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//
//    });
//
//}
//
-(void)setCoinModel:(SSKJ_Market_Index_Model *)coinModel
{
    if (coinModel == nil) {
        
        self.cionName.text = @"--";
        self.priceLabel.text = @"--";
        self.percentLabel.text = @"--";

        return;
    }
    self.cionName.text = [[coinModel.code uppercaseString] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    self.priceLabel.text = [WLTools roundingStringWith:coinModel.price.doubleValue afterPointNumber:[WLTools dotNumberOfCoinCode:coinModel.code]];
    
    UIColor *color;
    if (coinModel.change.doubleValue > 0) {
        color = GREEN_HEX_COLOR;
    }else{
        color = RED_HEX_COLOR;
    }
    
    if ([coinModel.changeRate containsString:@"-"]) {
        self.percentLabel.text = coinModel.changeRate;
    }else{
        self.percentLabel.text = [@"+" stringByAppendingString:coinModel.changeRate];
    }
    
    self.priceLabel.textColor = color;
    self.percentLabel.textColor = color;
    
    
//    self.cnyLabel.text = [NSString stringWithFormat:@"≈%@CNY",[WLTools noroundingStringWith:coinModel.cnyPrice.doubleValue afterPointNumber:2]];
}

@end
