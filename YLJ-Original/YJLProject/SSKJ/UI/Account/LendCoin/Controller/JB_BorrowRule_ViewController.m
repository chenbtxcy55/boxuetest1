//
//  JB_BorrowRule_ViewController.m
//  SSKJ
//
//  Created by James on 2019/5/22.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BorrowRule_ViewController.h"
#import <WebKit/WebKit.h>
@interface JB_BorrowRule_ViewController ()
<WKUIDelegate,WKNavigationDelegate,NSURLSessionDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation JB_BorrowRule_ViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = kMainBackgroundColor;
    self.title= SSKJLocalized(@"规则说明", nil);
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - 页面即将显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.translucent = NO;
    [self requestGetNoticeDetailURL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma  mark - 创建UI
- (void)createUI
{

    [self webView];
    
    
}



-(WKWebView *)webView
{
    if (nil == _webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero];
        
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView setOpaque:FALSE];
        _webView.backgroundColor=[UIColor clearColor];
        
        if (@available(iOS 11.0, *))
        {
            
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
            _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
            
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
        
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.view).offset(ScaleW(10));
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.width.equalTo(@(ScreenWidth));
            //            make.height.equalTo(@(0.1));
            
            make.bottom.equalTo(self.view.mas_bottom);
            
        }];
    }
    return _webView;
}


-(void)htmlStringWithString:(NSString *)htmlString
{
    NSString *newHtmlString = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "body {font-size:15px;}\n"
                               "</style> \n"
                               "</head> \n"
                               "<body>"
                               "<script type='text/javascript'>"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName('img');\n"
                               "for(var p in  $img){\n"
                               " $img[p].style.width = '100%%';\n"
                               "$img[p].style.height ='auto'\n"
                               "}\n"
                               "}"
                               "</script>%@"
                               "</body>"
                               "</html>",htmlString];
    
    // webView直接加载HTMLString
    //    [self.webViewContent loadHTMLString:newHtmlString baseURL:[NSURL URLWithString:nil]];
    
    [self.webView loadHTMLString:newHtmlString baseURL:[NSURL URLWithString:ProductBaseServer]];
    
}


//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
//    [_webViewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.titleBackView.mas_bottom).offset(ScaleW(10));
//
//        make.left.equalTo(@0);
//
//        make.right.equalTo(@0);
//
//        make.width.equalTo(@(ScreenWidth));
//
//        make.bottom.equalTo(self.view.mas_bottom);
//
//    }];
//    ///250是字体的大小,根据自己的需求修改
//    NSString* fontSize = [NSString stringWithFormat:@"%d",160];
//
//    fontSize = [fontSize stringByAppendingFormat:@"%@",@"%"];;
//
//    NSString* str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",fontSize];
////
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"];
////
////
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2d3033'"];
////
//    [self.webViewContent stringByEvaluatingJavaScriptFromString:str];
//
//}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"completionHandler:nil];
    
    //修改字体颜色  #9098b8
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"completionHandler:nil];
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *string = [NSString stringWithFormat:@"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function ResizeImages() { "
                        "var myimg,oldwidth;"
                        "var maxwidth = 1000.0;" // WKWebView中显示的图片宽度
                        "for(i=0;i <document.images.length;i++){"
                        "myimg = document.images[i];"
                        "oldwidth = myimg.width;"
                        "myimg.width = maxwidth;"
                        "}"
                        "}\";"
                        "document.getElementsByTagName('head')[0].appendChild(script);ResizeImages();"];
    
    [webView evaluateJavaScript:string completionHandler:nil];
    
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [MBProgressHUD showError:@"加载失败"];
}



#pragma mark -- 规则情 --
- (void)requestGetNoticeDetailURL
{
    
    NSDictionary *params = @{};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Borrow_Rule_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            [weakSelf createUI];
            NSString *rule = netWorkModel.data[@"rule"];
            if ([[SSKJLocalized sharedInstance].currentLanguage isEqualToString:@"en"]) {
                rule = netWorkModel.data[@"rule_en"];
            }else{
                rule = netWorkModel.data[@"rule"];
            }
            [weakSelf htmlStringWithString:rule];
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
