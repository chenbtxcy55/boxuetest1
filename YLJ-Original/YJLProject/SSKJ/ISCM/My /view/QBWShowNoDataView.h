//
//  QBWShowNoDataView.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/4/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBWShowNoDataView : UIView
//添加主视图
+(instancetype)showNoData:(BOOL)haveData toView:(UIView *)view offY:(CGFloat) offY;
@end
