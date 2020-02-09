//
//  OTC_BusinessApply_VC.m
//  SSKJ
//
//  Created by zpz on 2019/7/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "OTC_BusinessApply_VC.h"

@interface OTC_BusinessApply_VC ()

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIView *contentView;

@property(nonatomic, strong)UIButton *agreeBtn;
@property(nonatomic, strong)UIButton *applyBtn;

@property(nonatomic, strong)UILabel *priceLabel;

@property(nonatomic, copy)NSString *price;

@end

@implementation OTC_BusinessApply_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商家申请";
    
    [self applyBtn];
    
    [self agreeBtn];
    
    [self scrollView];
    
    [self contentView];
    
    [self setupSubViews];
    
    [self requestGetInfo];
    
}

- (void)setupSubViews{
    UILabel *titleLabel = [WLTools allocLabel:@"如何申请成为商家？" font:systemBoldFont(ScaleW(17)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(15)));
        make.top.equalTo(@(ScaleW(30)));
    }];
    
    UILabel *firstLabel = [WLTools allocLabel:@"步骤一：提交申请" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.right.equalTo(@(ScaleW(-15)));
        make.top.equalTo(titleLabel.mas_bottom).offset(ScaleW(30));
    }];
    
    UILabel *firstSubLabel = [WLTools allocLabel:@"发送邮件后，请在本页面点击“确认申请”按钮，提交申请。并同意冻结0ISCM作为商家保证金，什么是ISCM?提交完成后，您即可在普通交易区发布广告。" font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:firstSubLabel];
    [firstSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.right.equalTo(@(ScaleW(-15)));
        make.top.equalTo(firstLabel.mas_bottom).offset(ScaleW(13));
    }];
    self.priceLabel = firstSubLabel;
    
    UILabel *secondLabel = [WLTools allocLabel:@"步骤二：资料审核" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(firstSubLabel.mas_bottom).offset(ScaleW(20));
    }];
    
    UILabel *secondSubLabel = [WLTools allocLabel:@"我们将在72小时内对您的商家申请资料进行审核，请保持通讯畅通，我们会主动与您取得联系。\n注：大宗交易区发布广告必须成为超级商家，商家满足交易效率高、信誉好并同意缴纳大额保证金即可申请成为超级商家。" font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:secondSubLabel];
    [secondSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.right.equalTo(@(ScaleW(-15)));
        make.top.equalTo(secondLabel.mas_bottom).offset(ScaleW(13));
        make.bottom.offset(ScaleW(-20));
    }];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.equalTo(@0);
            make.bottom.equalTo(self.agreeBtn.mas_top).offset(ScaleW(-10));
        }];
    }
    return _scrollView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        [_scrollView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(@0);
            make.centerX.equalTo(self.scrollView);
            make.width.equalTo(@(ScreenWidth));
            make.top.equalTo(@0);
        }];
    }
    return _contentView;
}

- (UIButton *)applyBtn{
    if (!_applyBtn) {
        _applyBtn = [WLTools allocButton:@"申请成为商家" textColor:kMainWihteColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        [self.view addSubview:_applyBtn];
        [_applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
        _applyBtn.titleLabel.font = systemBoldFont(ScaleW(15));
        _applyBtn.layer.masksToBounds = YES;
        _applyBtn.layer.cornerRadius = ScaleW(5);
        _applyBtn.backgroundColor = kMainBlueColor;
        [_applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(25)));
            make.right.equalTo(@(ScaleW(-25)));
            make.height.equalTo(@(ScaleW(45)));
            make.bottom.equalTo(@(ScaleW(-20)));
        }];
    }
    return _applyBtn;
}

- (UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [WLTools allocButton:@" 同意冻结0ISCM作为商家保证金" textColor:kMainBlueColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        [self.view addSubview:_agreeBtn];
        [_agreeBtn addTarget:self action:@selector(agreeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _agreeBtn.titleLabel.font = systemFont(ScaleW(11));
        [_agreeBtn setImage:[UIImage imageNamed:@"weixuanze"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateSelected];
        [_agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.applyBtn);            make.bottom.equalTo(self.applyBtn.mas_top).offset(ScaleW(-13));
        }];
    }
    return _agreeBtn;
}

- (void)applyAction{
//    if (!self.price.length) {
//        [CMRemind error:@"未获取到最新价格,请退出重试"];
//        return;
//    }
    if (!self.agreeBtn.selected) {
        [CMRemind error:@"请同意冻结保证金"];
        return;
    }
    
    [self requestApplyShop];
}

- (void)agreeBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)updateInfo{
    [self.agreeBtn setTitle:[NSString stringWithFormat:@" 同意冻结%@ISCM作为商家保证金", self.price] forState:UIControlStateNormal];
    self.priceLabel.text = [NSString stringWithFormat:@"发送邮件后，请在本页面点击“确认申请”按钮，提交申请。并同意冻结%@ISCM作为商家保证金，什么是ISCM?提交完成后，您即可在普通交易区发布广告。", self.price];
}


#pragma mark -- 获取个人信息
-(void)requestGetInfo
{
    [CMRemind show];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_get_user_info_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        [CMRemind dismiss];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:netWorkModel.data];
            [SSKJ_User_Tool sharedUserTool].userInfoModel = userModel;
            self.price = userModel.shop_fee;
            [self updateInfo];
        }
        else
        {
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [CMRemind dismiss];
    }];
}

#pragma mark - 商家认证
-(void)requestApplyShop
{
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
    
    NSDictionary *params = @{
                             @"account":Account
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_ApplyShop_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showSuccess:SSKJLocalized(@"提交成功", nil)];
            [SSKJ_User_Tool sharedUserTool].userInfoModel.is_shop = @"2";
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

@end
