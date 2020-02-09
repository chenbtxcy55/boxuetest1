//
//  JJHETFPositionModel.h
//  test
//
//  Created by 张孟驰 on 16/8/30.
//  Copyright © 2016年 张孟驰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJHETFPositionModel : NSObject
@property(nonatomic,strong)NSString *publishDate;//发布日期
@property(nonatomic,strong)NSString *positionOunce;//净持仓量（盎司）
@property(nonatomic,strong)NSString *positionTon;//净持仓量（吨）
@property(nonatomic,strong)NSString *total;//总价值
@property(nonatomic,strong)NSString *changeEtf;//增减（吨）
@property(nonatomic,strong)NSString *type;//类型 1:黄金 2:白银
@property(nonatomic,strong)NSString *closingPrice;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *timestamp;
+(JJHETFPositionModel *)modelForData:(NSDictionary *)data;
+(NSString *)dateWithModel:(JJHETFPositionModel *)model andFormatter:(NSString *)forStr;
@end
