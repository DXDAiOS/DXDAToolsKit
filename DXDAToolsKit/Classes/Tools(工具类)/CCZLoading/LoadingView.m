//
//  LoadingView.m
//  LoadingView
//
//  Created by DXDA on 2017/5/3.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "LoadingView.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface LoadingView ()

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) CGFloat overTime;
@property (nonatomic,assign) BOOL showing;
@property (nonatomic,assign) CGPoint originalPoint;
@property (nonatomic,strong) UIImageView *tipsIcon;
@end

static CGFloat const max_w = 180;
static CGFloat const max_h = 150;
static CGFloat const loading_s = 80;
static CGFloat const indicator_s = 45;
static CGFloat const tipsFont = 15;
static CGFloat const view_w = 125;
static CGFloat const view_h = 120;
static CGFloat const leftSpace = 10;
static CGFloat const icon_s = 50;
static NSTimeInterval const duration = 0.15;

@implementation LoadingView

+(instancetype)createWith:(UIView *)view {
    return [[self alloc] initWith:view];
}

-(instancetype)initWith:(UIView *)view {
    if (self = [super init]) {
        _originalPoint = CGPointMake((Width-loading_s)/2, (Height-loading_s)/2-64);
        [view addSubview:self];
        [self setup];
    }
    return self;
}

-(void)setup {
    self.layer.cornerRadius = 7;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
    self.frame = CGRectMake(_originalPoint.x, _originalPoint.y, loading_s, loading_s);
    [self addSubview:self.indicatorView];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.tipsIcon];
    
}


#pragma mark - showLoading
-(void)show {
    
    [self invalidation];
    
    [self.indicatorView startAnimating];
    
    self.tipsLabel.hidden = YES;
    self.tipsIcon.hidden = YES;
    
    self.frame = CGRectMake((Width-loading_s)/2, (Height-loading_s)/2-64, loading_s, loading_s);
    self.indicatorView.frame = CGRectMake((self.frame.size.width-indicator_s)/2, (self.frame.size.height-indicator_s)/2, indicator_s, indicator_s);
    
    if (_showing) {
        return;
    }
    
    _showing = YES;
    
    self.alpha = 0;
    
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    }];
}

#pragma mark - hideLoading
-(void)hide {
    _showing = NO;
    [UIView animateWithDuration:duration animations:^{
        [self invalidation];
        [self.indicatorView stopAnimating];
        self.alpha = 0;
    }];
}

#pragma mark - showLoadingWithTips
-(void)showLoadingWithTips:(NSString *)tips {
    
    [self show];
    
    CGFloat topSpace = 20;
    CGFloat margin = 15;
    
    NSString *tempTips = tips ? : @"加载中...";
    
    CGSize size = [self calculateWith:tempTips max:CGSizeMake(max_w, max_h) fontSize:tipsFont];
    
    CGFloat current_w = MAX(topSpace+indicator_s+5+size.height+margin, size.width+margin*2);
    self.indicatorView.frame = CGRectMake((current_w-indicator_s)/2, topSpace, indicator_s, indicator_s);
    
    self.tipsLabel.hidden = NO;
    self.tipsLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.indicatorView.frame)+5, current_w-margin*2, size.height);
    self.tipsLabel.text = tempTips;
    
    CGFloat self_w = current_w;
    CGFloat self_h = CGRectGetMaxY(_tipsLabel.frame)+margin;
    CGFloat self_x = (Width-self_w)/2;
    CGFloat self_y = (Height-self_h)/2-64;
    
    self.frame = CGRectMake(self_x, self_y, self_w, self_h);
}

#pragma mark - showTips
-(void)showTips:(NSString *)tips {
    self.tipsIcon.hidden = YES;
    
    [self invalidation];
//    NSLog(@"当前线程：%@",[NSThread currentThread]);
    [self.indicatorView stopAnimating];
    
    self.alpha = 0;
    
    NSString *tempTips = tips ? : @"";
    
    if (tips.length == 0) {
        return;
    }
    
    CGSize size = [self calculateWith:tempTips max:CGSizeMake(max_w, max_h) fontSize:tipsFont];
    
    CGFloat self_w = size.width+20;
    CGFloat self_h = size.height+20;;
    CGFloat self_x = (Width-self_w)/2;
    CGFloat self_y = (Height-self_h)/2-64;
    
    self.frame = CGRectMake(self_x, self_y, self_w, self_h);
    self.tipsLabel.hidden = NO;
    self.tipsLabel.frame = CGRectMake(10, 0, size.width, self_h);
    self.tipsLabel.text = tempTips;
    
    _overTime = tips.length <= 4 ? 1 : MIN(tips.length*0.2, 2) ;
    
    [self startTimer];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

-(void)showErrorTips:(NSString *)tips {
    self.tipsIcon.hidden = NO;
    [self.tipsIcon setImage:[UIImage imageNamed:@"s_error_icon"]];
    [self calculateFrame:tips];
}

-(void)showSuccessTips:(NSString *)tips {
    self.tipsIcon.hidden = NO;
    [self.tipsIcon setImage:[UIImage imageNamed:@"s_success_icon"]];
    [self calculateFrame:tips];
}

-(void)calculateFrame:(NSString *)tips {
    [self invalidation];
    
    [self.indicatorView stopAnimating];
    
    self.alpha = 0;
    
    NSString *tempTips = tips ? : @"";
    
    if (tips.length == 0) {
        return;
    }
    
    CGSize size = [self calculateWith:tempTips max:CGSizeMake(max_w-leftSpace*2, max_h) fontSize:tipsFont];
    
    CGFloat current_w = 0.0;
    CGFloat tips_w = size.width+leftSpace*2;
    if (tips_w > view_w) {
        current_w = MIN(max_w, size.width+leftSpace*2);
    }
    else {
        current_w = view_w;
    }
    
    self.tipsIcon.frame = CGRectMake((current_w-icon_s)/2, 25, icon_s, icon_s);
    
    CGFloat self_w = current_w;
    CGFloat self_h = view_h+size.height+10;
    CGFloat self_x = (Width-self_w)/2;
    CGFloat self_y = (Height-self_h)/2-64;
    
    self.tipsLabel.hidden = NO;
    self.tipsLabel.frame = CGRectMake(leftSpace, CGRectGetMaxY(_tipsIcon.frame)+15, current_w-leftSpace*2, size.height);
    self.tipsLabel.text = tempTips;
    self.frame = CGRectMake(self_x, self_y, self_w, CGRectGetMaxY(_tipsLabel.frame)+20);
    
    _overTime = tips.length <= 4 ? 1 : MIN(tips.length*0.2, 2) ;
    
    [self startTimer];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

#pragma mark - 创建timer
-(void)startTimer {
    if (!_timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_overTime target:self selector:@selector(hide) userInfo:nil repeats:NO];
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

#pragma mark - 返回string size
-(CGSize)calculateWith:(NSString *)str max:(CGSize)maxSize fontSize:(NSInteger)font {
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}

#pragma mark - lazy
-(UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width-indicator_s)/2, (self.frame.size.height-indicator_s)/2, indicator_s, indicator_s)];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    }
    return _indicatorView;
}

-(UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = [UIFont systemFontOfSize:tipsFont];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.numberOfLines = 0;
    }
    return _tipsLabel;
}

-(NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_overTime target:self selector:@selector(hide) userInfo:nil repeats:NO];
    }
    return _timer;
}

-(UIImageView *)tipsIcon {
    if (!_tipsIcon) {
        _tipsIcon = [[UIImageView alloc] initWithFrame:CGRectMake((view_w-icon_s)/2, 25, icon_s, icon_s)];
    }
    return _tipsIcon;
}

-(void)dealloc {
    NSLog(@"dealloc");
}

@end
