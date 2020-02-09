//
//  JB_Setting_ViewController.m
//  SSKJ
//
//  Created by James on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Setting_ViewController.h"
#import "SSKJ_TabbarController.h"
#import "ETF_Default_ActionsheetView.h"
@interface JB_Setting_ViewController ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *languageLB;
@property (nonatomic, strong) UILabel *languageSubLB;
@property (nonatomic, strong) UIImageView *arrowIM;
@end

@implementation JB_Setting_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMainBackgroundColor;
    self.title = SSKJLocalized(@"设置", nil);
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.languageLB];
    [self.bgView addSubview:self.languageSubLB];
    [self.bgView addSubview:self.arrowIM];
    
    [self setupMasonry];
    
//    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"Eng"] isEqualToString:@"1"]) {
//        self.languageSubLB.text = @"English";
//    }else{
//        self.languageSubLB.text = @"中文";
//    }
    
    
    if ([[[SSKJLocalized sharedInstance]currentLanguage] isEqualToString:@"zh-Hans"]) {
        self.languageSubLB.text = @"中文";
    }else{
        self.languageSubLB.text = @"English";
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}


#pragma mark -- 语言点击
- (void)languageTapClick {
//    [self languageSwitch];
    NSArray *array = @[@"中文",@"English"];
    WS(weakSelf);
    [ETF_Default_ActionsheetView showWithItems:array title:SSKJLocalized(@"是否确认切换语言", nil) selectedIndexBlock:^(NSInteger selectIndex) {

        if ([weakSelf.languageSubLB.text isEqualToString:@"中文"]) {
//            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"Eng"];
            [[SSKJLocalized sharedInstance]setLanguage:@"en"];
            
        }else{
//            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"Eng"];
            [[SSKJLocalized sharedInstance]setLanguage:@"zh-Hans"];
        }
        SSKJ_TabbarController *tab=[[SSKJ_TabbarController alloc]init];
        tab.selectedIndex=0;
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    } cancleBlock:^{
        
    }];
}

- (void)languageSwitch {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"是否确认切换语言", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.languageSubLB.text isEqualToString:@"中文"]) {
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"Eng"];
            [[SSKJLocalized sharedInstance]setLanguage:@"en"];
            
        }else{
            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"Eng"];
            [[SSKJLocalized sharedInstance]setLanguage:@"zh-Hans"];
        }
//        NSString *language=[[SSKJLocalized sharedInstance]currentLanguage];
        SSKJ_TabbarController *tab=[[SSKJ_TabbarController alloc]init];
        tab.selectedIndex=0;
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    }]];
    alertVC.modalPresentationStyle = UIModalPresentationFullScreen;

    [self presentViewController:alertVC animated:YES completion:nil];
}





- (void)setupMasonry {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ScaleW(10));
        make.height.mas_equalTo(ScaleW(50));
    }];
    [self.languageLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(ScaleW(17));
    }];
    [self.arrowIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.equalTo(self.bgView).offset(-ScaleW(17));
    }];
    [self.languageSubLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.equalTo(self.arrowIM.mas_left).offset(-ScaleW(17));
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kSubBackgroundColor;
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(languageTapClick)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UILabel *)languageLB {
    if (!_languageLB) {
        _languageLB = [[UILabel alloc]init];
        _languageLB.text = SSKJLocalized(@"语言", nil);
        _languageLB.font = [UIFont systemFontOfSize:ScaleW(15)];
        _languageLB.textColor = [UIColor colorWithHexStringToColor:@"b2b9e7"];
    }
    return _languageLB;
}

- (UILabel *)languageSubLB {
    if (!_languageSubLB) {
        _languageSubLB = [[UILabel alloc]init];
        _languageSubLB.text = @"中文";
        _languageSubLB.font = [UIFont systemFontOfSize:ScaleW(15)];
        _languageSubLB.textColor = [UIColor colorWithHexStringToColor:@"878ff5"];
    }
    return _languageSubLB;
}

- (UIImageView *)arrowIM {
    if (!_arrowIM) {
        _arrowIM = [[UIImageView alloc]init];
        _arrowIM.image = [UIImage imageNamed:@"arrow_right_icon"];
    }
    return _arrowIM;
}

@end
