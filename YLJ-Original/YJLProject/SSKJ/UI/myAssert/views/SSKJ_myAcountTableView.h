//
//  SSKJ_myAcountTableView.h
//  SSKJ
//
//  Created by GT on 2019/9/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLLAssetsInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_myAcountTableView : UIView
@property (nonatomic ,assign) NSInteger selectedIndex;//选择下标
@property (nonatomic ,strong) void(^selectedItemBlock)(NSInteger index);//点击item
@property (nonatomic ,strong) void(^selectedCellBlock)(int index);//点击item
@property (nonatomic ,strong) NSDictionary *assetDict;
@property (nonatomic ,strong) void(^refreshHeader)(void);
@property (nonatomic ,strong) void(^refreshFooter)(void);

@property (nonatomic ,assign) BOOL isHide;

@end

NS_ASSUME_NONNULL_END
