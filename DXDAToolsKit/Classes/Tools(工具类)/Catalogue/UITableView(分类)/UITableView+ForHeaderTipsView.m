//
//  UITableView+ForHeaderTipsView.m
//  TableViewForHeaderTipsView
//
//  Created by 陈朝政 on 2017/5/20.
//  Copyright © 2017年 CCZ. All rights reserved.
//

#import "UITableView+ForHeaderTipsView.h"
#import <objc/runtime.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface HeaderTipsView : UIView

@property (nonatomic,weak) UIView *superView;
@property (nonatomic,weak) UITableView *targetView;
@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,assign) CGFloat original_y;
@property (nonatomic,assign) BOOL stopChange;
@property (nonatomic,strong) NSTimer *timer;

@end

static CGFloat const headerHeight = 35;

@implementation HeaderTipsView

+(instancetype)createWith:(UITableView *)targetView {
    return [[self alloc] initWith:targetView];
}

-(instancetype)initWith:(UITableView *)targetView {
    if (self = [super init]) {
        _superView = targetView.superview;
        _targetView = targetView;
        
        [self setup];
    }
    return self;
}

-(void)setup {
    
    self.frame = CGRectMake(0, -headerHeight, WIDTH, headerHeight);
    _original_y = 0;
    [self addSubview:self.tipsLable];
    self.backgroundColor = [UIColor colorWithRed:239/255.0 green:206/255.0 blue:150/255.0 alpha:1];
    [_superView addSubview:self];
    
    [self addObserver:self forKeyPath:@"targetView.contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"targetView.contentOffset"]) {
        [self changeFrame:_targetView.contentOffset.y];
    }
}

-(void)changeFrame:(CGFloat)currentY {
    if (_stopChange) {
        CGFloat changeY = MIN(0, -currentY+_original_y);
        self.frame = CGRectMake(0, changeY, WIDTH, headerHeight);
    }
    
}

-(void)showHeader:(NSString *)tips {
    self.hidden = NO;
    
    _stopChange = NO;
    
    self.tipsLable.text = tips;
    
    [self addTimer];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 0, WIDTH, headerHeight);
        _targetView.frame = CGRectMake(0, headerHeight, WIDTH, HEIGHT-64-headerHeight);
    } completion:^(BOOL finished) {
        _stopChange = YES;
    }];
}

-(void)addTimer {
    [self invalidateTimer];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideHeader) userInfo:nil repeats:NO];
    }
}

-(void)hideHeader {
    _stopChange = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, -headerHeight, WIDTH, headerHeight);
        _targetView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64-headerHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self invalidateTimer];
    }];
}

-(void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}

//MARK: - lazy
-(UILabel *)tipsLable {
    if (!_tipsLable) {
        _tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width-15*2, headerHeight)];
        _tipsLable.font = [UIFont systemFontOfSize:14];
        _tipsLable.textColor = [UIColor colorWithRed:252/255.0 green:94/255.0 blue:45/255.0 alpha:1];
        _tipsLable.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLable;
}

-(void)dealloc {
    [self removeObserver:self forKeyPath:@"targetView.contentOffset"];
}

@end

@interface UITableView ()

@property (nonatomic,strong) HeaderTipsView *headerView;

@end

static char key = 'c';

@implementation UITableView (ForHeaderTipsView)


-(void)setHeaderView:(HeaderTipsView *)headerView {
    objc_setAssociatedObject(self, &key, headerView, OBJC_ASSOCIATION_ASSIGN);
}

-(HeaderTipsView *)headerView {
    return objc_getAssociatedObject(self, &key);
}

-(void)showHeaderView:(NSString *)tips {
    if (!self.headerView) {
        self.headerView = [HeaderTipsView createWith:self];
    }
    [self.headerView showHeader:tips];
}

-(void)hideHeaderView {
    [self.headerView hideHeader];
}


@end
