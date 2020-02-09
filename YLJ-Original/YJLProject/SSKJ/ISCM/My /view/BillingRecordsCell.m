//
//  BillingRecordsCell.m
//  SSKJ
//
//  Created by 孙 on 2019/7/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BillingRecordsCell.h"

#import "UIButton+LXMImagePosition.h"

@interface BillingRecordsCell()

@property (nonatomic, strong) UILabel *commitDate;  // 提交时间

@property (nonatomic, strong) UIView *lineView;


@property (nonatomic, strong) UILabel *getMoneyAddress;

@property (nonatomic, strong) UILabel *getMoneyAmount;


@property (nonatomic, strong) UILabel *beiZhuLab;


@property (nonatomic, strong) UILabel *succeedDate;

@end

@implementation BillingRecordsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig{
    [self lineView];
    [self getMoneyAddress];
    [self getMoneyAmount];
    [self commitDate];
    [self succeedDate];
    [self beiZhuLab];
}
-(UILabel *)getMoneyAddress{
    
    if (!_getMoneyAddress) {
        _getMoneyAddress = [[UILabel alloc]init];
        [self label:_getMoneyAddress font:14 textColor:WLColor(50, 50, 50, 1) text:@"类型"];
        [self.contentView addSubview:_getMoneyAddress];
        [_getMoneyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(@18);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
    }
    
    return _getMoneyAddress;
}

-(UILabel *)getMoneyAmount{
    
    if (!_getMoneyAmount) {
        _getMoneyAmount = [[UILabel alloc]init];
        [self label:_getMoneyAmount font:14 textColor:WLColor(50, 50, 50, 1) text:@"数量"];
        [self.contentView addSubview:_getMoneyAmount];
        [_getMoneyAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(self.getMoneyAddress.mas_bottom).offset(13);
        }];
    }
    
    return _getMoneyAmount;
}
-(UILabel*)beiZhuLab
{
    if (_beiZhuLab == nil) {
        
        _beiZhuLab = [[UILabel alloc] init];
        
        
        _beiZhuLab.font = systemScaleFont(14);
        _beiZhuLab.textColor = [UIColor colorWithRed:142.0f/255.0f green:148.0f/255.0f blue:163.0f/255.0f alpha:1.0f];
        _beiZhuLab.numberOfLines = 0;
        [self.contentView addSubview:_beiZhuLab];
//        [_beiZhuTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@62);
//            make.top.equalTo(self.commitDate.mas_bottom).offset(3);
//            make.height.equalTo(@60);
//            make.width.equalTo(@(ScaleW(238)));
//
//        }];
    }
    return _beiZhuLab;
    
}
- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineGrayColor;
        [self.contentView addSubview:_lineView];
       
    }
    return _lineView;
}



-(UILabel *)commitDate
{
    if (!_commitDate)
    {
        _commitDate = [[UILabel alloc]init];
        [self label:_commitDate font:14 textColor:WLColor(50, 50, 50, 1) text:@"时间"];
        [self.contentView addSubview:_commitDate];
        
        [_commitDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(self.getMoneyAmount.mas_bottom).offset(13);
        }];
    }
    return _commitDate;
}
-(UILabel *)succeedDate
{
    if (!_succeedDate)
    {
        _succeedDate = [[UILabel alloc]init];
        [self label:_succeedDate font:14 textColor:WLColor(50, 50, 50, 1) text:@"备注"];
        [self.contentView addSubview:_succeedDate];
        [_succeedDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(self.commitDate.mas_bottom).offset(13);
        }];
    }
    return _succeedDate;
}

-(void)setValuedataSoure:(id)dataSoure typeStr:(NSString*)type{
    [self addAttributeWithLabel:self.getMoneyAddress title:SSKJLocalized(@"类型", nil) value:type];
    
    //        self.getMoneyAddress.text = [NSString stringWithFormat:@"%@：    %@ ",SSKJLocalized(@"提币地址", nil),model.qianbao_url] ;
    self.getMoneyAddress.adjustsFontSizeToFitWidth = YES;
    
    [self addAttributeWithLabel:self.getMoneyAmount title:SSKJLocalized(@"数量", nil) value:dataSoure[@"price"]];
    
    [self addAttributeWithLabel:self.commitDate title:SSKJLocalized(@"时间", nil) value:[WLTools convertTimestamp:[dataSoure[@"addtime"] longLongValue] andFormat:@"yyyy-MM-dd HH:mm:ss"]];
    
    
    
    self.beiZhuLab.text = dataSoure[@"memo"];
    CGFloat height = [self.beiZhuLab.text boundingRectWithSize:CGSizeMake(ScaleW(238), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.beiZhuLab.font} context:nil].size.height;
    [self.beiZhuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@62);
        make.top.equalTo(self.commitDate.mas_bottom).offset(13);
        make.height.equalTo(@(height>17?height:17));
        make.width.equalTo(@(ScaleW(238)));
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.beiZhuLab.mas_bottom).offset(23);
        make.height.equalTo(@0.5);
    }];
    
}
-(void)setValuedataSoure:(id)dataSoure type:(NSInteger)type;
{
//    "1": "平台充值",
//    "3": "出金扣出",
//    "4": "出金返回",
//    "9": "提币手续费",
//    "11": "冻结金额",
//    "12": "出售下单",
//    "13": "购买下单",
//    "14": "申诉",
//    "25": "兑换币种",
//    "26": "购买锁仓套餐",
//    "27": "日释放",
//    "28": "直推释放待售",
//    "29": "直推释放待售至可售",
//    "30": "代数奖励至待售",
//    "101": "在线充值"
    NSString * typeStr = @"";
    int state = 0;
    if (type ==1) {
        
        state = [dataSoure[@"state"] intValue];
        
    }
    else
    {
        state = [dataSoure[@"type"] intValue];

    }
    switch (state) {
        case 1:
        {
            typeStr = @"平台充值";

        }
            break;
        case 3:
        {
            typeStr = @"出金扣出";
        }
            break;
        case 4:
        {
            typeStr = @"出金返回";

        }
            break;
        case 9:
        {
            
            typeStr = @"提币手续费";

        }
            break;
        case 11:
        {
            typeStr = @"冻结金额";

        }
            break;
        case 12:
        {
            
            typeStr = @"出售下单";

        }
            break;
        case 13:
        {
            typeStr = @"购买下单";
        }
            break;
        case 14:
        {
            typeStr = @"申诉";

        }
            break;
        case 25:
        {
            typeStr = @"兑换币种";

        }
            break;
        case 26:
        {
            typeStr = @"购买锁仓套餐";
        }
            break;
        case 27:
        {
            typeStr = @"日释放";

        }
            break;
        case 28:
        {
            typeStr = @"直推释放待售";

        }
            break;
        case 29:
        {
            typeStr = @"直推释放待售至可售";

        }
            break;
        case 30:
        {
            typeStr = @"代数奖励至待售";

        }
            break;
        case 101:
        {
            typeStr = @"在线充值";
            
        }
            break;
            
        default:
            break;
    }
    
    [self addAttributeWithLabel:self.getMoneyAddress title:SSKJLocalized(@"类型", nil) value:typeStr];
    
    //        self.getMoneyAddress.text = [NSString stringWithFormat:@"%@：    %@ ",SSKJLocalized(@"提币地址", nil),model.qianbao_url] ;
    self.getMoneyAddress.adjustsFontSizeToFitWidth = YES;
    
    [self addAttributeWithLabel:self.getMoneyAmount title:SSKJLocalized(@"数量", nil) value:dataSoure[@"price"]];
    
    [self addAttributeWithLabel:self.commitDate title:SSKJLocalized(@"时间", nil) value:[WLTools convertTimestamp:[dataSoure[@"addtime"] longLongValue] andFormat:@"yyyy-MM-dd HH:mm:ss"]];
   
    
    
    self.beiZhuLab.text = dataSoure[@"memo"];
    CGFloat height = [self.beiZhuLab.text boundingRectWithSize:CGSizeMake(ScaleW(238), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.beiZhuLab.font} context:nil].size.height;
    [self.beiZhuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@62);
        make.top.equalTo(self.commitDate.mas_bottom).offset(13);
        make.height.equalTo(@(height>17?height:17));
        make.width.equalTo(@(ScaleW(238)));
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.beiZhuLab.mas_bottom).offset(23);
        make.height.equalTo(@0.5);
    }];
}


-(void)addAttributeWithLabel:(UILabel *)label title:(NSString *)title value:(NSString *)value
{
    NSString *message = [NSString stringWithFormat:@"%@    %@",title,value];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:message];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:142.0f/255.0f green:148.0f/255.0f blue:163.0f/255.0f alpha:1.0f] range:NSMakeRange(title.length, message.length - title.length)];
    label.attributedText = attributeString;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
