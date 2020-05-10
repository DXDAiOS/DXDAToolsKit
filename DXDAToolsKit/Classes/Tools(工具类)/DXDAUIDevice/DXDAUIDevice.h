//
//  DXDAUIDevice.h
//  NewApp3.0
//
//  Created by DXDA on 2018/4/9.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FCDeviceType) {
    DeviceUnknown       = 0,
    DeviceIsSimulator   = 1,
    DeviceIsiPhone      = 2,
    DeviceIsiPhone3G    = 3,
    DeviceIsiPhone3GS   = 4,
    DeviceIsiPhone4     = 5,
    DeviceIsiPhone4S    = 6,
    DeviceIsiPhone5     = 7,
    DeviceIsiPhone5C    = 8,
    DeviceIsiPhone5S    = 9,
    DeviceIsiPhone6     = 10,
    DeviceIsiPhone6Plus = 11,
    DeviceIsiPodTouch   = 12,
    DeviceIsiPodTouch2G = 13,
    DeviceIsiPodTouch3G = 14,
    DeviceIsiPodTouch4G = 15,
    DeviceIsiPad        = 16,
    DeviceIsiPad2       = 17,
    DeviceIsiPad3G      = 18,
    DeviceIsiPad4G      = 19,
    DeviceIsiPad5G_Air  = 20,
    DeviceIsiPadMini    = 21,
    DeviceIsiPadMini2G  = 22
};

@interface DXDAUIDevice : NSObject

/**
 *  判断设备型号
 *
 *  @return 返回设备型号的枚举类型
 */
+ (NSString *)platformString;
+ (FCDeviceType)deviceType;

+ (BOOL)OldEquipment;


@end
