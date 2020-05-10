//
//  UIImage+DXDAImage.h
//  NewApp3.0
//
//  Created by Erowin on 16/10/22.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DXDAImage)

/// 对图片尺寸进行压缩
-(UIImage*)imageWithScaledToSize:(CGSize)newSize;

/// 切圆
- (UIImage *)circleImage;

/// 不对图片进行渲染
+(UIImage *)imageOriginalWithImageName:(NSString *)imageName;

@end
