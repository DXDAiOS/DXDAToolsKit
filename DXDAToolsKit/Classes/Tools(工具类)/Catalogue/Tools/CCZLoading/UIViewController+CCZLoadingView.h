//
//  UIViewController+CCZLoadingView.h
//  LoadingView
//
//  Created by DXDA on 2017/5/6.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (CCZLoadingView)

-(void)showLoading;

-(void)showLoadingWithTips:(NSString *)tips;

-(void)showTips:(NSString *)tips;

-(void)showTipsDown:(NSString *)tips;

-(void)hideLoading;

-(void)showErrorTips:(NSString *)tips;

-(void)showSuccessTips:(NSString *)tips;

@end

@interface UIViewController (CCZLoadingView)

-(void)showLoading;

-(void)showLoadingWithTips:(NSString *)tips;

-(void)showTips:(NSString *)tips;

-(void)showTipsDown:(NSString *)tips;

-(void)hideLoading;

-(void)showErrorTips:(NSString *)tips;

-(void)showSuccessTips:(NSString *)tips;

@end

@interface UIView (CCZLoadingView)

-(void)showLoading;

-(void)showLoadingWithTips:(NSString *)tips;

-(void)showTips:(NSString *)tips;

-(void)showTipsDown:(NSString *)tips;

-(void)hideLoading;

-(void)showErrorTips:(NSString *)tips;

-(void)showSuccessTips:(NSString *)tips;

@end
