//
//  BLUserModel.h
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLUserModel : NSObject


@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *account;      //用户唯一编号
@property (nonatomic, copy) NSString *mobile;       //手机号码
@property (nonatomic, copy) NSString *mail;         //邮箱
@property (nonatomic, copy) NSString *realname;     //真实姓名
@property (nonatomic, copy) NSString *idcard;       //身份证号
@property (nonatomic, copy) NSString *opwd;         //登录密码
@property (nonatomic, copy) NSString *tpwd;         //安全密码
@property (nonatomic, assign) NSInteger sex;        //性别，0女1男
@property (nonatomic, assign) NSInteger reg_time;   //注册时间
@property (nonatomic, assign) NSInteger state;      //状态，1正常0冻结
@property (nonatomic, assign) NSInteger command;      //状态，1正常0冻结
@property (nonatomic, assign) NSString *status;      //状态，1未认证，2待审核，3已认证,4已拒绝
@property (nonatomic, assign) NSString *auth_status;      //高级认证状态，1未认证，2待审核，3已认证,4已拒绝
@property (nonatomic, assign) NSInteger tjid;       //推荐人id
@property (nonatomic, copy) NSString *tjuser;       //推荐人账号
@property (nonatomic, copy) NSString *tpath;        //推荐关系树
@property (nonatomic, assign) double wallone;      //资金总额
@property (nonatomic, assign) double ttl_game_money;      //游戏资金总额


@property (nonatomic, assign) CGFloat walltwo;
@property (nonatomic, assign) CGFloat wallone_AB;

@property (nonatomic, assign) CGFloat wallthree;
@property (nonatomic, assign) CGFloat wallfour;
@property (nonatomic, copy) NSString *cardimg1;     //身份证正面
@property (nonatomic, copy) NSString *cardimg2;     //身份证背面
@property (nonatomic, copy) NSString *cardimg3;     //手持身份证
@property (nonatomic, assign) CGFloat czprice;      //入金总计
@property (nonatomic, assign) CGFloat txprice;      //入金总计
@property (nonatomic, copy) NSString *tgno;         //推广编号

@property (nonatomic, copy) NSString *crowd_num;    //抢筹明细数量

@property (nonatomic, copy) NSString *qd_status;   // 0关闭签到功能 1开启
@property (nonatomic, copy) NSString *qd;  // 0未签到， 1 签到

@property(nonatomic,copy)NSString *tb_max;//提币最大值
@property(nonatomic,copy)NSString *tb_min;//提币最小值
@property(nonatomic,copy)NSString * is_shop; //0否 1是 2申请商家审核中 3撤销商家审核中
@property(nonatomic,copy)NSString *AB; //冻结资金（成为商家）
@property (nonatomic, copy) NSString *is_apply; //is_apply 1 未申请 2 申请中 3 同意 4 拒绝
//只有4 的状态有
@property (nonatomic, copy) NSString *apply_reason;

@property (nonatomic, copy) NSString *jigou_code;

@property (nonatomic, copy) NSString *is_start_google;    // 是否开启了谷歌验证
@property (nonatomic, copy) NSString *cny_money;    // 约等于人民币


//是否有支付方式
@property(nonatomic,copy)NSString *pay_list;

@property (nonatomic, copy) NSString *money1;
@property (nonatomic, copy) NSString *money2;
@property (nonatomic, copy) NSString *money3;
@property (nonatomic, copy) NSString *money4;
@property (nonatomic, copy) NSString *money5;

@property (nonatomic, copy) NSString *free_fee1;
@property (nonatomic, copy) NSString *free_fee2;
@property (nonatomic, copy) NSString *free_fee3;
@property (nonatomic, copy) NSString *free_fee4;
@property (nonatomic, copy) NSString *free_fee5;

+ (instancetype)userModelWithDictionary:(NSDictionary *)dict;

@end
