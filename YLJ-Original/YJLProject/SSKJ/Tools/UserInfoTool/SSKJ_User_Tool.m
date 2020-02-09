//
//  WL_LoginUser_Tool.m
//  明
//
//  Created by mac for csh on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "SSKJ_User_Tool.h"

@interface SSKJ_User_Tool()

@end

@implementation SSKJ_User_Tool

+(void)clearUserInfo
{
//    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    SSKJUserDefaultsSET(@"", @"token");
    SSKJUserDefaultsSET(@"", @"account");
    SSKJUserDefaultsSET(@"", @"mobile");
    SSKJUserDefaultsSET(@"", @"uid");
    SSKJUserDefaultsSET(@"0", @"kLogin");
    
    SSKJUserDefaultsSET(@"", @"kPhoneNumber");

    [self sharedUserTool].userInfoModel = nil;
    
}

+(SSKJ_User_Tool *)sharedUserTool
{
    
    static SSKJ_User_Tool *sharedSVC=nil;

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
        ^{
            
            sharedSVC = [[self alloc] init];
        });
  
    return sharedSVC;
}

#pragma mark -保存登录信息
-(void)saveLoginInfoWithLoginModel:(SSKJ_Login_Model *)loginModel;
{
    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    
    if (![loginModel.mobile isEqual:[NSNull null]]){
        self.userInfoModel.mobile =loginModel.mobile;
        [settings setObject:loginModel.mobile forKey:@"mobile"];
    }
    
    if (![loginModel.token isEqual:[NSNull null]]){

        [settings setObject:loginModel.token forKey:@"token"];
    }
    
    if (![loginModel.account isEqual:[NSNull null]]) {
        self.userInfoModel.account =loginModel.account;

        [settings setObject:loginModel.account forKey:@"account"];
    }
    
    if (![loginModel.uid isEqual:[NSNull null]]) {
        self.userInfoModel.mobile =loginModel.mobile;

        [settings setObject:loginModel.uid forKey:@"uid"];
    }
    
    
    
    
}

// 保存用户信息
-(void)saveUserInfoWithUserInfoModel:(SSKJ_UserInfo_Model *)userInfoModel
{
    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    
//    if (![userInfoModel.uid isEqual:[NSNull null]]){
//        [settings setObject:userInfoModel.uid forKey:@"uid"];
//    }
    
    
    
}
-(void)getUserInfoWithDic:(NSDictionary *)userInfoDic
{
    
   
    [SSKJ_User_Tool sharedUserTool].userInfoModel.is_start_google = userInfoDic[@"is_start_google"];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.is_apply = userInfoDic[@"is_apply"];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.pay_list = userInfoDic[@"pay_list"];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.status = userInfoDic[@"status"];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    [SSKJ_User_Tool sharedUserTool].userInfoModel.uid = userInfoDic[@""];
    
    
}
#pragma mark - 获取手机号
-(NSString *)getMobile
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"mobile"];
    
}

#pragma mark - 获取token
-(NSString *)getToken
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"token"];
}


#pragma mark - 获取用户account
-(NSString *)getAccount
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"account"];
    
}

#pragma mark - 获取用户id
-(NSString *)getUID
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"uid"];
    
}

-(void)setIsFinish:(BOOL)isFinish{
    
    
}
@end




























