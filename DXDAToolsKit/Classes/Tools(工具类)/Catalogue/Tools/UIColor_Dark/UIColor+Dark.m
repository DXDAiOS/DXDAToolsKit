//
//  UIColor+Dark.m
//  NewApp3.0
//
//  Created by DXDA on 2020/3/16.
//  Copyright © 2020 DXDA. All rights reserved.
//

#import "UIColor+Dark.h"




@implementation UIColor (Dark)

+(UIColor *)setLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor
{
    if (@available(iOS 13.0, *)) {//黑暗模式
        UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
               if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                   return lightColor;
               }
               else {
                   return darkColor;
               }
           }];
        
        return dyColor;
    } else {
        return lightColor;
    }
}


@end
