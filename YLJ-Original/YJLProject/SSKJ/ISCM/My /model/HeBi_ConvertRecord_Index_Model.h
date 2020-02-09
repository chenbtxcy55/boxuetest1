//
//  HeBi_ConvertRecord_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_ConvertRecord_Index_Model : NSObject
@property (nonatomic, copy) NSString *num;  //兑换数量
@property (nonatomic, copy) NSString *pname;    // 兑换币种名称
@property (nonatomic, copy) NSString *exnum;  //兑换成的币数量
@property (nonatomic, copy) NSString *expname;  //兑换成的币种名称
//@property (nonatomic, copy) NSString *memo;  //备注
@property (nonatomic, copy) NSString *addtime;  //兑换时间

@property (nonatomic,strong) NSString *memo;
@property (nonatomic,strong) NSString *dtime;
@property (nonatomic,strong) NSString *price;

/*
 account = 16696099716;
 dtime = "2019-11-23";
 id = 120;
 memo = "\U5151\U6362\U6263\U9664";
 price = "-2500.00";
 type = 11;
 userid = 6;
 */

@end

NS_ASSUME_NONNULL_END
