//
//  GoodsDetailCell.h
//  SSKJ
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^GoodsDetailCellBlcok)(void);
@interface GoodsDetailCell : UITableViewCell

@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,assign) CGFloat imgHeght;

@property (nonatomic,strong) ImgModel *model;

@property (nonatomic,strong) UIImageView *img;

@property (nonatomic,copy) GoodsDetailCellBlcok block;

@end

NS_ASSUME_NONNULL_END
