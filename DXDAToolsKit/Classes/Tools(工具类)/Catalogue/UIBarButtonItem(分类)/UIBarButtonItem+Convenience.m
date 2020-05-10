//
//  UIBarButtonItem+Convenience.m
//  NewApp3.0
//
//  Created by DXDA on 2017/4/8.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UIBarButtonItem+Convenience.h"

@implementation UIBarButtonItem (Convenience)

+(UIBarButtonItem *)createWith:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

+(UIBarButtonItem *)createScan:(NSString *)icon target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    imageView.frame = CGRectMake(5, 5, 20, 20);
    [button addSubview:imageView];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

@end
