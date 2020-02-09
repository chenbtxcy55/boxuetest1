//
//  SSKJ_TabbarController.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_TabbarController.h"

#import "UIImage+RoundedRectImage.h"

#import "SSKJ_BaseNavigationController.h"

#import "JB_Main_Root_ViewController.h"

#import "JB_FBC_Root_ViewController.h"

#import "JB_BBTrade_Root_ViewController.h"

#import "JB_Account_Root_ViewController.h"

#import "JB_Login_ViewController.h"

#import "MarketListViewController.h"

#import "MyAssert_Main_ViewController.h"

#import "YLJShopRootViewController.h"
#import "YLJ_MyRootViewController.h"

#import "Mine_Spertor_List_ViewController.h"



#define kControllerNameArray @[@"SSKJ_Main_Root_ViewController",@"YLJShopRootViewController",/*@"SuperMarket_Root_ViewController",*/@"Mine_Spertor_List_ViewController"/*,@"Money_Root_ViewController",@"Shop_Root_ViewController"*/,@"YLJ_MyRootViewController"]

#define kControllerTitleArray @[@"首页",@"商城",@"推广",@"我的"]

#define kImageNameArray @[@"firstPage_unSelected",@"shop_tav_unSelected",@"my_assert_unSelectede",@"my_tar_unSelected"]
#define kSelectedImageNameArray @[@"firstPage_selected",@"shop_tav_selected",@"my_assert_selectede",@"my_tar_selected"]

@interface SSKJ_TabbarController ()<UITabBarControllerDelegate>
@end

@implementation SSKJ_TabbarController
/**
 *  当第一次使用这个类或者子类的时候调用，作用：初始化
 */
#pragma mark - 改变 tabbar 选中状态下的文字颜色
+ (void)initialize
{
    //获取当前这个类下面的所有 tabBarItem
    //    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //
    //    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    //    //改变选中 tabbar 字体的颜色
    //    [mutDic setObject:kMainTextColor forKey:NSForegroundColorAttributeName];
    //    [item setTitleTextAttributes:mutDic forState:UIControlStateSelected];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTextTabColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTheMeColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    UITabBar *tabBar = [UITabBar appearance];
    

//    [tabBar setBarTintColor:kNavBGColor];
    [tabBar setBarTintColor:kMainWihteColor];

    
    tabBar.translucent = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self addAllChildViewController];
    
    self.selectedIndex = 0;
    self.delegate = self;
}

#pragma mark - 加载所有的子控制器
- (void)addAllChildViewController
{
    for (int i = 0; i < kControllerNameArray.count; i++)
    {
        NSString *controllerStr = kControllerNameArray[i];
        NSString *title = SSKJLocalized(kControllerTitleArray[i], nil);
        NSString *image = kImageNameArray[i];
        NSString *selectedImage = kSelectedImageNameArray[i];
        id controller = [[NSClassFromString(controllerStr) alloc] init] ;
        [self addChildVC:controller title:title image:image selectedImage:selectedImage];
    }
    
}

/**
 *  添加子控制器
 *
 *  @param childVC      子控制器
 *  @param title        标题
 *  @param image        正常状态图片
 *  @param seletedImage 选中时的图片
 */
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)seletedImage
{
    SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:childVC];
    
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    
    childVC.tabBarItem.selectedImage = [UIImage imageWithOriginalName:seletedImage];
    
    naviVC.tabBarItem.title = title;
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kSubTxtColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateNormal];
//
//
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kMainBlueColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateSelected];

    
    [self addChildViewController:naviVC];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    SSKJ_BaseNavigationController *navc = (SSKJ_BaseNavigationController *)viewController;
    
    if ([navc.topViewController isKindOfClass:[Mine_Spertor_List_ViewController class]]) {

        if (!kLogin) {
            [MBProgressHUD showError:@"请先登录"];
            JB_Login_ViewController *loginVc = [[JB_Login_ViewController alloc]init];
            SSKJ_BaseNavigationController *loginNavc = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:loginVc];
            loginNavc.modalPresentationStyle = UIModalPresentationFullScreen;

            [self presentViewController:loginNavc animated:YES completion:nil];
            return NO;
        } else {
            if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.state intValue] == 0) {
                [MBProgressHUD showError:SSKJLocalized(@"请先激活用户", nil)];
                return NO;
            }
        }
    }
    return YES;
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
