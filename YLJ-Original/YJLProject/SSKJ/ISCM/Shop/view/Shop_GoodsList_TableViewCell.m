//
//  Shop_GoodsList_TableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_GoodsList_TableViewCell.h"
@interface Shop_GoodsList_TableViewCell()

@property (nonatomic, strong) UIView *headerLine;

@property (nonatomic, strong) UIView *contenBackView;

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *upLine;

@property (nonatomic, strong) UIImageView *contenImg;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *typLabel;

@property (nonatomic, strong) UILabel *leftLabel1;

@property (nonatomic, strong) UILabel *leftLabel2;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *dpriceLabel;

@property (nonatomic, strong) UILabel *saledLabel;

@property (nonatomic, strong) UILabel *rasaveLabel;

@property (nonatomic, strong) UIView *downLine;

@property (nonatomic, strong) UIButton *onSaleBtn;

@property (nonatomic, strong) UIButton *edtingBtn;


@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) ICC_PreOrder_GoodsInfo_Model *goodsModel;

@property (nonatomic, assign) NSInteger type;





@end

@implementation Shop_GoodsList_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = self.contentView.backgroundColor = kBgColor353750;
        
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.headerLine];
    [self.contentView addSubview:self.contenBackView];
}

-(UIView *)headerLine
{
    if (!_headerLine) {
        _headerLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        _headerLine.backgroundColor = kMainColor;
    }
    return _headerLine;
}

-(UIView *)contenBackView
{
    if (!_contenBackView) {
        _contenBackView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(229))];
        _contenBackView.backgroundColor = kBgColor353750;
        
        [_contenBackView addSubview:self.numLabel];
        [_contenBackView addSubview:self.dateLabel];
        [_contenBackView addSubview:self.upLine];
        [_contenBackView addSubview:self.contenImg];
        [_contenBackView addSubview:self.titleLabel];
        [_contenBackView addSubview:self.typLabel];
        [_contenBackView addSubview:self.priceLabel];
        [_contenBackView addSubview:self.dpriceLabel];
//        [_contenBackView addSubview:self.saledLabel];
//        [_contenBackView addSubview:self.rasaveLabel];
        [_contenBackView addSubview:self.downLine];
        [_contenBackView addSubview:self.onSaleBtn];
        [_contenBackView addSubview:self.edtingBtn];
        [_contenBackView addSubview:self.deleteBtn];
        
        [_contenBackView addSubview:self.leftLabel1];
        [_contenBackView addSubview:self.leftLabel2];

    }
    return _contenBackView;
}

-(UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [WLTools allocLabel:@"编号：--" font:systemFont(13) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), 0, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _numLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"xxxx-xx-xx  xx:xx:xx" font:systemFont(13) textColor:kSubSubTxtColor frame:CGRectMake(ScreenWidth/2.f - ScaleW(15), 0, ScreenWidth/2.f, ScaleW(40)) textAlignment:(NSTextAlignmentRight)];
    }
    return _dateLabel;
}

-(UIView *)upLine
{
    if (!_upLine) {
        _upLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _dateLabel.bottom, ScreenWidth - ScaleW(30), ScaleW(1))];
        _upLine.backgroundColor = kLineGrayColor;
    }
    return _upLine;
}

-(UIImageView *)contenImg
{
    if (!_contenImg) {
        _contenImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _upLine.bottom,ScaleW(110), ScaleW(110))];
        _contenImg.backgroundColor = [UIColor purpleColor];
        
    }
    return _contenImg;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"日本制作榨汁机榨汁 月销过万 麦可酷M9便携式家用水果小型电动榨汁机" font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(_contenImg.right +ScaleW(10) , _contenImg.top, self.width-(_contenImg.right), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}
-(UILabel *)typLabel
{
    if (!_typLabel) {
        _typLabel = [WLTools allocLabel:@"类别：xxxx" font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(_titleLabel.left, _titleLabel.bottom, self.width-_titleLabel.left-ScaleW(10), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
        _typLabel.adjustsFontSizeToFitWidth=YES;
        
    }
    return _typLabel;
}
-(UILabel *)leftLabel1{
    
    if (!_leftLabel1) {
        
        _leftLabel1=[WLTools allocLabel:SSKJLocalized(@"价格", nil) font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(_titleLabel.left, ScaleW(15) + _typLabel.bottom, ScaleW(40), ScaleW(17)) textAlignment:NSTextAlignmentLeft];
       
    }
    
    return _leftLabel1;
    
}

-(UILabel *)leftLabel2{
    
    if (!_leftLabel2) {
        
        _leftLabel2=[WLTools allocLabel:SSKJLocalized(@"价格", nil) font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(_titleLabel.left, ScaleW(10) + _leftLabel1.bottom, ScaleW(40), ScaleW(17)) textAlignment:NSTextAlignmentLeft];
        
    }
    
    return _leftLabel2;
    
}
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        
       
        _priceLabel = [WLTools allocLabel:@"0.0000 " font:systemBoldFont(ScaleW(17)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(40) + _contenImg.right, ScaleW(15) + _typLabel.bottom, ScreenWidth-(ScaleW(55) + _contenImg.right), ScaleW(17)) textAlignment:(NSTextAlignmentLeft)];
        
        
    }
    return _priceLabel;
}
-(UILabel *)dpriceLabel{
    
    if (!_dpriceLabel) {
        
       
         _dpriceLabel = [WLTools allocLabel:@"0.0000 " font:systemBoldFont(ScaleW(17)) textColor:UIColorFromRGB(0x5ba56f) frame:CGRectMake(ScaleW(40) + _contenImg.right, ScaleW(10) + _priceLabel.bottom, ScreenWidth-(ScaleW(55) + _contenImg.right), ScaleW(17)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _dpriceLabel;
    
}
-(UILabel *)saledLabel

{
    if (!_saledLabel) {
        _saledLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(_typLabel.right+ScaleW(10), _typLabel.top, ScaleW(70), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
        _saledLabel.centerY = _priceLabel.centerY;
    }
    return _saledLabel;
}
-(UILabel *)rasaveLabel
{
    if (!_rasaveLabel) {
        _rasaveLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(_saledLabel.right,  _saledLabel.top, ScaleW(82), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
        _rasaveLabel.centerY = _priceLabel.centerY;
    }
    return _rasaveLabel;
}

-(UIView *)downLine
{
    if (!_downLine) {
        _downLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _contenImg.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(1))];
        _downLine.backgroundColor = kLineGrayColor;
    }
    return _downLine;
}
-(UIButton *)onSaleBtn
{
    if (!_onSaleBtn) {
        _onSaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_onSaleBtn btn:_onSaleBtn font:ScaleW(13) textColor:UIColorFromRGB(0x5ba56f) text:@"上架" image:nil sel:@selector(onSaleBtnAction:) taget:self];
        _onSaleBtn.frame = CGRectMake(ScaleW(230), ScaleW(8) + _downLine.bottom, ScaleW(60), ScaleW(25));
        [_onSaleBtn setCornerRadius:ScaleW(4)];
        [_onSaleBtn setBorderWithWidth:ScaleW(1) andColor:UIColorFromRGB(0x5ba56f)];
        
    }
    return _onSaleBtn;
}

-(UIButton *)edtingBtn
{
    if (!_edtingBtn) {
        _edtingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_edtingBtn btn:_edtingBtn font:ScaleW(13) textColor:UIColorFromRGB(0x5ba56f) text:SSKJLocalized(@"编辑", nil) image:nil sel:@selector(edtingBtnAction:) taget:self];
        _edtingBtn.frame = CGRectMake(_onSaleBtn.right + ScaleW(10), ScaleW(8) + _downLine.bottom, ScaleW(60), ScaleW(25));
        [_edtingBtn setCornerRadius:ScaleW(4)];
        [_edtingBtn setBorderWithWidth:ScaleW(1) andColor:UIColorFromRGB(0x5ba56f)];
        
    }
    return _edtingBtn;
}
-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn btn:_deleteBtn font:ScaleW(13) textColor:UIColorFromRGB(0x5ba56f) text:SSKJLocalized(@"删除", nil) image:nil sel:@selector(deleteBtnAction:) taget:self];
        _deleteBtn.frame = CGRectMake(ScaleW(230), ScaleW(8) + _downLine.bottom, ScaleW(60), ScaleW(25));
        _deleteBtn.left = _onSaleBtn.left - ScaleW(70);
        [_deleteBtn setCornerRadius:ScaleW(4)];
        [_deleteBtn setBorderWithWidth:ScaleW(1) andColor:UIColorFromRGB(0x5ba56f)];
        
    }
    return _deleteBtn;
}


-(void)onSaleBtnAction:(UIButton *)sender
{
    if (self.type == 1) {
       
        if (self.downGoodsBlock) {
            self.downGoodsBlock(self.goodsModel);
        }
        
    }else
    {
        if (self.upGoodsBlock) {
            self.upGoodsBlock(self.goodsModel);
        }
    }
}
-(void)edtingBtnAction:(UIButton *)sender
{
    if (self.editBlock) {
        self.editBlock(self.goodsModel);
    }
}
-(void)deleteBtnAction:(UIButton *)sender
{
    if (self.deleteBlock) {
        self.deleteBlock(self.goodsModel);
    }
}
-(void)setCellWithModel:(ICC_PreOrder_GoodsInfo_Model *)model goodsType:(NSInteger)goosType
{
    _goodsModel = model;
    self.type = goosType;
    [self.onSaleBtn setTitle:goosType == 1?SSKJLocalized(@"下架", nil):SSKJLocalized(@"上架", nil) forState:(UIControlStateNormal)];
    
    [self.contenImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.thumbnail_pic]] placeholderImage:[UIImage imageNamed:@"qrcode_default"]];
    
    self.titleLabel.text = model.name;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@", [WLTools noroundingStringWith:[model.skus doubleValue] afterPointNumber:2]];
    
    self.dpriceLabel.text = [NSString stringWithFormat:@"%@ ", [WLTools noroundingStringWith:[model.rmb_price doubleValue] afterPointNumber:2]];
    
    
    self.typLabel.text =[NSString stringWithFormat:@"%@%@ | %@%@ | %@%@",
                         SSKJLocalized(@"类别：", nil),model.title,SSKJLocalized(@"销量：", nil),model.sale_num,SSKJLocalized(@"价格：", nil),model.skus];
    self.numLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"编号：", nil),model.id];
   
    if (goosType == 1) {
        
        if (model.on_time.length ==0) {
            
            self.dateLabel.text=model.add_time;
            
        }
        else{
            
            self.dateLabel.text=model.on_time;

        }

        self.onSaleBtn.hidden = NO;
        self.edtingBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.onSaleBtn.left=ScreenWidth-ScaleW(75);
       
    }else{
        self.dateLabel.text=model.off_time;

        self.onSaleBtn.hidden = NO;
        self.edtingBtn.hidden = NO;
        self.deleteBtn.hidden = YES;

//        self.deleteBtn.hidden = NO;
    }
};

@end
