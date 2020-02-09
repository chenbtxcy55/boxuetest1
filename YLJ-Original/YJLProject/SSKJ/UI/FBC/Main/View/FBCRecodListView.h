//
//  FBCRecodListView.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBCRecodListView : UIView
-(void)headerRefresh;
@property (nonatomic, copy) void(^selecetCellBlock)(id objc);
@end

NS_ASSUME_NONNULL_END
