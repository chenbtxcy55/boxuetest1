//
//  BFEXSafeSelectViewController.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/10.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEXSafeSelectViewController.h"
#import "BFEXShowChartView.h"
#import "JB_PayWayModel.h"
@interface BFEXSafeSelectViewController ()
@property (nonatomic, strong) BFEXShowChartView *showView;
@end

@implementation BFEXSafeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}
-(void)showViewAlert:(id)type{
    if ([type isKindOfClass:[NSString class]]) {
        self.showView.addType = type;
    }
    if ([type isKindOfClass:[JB_PayWayModel class]]) {
        self.showView.addType = @"edit";
        self.showView.dataData = type;
    }
    
}
-(BFEXShowChartView *)showView
{
    if (!_showView) {
        WS(weakSelf);
        _showView = [[BFEXShowChartView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _showView.viewController = self;
        [self.view addSubview:_showView];
        _showView.sucessBlock = ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadBankListAction" object:nil];
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                
            }];
        };
        _showView.cancellBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                
            }];
        };
    }
    return _showView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
