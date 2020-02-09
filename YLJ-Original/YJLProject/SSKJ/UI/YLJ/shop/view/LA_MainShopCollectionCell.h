//
//  LA_MainShopCollectionCell.h
//  SSKJ
//
//  Created by GT on 2019/7/25.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LA_MainShopHotListModel.h"
#import "LA_MainShopHotListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LA_MainShopCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic, copy) LA_MainShopHotListModel *lModel;

- (void)changeUI;
@end

NS_ASSUME_NONNULL_END
