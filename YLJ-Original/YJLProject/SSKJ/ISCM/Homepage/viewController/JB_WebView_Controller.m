//
//  JB_WebView_Controller.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/13.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_WebView_Controller.h"
#import <WebKit/WebKit.h>

@interface JB_WebView_Controller ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *htmlString;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIScrollView *contenScrollView;

@end

@implementation JB_WebView_Controller


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cleanCacheAndCookie];
    
    [self setUI];
    

    //self.url = ETF_REGISTERPROTOCOL_URL;
    
    if (self.protocolType == PROTOCOLTYPEPABOUT) {
        self.url =  kowner_shopshop_notice_detail;
    }
    //[self.webView loadRequest:[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]]];
    
    
    //[self requestContent];
    self.title = @"资讯详情";
     self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(UIScrollView *)contenScrollView
{
    if (!_contenScrollView) {
        _contenScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        [_contenScrollView addSubview:self.titleLabel];
        [_contenScrollView addSubview:self.dateLabel];
        [_contenScrollView addSubview:self.contentLabel];
        
        
    }
    return _contenScrollView;
}
-(UILabel *)titleLabel

{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(15))
                       ];
        [_titleLabel label:_titleLabel font:ScaleW(15) textColor:kMainTextColor text:@""];
        
        //_titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel ) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), _titleLabel.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(12))];
        [_dateLabel label:_dateLabel font:ScaleW(12) textColor:kSubSubTxtColor text:@""];
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}

-(UILabel *)contentLabel

{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(30) + _dateLabel.bottom, ScreenWidth - ScaleW(30), ScaleW(15))
                       ];
        [_contentLabel label:_contentLabel font:ScaleW(15) textColor:kMainTextColor text:@""];
        
        
    }
    return _contentLabel;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self requstAcction];
    [self.view addSubview:self.contenScrollView];
}
-(void)requstAcction
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    NSDictionary *params = @{
                             @"id":self.idString,
                            
                             };
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kowner_shopshop_notice_detail RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            self.titleLabel.text = netWorkModel.data[@"title"];
            self.dateLabel.text = netWorkModel.data[@"create_time"];
            NSString *detailTextString = [NSString stringWithFormat:@"%@",netWorkModel.data[@"content"]];
            NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",self.view.width -ScaleW(30),detailTextString];
            self.contentLabel.attributedText = [self getanOther: str];
            self.contentLabel.numberOfLines = 0;
            [self.contentLabel sizeToFit];
            CGRect rect = self.contentLabel.frame;
            rect.size.height = [self getAttriHeightWithLabel:self.contentLabel width:self.view.bounds.size.width];
            self.contentLabel.frame = rect;
            _contenScrollView.contentSize = CGSizeMake(0, self.contentLabel.bottom + ScaleW(250));
            _contenScrollView.scrollEnabled = YES;
            
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
            
            
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
    
}

-(NSAttributedString *)getanOther:(NSString *)string
{
    NSAttributedString *trimmedString =   [self strToAttriWithStr:string];
   
    return trimmedString;
    
}

/**
 *  富文本转html字符串
 */
- (NSString *)attriToStrWithAttri:(NSAttributedString *)attri{
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    
    NSData *htmlData = [attri dataFromRange:NSMakeRange(0, attri.length)
                         documentAttributes:tempDic
                                      error:nil];
    
    return [[NSString alloc] initWithData:htmlData
                                 encoding:NSUTF8StringEncoding];
}

/**
 *  字符串转富文本
 */
- (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr{
    return [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
}

/**
 *获得富文本的高度
 **/
-(CGFloat)getAttriHeightWithLabel:(UILabel *)label width:(CGFloat)width {
    CGFloat height = [label.attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;//针对富文本
    return height;
}

- (void)requestGetjyznGUrl
{
    
}

- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}


#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.contenScrollView];
}

-(WKWebView *)webView
{
    if (nil == _webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
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
        
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        
    }
    return _webView;
}



#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"completionHandler:nil];
    
    //修改字体颜色  #9098b8
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"completionHandler:nil];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showError:SSKJLocalized(@"加载失败",nil)];
}



#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //网页title
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.title = SSKJLocalized(@"用户服务协议", nil);
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"title"];
}

-(void)requestContent
{
    
    NSString *lang;
    if ([[[SSKJLocalized sharedInstance]currentLanguage] hasPrefix:@"en"]) {
        lang = @"en";
    }else{
        lang = @"zh";
    }
    
    NSDictionary *params = @{
                             @"lang":lang
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:self.url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            NSString *key;
            if (weakSelf.protocolType == PROTOCOLTYPEREGISTER) {
                key = @"reg_agree";
            }else if (weakSelf.protocolType == PROTOCOLTYPEPRIVACY){
                key = @"trans_agree";
            }else if (weakSelf.protocolType == PROTOCOLTYPEPTRADE){
                key = @"trade_agree";
            }else if (weakSelf.protocolType == PROTOCOLTYPEPLAW){
                key = @"law_agree";
            }else if (weakSelf.protocolType == PROTOCOLTYPEPABOUT){
                key = @"faq";
            }else if (weakSelf.protocolType == PROTOCOLTYPEPABOUTAML){
                key = @"aml";
            }
            
            weakSelf.htmlString = [network_model.data objectForKey:key];
            [weakSelf.webView loadHTMLString:weakSelf.htmlString  baseURL:nil];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
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
