//
//  Shop_PublishView_ViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "ICC_PreOrder_GoodsInfo_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Shop_PublishView_ViewController : SSKJ_BaseViewController


@property (nonatomic, strong) ICC_PreOrder_GoodsInfo_Model *model;


@property (nonatomic, strong) NSString *cateId;

@end

NS_ASSUME_NONNULL_END
