//
//  AccountTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/4/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "AccountTableViewCell.h"

@interface AccountTableViewCell()
@property (nonatomic, strong) UIImageView *lerVImg;




@end

@implementation AccountTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.contentView.backgroundColor = kMainWihteColor;
    self.backgroundColor = kMainWihteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.telNumLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.lerVImg];
}
-(UILabel *)telNumLabel
{
    if (!_telNumLabel) {
        _telNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(0), ScaleW(100), ScaleW(35))];
        [_telNumLabel label:_telNumLabel font:ScaleW(12) textColor:kSubTxtColor text:@"177****6325"];
        
    }
    return _telNumLabel;
}
-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(200) - ScaleW(15), _telNumLabel.top, ScaleW(200), ScaleW(35))];
        [_dateLabel label:_dateLabel font:ScaleW(12) textColor:kSubTxtColor text:@"2019-10-11 02:05:06"];
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}
-(UIImageView *)lerVImg{
    if (!_lerVImg) {
        _lerVImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(12), ScaleW(12))];
    }
    return _lerVImg;
}
-(void)setNameValue:(NSString *)nameValue
{
    _nameValue = nameValue;
    
    self.telNumLabel.text = _nameValue;
    
    [self.telNumLabel sizeToFit];
    
    _lerVImg.centerY = self.telNumLabel.centerY;
    
    _lerVImg.left = self.telNumLabel.right + ScaleW(10);
}

-(void)setVValues:(NSString *)vValues{
    _vValues = vValues;
    
    switch (_vValues.integerValue) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        default:
            break;
    }
    NSString *imgName = [NSString stringWithFormat:@"V%@",_vValues];
    self.lerVImg.image = [UIImage imageNamed:imgName];

    
}

@end
