//
//  UIButton+DXDAFont.m
//  NewApp3.0
//
//  Created by Erowin on 16/10/25.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "UIButton+DXDAFont.h"
#import <objc/runtime.h>
#import "DXDANormalTools.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height



@implementation UIButton (myFont)

//+ (void)load{
//    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
//    method_exchangeImplementations(imp, myImp);
//}
//
//- (id)myInitWithCoder:(NSCoder*)aDecode{
//    [self myInitWithCoder:aDecode];
//    if (self) {
//        //部分不像改变字体的 把tag值设置成333跳过
//        if(self.titleLabel.tag != 333){
//            CGFloat fontSize = self.titleLabel.font.pointSize;
//            self.titleLabel.font = [UIFont systemFontOfSize:fontSize*SizeScale];
//        }
//    }
//    return self;
//}


@end

@implementation UILabel (myFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
//            NSLog(@"%lf",SizeScale);
            CGFloat fontRate = iPhone4_4s||iPhone5_5s ? 0.85 : iPhone6_7 ? 0.9 : 1.0;
            self.font = [UIFont systemFontOfSize:fontSize*fontRate];
//            self.font = [UIFont systemFontOfSize:fontSize*SizeScale];
        }
    }
    return self;
}

@end
