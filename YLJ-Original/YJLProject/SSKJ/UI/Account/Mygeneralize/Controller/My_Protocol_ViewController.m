//
//  My_Protocol_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Protocol_ViewController.h"


@interface My_Protocol_ViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation My_Protocol_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.view.backgroundColor = kMainBackgroundColor;
    
    [self setupUI];
    [self requestProtocolContent];
    
    if (self.protocolType == PROTOCOLTYPEPRIVATE) {
        self.title = SSKJLocalized(@"隐私条款", nil);
    }else if(self.protocolType == PROTOCOLTYPESERVICE){
        self.title = SSKJLocalized(@"服务协议", nil);
    }
}

- (void)setupUI {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
    webView.backgroundColor = kMainBackgroundColor;
    webView.delegate = self;
    [self.view addSubview:webView];
    _webView = webView;
}

- (void)requestProtocolContent {
    
    
//    NSString *type;
//    if (self.protocolType == PROTOCOLTYPEPRIVATE) {
//        type = @"trans_agree";
//    }else  if (self.protocolType == PROTOCOLTYPESERVICE) {
//        type = @"reg_agree";
//    }
//    
//    if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"en"]) {
//        // 英文
//        type = [type stringByAppendingString:@"1"];
//    }else if([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"zh-Hant"]  || [[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"zh-Hans"]){
//    }
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"type"] = type;
//    LSLog(@"params : %@",params);
//    __weak typeof(self) weakSelf = self;
//    [HttpTool postWithURL:ProtocolURL params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        LSLog(@"json : %@",json);
//        [weakSelf.hud hideAnimated:YES];
//        if (status.integerValue == 200) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.webView loadHTMLString:json[@"data"] baseURL:nil];
//            });
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        [weakSelf.hud hideAnimated:YES];
//        LSLog(@"error : %@",error);
//        [MBProgressHUD showError:ZBLocalized(@"网错出错", nil)];
//    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    ///250是字体的大小,根据自己的需求修改
    NSString* fontSize = [NSString stringWithFormat:@"%d",160];

    fontSize = [fontSize stringByAppendingFormat:@"%@",@"%"];;

//    NSString* str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",fontSize];
//
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"];
//
//
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2d3033'"];
//
//    [self.webView stringByEvaluatingJavaScriptFromString:str];

}

@end
