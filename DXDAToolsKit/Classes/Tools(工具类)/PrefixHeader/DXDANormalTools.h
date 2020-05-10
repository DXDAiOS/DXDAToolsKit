//
//  DXDANormalTools.h
//  NewApp3.0
//
//  Created by DXDA on 2020/5/9.
//  Copyright © 2020 DXDA. All rights reserved.
//

#import "UIColor+Dark.h"

#ifndef DXDANormalTools_h
#define DXDANormalTools_h

//MARK: - APP主调颜色
#define DXDA_DefaultColor [UIColor colorWithRed:235/255.f green:81/255.f blue:43/255.f alpha:1]  //橙色
#define DXDA_LineColor [UIColor colorWithRed:236/255.f green:236/255.f blue:236/255.f alpha:1]   //背景灰色
#define DXDA_DefaultColor_O [UIColor colorWithRed:235/255.f green:81/255.f blue:43/255.f alpha:1]  //橙色
  
// 测试蓝色 IosMSCApp_YYT
// #define DXDA_DefaultColor [UIColor colorWithRed:94/255.f green:167/255.f blue:220/255.f alpha:1] // 蓝色

//MARK: - 字体颜色
#define DXDA_FontColor GrayRGB(80)

// 上链状态颜色
#define DXDA_BlockChainColor [UIColor colorWithRed:10/255.f green:96/255.f blue:254/255.f alpha:1]

// CRM 橙色
#define DXDA_CRMColor [UIColor colorWithRed:235/255.f green:138/255.f blue:43/255.f alpha:1]
#define DXDA_CRMColorAlpha [UIColor colorWithRed:235/255.f green:138/255.f blue:43/255.f alpha:0.5]
#define DXDA_CRM_textColor GrayRGB(54)
#define DXDA_CRM_G_textColor GrayRGB(153)
#define DXDA_CRM_GreenColor RGB(124, 177, 92)
#define DXDA_CRM_BlueColor RGB(49, 144, 191)

#define DXDA_CRM_lightColor RGB(230, 140, 85)
#define DXDA_CRM_lineNoneColor RGB(135, 135, 135)
#define DXDA_CRM_textNoneColor RGB(165, 165, 165)
#define DXDA_CRM_LightGrayColor GrayRGB(150)

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]             //RGB 透明度为 1
#define GrayRGB(g) [UIColor colorWithRed:g/255.0 green:g/255.0 blue:g/255.0 alpha:1]             //RGB同值 透明度为 1
#define DXDA_G_textColor [UIColor colorWithRed:170/255.f green:170/255.f blue:170/255.f alpha:1] //字体灰色
#define AlphaColor(i,k) [UIColor colorWithWhite:i alpha:k]  // 透明

//用于dark主题的配色
#define Dark_LineColor [UIColor setLightColor:DXDA_LineColor darkColor:UIColor.blackColor]
#define Dark_BackgroudColor [UIColor setLightColor:UIColor.whiteColor darkColor:RGB(28, 28, 28)]
#define Dark_BackgroudColor_Gray [UIColor setLightColor:UIColor.whiteColor darkColor:RGB(89, 89, 89)]
#define Dark_TextColor [UIColor setLightColor:UIColor.blackColor darkColor:UIColor.whiteColor]

// 工作台主调颜色
#define DXDA_WorkCenterColor RGB(43, 85, 140)

//MARK: - APP主题字体
#define DXDA_S_font [UIFont systemFontOfSize:14] //小字体
#define DXDA_font [UIFont systemFontOfSize:15] //中字体
#define DXDA_M_font [UIFont systemFontOfSize:17] //大字体


//MARK: - 屏幕判断
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width   // 屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height // 屏幕高度
#define iPhone4_4s (SCREEN_WIDTH == 320.f && SCREEN_HEIGHT == 480.f ? YES : NO)  //IPHONE4-4s
#define iPhone5_5s (SCREEN_WIDTH == 320.f && SCREEN_HEIGHT == 568.f ? YES : NO)  //IPHONE5-5s
#define iPhone6_7  (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 667.f ? YES : NO)  //IPHONE6-6s-7
#define iPhone6plus_7plus  (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 736.f ? YES : NO) //IPHONE6-6s-7 Plus
#define IS_IPHONE_X (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO) || (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)//x,xs,11pro

//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)

#define SizeScale ((SCREEN_HEIGHT < 746) ? SCREEN_HEIGHT/746 : 1)  //不同设备的屏幕比例(当然倍数可以自己控制)
#define kNavgationHeight (IS_IPHONE_X ? 88.0f: 64.0f)
#define kTabbarHeight (IS_IPHONE_X ? 83.0f : 49.0f)
#define kStatusBarHeight (IS_IPHONE_X ? 44.0f : 20.0f)
#define kViewFooderHeight (IS_IPHONE_X ? 35.0f : 0.0f) // iPhone X 导航条
#define kNavgationAndFooderHeight (IS_IPHONE_X ? 88.0f+33.0f: 64.0f)
//异性全面屏
//#define  isFullScreen (IS_IPHONE_X || isIphoneXR_XSMax)
//#define kNavgationHeight (isFullScreen ? 88.0f: 64.0f)
//#define kTabbarHeight (isFullScreen ? 83.0f : 49.0f)
//#define kStatusBarHeight (isFullScreen ? 44.0f : 20.0f)
//#define kViewFooderHeight (isFullScreen ? 35.0f : 0.0f) // iPhone X 导航条
//#define kNavgationAndFooderHeight (isFullScreen ? 88.0f+33.0f: 64.0f)

//MARK: - 字符串（字段）处理
#define StrNumber(Number) Number?Number:@0            //Number 类型字段是否nil 为空返回@0
#define dataStr(Str) Str?Str:@""                       //String 类型字段是否nil 为空返回 @""
#define Str(T) [NSString stringWithFormat:@"%@",T]     //通用类型转String
#define Str_ld(T) [NSString stringWithFormat:@"%ld",T] //无符号长整型 转String
#define Str_d(T) [NSString stringWithFormat:@"%d",T]   //整型 转String
#define Str_f(F) [NSString stringWithFormat:@"%.2f",F]
#define StrWithFormat(str1,str2) [NSString stringWithFormat:@"%@/%@",str1,str2]  //域名拼接加 @"／"
#define STR(arg1, arg2) [NSString stringWithFormat:@"%@%@",arg1,arg2]            //字符串拼接
#define float_2(f) (float)((int)(float)((f * 100) + 0.5) / 100.0)                // 4舍5入保留两位小数


#define weak(self) __weak typeof(self) weak##Self = self;      // weakSelf


//MARK: - 其他
#define CCZDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead) // 过期提醒
#define kCurrentVersion [[UIDevice currentDevice].systemVersion floatValue]

#ifdef DEBUG
#   define CLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define CLog(...)
#endif

#endif /* DXDANormalTools_h */
