//
//  UIViewController+DXDAAuthorityTipsView.m
//  NewApp3.0
//
//  Created by DXDA on 2017/4/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UIViewController+DXDAAuthorityTipsView.h"

static CGFloat const tipsFont = 14;
static NSTimeInterval const duration = 0.2;

@interface AuthorityTipsView : UIView;

@property (nonatomic,strong) UILabel *tipsLabel;

@property (nonatomic,assign) BOOL timeover;

@property (nonatomic,weak) NSTimer *timer;

@end

static AuthorityTipsView *instance = nil;

@implementation AuthorityTipsView

+(instancetype)share {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


-(instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(void)setup {

    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.9];

}

-(void)showAuthorityTips {

//    if (_timeover) {
//        return;
//    }
//    
//    _timeover = YES;
    
    self.alpha = 0;
    
    [self invalidation];
    [self startTimer];
    
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    }];
}

-(void)hide {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    }];
}

-(void)createTips:(NSString *)title {
    NSString *tempTitle = title ? : @"此版本不支持此项功能";
    
    CGSize size = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:tipsFont] String:tempTitle size:CGSizeMake(150, 50)];
    
    CGFloat self_w = size.width+20;
    CGFloat self_h = size.height+20;
    CGFloat self_x = (SCREEN_WIDTH-self_w)/2;
    CGFloat self_y = (SCREEN_HEIGHT-self_h)/2;
    
    self.frame = CGRectMake(self_x, self_y, self_w, self_h);
    
    if (_tipsLabel) {
        _tipsLabel.frame = CGRectMake((self_w-size.width)/2, 0, size.width, self_h);
        _tipsLabel.text = tempTitle;
    }
    else {
    _tipsLabel = [UILabel createWithCenter:CGRectMake((self_w-size.width)/2, 0, size.width, self_h) title:tempTitle titleColor:[UIColor whiteColor] font:tipsFont];
    }
    
    
    [self addSubview:_tipsLabel];
}

#pragma mark - 创建timer
-(void)startTimer {
    if (!_timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(hide) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
}

#pragma mark - 废弃timer
-(void)invalidation {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}


@end

@implementation UIViewController (DXDAAuthorityTipsView)


-(void)showWith:(NSString *)title {
    [self.view addSubview:[AuthorityTipsView share]];
    [instance createTips:title];
    [instance showAuthorityTips];
}





@end
