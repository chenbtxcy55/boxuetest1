//
//  YLJShopAddressInfoModel.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLJShopAddressInfoModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *country;
@property (nonatomic,copy) NSString *detail;
@property (nonatomic,copy) NSString *is_default;

@property (nonatomic,copy) NSString *address_id;
@property (nonatomic,copy) NSString *user_name;



@end
//"address_info": {
//    "id": "39",
//    "account": "0",
//    "user_id": "2",
//    "name": "张小明",
//    "phone": "15238889996",
//    "province": "河南省",
//    "city": "郑州市",
//    "country": "郑东新区",
//    "detail": "绿地中心云峰A座",
//    "is_default": "1",
//    "created_at": "2019-11-21 15:11:23",
//    "updated_at": "2019-11-21 15:11:23",
//    "deleted_at": "2019-11-21 15:11:23"
//}
NS_ASSUME_NONNULL_END
