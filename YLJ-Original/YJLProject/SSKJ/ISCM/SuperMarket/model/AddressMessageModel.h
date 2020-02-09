//
//  AddressMessageModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
/* {
 "id": "1",
 "uid": "2",
 "address": "test test",
 "default_status": "2",
 "create_time": "2018-05-31 11:29:32",
 "update_time": "2018-06-01 16:10:42",
 "name": "沙僧4",
 "mobile": "15500000011",
 "sheng": "河南省",
 "shi": "郑州市",
 "qu": "郑东新区",
 "delete_status": "1",
 "area_code": "410192"
 },*/

NS_ASSUME_NONNULL_BEGIN

@interface AddressMessageModel : NSObject
@property (nonatomic, strong) NSString *ID;//地址id
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *address;//详细地址
@property (nonatomic, strong) NSString *default_status;//1不是默认2是默认
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *name;//姓名
@property (nonatomic, strong) NSString *mobile;//电话
@property (nonatomic, strong) NSString *sheng;//省
@property (nonatomic, strong) NSString *shi;//市
@property (nonatomic, strong) NSString *qu;//区
@property (nonatomic, strong) NSString *delete_status;//
@property (nonatomic, strong) NSString *area_code;
//address_id": "47",
//"user_name": "Fdsafssa",
//"phone": "4234234",
//"province": "河南省",
//"city": "郑州市",
//"country": "金水区",
//"detail": "Ewrtewtew"
//res": [{
//"address_id": "43",
//"address_name": "Hukaikai",
//"phone": "13937176580",
//"province": "河南省",
//"city": "郑州市",
//"country": "金水区",
//"detail": "Ahah",
//"is_default": "1"
//}]
//"id": "2",
//"name": "王霞",
//"phone": "176101010101",
//"province": "安徽省",
//"city": "安庆",
//"country": "大庆区",
//"detail": "东乡街道1",
//"is_default": "0",
@end

NS_ASSUME_NONNULL_END
