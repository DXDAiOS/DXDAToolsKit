//
//  UIImage+compress.h
//  RxdaApp
//
//  Created by Erowin on 16/9/21.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (compress)
//对图片尺寸进行压缩--
-(UIImage*)imageWithScaledToSize:(CGSize)newSize;
//切圆
- (UIImage *)circleImage;

+ (UIImage *)dxd_imageNamed:(NSString *)imageNamed;

// 改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color;

@end
