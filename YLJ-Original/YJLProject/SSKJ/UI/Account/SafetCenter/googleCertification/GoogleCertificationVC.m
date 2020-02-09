//
//  GoogleCertificationVC.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2018/8/30.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "GoogleCertificationVC.h"

#import "GoogleCodeVC.h"
@interface GoogleCertificationVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detaillabel;

@property (weak, nonatomic) IBOutlet UIButton *fuzhiBtn;
@property (weak, nonatomic) IBOutlet UILabel *tishiLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@property (weak, nonatomic) IBOutlet UIImageView *erweimaImg;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end

@implementation GoogleCertificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createGoogleCommand];
    self.titleLabel.text = SSKJLocalized(@"绑定谷歌身份验证器", nil);
    self.detaillabel.text = SSKJLocalized(@"请妥善备份二维码以防遗失", nil);
    self.tishiLabel.text = SSKJLocalized(@"请妥善保存", nil);
    [self.fuzhiBtn setTitle:SSKJLocalized(@"复制", nil) forState:UIControlStateNormal];
    [self.nextBtn setTitle:SSKJLocalized(@"下一步", nil) forState:UIControlStateNormal];
}

- (IBAction)copyBtnClick:(UIButton *)sender {
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.codeLabel.text;
}
- (IBAction)nextBtnClick:(id)sender {
    GoogleCodeVC *codeVC = [[GoogleCodeVC alloc]init];
    [self.navigationController pushViewController:codeVC animated:YES];
}

// 加载邀请码
- (void)createGoogleCommand {
//    [[ManagerGlobeUntil sharedManager] showHUDWithMsg:ZBLocalized(@"加载中", nil) inView:self.view];
//    WS(weakSelf);
//    [HttpTool getWithURL:CreateGoogleCommand params:nil success:^(id json) {
//        NSLog(@"json : %@",json);
//        
//        if ([json[@"status"] integerValue] == 200) {
//            weakSelf.codeLabel.text = json[@"data"][@"command"];
//            [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
//            [weakSelf.erweimaImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",json[@"data"][@"local_url"]]] placeholderImage:nil];
//        }
//         [[ManagerGlobeUntil sharedManager] hideHUDFromeView:weakSelf.view];
//    } failure:^(NSError *error) {
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:weakSelf.view];
//        [MBProgressHUD showError:ZBLocalized(@"服务器请求异常", nil)];
//    }];
//    
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
