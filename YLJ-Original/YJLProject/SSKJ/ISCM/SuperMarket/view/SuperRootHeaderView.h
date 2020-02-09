//
//  SuperRootHeaderView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuperRootHeaderView : UICollectionReusableView

@property (nonatomic, strong) NSArray *noticeArray;

@property (nonatomic, copy) void(^hotBlock)(void);

@property (nonatomic, copy) void(^notifacationBlock)(void);

@property (nonatomic, strong) NSMutableArray *bannerArray;

@property (nonatomic, strong) NSMutableArray *kindsArray;

@property (nonatomic, copy) void(^cateReteBlock)(NSDictionary *cate_id);

@property (nonatomic, copy) void(^gotoBaussBlock)(void);

@property (nonatomic, copy) void(^naviClickBlock)(NSInteger type);

@end

NS_ASSUME_NONNULL_END
