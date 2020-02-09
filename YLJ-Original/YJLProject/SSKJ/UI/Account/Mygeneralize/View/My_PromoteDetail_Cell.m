//
//  My_PromoteDetail_Cell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/11/29.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "My_PromoteDetail_Cell.h"

@interface My_PromoteDetail_Cell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contactLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation My_PromoteDetail_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kSubBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.contactLabel];
    [self addSubview:self.timeLabel];
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        CGFloat width = (ScreenWidth - ScaleW(30)) / 3;
        _nameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTextColorb2b9e7 frame:CGRectMake(ScaleW(15), ScaleW(15), width, ScaleW(30)) textAlignment:NSTextAlignmentLeft];
        _nameLabel.centerY = ScaleW(30);
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}

-(UILabel *)contactLabel
{
    if (nil == _contactLabel) {
        _contactLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTextColorb2b9e7 frame:CGRectMake(self.nameLabel.right, 0, self.nameLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        _contactLabel.adjustsFontSizeToFitWidth = YES;
        _contactLabel.centerY = self.nameLabel.centerY;
    }
    return _contactLabel;
}

-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"" font:[UIFont systemFontOfSize:ScaleW(13)] textColor:kTextColorb2b9e7 frame:CGRectMake(self.contactLabel.right,0, self.nameLabel.width, ScaleW(60)) textAlignment:NSTextAlignmentRight];
        _timeLabel.centerY = self.nameLabel.centerY;
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}

-(void)setCellWithModel:(My_Promote_Index_Model *)model
{
    self.nameLabel.text = model.realname.length > 0 ? model.realname:@"--";
    
    self.contactLabel.text = model.mobile;
    if ([model.mobile isEqual:[NSNull null]] || model.mobile.length == 0) {
        self.contactLabel.text = model.mail;
        
        if ([model.mail isEqual:[NSNull null]]) {
            self.contactLabel.text = nil;
        }
    }
    
    
    self.timeLabel.text = [self dateStringWithTimeInterval:model.reg_time];
}

-(NSString *)dateStringWithTimeInterval:(NSString *)timeInterval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.doubleValue];
    return [formatter stringFromDate:date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
