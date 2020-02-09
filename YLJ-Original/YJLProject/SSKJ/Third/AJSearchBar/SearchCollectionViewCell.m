//
//  SearchCollectionViewCell.m
//  准到-ipad
//
//  Created by zhundao on 2017/9/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.wordLabel];
    }
    return self;
}



- (UILabel *)wordLabel{
    if (!_wordLabel) {
        _wordLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        
        _wordLabel.textColor = kMainWihteColor;
        _wordLabel.backgroundColor = [UIColor clearColor];
        _wordLabel.font = KweixinFont(14);
        
        _wordLabel.layer.cornerRadius = 3;
        
        _wordLabel.layer.masksToBounds = YES;
        
        _wordLabel.textAlignment = NSTextAlignmentCenter;
        
        _wordLabel.layer.borderColor = [kMainWihteColor CGColor];
        
        _wordLabel.layer.borderWidth = 1;
    }
    return _wordLabel;
}

- (void)setSearchStr:(NSString *)searchStr{
    
    _searchStr = searchStr;
    
    SsLog(@"searchStr:::::%@",searchStr);
    
    _wordLabel.text = _searchStr;
    
    CGSize size = [_searchStr boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :KweixinFont(14)} context:nil].size;
    
    _wordLabel.frame = CGRectMake(10, ScaleW(20), size.width+30, 30);
    
}

- (CGSize)sizeForCell {
    
    return CGSizeMake(_wordLabel.frame.size.width+20, 50);
    
}

@end
