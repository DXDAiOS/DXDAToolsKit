//
//  UIBarButtonItem+Item.h
//  RxdaApp
//
//  Created by Erowin on 16/5/20.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)


+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image PlaceImage:(UIImage *)placeImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;


@end
