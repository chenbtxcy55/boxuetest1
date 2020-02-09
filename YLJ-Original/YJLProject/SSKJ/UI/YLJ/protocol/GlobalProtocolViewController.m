//
//  GlobalProtocolViewController.m
//  ZYW_MIT
//
//  Created by mac on 2019/9/20.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "GlobalProtocolViewController.h"
#import "ProtocolModel.h"
@interface GlobalProtocolViewController ()<UIWebViewDelegate>


@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation GlobalProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.view.backgroundColor = kMainColor;
    
    [self setupUI];
    [self requestProtocolContent];
    

}

- (void)setupUI {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
//    webView.backgroundColor = KNavBgColor;
    webView.delegate = self;
    [self.view addSubview:webView];
    _webView = webView;
}

- (void)requestProtocolContent {

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = [NSString stringWithFormat:@"%ld",(long)self.type];
    NSLog(@"params : %@",params);
    __weak typeof(self) weakSelf = self;
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_agree_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [weakSelf.hud hideAnimated:YES];
        if (model.status.integerValue == 200) {
            ProtocolModel *pModel = [ProtocolModel mj_objectWithKeyValues:model.data];
            weakSelf.title = pModel.title;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",self.view.width -ScaleW(30),pModel.content];

                NSURL *url = [NSURL URLWithString:ProductBaseServer];
//                [weakSelf.webView loadHTMLString:pModel.content baseURL:url];
                [weakSelf.webView loadHTMLString:str baseURL:url];
            });
        } else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    ///250是字体的大小,根据自己的需求修改
    NSString* fontSize = [NSString stringWithFormat:@"%d",160];
    
    fontSize = [fontSize stringByAppendingFormat:@"%@",@"%"];;
    
    //    NSString* str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",fontSize];
    //
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#6c6c6c'"];
    //
    //
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#ffffff'"];
    //
    //    [self.webView stringByEvaluatingJavaScriptFromString:str];
    
}

@end
