//
//  AppDelegate.m
//  CarCare
//
//  Created by joe on 2017/3/8.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "IQKeyboardManager.h"
#import "APPUpdateManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;

    
    [APPUpdateManager shareInstance];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    [self.window makeKeyAndVisible];
    
    
    [[UINavigationBar appearance] setTintColor:mainColor ];
    [UINavigationBar appearance].barTintColor = [UIColor blackColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:mainColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]}];


    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.hidden = YES;
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, WindowWidth, 1)];
    [nav.navigationBar addSubview:line];
    line.backgroundColor = mainColor;
    
    self.window.rootViewController = nav;
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    
    if (![CommonFunc hasSetSetting]) {
        NSString *yalidanwei = @"Bar";
        NSString *wendudanwei = @"°C";
        CGFloat defaultYaliShang = 3.0;
        CGFloat defaultYaliXia = 2.0;
        CGFloat defaultWenduShang = 65;
        CGFloat defaultDianliang = 20;
        
        [CommonFunc setisZhenDong:NO];
        [CommonFunc setyalidanwei:yalidanwei];
        [CommonFunc setwendudanwei:wendudanwei];
        [CommonFunc setdefaultYaliShang:defaultYaliShang];
        [CommonFunc setdefaultYaliXia:defaultYaliXia];
        [CommonFunc setdefaultWenduShang:defaultWenduShang];
        [CommonFunc setdefaultdianliangXia:defaultDianliang];
        [CommonFunc setisPlayVioce:YES];
        
        
        [CommonFunc setHasSetSetting];
    }

    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self redirectNSLogToDocumentFolder];
        
    });

    
    

    

    return YES;
}

void UncaughtExceptionHandler(NSException* exception)
{
    NSLog(@"UncaughtExceptionHandler Begin\r\n");
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ]; //将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [ strSymbols appendString: item ];
        [ strSymbols appendString: @"\r\n" ];
    }
    
    //将crash日志保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.txt"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]\r\n\r\n", dateStr, name, reason, strSymbols];
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    
    NSLog(@"UncaughtExceptionHandler End\r\n");
    //把错误日志发送到邮箱
    //    NSString *urlStr = [NSString stringWithFormat:@"mailto://test@163.com?subject=bug报告&body=感谢您的配合!<br><br><br>错误详情:<br>%@",crashString ];
    //    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    [[UIApplication sharedApplication] openURL:url];
}



- (void)redirectNSLogToDocumentFolder
{
    //如果已经连接Xcode调试则不输出到文件
    if(isatty(STDOUT_FILENO)) {
        return;
    }
    
    UIDevice *device = [UIDevice currentDevice];
    if([[device model] hasSuffix:@"Simulator"]){ //在模拟器不保存到文件中
        return;
    }
    
    //将NSlog打印信息保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //每次启动后都保存一个新的日志文件中
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/%@.log",dateStr];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
