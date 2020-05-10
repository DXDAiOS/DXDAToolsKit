//
//  UIViewController+CCZLoadingView.m
//  LoadingView
//
//  Created by DXDA on 2017/5/6.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UIViewController+CCZLoadingView.h"
#import <objc/runtime.h>
#import "LoadingView.h"
#import "DXDANormalTools.h"

@interface UIViewController ()

@property (nonatomic,strong) LoadingView *loadingView;

@end

static const char loadingKey = '\0';

#pragma mark - UIView
@implementation UIView (CCZLoadingView)

#pragma mark - 无文字Loading
-(void)showLoading {
    [self initLoading];
    
    [self.loadingView show];
}

#pragma mark - 带文字Loading
-(void)showLoadingWithTips:(NSString *)tips {
    [self initLoading];
//    self.window.alpha = 1;
//    self.loadingView.alpha = 1;
    [self.loadingView showLoadingWithTips:tips];
}

#pragma mark - 文字提示
-(void)showTips:(NSString *)tips {
    [self initLoading];
    
    [self.loadingView showTips:tips];
    
    self.loadingView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-(IS_IPHONE_X?200:150));
    
}
#pragma mark - 下方显示文字提示
-(void)showTipsDown:(NSString *)tips {

    [self initLoading];
    [self.loadingView showTips:tips];
    self.loadingView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-(IS_IPHONE_X?200:150));
}

-(void)showErrorTips:(NSString *)tips {
    [self initLoading];
    
    [self.loadingView showErrorTips:tips];
}

-(void)showSuccessTips:(NSString *)tips {
    [self initLoading];
    
    [self.loadingView showSuccessTips:tips];
}

#pragma mark - 隐藏Loading
-(void)hideLoading {
    //    [self initLoading];
    
    [self.loadingView hide];
}

#pragma mark - 初始化
-(void)initLoading {
    if (self.loadingView) {
        [self addSubview:self.loadingView];
    }
    if (!self.loadingView) {
        self.loadingView = [LoadingView createWith:self];
    }
}



#pragma mark - get set
-(void)setLoadingView:(LoadingView *)loadingView {
    objc_setAssociatedObject(self, &loadingKey, loadingView, OBJC_ASSOCIATION_ASSIGN);
}

-(LoadingView *)loadingView {
    return objc_getAssociatedObject(self, &loadingKey);
}


@end


#pragma mark - UIViewController
@implementation UIViewController (CCZLoadingView)


#pragma mark - 无文字Loading
-(void)showLoading {
    [self initLoading];
    
    [self.loadingView show];
}

#pragma mark - 带文字Loading
-(void)showLoadingWithTips:(NSString *)tips {
    [self initLoading];
//    self.loadingView.alpha = 1;
//    self.loadingView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];;
    [self.loadingView showLoadingWithTips:tips];
}

#pragma mark - 文字提示
-(void)showTips:(NSString *)tips {
    [self initLoading];
    
    [self.loadingView showTips:tips];
    
    self.loadingView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height- (IS_IPHONE_X?200:150));
}

#pragma mark - 下方显示文字提示
-(void)showTipsDown:(NSString *)tips {
    
    [self initLoading];
    
    [self.loadingView showTips:tips];
    
    self.loadingView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height- (IS_IPHONE_X?200:150));
}

-(void)showErrorTips:(NSString *)tips {
    [self initLoading];
    
    [self.loadingView showErrorTips:tips];
}

-(void)showSuccessTips:(NSString *)tips {
    [self initLoading];
    
    [self.loadingView showSuccessTips:tips];
}

#pragma mark - 隐藏Loading
-(void)hideLoading {
    //    [self initLoading];
    
    [self.loadingView hide];
}

#pragma mark - 初始化
-(void)initLoading {
    if (self.loadingView) {
        self.loadingView.alpha = 1;
        self.loadingView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
        [self.view addSubview:self.loadingView];
    }
    else if (!self.loadingView) {
        self.loadingView = [LoadingView createWith:self.view];
    }
}



#pragma mark - get set
-(void)setLoadingView:(LoadingView *)loadingView {
    objc_setAssociatedObject(self, &loadingKey, loadingView, OBJC_ASSOCIATION_ASSIGN);
}

-(LoadingView *)loadingView {
    return objc_getAssociatedObject(self, &loadingKey);
}


@end
