//
//  SKAssetsInfoCell.m
//  SSKJ
//
//  Created by 孙 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKAssetsInfoCell.h"
#import "UIButton+LXMImagePosition.h"

@interface SKAssetsInfoCell()

@property(nonatomic,strong)UILabel * typeLab;

@property(nonatomic,strong)UIButton * moneyDetailBtn;

/**
 可用
 */
@property(nonatomic,strong)UILabel * availableLab;

@property(nonatomic,strong)UILabel * availableContentLab;

/**
 冻结
 */
@property(nonatomic,strong)UILabel * freezeLab;

@property(nonatomic,strong)UILabel * freezeContentLab;

/**
 待售
 */
@property(nonatomic,strong)UILabel * forSaleLab;

@property(nonatomic,strong)UILabel * forSaleContentLab;

/**
 可售
 */
@property(nonatomic,strong)UILabel * availableSaleLab;

@property(nonatomic,strong)UILabel * availableSaleContentLab;

@property(nonatomic,strong)UIImageView * lineImaeView;

@end


@implementation SKAssetsInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        
        
        [self.contentView addSubview:self.typeLab];
//        self.typeLab.text = @"ISCM";
        
        [self.contentView addSubview:self.moneyDetailBtn];
   
        self.availableLab = [self createLabWithFrame:CGRectMake(_typeLab.left, _typeLab.bottom+26, ScaleW(65), 13) contentString:@"锁仓" WithColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] withFont:systemMediumFont(12)];
        [self.contentView addSubview:self.availableLab];

        self.availableContentLab = [self createLabWithFrame:CGRectMake(_availableLab.right +10, _availableLab.top, ScreenWidth/2-_availableLab.right -10-10, 13) contentString:@"654.3256" WithColor:[UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0f] withFont:systemBoldFont(12)];
        self.availableContentLab.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.availableContentLab];
        
        
        self.freezeLab = [self createLabWithFrame:CGRectMake(ScreenWidth/2+10, _typeLab.bottom+26, ScaleW(65), 13) contentString:@"冻结" WithColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] withFont:systemMediumFont(12)];
        [self.contentView addSubview:self.freezeLab];
        
        self.freezeContentLab = [self createLabWithFrame:CGRectMake(_freezeLab.right +10, _freezeLab.top, ScreenWidth/2-_freezeLab.width -10-10-15, 13) contentString:@"654.3256" WithColor:[UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0f] withFont:systemBoldFont(12)];
        self.freezeContentLab.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.freezeContentLab];
        
        
        
        
        self.forSaleLab = [self createLabWithFrame:CGRectMake(_typeLab.left, _availableLab.bottom+17, ScaleW(65), 13) contentString:@"待售(YEC)" WithColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] withFont:systemMediumFont(12)];
        [self.contentView addSubview:self.forSaleLab];
        
        self.forSaleContentLab = [self createLabWithFrame:CGRectMake(_forSaleLab.right +10, _forSaleLab.top, ScreenWidth/2-_forSaleLab.right -10-10, 13) contentString:@"654.3256" WithColor:[UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0f] withFont:systemBoldFont(12)];
        self.forSaleContentLab.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.forSaleContentLab];
        
        
        self.availableSaleLab = [self createLabWithFrame:CGRectMake(ScreenWidth/2+10, _freezeLab.bottom+17, ScaleW(65), 13) contentString:@"可售(YEC)" WithColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] withFont:systemMediumFont(12)];
        [self.contentView addSubview:self.availableSaleLab];
        
        self.availableSaleContentLab = [self createLabWithFrame:CGRectMake(_availableSaleLab.right +10, _availableSaleLab.top, ScreenWidth/2-_availableSaleLab.width -10-10-15, 13) contentString:@"654.3256" WithColor:[UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0f] withFont:systemBoldFont(12)];
        self.availableSaleContentLab.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.availableSaleContentLab];
        
        
        UIImageView* lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 112.5, ScreenWidth, .5)];
        lineImageView.backgroundColor = WLColor(231,234,237,1);
        self.lineImaeView = lineImageView;
        
        [self.contentView addSubview:self.lineImaeView];
        
        
    }
    return self;
}

-(UILabel*)typeLab
{
    if (!_typeLab) {
   
        UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(17, 18, 100, 15)];
        showTile.textColor = [UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0f];
        showTile.textAlignment = NSTextAlignmentLeft;
        showTile.font = systemBoldFont(17);
        showTile.adjustsFontSizeToFitWidth = YES;
        
        _typeLab = showTile;
    }
    return _typeLab;
    
}
-(UIButton*)moneyDetailBtn
{
    if (!_moneyDetailBtn) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenWidth -16- 50, 10, 50, 14 + 16);
        
        [button addTarget:self action:@selector(moneyDetaiEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        
        [button setTitle:@"明细" forState:UIControlStateNormal];
    
        button.titleLabel.font = systemMediumFont(14);
        [button setTitleColor:[UIColor colorWithRed:135.0f/255.0f green:170.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"icon_jiantou_right_blue"] forState:UIControlStateNormal];
        
        
        [button setImagePosition:LXMImagePositionRight spacing:10];
        _moneyDetailBtn = button;
    }
    
    return _moneyDetailBtn;
}
-(void)moneyDetaiEvent:(UIButton*)sender
{
    
    if ([self.model.type isEqualToString:@"ETH"]) {
        if (self.moneyDetailENTBLock) {
            self.moneyDetailENTBLock();
        }
    }
    else
    {
        if (self.moneyDetailBLock) {
            self.moneyDetailBLock();
        }
    }
   
}
-(UILabel*)createLabWithFrame:(CGRect)frame contentString:(NSString *)text WithColor:(UIColor*)color withFont:(UIFont*)font
{
    UILabel * showTile = [[UILabel alloc]initWithFrame:frame];
    showTile.textColor = color;
    showTile.font = font;
    showTile.adjustsFontSizeToFitWidth = YES;
    
    showTile.text = text;
    
    return showTile;
}
-(void)setModel:(SKAssetManagementModel *)model
{
    _model = model;
    if ([model.type isEqualToString:@"YEC"]) {
        self.typeLab.text = @"YEC";
        self.availableLab.text = [NSString stringWithFormat:@"锁仓(YEC)"];
        self.freezeLab.text = [NSString stringWithFormat:@"冻结(YEC)"];
        self.availableContentLab.text = [NSString stringWithFormat:@"%.4f",model.usableISCM.doubleValue];
        self.freezeContentLab.text = [NSString stringWithFormat:@"%.4f",model.frostISCM.doubleValue];
        self.forSaleContentLab.text = model.daishou;
        self.availableSaleContentLab.text = model.keshou;
        
        self.forSaleLab.hidden = NO;
        self.forSaleContentLab.hidden = NO;
        self.availableSaleLab.hidden = NO;
        self.availableSaleContentLab.hidden = NO;
        
        self.lineImaeView.top = 112.5;

    }
    else
    {
        self.typeLab.text = @"ETH";
        self.availableLab.text = [NSString stringWithFormat:@"锁仓(ETH)"];
        self.freezeLab.text = [NSString stringWithFormat:@"冻结(ETH)"];

        self.availableContentLab.text =[NSString stringWithFormat:@"%.4f",model.usableETH.doubleValue];
        self.freezeContentLab.text =[NSString stringWithFormat:@"%.4f",model.frostETH.doubleValue] ;
        
        self.forSaleLab.hidden = YES;
        self.forSaleContentLab.hidden = YES;
        self.availableSaleLab.hidden = YES;
        self.availableSaleContentLab.hidden = YES;
        self.lineImaeView.top = 99.5;

    }
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
