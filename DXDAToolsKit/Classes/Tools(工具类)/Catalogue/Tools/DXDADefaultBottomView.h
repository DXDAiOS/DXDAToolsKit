//
//  DXDADefaultBottomView.h
//  x_App
//
//  Created by DXDA on 2018/1/23.
//  Copyright © 2018年 SimpleTable. All rights reserved.
//





#import <UIKit/UIKit.h>

@interface DXDADefaultBottomView : UIView

+ (instancetype)createWithArray:(NSArray<NSDictionary *> *)array action:(void(^)(NSInteger index, NSString *title))action;
+ (instancetype)createWithArray2:(NSArray<NSDictionary *> *)array action:(void(^)(NSInteger index, NSString *title))action;


/**
 (NSArray<NSDictionary *> *)array

 NSDictionary 的结构如下
 title 对应按钮的 titleName
 type 对应按钮的类型
 0 默认样式
 1 不可用样式
 2 特别样式
 其中 0 2 都提供用户交互， 1 关闭用户交互
 */
- (void)changeButtonData:(NSArray<NSDictionary *> *)array;

- (void)changeButtonType:(NSArray<NSNumber *> *)array;

@end
