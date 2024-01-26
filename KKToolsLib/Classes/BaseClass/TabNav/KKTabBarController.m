//
//  KKTabBarController.m
//  FileMusic
//  
//  Created by 陈德军 on 2024/1/23.
//  Copyright ©合肥维方科技有限公司. All rights reserved.
//  
//                      ____   ____      __
//                     / ___\ / _  \    / /
//                    / /    / / / /   / /
//                   / /___ / /_/ /?__/ /
//                  /_ -_-_/____,‘\____/
//
//
    

#import "KKTabBarController.h"
#import "KKNavigationController.h"

#import "MusicListVC.h"
#import "HomePageVC.h"
#import "TransferVC.h"
#import "SettingVC.h"


@interface KKTabBarController ()<UITabBarControllerDelegate>{
    
}

@end

@implementation KKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(notificationCenterChangeAppLanguageEvent)
//                                                 name:KK_NotificationCenter_ChangeAppLanguage
//                                               object:nil];
    
    UIColor *tabbarBackgroudColor  = [UIColor whiteColor];
    // 需要隐藏线条就设置[UIColor clearColor]
    UIColor *tabbarLineColor = KK_BGMainColor;
    
    if (@available (iOS 15.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = tabbarBackgroudColor;
        appearance.shadowColor = tabbarLineColor;
        self.tabBar.standardAppearance = appearance;
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
    } else {
        [[UITabBar appearance] setShadowImage:[self createImageWithColor:tabbarLineColor]];
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
        [UITabBar appearance].backgroundColor = tabbarBackgroudColor;
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    
    [self setupChildVC];
}

- (void)setupChildVC{
    HomePageVC *vc1 = [HomePageVC new];
    [self setupTabbarItem:vc1.tabBarItem title:KK_LocalizedString(@"首页") normalImage:@"tab_0_n" selectedImage:@"tab_0_y"];
    
    MusicListVC *vc2 = [MusicListVC new];
    [self setupTabbarItem:vc2.tabBarItem title:KK_LocalizedString(@"音乐") normalImage:@"tab_1_n" selectedImage:@"tab_1_y"];
    
    TransferVC *vc3 = [TransferVC new];
    [self setupTabbarItem:vc3.tabBarItem title:KK_LocalizedString(@"传输") normalImage:@"tab_2_n" selectedImage:@"tab_2_y"];

    SettingVC *vc4 = [SettingVC new];
    [self setupTabbarItem:vc4.tabBarItem title:KK_LocalizedString(@"我的") normalImage:@"tab_3_n" selectedImage:@"tab_3_y"];
    
    KKNavigationController *nav1 = [[KKNavigationController alloc]initWithRootViewController:vc1];
    KKNavigationController *nav2 = [[KKNavigationController alloc]initWithRootViewController:vc2];
    KKNavigationController *nav3 = [[KKNavigationController alloc]initWithRootViewController:vc3];
    KKNavigationController *nav4 = [[KKNavigationController alloc]initWithRootViewController:vc4];

    self.viewControllers = @[nav1, nav2, nav3, nav4];
}

- (void)setupTabbarItem:(UITabBarItem *)tabbarItem title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage{
    [tabbarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)]; //将tabbar的title上移，y为负时上移，y为正下移
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];//为了防止系统着色，使用UIImageRenderingModeAlwaysOriginal提供图像
    
    // 未选中样式
    NSDictionary *attribuDic = @{
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"181818" alpha:0.4],
                                 NSFontAttributeName:[UIFont fontWithName:KK_Regular size:9],
                                 };
    [[UITabBarItem appearance]setTitleTextAttributes:attribuDic forState:UIControlStateNormal];
    
    // 选中样式
    NSDictionary *attributSelDic = @{
                                     NSForegroundColorAttributeName:KK_MainColor,
                                     NSFontAttributeName:[UIFont fontWithName:KK_Regular size:9],
                                     };
    [[UITabBarItem appearance] setTitleTextAttributes:attributSelDic forState:UIControlStateSelected];
}


- (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, kScreenWidth, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
