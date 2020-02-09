//
//  YLJWebViewTableViewCell2.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJWebViewTableViewCell2.h"
@interface YLJWebViewTableViewCell2()
<UIWebViewDelegate>

@end
@implementation YLJWebViewTableViewCell2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
}

- (void)viewConfig {
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setHtmlString:(NSString *)htmlString {
    _htmlString = htmlString;
    [self cleanCacheAndCookie];
    [self.webView removeFromSuperview];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - ScaleW(30), 1)];
    self.webView = webView;
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:ProductBaseServer];
    
    [self.webView loadHTMLString:htmlString baseURL:url];
    //    [self.webView loadHTMLString:htmlString baseURL:nil];
    
    //监听scrollView contentSize 变化
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    
}
/**清除缓存和cookie*/

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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"-----------------webViewDidFinishLoad");
    if (webView.isLoading) {
        return;
    }
    CGFloat webViewHeightFromScrollContentSize =[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeightFromScrollContentSize;
    webView.frame = newFrame;
    
    //下面这两行是去掉不必要的webview效果的(选中,放大镜)
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"webViewload出错了!");
}

//监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize2"]) {
        
        CGSize fitSize = [_webView sizeThatFits:CGSizeZero];
        //        NSLog(@"webview fitSize:%@",NSStringFromCGSize(fitSize));
        self.webView.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
        
        if(self.changeHeightBlock){
            self.changeHeightBlock(self.webView.frame.size.height);
        }
    }
}

//这里别忘了在dealloc理移除监听
- (void)dealloc {
    NSLog(@"webView ---------dealloc");
    [self.webView.scrollView removeObserver:self
                                 forKeyPath:@"contentSize" context:nil];
}

@end
