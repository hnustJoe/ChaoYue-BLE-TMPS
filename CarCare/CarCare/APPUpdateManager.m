//
//  APPUpdateManager.m
//  MoveBand
//
//  Created by joe on 2016/11/23.
//  Copyright © 2016年 alcatel. All rights reserved.
//

#import "APPUpdateManager.h"


@interface APPUpdateManager ()<NSURLConnectionDataDelegate,UIAlertViewDelegate>
//{
//    NSString *version; //版本信息
//    NSString *trackViewUrl; //app下载地址
//}

@property (nonatomic,copy) NSString *version;//版本信息
@property (nonatomic,copy) NSString *trackViewUrl;//app下载地址

@end


@implementation APPUpdateManager


+ (instancetype)shareInstance{
    static APPUpdateManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APPUpdateManager alloc]init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}


- (void)appEnterForeground{
    
    
    
    NSInteger latestCheckTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"latestCheckTime"];
    
    
    NSInteger currentTimeInter = [[NSDate date]timeIntervalSince1970];
    if (currentTimeInter -  latestCheckTime > 3600 * 24) {
        
        
        [[NSUserDefaults standardUserDefaults]setInteger:currentTimeInter forKey:@"latestCheckTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *urlStr = @"https://itunes.apple.com/lookup?id=1223781321";
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:req delegate:self];

        
    }
    
//    1492588093
    
    
  


    
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *appInfo = (NSDictionary *)jsonObject;
    NSArray *infoContent = [appInfo objectForKey:@"results"];
    
    if (infoContent.count == 0) {
        return;
    }
    
    
    self.version = [[infoContent objectAtIndex:0]objectForKey:@"version"];
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    

    
        NSInteger  localVersion = [[currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
        NSInteger latestVersion = [[self.version stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    
    
        if (localVersion < latestVersion ) {
            self.trackViewUrl = [[infoContent objectAtIndex:0]objectForKey:@"trackViewUrl"];
            [self alertViewShow];
        }
        
    
}
- (void)alertViewShow{
    
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"IDS_FIND_NEW_DEVICE",@"发现新版本") message:self.version delegate:self cancelButtonTitle:NSLocalizedString(@"IDS_CANCEL",@"取消") otherButtonTitles:NSLocalizedString(@"IDS_ENSURE",@"确定") , nil];
    [alertview show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.trackViewUrl]];
    }
}



@end
