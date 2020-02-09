//
//  CISetupTableViewCell.m
//  ZYW_MIT
//
//  Created by terre sea on 2019/9/3.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "CISetupTableViewCell.h"

@interface CISetupTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end



@implementation CISetupTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconImageView];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(ScaleW(15), 0, ScaleW(12), kCISetupTableViewCellHeight) textAlignment:NSTextAlignmentCenter];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _titleLabel;
    
}


-(UIImageView *)iconImageView
{
    if (nil == _iconImageView) {
        UIImage *icon = [UIImage imageNamed:(@"mine_duigou")];
        _iconImageView = [WLTools allocImageView:CGRectMake(ScreenWidth-icon.size.width-15, (kCISetupTableViewCellHeight-icon.size.height)/2, icon.size.width, icon.size.height) image:icon];
        [_iconImageView setHidden:YES];
    }
    return _iconImageView;

}


@end
