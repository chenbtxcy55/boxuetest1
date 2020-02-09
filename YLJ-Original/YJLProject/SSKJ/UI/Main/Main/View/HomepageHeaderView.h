//
//  HomepageHeaderView.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_Market_Index_Model.h"
#import "SSKJ_Main_BannerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomepageHeaderView : UIView

@property (nonatomic, copy) void (^newListBlock)(void);
@property (nonatomic, copy) void (^newsIndexBlock)(NSInteger index);
@property (nonatomic, copy) void (^shopBlock)(void);
@property (nonatomic, copy) void (^inviteBlock)(void);
@property (nonatomic, copy) void (^signBlock)(void);


@property (nonatomic, copy) void (^bannerClickBlock)(NSInteger subIndex);


@property (nonatomic, copy) void (^lookMoreBlock)(void);
@property (nonatomic, copy) void (^HelpCenterBlock)(void);




@property (nonatomic, strong) NSArray *bannerArray;
@property (nonatomic, strong) NSArray *noticeArray;



@end

NS_ASSUME_NONNULL_END
