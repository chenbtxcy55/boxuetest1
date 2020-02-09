//
//  Shop_Publish_headerView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop_Publish_View.h"
#import "UIInput_Title_TFView.h"
#import "ICC_PreOrder_GoodsInfo_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface Shop_Publish_headerView : UIView

@property (nonatomic, copy) void(^commitBlock)(NSDictionary *pamas);

@property (nonatomic, strong) Shop_Publish_View *shuoView; //缩略图

@property (nonatomic, strong) Shop_Publish_View *shopView;

@property (nonatomic, strong) Shop_Publish_View *detailView;


@property (nonatomic, strong) UIInput_Title_TFView *shopTypeTf;

@property (nonatomic, strong) UIInput_Title_TFView *shopPriceTf;

@property (nonatomic, strong) UIInput_Title_TFView *shopStoreTf; //可售价格

@property (nonatomic, strong) UIInput_Title_TFView *daiShouStoreTf; //待售价格
@property (nonatomic, strong) UIInput_Title_TFView *kuaiDiStoreTf; //快递费用

@property (nonatomic, strong) ICC_PreOrder_GoodsInfo_Model *model;

@property (nonatomic, strong) NSString *cateId;
//1发布  2编辑
@property (nonatomic, assign) NSInteger type;



@end

NS_ASSUME_NONNULL_END
