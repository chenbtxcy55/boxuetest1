//
//  HKButtonView.m
//  SSKJ
//
//  Created by apple on 2019/9/6.
//  Copyright © 2019 HKK. All rights reserved.
//

#import "HKButtonView.h"


@implementation HKButtonView


-(HKButtonView *)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle andImg:(NSString *)imgName andFrame:(CGRect)frame isLeft:(BOOL)isLeft{
    
    HKButtonView *view=[[HKButtonView alloc]initWithFrame:frame];
    
    _myFrame=frame;
 
    _title=title;
    
    _subTitle=subTitle;
    
    _imgName=imgName;
    
    _isLleft=isLeft;
    
    view.userInteractionEnabled=YES;
    
    [view addSubview:self.fbcImageView];
    
    
    return view;
    
}
-(void)configUI{
    
}
-(UIImageView *)fbcImageView
{
    if (nil == _fbcImageView) {
        
      
        if (_isLleft) {
            
            _fbcImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(5), ScaleW(12), _myFrame.size.width - ScaleW(20), _myFrame.size.height-ScaleW(24))];
        
        }
        else{
            _fbcImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(12), _myFrame.size.width - ScaleW(20), _myFrame.size.height-ScaleW(24))];
        }
        
        
        _fbcImageView.backgroundColor = kMainBackgroundColor;
        
        _fbcImageView.userInteractionEnabled = YES;
        
        _fbcImageView.layer.masksToBounds = YES;
        
        _fbcImageView.layer.cornerRadius = 5;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//
//        [_fbcImageView addGestureRecognizer:tap];
        
      
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_fbcImageView.width - ScaleW(13) - ScaleW(60), 0, ScaleW(60), ScaleW(50))];
        
        imageView.centerY = _fbcImageView.height / 2;
        
        imageView.image = [UIImage imageNamed:self.imgName];
        
        imageView.backgroundColor=[UIColor clearColor];
        
        imageView.userInteractionEnabled=YES;
        
        [_fbcImageView addSubview:imageView];
        
        UILabel *label = [WLTools allocLabel:SSKJLocalized(self.title, nil) font:systemBoldFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(25), imageView.x - ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        
        [_fbcImageView addSubview:label];
        
        NSString *string = SSKJLocalized(self.subTitle,nil);
        
        CGFloat height = [string boundingRectWithSize:CGSizeMake(imageView.x - ScaleW(11), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(ScaleW(11))} context:nil].size.height;
        
        UILabel *contentLabel = [WLTools allocLabel:string font:systemFont(ScaleW(11)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), label.bottom + ScaleW(8), imageView.x - ScaleW(11), height) textAlignment:NSTextAlignmentLeft];
        
        [_fbcImageView addSubview:contentLabel];
        
        
    }
    return _fbcImageView;
}

-(void)tapAction:(UITapGestureRecognizer*)sender{
    
    SsLog(@"click2");
    
    if (self.block) {
        
        self.block();
        
    }
}



@end
