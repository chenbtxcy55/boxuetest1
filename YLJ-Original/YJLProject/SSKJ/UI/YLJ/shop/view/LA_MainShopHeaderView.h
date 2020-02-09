//
//  LA_MainShopHeaderView.h
//  SSKJ
//
//  Created by GT on 2019/7/25.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LA_MainShopHotListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LA_MainShopHeaderView : UICollectionReusableView
@property (nonatomic, copy) NSArray *dataSourceArray;
@property (nonatomic, copy) void (^guanggaoBlock)(void);    //广告
@property (nonatomic, copy) void (^selectBlock)(NSInteger index);    //选中了哪个热门

@end

NS_ASSUME_NONNULL_END
