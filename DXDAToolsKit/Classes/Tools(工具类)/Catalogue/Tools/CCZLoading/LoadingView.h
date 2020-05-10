//
//  LoadingView.h
//  LoadingView
//
//  Created by DXDA on 2017/5/3.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+(instancetype)createWith:(UIView *)view;

-(void)show;

-(void)hide;

-(void)showTips:(NSString *)tips;

-(void)showLoadingWithTips:(NSString *)tips;

-(void)showErrorTips:(NSString *)tips;

-(void)showSuccessTips:(NSString *)tips;

@end
