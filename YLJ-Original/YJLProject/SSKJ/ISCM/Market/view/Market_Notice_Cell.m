//
//  Market_Notice_Cell.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/26.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "Market_Notice_Cell.h"

@interface Market_Notice_Cell()

@property (nonatomic,strong) UIImageView * leftImg;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * timeLabel;

@property (nonatomic,strong) UIView * lineView;
@end

@implementation Market_Notice_Cell


#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor=kNavBGColor;
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self leftImg];

        [self titleLabel];
        
        [self timeLabel];
        
        [self lineView];
        
        UIImage *image = [UIImage imageNamed:@"Market_Notice_img"];
        [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.top.equalTo(self).offset(ScaleW(22));
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
            
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleW(22)));
            make.left.equalTo(self.leftImg.mas_right).offset(ScaleW(15));
            make.right.equalTo(@(ScaleW(-15)));
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(10));
            make.left.equalTo(self.leftImg.mas_right).offset(ScaleW(15));
            make.right.equalTo(@(ScaleW(-15)));
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.right.equalTo(@(ScaleW(-15)));
            make.bottom.equalTo(@(ScaleW(0)));
            make.height.equalTo(@(ScaleW(1)));
            make.top.equalTo(self.timeLabel.mas_bottom).offset(ScaleW(22));
        }];
    }
    
    return self;
}

- (UIImageView *)leftImg{
    if (_leftImg == nil) {
        UIImage *image = [UIImage imageNamed:@"Market_Notice_img"];
        _leftImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Market_Notice_img"]];
        [self.contentView addSubview:_leftImg];

    }
    return _leftImg;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(14) textColor: kMainTextColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
  
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTextLightBlueColor font:systemFont(12)];
        _timeLabel.numberOfLines = 2;
        [self.contentView addSubview:_timeLabel];

    }
    return _timeLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0x242549)];
        [self.contentView addSubview:_lineView];
 
    }
    return _lineView;
}

- (void)initDataWithModel:(GoCoin_TradingGuide_Model *)Model
{
    self.titleLabel.text = Model.title;
    
    self.timeLabel.text = [WLTools convertTimestamp:Model.create_time.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
