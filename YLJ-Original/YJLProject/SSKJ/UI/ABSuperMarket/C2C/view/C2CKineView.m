//
//  C2CKineView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "C2CKineView.h"
#import "BCLineViews.h"
@interface C2CKineView()
@property (nonatomic, strong) BCLineViews *KlineView;
@end

@implementation C2CKineView

-(instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = kMainWihteColor;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(180));
        
        
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    [self addSubview:self.KlineView];
}
-(BCLineViews *)KlineView{
    if (!_KlineView) {
        _KlineView = [[BCLineViews alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height)];
    }
    return _KlineView;
}
-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    
    self.KlineView.dataArr = _dataArr;
}

@end
