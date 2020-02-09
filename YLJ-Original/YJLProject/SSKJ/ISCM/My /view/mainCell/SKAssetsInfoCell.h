//
//  SKAssetsInfoCell.h
//  SSKJ
//
//  Created by 孙 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKAssetManagementModel.h"

@interface SKAssetsInfoCell : UITableViewCell

@property(nonatomic,copy)void(^moneyDetailBLock)(void);
@property(nonatomic,copy)void(^moneyDetailENTBLock)(void);

@property(nonatomic,strong)SKAssetManagementModel * model;
@end


