//
//  DXDAShowImageAlertView.m
//  NewApp3.0
//
//  Created by DXDA on 2018/3/7.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import "DXDAShowImageAlertView.h"

static CGRect oldframe;
static NSInteger const viewTag = 100100;

@implementation DXDAShowImageAlertView

+ (void)showWith:(UIImageView *)currentImageView {
    // 获取图片
    UIImage *image = currentImageView.image;

    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    UIView *backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    oldframe = [currentImageView convertRect:currentImageView.bounds toView:window];
    
    [backgroundView setBackgroundColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:99/255.0 alpha:0.8]];

    [backgroundView setAlpha:0];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    [imageView setImage:image];
    [imageView setTag:viewTag];
    [backgroundView addSubview:imageView];

    [window addSubview:backgroundView];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    //动画放大所展示的ImageView
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
        //宽度为屏幕宽度
        width = [UIScreen mainScreen].bounds.size.width;
        //高度 根据图片宽高比设置
        height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        if (isnan(y)) {
            y=0;
            height = 0;
        }
        [imageView setFrame:CGRectMake(0, y, width, height)];
        //重要！ 将视图显示出来
        [backgroundView setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
}




//MARK: - hide
+ (void)hideImageView:(UITapGestureRecognizer *)tap
{
    UIView *backgroundView = tap.view;

    UIImageView *imageView = [tap.view viewWithTag:viewTag];

    [UIView animateWithDuration:0.4 animations:^{
        [backgroundView setAlpha:0];
        [imageView setFrame:oldframe];
    } completion:^(BOOL finished) {
        //完成后操作->将背景视图删掉
        [backgroundView removeFromSuperview];
    }];
}

@end
