//
//  DXDAUIDevice.m
//  NewApp3.0
//
//  Created by DXDA on 2018/4/9.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import "DXDAUIDevice.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DXDAUIDevice

+ (BOOL)OldEquipment
{
    FCDeviceType type = [self deviceType];
    if (type == DeviceIsiPhone3G) return YES;
    if (type == DeviceIsiPhone3GS) return YES;
    if (type == DeviceIsiPhone4) return YES;
    if (type == DeviceIsiPhone4S) return YES;
    if (type == DeviceIsiPhone5) return YES;
    if (type == DeviceIsiPhone5C) return YES;
    if (type == DeviceIsiPodTouch) return YES;
    if (type == DeviceIsiPodTouch2G) return YES;
    if (type == DeviceIsiPodTouch3G) return YES;
    if (type == DeviceIsiPodTouch4G) return YES;
    return NO;
}

#pragma mark 从系统底层获取硬件平台类型字符串
+ (NSString*)platformString{
    
    size_t size;
    sysctlbyname("hw.machine",NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size,NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];


    NSString *PhoneDeviceStr = [NSString string];
    PhoneDeviceStr = [UIDevice currentDevice].model;

    free(machine);
    return platform;
}

#pragma mark 获取设备型号的枚举类型
+ (FCDeviceType)deviceType{
    
    NSString *platform = [self platformString];
    
    FCDeviceType deviceType;
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,2"])  return DeviceIsiPad3G;
    if ([platform isEqualToString:@"iPhone2,1"])  return DeviceIsiPhone3GS;
    
    if ([platform isEqualToString:@"iPhone3,1"])  return DeviceIsiPhone4;
    if ([platform isEqualToString:@"iPhone3,2"])  return DeviceIsiPhone4;
    if ([platform isEqualToString:@"iPhone3,3"])  return DeviceIsiPhone4;
    
    if ([platform isEqualToString:@"iPhone4,1"])  return DeviceIsiPhone4S;
    if ([platform isEqualToString:@"iPhone5,1"])  return DeviceIsiPhone5;
    if ([platform isEqualToString:@"iPhone5,2"])  return DeviceIsiPhone5;
    if ([platform isEqualToString:@"iPhone5,3"])  return DeviceIsiPhone5C;
    if ([platform isEqualToString:@"iPhone5,4"])  return DeviceIsiPhone5C;
    
    if ([platform isEqualToString:@"iPhone6,1"])  return DeviceIsiPhone5S;
    if ([platform isEqualToString:@"iPhone6,2"])  return DeviceIsiPhone5S;
    
    if ([platform isEqualToString:@"iPhone7,1"])  return DeviceIsiPhone6;
    if ([platform isEqualToString:@"iPhone7,2"])  return DeviceIsiPhone6Plus;
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])    return DeviceIsiPodTouch;
    if ([platform isEqualToString:@"iPod2,1"])    return DeviceIsiPodTouch2G;
    if ([platform isEqualToString:@"iPod3,1"])    return DeviceIsiPodTouch3G;
    if ([platform isEqualToString:@"iPod4,1"])    return DeviceIsiPodTouch4G;
    if ([platform isEqualToString:@"iPod5,1"])    return DeviceIsiPodTouch;

    //iPad
    if ([platform isEqualToString:@"iPad1,1"])    return DeviceIsiPad;
    if ([platform isEqualToString:@"iPad2,1"])    return DeviceIsiPad2;
    if ([platform isEqualToString:@"iPad2,2"])    return DeviceIsiPad2;
    if ([platform isEqualToString:@"iPad2,3"])    return DeviceIsiPad2;
    if ([platform isEqualToString:@"iPad2,4"])    return DeviceIsiPad2;
    if ([platform isEqualToString:@"iPad2,5"])    return DeviceIsiPadMini;
    if ([platform isEqualToString:@"iPad2,6"])    return DeviceIsiPadMini;
    if ([platform isEqualToString:@"iPad2,7"])    return DeviceIsiPadMini;
    
    if ([platform isEqualToString:@"iPad3,1"])    return DeviceIsiPad3G;
    if ([platform isEqualToString:@"iPad3,2"])    return DeviceIsiPad3G;
    if ([platform isEqualToString:@"iPad3,3"])    return DeviceIsiPad3G;
    if ([platform isEqualToString:@"iPad3,4"])    return DeviceIsiPad4G;
    if ([platform isEqualToString:@"iPad3,5"])    return DeviceIsiPad4G;
    if ([platform isEqualToString:@"iPad3,6"])    return DeviceIsiPad4G;
    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])       return DeviceIsSimulator;
    return deviceType;
    
}

@end
