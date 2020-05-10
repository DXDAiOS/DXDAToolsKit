//
//  DXDABubbleView.m
//  x_App
//
//  Created by 东信达 on 2017/7/4.
//  Copyright © 2017年 SimpleTable. All rights reserved.
//

#import "DXDABubbleView.h"

@interface DXDABubbleView ()

@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) CALayer *coverLayer;
@property (nonatomic,strong) void(^passValue)(UIButton *button);
@property (nonatomic,copy) NSArray *dataArray;

@end

static CGFloat const BUTTON_W = 130.00;
static CGFloat const BUTTON_BUTTON_H = 45;

@implementation DXDABubbleView

+ (DXDABubbleView *)createWith:(NSArray *)titlaArr click:(void(^)(UIButton *but))but
{
    return [[self alloc] initWith:titlaArr click:but];
}

- (instancetype)initWith:(NSArray *)titleArr click:(void(^)(UIButton *but))but
{
    self = [super init];
    if (self) {
        _dataArray = titleArr;
        [self initView];
        self.passValue = ^(UIButton *button) {
            but ? but(button) : nil;
        };
    }
    
    return self;
}

- (void)initView
{
    self.frame = CGRectMake(0, 0, BUTTON_W, _dataArray.count*BUTTON_BUTTON_H+10);
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    self.layer.cornerRadius = 5;
    self.layer.anchorPoint = CGPointMake(0.5, 0);
    self.layer.position = CGPointMake(SCREEN_WIDTH-75, kNavgationHeight);
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.windowLevel = UIWindowLevelAlert;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowTapGestureRecognizer:)];
    [self.window addGestureRecognizer:tap];
    [self.window addSubview:_bgView];
    [self.window addSubview:self];
    
    _coverLayer = [CALayer layer];
    _coverLayer.backgroundColor = RGB(80, 80, 80).CGColor;
    _coverLayer.frame = CGRectMake(0, 10, BUTTON_W, _dataArray.count*BUTTON_BUTTON_H);
    //    _coverLayer.cornerRadius = 3;
    _coverLayer.masksToBounds = YES;
    [self.layer addSublayer:_coverLayer];
    
    for (int i=0; i<_dataArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, BUTTON_BUTTON_H*i+10, BUTTON_W, BUTTON_BUTTON_H)];
        [button setTitle:_dataArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(currentTitle:) forControlEvents:UIControlEventTouchDown];
        button.tag = i;
        if (i<_dataArray.count-1) {
            [button.layer addSublayer:[self createLineLayer:CGRectMake(10, BUTTON_BUTTON_H-1, BUTTON_W-20, 1)]];
        }
        
        [self addSubview:button];
    }
}

-(void)currentTitle:(UIButton *)sender {
    self.passValue(sender);
    [self hidePopoverView];
}


-(void)showPopoverView {
    self.window.hidden = NO;
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.9;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

-(void)hidePopoverView {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        self.window.hidden = YES;
    }];
}
- (void)windowTapGestureRecognizer:(UITapGestureRecognizer *)tap
{
    [self hidePopoverView];
}
-(void)remove {
    [self removeFromSuperview];
    self.window = nil;
}

/**
 *画三角形
 */
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //设置画笔
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    [RGB(80, 80, 80) set];  //设置填充颜色  同时设置fill stroke
    
    //添加画笔
    CGContextBeginPath(ref);
    CGPoint point = CGPointMake(BUTTON_W-20, 0);
    // 设置起点
    CGContextMoveToPoint(ref, point.x, point.y);
    // 画线
    CGContextAddLineToPoint(ref, point.x - 10, point.y + 10);
    CGContextAddLineToPoint(ref, point.x + 10, point.y + 10);
    CGContextClosePath(ref);
    // 绘制路径
    CGContextDrawPath(ref, kCGPathFillStroke);
}

-(CALayer *)createLineLayer:(CGRect)frame {
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = RGB(120, 120, 120).CGColor;
    return layer;
}

-(void)dealloc {
    NSLog(@"dealloc");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
