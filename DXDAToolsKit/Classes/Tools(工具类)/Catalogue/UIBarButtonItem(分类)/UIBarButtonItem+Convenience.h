//
//  UIBarButtonItem+Convenience.h
//  NewApp3.0
//
//  Created by DXDA on 2017/4/8.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Convenience)

+(UIBarButtonItem *)createScan:(NSString *)icon target:(id)target action:(SEL)action;

@end
