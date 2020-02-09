//
//  SSKJ_UserInfo_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/10.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_UserInfo_Model : NSObject

//yec
@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *account;  // account 会员账号

@property (nonatomic, copy) NSString *mobile;  // 手机号
@property (nonatomic, copy) NSString * opwd;//新密码
@property (nonatomic, copy) NSString *tpwd;  // 是否设置支付密码
@property (nonatomic, copy) NSString *is_shop;  //是否是商家 0否 1是 2审核中
@property (nonatomic, copy) NSString *tgno;//推广码
@property (nonatomic, copy) NSString *is_trans;//是否购买套餐激活  0否 1是
//0为会员 1为服务中心
@property (nonatomic, copy) NSString *level;////级别字段，未激活是 0普通会员 购买不同套餐（1、初级2、中级3、高级4、超级5、特级经纪人）
@property (nonatomic, copy) NSString *is_community;//是否为社区 0否 1是
@property (nonatomic, copy) NSString *shop_blance;//商城余额(购物券)
@property (nonatomic, copy) NSString *is_yuyue;//1已经预约 0 未预约
@property (nonatomic,copy) NSString *coupon; //油乐劵
@property (nonatomic, copy) NSString * money;//账户余额
//上级账户
@property (nonatomic,copy) NSString *tgaccount;
//服务中心账户
@property (nonatomic,copy) NSString *level_account;
//0 未激活  1激活
@property (nonatomic,copy) NSString *state;




@property (nonatomic, copy) NSString *uid;//用户id





@property (nonatomic, copy) NSString *basicAuthenticationStatus;
@property (nonatomic, copy) NSString *highAuthenticationStatus;
@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *idcard;  // 身份证号
@property (nonatomic, copy) NSString *email;  // 邮箱
@property (nonatomic, copy) NSString *command;//0未认证  1已认证

@property (nonatomic, copy) NSString *realname;  // 真实姓名
@property (nonatomic, copy) NSString *status;  // 初级认证 1 未认证 2 待审核 3 已通过  4拒绝
@property (nonatomic, copy) NSString *auth_status;  //高级认证 1 未认证 2 待审核 3 已通过  4拒绝
@property (nonatomic, copy) NSString *wallone;
@property (nonatomic, copy) NSString *pay_list;  // 是否有添加支付方式
@property (nonatomic, copy) NSString *shop_fee;  //成为商家费用
@property (nonatomic, copy) NSString *is_apply;  // 申请商家状态
@property (nonatomic, copy) NSString *apply_reason;  // 拒绝原因
@property (nonatomic, copy) NSString *AB;  // 申请商家冻结金额
@property (nonatomic, copy) NSString *is_start_google;  // 是否开启谷歌验证 0 关 1开
@property (nonatomic, copy) NSString *register_type;  // 1手机号注册2邮箱注册
@property (nonatomic, copy) NSString * upic;//头像



//

@property (nonatomic, copy) NSString *pid;
//等级
@property (nonatomic, copy) NSString *grade;

//昵称
@property (nonatomic, strong) NSString *nickname;
//是不是店铺商家
@property (nonatomic, strong) NSString *is_icc_shop;

//
@property (nonatomic, strong) NSString *is_pwd;
// 店铺
@property (nonatomic, strong) NSString *iccshop_status;

@property (nonatomic, strong) NSString *zt_lervel;

@property (nonatomic, strong) NSString *deng_ji;


//新增-----11
@property (nonatomic, copy) NSString * cny_money;


@property (nonatomic, copy) NSString * force;
@property (nonatomic, copy) NSString * fy_rate;
@property (nonatomic, copy) NSString * jigou_code;
@property (nonatomic, copy) NSString * mcode;
@property (nonatomic, copy) NSString * qd;
@property (nonatomic, copy) NSString * sxfee;//法币交易手续费
@property (nonatomic, copy) NSString * usdt;
@property (nonatomic, copy) NSString * user_level;
@property (nonatomic, copy) NSString * wallone_usdt;

//新增-----11
//"wallone": "0.0000",
//"walltwo": "0.0000",
//"wallthree": "5000.0000",
//"wallfour": "98706.9500",
@property (nonatomic, copy) NSString * walltwo;
@property (nonatomic, copy) NSString * wallthree;//待售
@property (nonatomic, copy) NSString * wallfour;//可售
@end


NS_ASSUME_NONNULL_END

/*
 
 
 "apply_reason" = "<null>";
 "auth_status" = 2;
 "cny_money" = 0;
 command = 0;
 email = 0;
 force = 0;
 "fy_rate" = 0;
 grade = 0;
 idcard = "411***********009X";
 "is_apply" = 1;
 "is_shop" = 0;
 "is_start_google" = 0;
 "jigou_code" = "<null>";
 mcode = "<null>";
 mobile = "155****5113";
 name = "1***1";
 opwd = "******";
 "pay_list" = 0;
 qd = 0;
 status = 3;
 sxfee = 0;
 tgno = hSsCJz;
 tpwd = "******";
 uid = 296221238;
 usdt = "<null>";
 "user_level" = 1;
 wallone = 0;
 "wallone_usdt" = "0.0000";
 }
 */
