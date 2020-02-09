//
//  LockedTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "LockedTableViewCell.h"
#import "LLGifView.h"
@interface LockedTableViewCell()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *headerImg;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIButton *buyBtn;


@end
@implementation LockedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.contentView.backgroundColor = self.backgroundColor = kBgColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.backView];
    
    [self.backView addSubview:self.headerImg];
    
    [self.backView addSubview:self.nameLabel];
    
    [self.backView addSubview:self.detailLabel];
    
    [self.backView addSubview:self.priceLabel];
    
    [self.backView addSubview:self.buyBtn];
    
    
}
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(125))];
        _backView.backgroundColor = kMainWihteColor;
        _backView.layer.cornerRadius = ScaleW(10);
        
        
    }
    return _backView;
}

-(UIImageView *)headerImg
{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(90), ScaleW(90))];
        //_headerImg.backgroundColor = [UIColor purpleColor];
       // _headerImg.layer.cornerRadius = ScaleW(5);
        [_headerImg setCornerRadius:ScaleW(5)];
    
    }
    return _headerImg;
    
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"-----" font:systemBoldFont(ScaleW(16)) textColor:kTitleColor frame:CGRectMake(ScaleW(19) + _headerImg.right + ScaleW(19), ScaleW(25), ScaleW(200), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [WLTools allocLabel:@"0.00 ISCM" font:systemFont(ScaleW(12)) textColor:kTitleColor frame:CGRectMake(_nameLabel.left, _nameLabel.bottom + ScaleW(44), ScaleW(132), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _detailLabel;
    
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [WLTools allocLabel:@"价格：0.00 ETH" font:systemFont(ScaleW(12)) textColor:kTitleColor frame:CGRectMake(_nameLabel.left, _nameLabel.bottom + ScaleW(25), ScaleW(132), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _priceLabel;
    
        
}


-(UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.frame = CGRectMake(ScaleW(150) + _headerImg.right, ScaleW(76), ScaleW(75), ScaleW(30));
        [_buyBtn btn:_buyBtn font:ScaleW(12) textColor:kMainWihteColor text:@"抢购" image:nil sel:@selector(gotoBuyAction:) taget:self];
        
        _buyBtn.layer.cornerRadius = ScaleW(5);
        _buyBtn.backgroundColor = kMainBlueColor;
    }
    return _buyBtn;
}

-(void)gotoBuyAction:(UIButton *)sender
{
    !self.buyBlock?:self.buyBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(LockedModel *)model
{
    _model = model;
    
   
    
    _nameLabel.text = model.title;
    
    _priceLabel.text = [NSString stringWithFormat:@"%@ %.4fETH",SSKJLocalized(@"价格", nil),model.price.doubleValue];
    
    _detailLabel.text = [NSString stringWithFormat:@"数量 %@ ISCM",model.num];
    
    if ([[WLTools imageURLWithURL:model.icon] hasSuffix:@".gif"]) {
        for (UIView *v  in _headerImg.subviews) {
            [v removeFromSuperview];
            
        }
      LLGifView*  gifView = [[LLGifView alloc] initWithFrame:_headerImg.bounds url:[WLTools imageURLWithURL:model.icon]];
        
        [_headerImg addSubview: gifView];
        
        [gifView startGif];
    }else
    {
         [_headerImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.icon]]];
    }
    
}
@end
