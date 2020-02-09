//
//  ISCMProtocolViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ISCMProtocolViewController.h"

@interface ISCMProtocolViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation ISCMProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"用户服务协议", nil);
    
    [self.view addSubview:self.scrollView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    [self network];
}

#pragma mark - lazy load
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
//        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.left.bottom.equalTo(@0);
//            make.top.equalTo(@(ScaleW(5)));
//        }];
        _scrollView.frame = CGRectMake(0, ScaleW(20), ScreenWidth, ScreenHeight-Height_NavBar - ScaleW(20));
        [_scrollView addSubview:self.contentLabel];
    }
    return _scrollView;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(100)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _contentLabel;
}

#pragma mark - 加载内容
- (void)network{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
    NSString *type;
    if ([language isEqualToString:@"en"]) {
        language = @"en";
    }else{
        language = @"zh-CN";
    }
    
    NSDictionary *params = @{
                             @"type":@"reg_agree",
//                             @"language":language
                             };
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:kIscm_agree_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             
             NSString *detailTextString = [NSString stringWithFormat:@"%@",network_Model.data];
             NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",self.view.width -ScaleW(30),detailTextString];
             
             
             @try {
                 
                 NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                 if (!attrStr.length) {
                     return;
                 }
                 [attrStr addAttribute:NSForegroundColorAttributeName
                                 value:kTitleColor
                                 range:NSMakeRange(0, attrStr.length - 1)];
                 weakSelf.contentLabel.attributedText = attrStr;
                 
                 weakSelf.contentLabel.numberOfLines = 0;
                 
                 [weakSelf.contentLabel sizeToFit];
                 
                 
             } @catch (NSException *exception) {
                 NSLog(@"-----数据异常-----");
             } @finally {
                 
             }
             
             //             NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
             //             [paragraphStyle setLineSpacing:2];
             //             [paragraphStyle setParagraphSpacing:5];
             //
             //             [attrStr addAttribute:NSParagraphStyleAttributeName
             //                             value:paragraphStyle
             //                             range:NSMakeRange(0, [attrStr length] - 1)];
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
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
