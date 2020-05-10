//
//  DXDASelectPhotoManager.h
//  NewApp3.0
//
//  Created by DXDA on 2018/3/6.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectPhotoDelegate <NSObject>

@optional

/**
 上传图片

 @param imageView 当前imageView
 @param handle 上传完的回调 下标、url、 以及存储起来的imageView
 @param fail 失败的回调 下标 以及存储起来的imageView
 */
- (void)uploadPhotoMethod:(UIImageView *)imageView
                   handle:(void(^)(NSInteger index, NSString *url, UIImageView *imageV))handle
                     fail:(void(^)(NSInteger index, UIImageView *imageV))fail;


/**
 返回更新后的 rect

 @param size 当前self.size
 */
- (void)returnUpdateRect:(CGSize)size;


/**
 返回当前路径数组

 @param urls 当前路径数组
 */
- (void)returnCurrentURLs:(NSArray<NSString *> *)urls;

@end

@interface DXDASelectPhotoManager : UIView

@property (nonatomic, weak) id<SelectPhotoDelegate>delegate;    // 代理

@property (nonatomic, assign) NSInteger maxSelectCount;         // 最大选择数
@property (nonatomic, assign) NSInteger maxCount;               // 最大图片数

//@property (nonatomic, assign) BOOL haveTitle;                   // 是否有title
@property (nonatomic, assign) BOOL readonly;                    // 是否可编辑

@property (nonatomic, strong) NSMutableArray<UIImage *> *photoArray;       // 图片数组
@property (nonatomic, strong) NSMutableArray<UIView *> *viewArray;         // 图片框数组
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *urlDic;    // 路径字典

@property (nonatomic, assign) CGFloat view_w;       // 图片框width;


/**
 更新图片数据

 @param array url路径数组
 */
- (void)updatePhotoData:(NSArray<NSString *> *)array;

@end
