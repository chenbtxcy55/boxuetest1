//
//  SKMyExtract_RecordCell.m
//  SSKJ
//
//  Created by 孙 on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMyExtract_RecordCell.h"
#import "UIButton+LXMImagePosition.h"

@interface SKMyExtract_RecordCell()

@property (nonatomic, strong) UILabel *commitDate;  // 提交时间

@property (nonatomic, strong) UIView *lineView;


@property (nonatomic, strong) UILabel *getMoneyAddress;

@property (nonatomic, strong) UILabel *getMoneyAmount;

@property (nonatomic, strong) UILabel *getMoneyState;


@property (nonatomic, strong) UILabel *succeedDate;

@end

@implementation SKMyExtract_RecordCell

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
    [self getMoneyState];

}
-(UILabel *)getMoneyAddress{
    
    if (!_getMoneyAddress) {
        _getMoneyAddress = [[UILabel alloc]init];
        [self label:_getMoneyAddress font:14 textColor:WLColor(50, 50, 50, 1) text:@"充值地址"];
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
        [self label:_getMoneyAmount font:14 textColor:WLColor(50, 50, 50, 1) text:@"充值数量"];
        [self.contentView addSubview:_getMoneyAmount];
        [_getMoneyAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(self.getMoneyAddress.mas_bottom).offset(13);
        }];
    }
    
    return _getMoneyAmount;
}

- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineGrayColor;
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.succeedDate.mas_bottom).offset(25);
            make.height.equalTo(@0.5);
        }];
    }
    return _lineView;
}

-(UILabel *)getMoneyState
{
    if (!_getMoneyState)
    {
        _getMoneyState = [[UILabel alloc]init];
        [self label:_getMoneyState font:15 textColor:WLColor(50, 50, 50, 1) text:@"待审核"];
        [self.contentView addSubview:_getMoneyState];
        [_getMoneyState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(self.succeedDate.mas_centerY);
        }];
    }
    return _getMoneyState;
}


-(UILabel *)commitDate
{
    if (!_commitDate)
    {
        _commitDate = [[UILabel alloc]init];
        [self label:_commitDate font:14 textColor:WLColor(50, 50, 50, 1) text:@"提交时间"];
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
        [self label:_succeedDate font:14 textColor:WLColor(50, 50, 50, 1) text:@"审核时间"];
        [self.contentView addSubview:_succeedDate];
        [_succeedDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(self.commitDate.mas_bottom).offset(13);
        }];
    }
    return _succeedDate;
}


-(void)setValuedataSoure:(id)dataSoure type:(NSInteger)type;
{
    NSString * state =dataSoure[@"state"];
    NSString * status = @"";
//    ,1 待审核 2到账中 3已拒绝 4已到账
    if (state.integerValue == 1) {
        status = SSKJLocalized(@"待审核", nil);
//        self.getMoneyState.hidden = NO;
        
//        self.succeedDate.hidden = YES;
    }
    else if (state.integerValue == 2){
        status = SSKJLocalized(@"到账中", nil);
//        self.getMoneyState.hidden = NO;
        
//        self.succeedDate.hidden = NO;
        _getMoneyState.textColor = [UIColor redColor];
    }
    else if(state.integerValue == 3){
//        self.getMoneyState.hidden = NO;
        status = SSKJLocalized(@"已拒绝", nil);
        //            self.errorImg.hidden = NO;
        //            self.errorMessage.hidden = NO;
        //            self.succeedDate.hidden = NO;
        _getMoneyState.textColor = RED_HEX_COLOR;
//        self.succeedDate.hidden = YES;
        
    }
    else if (state.integerValue == 4){
        status = SSKJLocalized(@"已到账", nil);
//        self.getMoneyState.hidden = NO;
        
//        self.succeedDate.hidden = NO;
        _getMoneyState.textColor = [UIColor redColor];
    }
   
    _getMoneyState.text = [NSString stringWithFormat:@"%@",status];
    
    [self addAttributeWithLabel:self.getMoneyAddress title:SSKJLocalized(@"提币地址", nil) value:dataSoure[@"qianbao_url"]];
    
    //        self.getMoneyAddress.text = [NSString stringWithFormat:@"%@：    %@ ",SSKJLocalized(@"提币地址", nil),model.qianbao_url] ;
    self.getMoneyAddress.adjustsFontSizeToFitWidth = YES;
    
    [self addAttributeWithLabel:self.getMoneyAmount title:SSKJLocalized(@"提币数量", nil) value:dataSoure[@"price"]];
    
    //        self.getMoneyAmount.text =[NSString stringWithFormat:@"%@：    %@ ",SSKJLocalized(@"提币数量", nil),model.actual] ;
    //        [self addAttributeWithLabel:self.getMoneyAmount title:SSKJLocalized(@"提交时间", nil) value:[WLTools convertTimestamp:model.addtime.longLongValue andFormat:@"yyyy-MM-dd HH:mm:ss"]];
//    [WLTools convertTimestamp:model.createTime.longLongValue / 1000 andFormat:@"yyyy-MM-dd HH:mm:ss"]
    [self addAttributeWithLabel:self.commitDate title:SSKJLocalized(@"提交时间", nil) value:[WLTools convertTimestamp:[dataSoure[@"addtime"] longLongValue] andFormat:@"yyyy-MM-dd HH:mm:ss"]];

//    [WLTools convertTimestamp:model.inspectTime.longLongValue / 1000 andFormat:@"yyyy-MM-dd HH:mm:ss"]
    [self addAttributeWithLabel:self.succeedDate title:SSKJLocalized(@"审核时间", nil) value:[WLTools convertTimestamp:[dataSoure[@"check_time"] longLongValue] andFormat:@"yyyy-MM-dd HH:mm:ss"]];
    
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
