//
//  SKMain_Header_Cell.m
//  SSKJ
//
//  Created by 孙 on 2019/7/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMain_Header_Cell.h"
#import "CommonToolHelper.h"
#import "RegularExpression.h"
#import "UIImageView+KWSexangle.h"
@interface SKMain_Header_Cell()

@property(nonatomic,strong)UIView * bgView;

@property(nonatomic,strong)UIImageView * bgViewImageView;



@end

@implementation SKMain_Header_Cell

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
        
        
        
        [self.contentView addSubview:self.bgView];
        
        [self.bgView addSubview:self.bgViewImageView];
        [self.bgView addSubview:self.phoneLab];
        [self.bgView addSubview:self.uidLab];
        [self.bgView addSubview:self.stateLab];
        [self.bgView addSubview:self.headerImageView];
         [self.bgView addSubview:[self itemView]];
        
    }
    return self;
}
-(UIView*)bgView
{
    if (_bgView == nil) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 181 + ScaleW(26)+30 + 90*2)];
        
        _bgView.backgroundColor = WLColor(246, 247, 251, 1);
        
    }
    return _bgView;
    
}
-(UIImageView*)bgViewImageView
{
    if (_bgViewImageView == nil) {
        
        _bgViewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 181 + ScaleW(26)+30 + 90)];
        
        _bgViewImageView.image = [UIImage imageNamed:@"my_bgView"];
        
//        _bgViewImageView.backgroundColor = [UIColor blueColor];
    }
    return _bgViewImageView;
    
}
- (UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), Height_NavBar+10, 150, 20)];
        _phoneLab.textColor = kMainWihteColor;
        _phoneLab.font = systemBoldFont(ScaleW(25));
        _phoneLab.adjustsFontSizeToFitWidth = YES;
        _phoneLab.text = [self setupTitle:kISCMPhoneNumber];
    }
    return _phoneLab;
}
- (UILabel *)uidLab {
    if (!_uidLab) {
        _uidLab = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), self.phoneLab.bottom+24, 150, 20)];
        _uidLab.textColor = kMainWihteColor;
        _uidLab.font = systemScaleFont(17);
        _uidLab.adjustsFontSizeToFitWidth = YES;
        _uidLab.text = [NSString  stringWithFormat:@"UID:%@",[[SSKJ_User_Tool sharedUserTool] getUID]];
    }
    return _uidLab;
}

-(UILabel*)stateLab
{
    if (_stateLab == nil) {
        
    
        _stateLab = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), self.uidLab.bottom+19, ScaleW(75), ScaleW(26))];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_stateLab.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(15, 0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _stateLab.bounds;
        maskLayer.path = maskPath.CGPath;
        _stateLab.layer.mask = maskLayer;
        _stateLab.backgroundColor =WLColor(255, 255, 255, 0.2);
        _stateLab.textColor = [UIColor whiteColor];
        _stateLab.font = systemScaleFont(15);
        _stateLab.textAlignment = NSTextAlignmentCenter;
        _stateLab.text = @"已认证";
        
    }
    return _stateLab;
    
}
-(UIImageView*)headerImageView
{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] initWithDrawSexangleWithImageViewWidth:ScaleW(80) withLineWidth:4 withStrokeColor:[UIColor whiteColor]];
        _headerImageView.frame = CGRectMake( ScreenWidth- ScaleW(15)-100, Height_NavBar, ScaleW(80), ScaleW(86));
//        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.image =[UIImage imageNamed:@"my_header"];
        _headerImageView.layer.cornerRadius = _headerImageView.height/2;
        
//        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpMyInfo:)];
//        [_headerImageView addGestureRecognizer:tapGesture];
        
    }
    return _headerImageView;
    
}
//-(void)jumpMyInfo:(UIGestureRecognizer*)gesture
//{
//    
//    if (self.jumpMyInfo) {
//        
//        self.jumpMyInfo();
//    }
//    
//}
-(UIView *)itemView
{
    UIView * bgView =[[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), self.stateLab.bottom +30, ScreenWidth - ScaleW(15)*2, 60 *3)];
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    
    NSArray * titleArr = @[@"个人资料",@"资产管理",@"安全中心"];
    NSArray * imageViewArr = @[@"my_persionInfo",@"my_assertMannager",@"my_safeCenter"];
    
   
    for (int i = 0; i<3; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 60 *i, bgView.width, 60);
        
        [button addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        
        button.tag = 11223344 + i;
        
        [bgView addSubview:button];
        
        
        UIImageView * iconImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(15), (button.height-ScaleW(19))/2, ScaleW(19), ScaleW(19))];
        iconImageView.image = [UIImage imageNamed:imageViewArr[i]];
        [button addSubview:iconImageView];
        
        UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(iconImageView.right+ScaleW(16), (button.height -20)/2, 100, 20)];
        showTile.textColor = kMainWihteColor;
        showTile.font = [UIFont systemFontOfSize:ScaleW(14)];
        showTile.adjustsFontSizeToFitWidth = YES;
        showTile.textColor =[UIColor blackColor];

        showTile.text = titleArr[i];
        [button addSubview:showTile];
        
        
        UIImageView * arrowImageView =[[UIImageView alloc] initWithFrame:CGRectMake(button.width- ScaleW(15) -ScaleW(8), (button.height-ScaleW(13))/2, ScaleW(8), ScaleW(13))];
        
        arrowImageView.image = [UIImage imageNamed:@"my_rightArrow"];
        [button addSubview:arrowImageView];
        
        if (i !=2) {
            UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(15), button.height -.5, button.width -ScaleW(15) *2, .5)];
            lineImageView.backgroundColor =kLineGrayColor;
            [button addSubview:lineImageView];
        }
        
        
    }
    return bgView;
    
}
-(void)btnEvent:(UIButton *)sender
{
    
    if (self.myBlock) {
        self.myBlock(sender.tag - 11223344);
    }
    
}
- (NSString *)setupTitle:(NSString *)title {
    NSMutableString* str1 = [[NSMutableString alloc]initWithString:title];
    NSString *mobileStr;
    if ([RegularExpression validateMobile:title] ) {
        mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        NSRange range = [title rangeOfString:@"@"];
        
        if (range.location == 0) {
            [str1 insertString:@"*" atIndex:1];
            mobileStr = [NSString stringWithFormat:@"%@",str1];
        }else if (range.location == 1){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        }else if (range.location == 2){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"****"];
        }else if (range.location == 3){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"****"];
        }else if (range.location == 4){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@"****"];
        }else if (range.location == 5){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"****"];
        }else{
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 4) withString:@"****"];
        }
    }
    return mobileStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
