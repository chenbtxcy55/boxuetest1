//
//  JJHETFPositionModel.m
//  test
//
//  Created by 张孟驰 on 16/8/30.
//  Copyright © 2016年 张孟驰. All rights reserved.
//

#import "JJHETFPositionModel.h"

@implementation JJHETFPositionModel
+(JJHETFPositionModel *)modelForData:(NSDictionary *)data{
    JJHETFPositionModel *model = [[JJHETFPositionModel alloc]init];
    model.type = [JJHETFPositionModel dicToString:data andKey:@"type"];
    model.publishDate = [JJHETFPositionModel dicToString:data andKey:@"publishDate"];
    model.positionOunce = data[@"positionOunce"];
    model.positionTon = data[@"positionTon"];
    model.total = data[@"total"];
    model.changeEtf = data[@"changeEtf"];
    model.time = data[@"time"];
    model.timestamp = data[@"timestamp"];
    model.closingPrice = data[@"closingPrice"];
    return model;
}

+(NSString *)dicToString:(NSDictionary *)dic andKey:(NSString *)key{
    id string = [dic objectForKey:key];
    if ([string isKindOfClass:[NSString class]]) {
    }else{
        string = [NSString stringWithFormat:@"%@",string];
    }
    return string;
}

+(NSString *)dateWithModel:(JJHETFPositionModel *)model andFormatter:(NSString *)forStr{
    // yyyy-MM-dd HH:mm:ss
   NSString *time = [model.time substringWithRange:NSMakeRange(5, 5)];
    return time;
}
//-(NSString *)time
//{
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//   NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.timestamp.longLongValue];
//    [formatter setDateFormat:@"HH:mm:ss"];
//    return [formatter stringFromDate:date];
//}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)closingPrice
{
    return [NSString stringWithFormat:@"%.2f",_closingPrice.doubleValue];
        
}
@end
