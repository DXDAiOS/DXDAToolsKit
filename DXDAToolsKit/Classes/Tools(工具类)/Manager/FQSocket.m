//
//  FQSocket.m
//  推送socket
//
//  Created by Erowin on 16/11/29.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "FQSocket.h"
#import <UserNotifications/UserNotifications.h>
#import "UserInfoManager.h"
#import "ChangeToDictionary.h"

@interface FQSocket ()<GCDAsyncSocketDelegate>


@end

@implementation FQSocket

+(instancetype)shareSocket
{
    static dispatch_once_t onceToken;
    static FQSocket *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[FQSocket alloc]init];
        manager.socket = [[GCDAsyncSocket alloc]initWithDelegate:manager delegateQueue:dispatch_get_main_queue()];
    });
    return manager;
}



-(BOOL)connectSocket
{
    NSError *error = nil;
    //@"183.237.5.39"
    [self.socket connectToHost:@"183.237.5.39" onPort:8581 withTimeout:-1 error:&error];
    if (error)
    {
        NSLog(@"%@",error);
    }
    return error;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"成功链接服务器:%@端口:%zd",host,port);
    [self.socket performBlock:^{
        [self.socket enableBackgroundingOnSocket];
    }];
    
    NSString *dataStr = [NSString stringWithFormat:@"Text|%@|Test",[UserInfoManager sharedUserInfoManager].userData.strUserID];
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    //withTimeout -1 :无穷大
    //tag： 消息标记
    [self.socket writeData:data withTimeout:-1 tag:0];

    [self.socket readDataWithTimeout:-1 tag:0];
}


-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(socketRead:readData:withTag:)]){
//        [self.delegate socketRead:sock readData:data withTag:tag];
//    }
   // NSLog(@"%@",dataStr);
//
//    if ([dataStr isEqualToString:@"0\r\n"]||[dataStr isEqualToString:@"9\r\n"])
//    {
//        return;
//    }
//    
    
    [self.socket readDataWithTimeout:-1 tag:0];
    NSLog(@"0%@",dataStr);
    

    NSError *error;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error != nil)
    {
        return;
    }
    // ccz 这个通知是干什么用的
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationSocket" object:self];
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
     NSLog(@"1%@",systemVersion);
    if (systemVersion.floatValue >=10.0)
    {
        NSLog(@"2%lf",systemVersion.floatValue);
        [self registerNotification:1 TitleStr:jsonDic[@"Sender"] TitleBoby:jsonDic[@"Msg"]];
    }else
    {
          NSLog(@"3%lf",systemVersion.floatValue);
        [self registerLocalNotification:1 TitleStr:jsonDic[@"Sender"] TitleBoby:jsonDic[@"Msg"]];
    }

  
}
//使用 UNNotification 本地通知
-(void)registerNotification:(NSInteger )alerTime TitleStr:(NSString *)titleStr TitleBoby:(NSString *)titleBoby{
    
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:titleStr arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:titleBoby
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    // 在 alertTime 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:alerTime repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"content:content trigger:trigger];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
        //        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        //        [alert addAction:cancelAction];
        //        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
}
//ios10之前
-(void)registerLocalNotification:(NSInteger)alertTime TitleStr:(NSString *)titleStr TitleBoby:(NSString *)titleBoby
{
    // ios8后，需要添加这个注册，才能得到授权
    // if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    // UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    // UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
    // [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    // // 通知重复提示的单位，可以是天、周、月
    // }
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody = titleBoby;
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:titleStr forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
