//
//  UrlDefine.h
//  SSKJ
//
//  Created by James on 2018/6/14.
//  Copyright © 2018年 James. All rights reserved.
//


#define SUCCESSED 200

#define ENVIRONMENT 0 //  0－开发/1－正式

#if ENVIRONMENT == 0
/* ************************  开发服务器接口地址  *********************************** */
//192.168.1.222:8080
//#define ProductBaseServer  @"http://yec.yjkzsyx.com"

#define ProductBaseServer  @"http://www.youlejia.shop"


//#define BBMarketSocketUrl @"ws://113.52.135.113:7272"   // 行情推送
#define BBMarketSocketUrl @"ws://yec.yjkzsyx.com:7272"   // 行情推送

//#define BBDeepthSocketUrl @"ws://113.52.135.113:7274"   // 深度推送
#define BBDeepthSocketUrl @"ws://www.bituneex.com:7274"   // 深度推送

//#define BBPankouSocketUrl @"ws://113.52.135.113:7273"   // 盘口推送
#define BBPankouSocketUrl @"ws://www.bituneex.com:7273"   // 盘口推送

//#define BBDealRecordSocketUrl @"ws://113.52.135.113:7275"   // 实时成交推送
#define BBDealRecordSocketUrl @"ws://www.bituneex.com:7275"   // 实时成交推送

/*******************************************************************************************/

#elif ENVIRONMENT ==1

/* ************************  发布正式服务器接口地址  *********************************** */

//#define ProductBaseServer  @"http://113.52.135.113"

//#define ProductBaseServer  @"http://abchain.shop"
#define ProductBaseServer  @"http://47.244.31.182"

//#define BBMarketSocketUrl @"ws://113.52.135.113:7272"   // 行情推送
#define BBMarketSocketUrl @"ws://47.244.31.182:7272"   // 行情推送

//#define BBDeepthSocketUrl @"ws://113.52.135.113:7274"   // 深度推送
#define BBDeepthSocketUrl @"ws://www.bituneex.com:7274"   // 深度推送

//#define BBPankouSocketUrl @"ws://113.52.135.113:7273"   // 盘口推送
#define BBPankouSocketUrl @"ws://www.bituneex.com:7273"   // 盘口推送

//#define BBDealRecordSocketUrl @"ws://113.52.135.113:7275"   // 实时成交推送
#define BBDealRecordSocketUrl @"ws://www.bituneex.com:7275"   // 实时成交推送

/*******************************************************************************************/

#endif


/************************************ 登录、注册、忘记密码、获取验证码 ****************************/

/* 用户注册 */
#define JB_Register_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/register"]

/* 发送手机验证码 */
#define JB_GetSMSCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/send_sms"]

/* 发送邮箱验证码 */
#define JB_GetEmailCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Mail/send_mail"]

/* 登录 */
#define JB_Login_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/user_login"]

#define JB_Shop_OrderDetail [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/UsersOrder/order_detail"]
#define JB_Shop_OrderList [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/UsersOrder/order_list"]

/* 验证登录密码 */
#define JB_CheckPWD_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/check_opwd"]
///* 钱包隐私协议 */
//#define ETF_PRAVITYPROTOCOL_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/wallet_rule"]

/* 注册时服务协议 */
#define ETF_REGISTERPROTOCOL_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/ajax/get_web_agree"]

/* 重置登录密码*/
#define ETF_ResetPWD_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/xiugai_pwd"]


/* 忘记登录密码*/
#define ETF_ForgetPWD_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/find_opwd"]


// 版本管理
#define JB_CheckVersion_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Version/check_version"]

// 弹屏公告   /Home/ajax/pop_notice
#define JB_pop_notice_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/ajax/pop_notice"]
// 联系客服
#define JB_CustomerService_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/customer_service"]

// 登录验证谷歌验证码
#define JB_CheckGoogle_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/google/check_google_code"]


/************************************ BB交易 ****************************/


/* 币币交易市场行情*/
#define ETF_BBTrade_MarketList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getpro"]

/* 币币交易历史记录*/
#define ETF_BBTrade_OrderList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/tranlist"]

/* 币币交易下单*/
#define ETF_BBTrade_ConfirmBuy_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/bbtran"]

/* 币币交易K线图*/
#define JB_BBTrade_KLine_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Ajax/index"]

/* 币币交易K线图*/
#define ETF_BBTrade_CoinIntroduce_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/get_info"]


/* 币币交易获取币种余额*/
#define ETF_BBTrade_GetCoinBalance_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/getCodeBalance"]

/* 币币交易获取币种余额*/
#define ETF_BBTrade_CoinList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/get_pro"]

/* 币币撤单*/
#define ETF_BBTradeCancle_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Trade/cancel"]

/* 币币盘口*/
#define ETF_BBTradePankou_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getdepth"]

/* 币币深度*/
#define ETF_BBTradeDeep_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/get_shendu"]

/* 平台公告详情*/
#define ETF_NoticeDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/zixun_detail"]

/* 平台公告列表*/
#define ETF_NoticeList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/zixun"]

/* 行情bannerfind_URL列表*/
#define ETF_bannerfind_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Sign/bannerfind"]


#pragma mark - 法币

#define ISCM_OTCLimit_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/get_fb_price"]


//法币交易大厅

#define ETF_FBHomeFbtransTrading_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/trading"]
//交易记录
#define ETF_FBHomeFbtransRecode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/get_mx"]
//发布求购
#define ETF_FBHomeFbtransPmma_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/pmma"]
/// 获取价格Home/Fbtrans/get_price
#define ETF_FBHomeFbtransgGetPrice_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Fbtrans/get_price"]
/* 主页获取轮播图*/
#define ETF_Main_GetBanner_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getBanner"]
/// 实时AB数量 Home/Fbtrans/get_my_AB
#define Main_Get_My_AB_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Fbtrans/get_my_AB"]
///Home/Fbtrans/create_order下单
#define Main_Get_create_order_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/create_order"]

// 法币获取默认价格
#define Main_GetDefaultrice_order_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Fbtrans/get_price"]

// 法币发布订单列表
#define FBC_PublishOrderList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/pmmaLists"]

// 法币发布订单撤销
#define FBC_PublishCancleOrder_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/pmmaRev"]

// 法币订单详情
#define FBC_DealOrderDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/orderDetail"]

// 买家取消法币订单
#define FBC_CancleOrder_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/re_order"]

// 买家标记已付款
#define FBC_ConfirmPay_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Fbtrans/setOrderStatus"]

// 卖家放币
#define FBC_ConfirmFangbi_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/payOrder"]

// 卖家申诉
#define FBC_Apeal_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Fbtrans/post_allege"]

// 法币判断是否在时间段
#define ISCM_OTC_JudgeDeal [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/transTime"]


/************************************ 理财 ****************************/

/* 理财币种列表*/
#define JB_Account_LicaiCoinList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/lend/lend_coin_list"]

/* 理财币种统计*/
#define JB_Account_LicaiStatistics_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/lend/blend"]

/* 理财挂单*/
#define JB_Account_LicaiConfirmBuy_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/lend/lend_add"]

/* 理财挂单记录*/
#define JB_Account_LicaiRecord_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/lend/get_transrecord"]

/* 理财挂单赎回*/
#define JB_Account_LicaiCancle_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/lend/pay_back"]



/************************************ 我的 ****************************/

/* 个人中心*/
#define JB_Account_UserInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/user_info"]

/* 理财账户列表*/
#define JB_Account_LicaiAsset_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/borrow/borrow_asset"]

/* 交易账户列表*/
#define JB_Account_DealAsset_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/get_asset"]

/* 交易账户列表*/
#define JB_Account_DUIHUAN_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/ex_pre"]

/* 兑换*/
#define JB_exchange_exchange_assert_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/exchange/exchange"]

/* 兑换的币种列表*/
#define JB_coinList_assert_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/exchange/coinList"]






/* 兑换的币种列表 /Home/Recharge/get_recharge_coin_list*/
#define JB_get_recharge_coin_list_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recharge/get_recharge_coin_list"]

/* 兑换的币种列表 /Home/Recharge/withdraw_coin_data*/
#define JB_get_withdraw_coin_data_list_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recharge/withdraw_coin_data"]



/* 币种可以兑换的列表*/
#define JB_thisCoinList_assert_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/exchange/thisCoinList"]


/* AB充值*/
#define JB_Account_Charge_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/bpay"]

#define JB_Account_Bank_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/add_bank"]

#define JB_Account_tibiInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/order/ti_bi_info"]

#define JB_Account_Order_tibi [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/order/ti_bi"]

#define JB_Account_Malls_Recode [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/malls/money_recode"]
#define JB_Account_Malls_confirm_order [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/malls/confirm_order"]

/* 获取支付方式列表*/
#define JB_Account_PayList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/get_pay"]
/* 绑定手机号*/
#define JB_Bind_Mobile_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/binding_mobile"]

/* 绑定邮箱*/
#define JB_Bind_Email_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/binding_email"]

//增加支付方式
#define JB_AddPaywaysApi [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/pay_add"]


//改变支付状态
#define JB_KchangePaystatus [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/set_pay_status"]

// 设置安全密码
#define JB_SetPayPwdURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/reset_tpwd"]

// 设置登录密码
#define JB_SetLoginPwdURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/xiugai_pwd"]

//初级认证
#define JB_SetPrimary_AuthURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/set_sm"]

//高级认证
#define JB_SetAdvan_AuthURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/set_img"]

//上传图片
#define JB_Upload_pic_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/upload.php"]

//创建谷歌账户
#define JB_CreateGoogle_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Google/createGoogleCommand"]

//密保验证开关谷歌账户
#define JB_SetGoogle_State_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/google/set_google_state"]

//绑定谷歌验证
#define JB_BingGoogle_State_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/google/checkGoogleCommand"]

//  申请成为商家
#define JB_ApplyShop_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/add_shop"]

//  撤销商家
#define JB_CancleShop_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Fbtrans/del_shop"]

//  我的推广
#define JB_MyHome_Link_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/link"]

//  我要推广+我的客户
#define JB_MyHome_ClientLink_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/my_down"]

// 佣金明细
#define JB_YongJin_Detail__URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/tjreward_list"]

//  提币URL
#define JB_TiBi_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/ti_bi"]
//  提币地址列表
#define JB_AddressList_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/AddrList"]

//  添加和删除地址列表
#define JB_AddAddress_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/AddrManage"]

//  充提币记录
#define JB_CoinTiCho_Record_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/record"]

//  删除提币
#define JB_TiBiCancel_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/cancle_tibi"]

//  抵押记录
#define JB_PledgeBorrow_Record_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Borrow/get_transrecord"]

//  抵押币列表
#define JB_PledgeCoins_List_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/coins_list"]


//  借入币列表
#define JB_BorrowCoins_List_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/borrow/mortgage_info"]

//  抵押币详情
#define JB_PledgeCoinDetail_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/borrow/mortgage_info"]

//  借入币详情
#define JB_BorrowgeCoinDetail_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/borrow/borrow_info"]

//  借币，借款
#define JB_LendCoin_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Borrow/borrow_add"]

//  抵押借款
#define JB_PledgeLendMoney_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/borrow/trans_total"]

//  交易理财划转
#define JB_BorrowTransferMoney_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Borrow/transfer"]

//  划转记录
#define JB_BorrowTransferMoney_Record_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Borrow/get_transfer_record"]

//  h周期天数
#define JB_Borrow_GetDays_Record_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/borrow/getdays"]

//  获取借入币信息
#define JB_Borrow_Info_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/borrow/borrow_info"]

//  抵押贷快
#define JB_BorrowAdd_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Borrow/borrow_add"]

//  还款 、赎回
#define JB_BorrowPayback_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Borrow/payback"]

//  资产流水
#define JB_Re_Asset_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/re_asset"]


//  获取某币种理财账户余额
#define JB_LicaiCoinBalance_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/borrow/bcover"]

//  借款补仓
#define JB_LendCover_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/borrow/cover"]

//  赎回信息
#define JB_BuyBackInfo_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/borrow/bpayback"]

//  抵押借贷规则
#define JB_Borrow_Rule_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/borrow/get_borrow_rule"]

//  交易理财币种列表
#define JB_QBW_Account_listBorrow_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/account_list"]

//  获取联系方式
#define JB_GetEmail_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/serviceData"]


//---------------------ab商城-------------------------------

//注册

#define AB_Register_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/register"]
//发送验证码/Home/Users/send_sms

#define AB_SenderMessage_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/send_sms"]
//登录
#define AB_LoginIn_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/users/user_login"]
//忘记密码/Home/users/reset_opwd
#define AB_resetPsw_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/users/reset_opwd"]

//个人信息/Home/users/user_info
#define AB_user_info_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/users/user_info"]

//身份证验证/Home/Users/set_aut
#define AB_set_aut_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/set_aut"]

//设置昵称/Home/Users/set_aut
#define AB_set_nickname_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/set_nickname"]
//设置头像/Home/Users/set_photo
#define AB_set_photo_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/set_photo"]


//修改登录界面/Home/users/xiugai_pwd
#define AB_xiugai_pwd_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/users/xiugai_pwd"]
//分享/Home/Users/link
#define AB_Users_link_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/link"]
///Home/Users/reset_tpwd
#define AB_reset_tpwd_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/reset_tpwd"]
///Home/Users/get_pay
#define AB_Users_get_pay_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/get_pay"]
///Home/Users/pay_add
#define AB_Users_pay_add_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/pay_add"]

///Home/ajax/upload_pic
#define AB_Users_upload_pic_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/ajax/upload_pic"]

///Home/Users/mess意见反馈
#define AB_Users_upload_mess_url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/mess"]

//---------------商家------------------
///Shop/Shop/shop_slide_list_post//轮播图

#define AB_Shop_slide_list_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Malls/index"]
///Shop/Shop/cate_list_post 列表分类

#define AB_Shop_cate_list_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Shop/cate_list_post"]
///Shop/Goods/owner_goods_index 商品分类

#define AB_Shop_owner_goods_index [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Goods/owner_goods_index"]
//商品搜索

#define KGoods_search [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Malls/search"]
///Shop/Goods/goods_index 列表
#define AB_Shop_goods_index [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/hot_shop_goods"]
///Shop/Shop/user_shop_goods_info 商品详情

#define AB_Shop_user_shop_goods_info [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Shop/user_shop_goods_info"]
//店铺中商品

#define AB_Shop_user_shop_goods_list [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/get_store_list"]
//单个店铺轮播图
////Shop/Shop/user_shop_info
#define AB_Shop_user_user_shop_info [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/get_store_detail"]

///Shop/Order/order_add_pos
#define AB_Shop_user_order_add_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Malls/go_pay"]

//确认信息/Shop/Order/order_confirm

#define AB_Shop_user_order_confirm [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/order_detail"]
///Shop/Order/order_pay_post买

#define AB_Shop_user_order_pay_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/confirm_pay"]
///Shop/Shop/owner_apply_post申请成为商家

#define AB_Shop_user_owner_apply_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/customer_email"]

///Shop/Shop/shop_notice_list_post公告滚动

#define AB_Shop_shop_notice_list_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/shop_notice_list_post"]
//商城公告列表
#define KShopNoticeUrl [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/shop_notice"]
//添加地址/Shop/Address/address_add_post

#define AB_Shop_shop_address_add_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Address/add_address"]
//地址列表/Shop/Address/address_index_post
#define AB_Shop_shop_address_index_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/address/my_address"]
//设置默认地址/Shop/Address/address_default_post
#define AB_Shop_shop_address_default_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/address/set_default_address"]
///Home/Users/set_pay_status设置状态
#define AB_Shop_shop_set_pay_status [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/set_pay_status"]

//-------资产首页


///Home/Asset/accindex

#define AB_Shop_shop_accindex [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Asset/accindex"]

///home/transfer/balance_list列表

#define AB_Shop_balance_list [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/transfer/balance_list"]
///home/transfer/jifen_info爱点列表
#define AB_Shop_jifen_info [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/transfer/jifen_info"]

///home/transfer/tibi_info 提币界面
#define AB_Shop_tibi_info  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/transfer/tibi_info"]
///home/transfer/tibi提笔接口、
#define AB_Shop_tibi_tibi  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/transfer/tibi"]
///Home/Transfer/Transfer
#define AB_Shop_tibi_Transfer  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Transfer/Transfer"]
/* 商城->商家->商家 -> 商家订单操作 */
#define VPay_Shop_BusinessOrderHandle_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/ship"]
//赚爱点界面/Home/Transfer/balance_jifen_page
#define AB_Shop_tibi_balance_jifen_page  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Transfer/balance_jifen_page"]

#define AB_Shop_balance_jifen_post  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Transfer/balance_jifen_post"]
///Home/Transfer/account_qrc
//生成二维码
#define AB_Shop_balance_account_qrc  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Transfer/account_qrc"]

///Home/Transfer/tibi_list//提币记录
#define AB_Shop_balance_tibi_list  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Transfer/tibi_list"]


///Home/Transfer/exchange_Record//兑换记录
#define AB_Shop_balance_exchange_Record  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Transfer/exchange_Record"]

///Shop/Address/address_delete_post

#define AB_Shop_address_delete_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Address/del_address"]

///Shop/Address/address_edit_post//编辑地址

#define AB_Shop_address_edit_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Address/edit_address"]

//我的订单列表/Shop/Order/order_index_post

#define AB_Shop_order_index_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/usersOrder/get_user_order_detail"]

//订单详情/Shop/Order/order_detail

#define AB_Shop_order_order_detail [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Order/order_detail"]

#define VPay_Shop_ShopOrderDetail_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Order/shop_order_detail"]

//添加商品发布

#define AB_Shop_order_owner_goods_add_post [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/push_goods"]

#define VPay_Shop_GoodsList_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/off_shelves"]
#define ShangJiaGoodsList_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/my_store"]
/* 商城->店铺个人中心->上架、下架商品 */
#define VPay_Shop_UpGoods_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/off_goods"]

#define KShangJiaURL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/on_goods"]

/* 商城->店铺个人中心->删除商品 */
#define VPay_Shop_DeleteGoods_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Goods/owner_goods_delete_post"]

/* 商城->店铺个人中心->添加商品 */
#define VPay_Shop_AddGoods_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Goods/owner_goods_add_post"]

/* 商城->店铺个人中心->编辑商品 */
#define VPay_Shop_EditGoods_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/edit_off_goods"]
///* 商城->商家->商家 -> 用户订单操作 取消*/
#define VPay_Shop_UserOrderHandle_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/usersOrder/cancel_order"]
//用户确认订单
#define KUserSureOrder   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/usersOrder/confirm_receive"]
#define KdeleteOrder  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/usersOrder/del_order"]
///Shop/Order/order_op_post
///* 商城->商家->商家 -> 商品列表->商品详情->点击立即购买->确认支付 */
#define VPay_Shop_ConfirmPay_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Order/order_pay_post"]
///Shop/Order/shop_order_fahuo_confirm确认发货

#define VPay_shop_order_fahuo_confirm_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Shop/Order/shop_order_fahuo_confirm"]

//Home/ajax/kline

#define VPay_shop_order_fahuo_kline_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/ajax/kline"]

///* 商城->商家->商家 -> 商家订单列表 */
#define VPay_Shop_shop_order_index_post_URL   [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/get_store_order_detail"]
///home/transfer/get_fee

#define kTransferFees_url [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/transfer/get_fee"]

///Shop/Shop/shopcate_list

#define kTransshopcate_list_url [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/go_type"]
///Shop/Shop/owner_shop_edit_post
#define kowner_shop_edit_post_url [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/edit_store"]
///Shop/Shop/user_shop_index
#define kowner_shop_user_shop_index [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/good_faith_store"]
///shop/shop/shop_notice_detail
#define kowner_shopshop_notice_detail [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/shop/shop/shop_notice_detail"]

///Shop/Shop/user_shop_info
#define kowner_shopuser_shop_info [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/get_store_detail"]
///Home/Users/get_tema获取团队

#define kowner_get_tema [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/get_tema"]

//我的团队/Home/Users/my_tuandui
#define kowner_get_temamy_tuandui [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Users/my_tuandui"]
///Home/Transfer/Record_Transfer

#define kowner_get_Record_Transfer [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Transfer/Record_Transfer"]

///Home/Version/check_version

#define kowner_get_check_version [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Version/check_version"]


//home/ajax/get_tuxing
#define kowner_get_get_tuxing [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/get_tuxing"]



//注册/Home/Qbw/register

#define kIscm_user_registerApi [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/register"]

//验证码/Home/Qbw/send_sms

#define kIscm_user_send_smsApi [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/send_sms"]
//登录/Home/Qbw/user_login
#define kIscm_user_login_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/user_login"]
//重置登录密码/home/qbw/reset_opwd
#define kIscm_user_reset_opwd_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/reset_opwd"]


//公告列表/Home/Qbw/zixun
#define kIscm_user_zixunApi [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/zixun"]
//公告详情/Home/Qbw/zixun_detail
#define kIscm_user_zixun_detailApi [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/zixun_detail"]
//锁仓界面/Home/Recognize/lock_index
#define kIscm_user_lock_indexApi [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/lock_index"]

#define kYLJ_Home_zixun_detailApi [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/shop_notice_detail"]

#pragma mark - 行情

/**
 行情轮播图
 */
#define kIscm_Market_Banner [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getBanner"]

/**
 行情列表
 */
#define kIscm_Market_List [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/ajax/getpro"]

/**
 K线
 */
#define kIscm_Market_KLine [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Ajax/index"]

/**
 各币种资料
 */
#define kIscm_Market_CoinInfo [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/get_info"]

#pragma mark ------个人信息------

///上传图片 Home/Qbw/upload_pic
#define kIscm_upload_pic_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/upload_pic"]
///设置用户头像 Home/Qbw/set_photo
#define kIscm_Home_set_photo_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/set_photo"]

#define KuploadImg [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/uploadsPic"]
///关于我们 Home/sign/lxfs
#define kIscm_about_us_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/sign/lxfs"]

//版本更新 Home/Version/check_version
#define kIscm_check_version_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Version/check_version"]

//获取公告 Home/sign/huoqugg
#define kIscm_sign_huoqugg_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/sign/huoqugg"]


///获取个人信息 Home/Qbw/user_info
#define kIscm_get_user_info_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/user_info"]
///兑换开关 Home/Qbw/user_info
#define kIscm_czOnOff_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qtc/czOnOff"]
//Qbw/Sign
#define kYLJ_center_sign [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/Sign"]
///个人设置高级认证 /home/qbw/set_img
#define kIscm_advance_set_img_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/set_img"]
///个人设置初级认证  /home/qbw/set_sm
#define kIscm_primary_set_sm_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/set_sm"]

///修改登录密码  /home/qbw/xiugai_pwd
#define kIscm_xiugai_pwd_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/xiugai_pwd"]


///提币地址  /home/qbw/AddrList
#define kIscm_my_AddrList_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recharge/withdrawal_addr_List"]


///添加提币地址  /home/qbw/AddrManage
#define kIscm_add_AddrManage_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recharge/add_withdrawal_address"]
//购买锁仓套餐/Home/Recognize/buy_lock


///取消商家 Home/Qbw/user_info
#define kIscm_cancel_shop_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Fbtrans/del_shop"]


///一键反馈 /Home/Qbw/u_msg
#define kIscm_u_msg_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/u_msg"]

///我的社区头部   /Home/Qbw/community_count
#define kIscm_community_count_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/community_count"]

///我的动态头部   /Home/Qbw/community_count
#define kIscm_concession_count_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/concession_count"]


///社区奖励列表  /Home/qbw/concession_detail
#define kIscm_concession_detail_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/concession_detail"]


///社区奖励列表  /Home/qbw/community_detail
#define kIscm_community_detail_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/community_detail"]


///充、提币记录列表 /Home/Recharge/record_list

#define kIscm_record_list_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recharge/record_list"]


///资金明细 /Home/user/asset_detail
#define kIscm_asset_detail_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/users/asset_detail"]

///商城余额   Home/Qbw/get_shop_balance
#define kIscm_get_shop_balance_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/get_shop_balance"]

///我的团队列表   /Home/qbw/team_list
#define kIscm_team_list_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/team_list"]
///我的团队   /Home/Qbw/my_team
#define kIscm_team_jiBiecount_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/my_team"]


///静态收益   /Home/Qbw/my_team
#define kIscm_jingtaishouyi_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/qbw/static_release"]



///我的推广业绩   /Qbw/team_achievement
#define kIscm_team_achievement_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/fy_info"]

//推广链接   /Home/Qbw/link
#define kIscm_tuiguang_link_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/link"]
//资产管理 /Home/Recognize/asset
#define kIscm_Recognize_asset_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/asset"]
//币充值页面 /home/order/bpay
#define kIscm_order_bpay_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/order/bpay"]
//提币 /Home/Recharge/withdraw_coin
#define kIscm_order_ti_bi_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recharge/withdraw_coin"]
//兑换页面    /Home/Recognize/ex_pre
#define kIscm_Recognize_ex_pre_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/ex_pre"]
//提交兑换  /Home/Recognize/do_ex
#define kIscm_Recognize_do_ex_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/do_ex"]
//兑换记录  /Home/Recognize/ex_list
#define kIscm_Recognize_ex_list_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/ex_list"]




//充值记录  /Home/Recharge/conin_recharge
#define kIscm_conin_recharge_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recharge/conin_recharge"]


//充值记录  /Home/qbw/record
#define kIscm_Recognize_record_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/record"]

// 提币手续费  /Home/api/get_tb
#define kIscm_get_tb_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/api/get_tb"]

// EHT 明细  /Home/qbw/re_asset
#define kIscm_re_asset_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/re_asset"]

// ISCM 明细  /Home/qbw/caiwu
#define kIscm_caiwu_ISCM_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/caiwu"]

// 筛选列表  /Home/qbw/asset_type
#define kIscm_asset_type_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/qbw/asset_type"]


#define kIscm_add_Abuy_lock_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/buy_lock"]
//锁仓记录/Home/Recognize/lock_list

#define kIscm_lock_list_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/lock_list"]

///Home/Api/asset
#define kIscm_lasset_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Recognize/wallet_asset"]

///home/order/bpay3

#define kIscm_bpay_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/order/bpay"]
///home/qbw/agree
#define kIscm_agree_Api [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/Qbw/agree"]

#define kMarketURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/home/order/bpay"]
//实时交易盈利数据
#define shiShiChengJiaoSocketUrl @"ws://47.244.230.29:7277"

//交易盈利数据
#define Heyue_ShiShiChengjiao_Api [NSString stringWithFormat:@"%@/home/ajax/RealTimeDeal",ProductBaseServer]

/**合约  暂时先用**/
// 获取 最小购买量 和 杠杆 1
#define GetLeverageURL [NSString stringWithFormat:@"%@/home/api/get_lever",ProductBaseServer]
//交易金额
#define Property_income_record_URL @""


//二期接口
//期权交易配置信息
#define KQiQuanSettting [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/OptionMallOrder/getOrderSettings"]

//期权下单
#define  KQiQuanBuy [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/OptionMallOrder/addOrder"] 
//最新盈利订单
#define KNewOrdersList [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/OptionMallOrder/newProfitOrders"] 
//持仓订单
#define KNowOrdersList [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/OptionMallOrder/positions"]
//成交订单
#define KDealdOrdersList [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/OptionMallOrder/trans"]
//商品详情
#define KGoodsDetail [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/get_goods_detail"]
//店铺状态
#define KShopStatus [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/my_store"]

//店铺申请
#define KShopApply [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/add_store"]
//商品类别
#define KGoodsType  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/malls/type_list"]
//店铺信息

#define KStoreInfo [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/go_edit"]
//确认订单
#define KConfimOerder [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Api/go_pay"]
//商家取消订单
#define KShopCancelOrder [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/cancel_order"]

//编辑商品信息
#define  KEditGoodsInfo [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/store/go_edit_goods"]

#define KCanCelUSerOrder [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/usersOrder/cancel_order"]
// 激活
//预约套餐列表或预约订单详情
#define ActivateListURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/lock_index"]
//预约套餐
#define Yuyue_lockURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/yuyue_lock"]
//取消预约
#define Qx_yuyue_lockURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/qx_yuyue_lock"]
//购买套餐 付款
#define buy_lockURL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/Home/Qbw/buy_lock"]
