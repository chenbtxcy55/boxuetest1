//
//  XBTextLoopTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2018/12/21.
//  Copyright © 2018 刘小雨. All rights reserved.
//

#import "XBTextLoopTableViewCell.h"
#define kCellHeight 44.f
@interface XBTextLoopTableViewCell()
@end

@implementation XBTextLoopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    [self contentTxtLabel];
}
-(UILabel *)contentTxtLabel{
    if (!_contentTxtLabel) {
        _contentTxtLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-ScaleW(30)-ScaleW(70), kCellHeight)];
        [_contentTxtLabel label:_contentTxtLabel font:14 textColor:kMainTextColor text:@"--"];
        _contentTxtLabel.adjustsFontSizeToFitWidth = NO;
        _contentTxtLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_contentTxtLabel];
        
    }
    return _contentTxtLabel;
}

@end
