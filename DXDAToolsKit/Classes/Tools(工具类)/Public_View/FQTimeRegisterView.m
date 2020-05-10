//
//  FQTimeView.m
//  TeXFG
//
//  Created by Erowin on 16/9/14.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "FQTimeRegisterView.h"

@interface FQTimeRegisterView ()

@property(nonatomic,strong)UIButton *timeBtn;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger timeNum;

@property(nonatomic,strong)UIView *lineView;

@end

@implementation FQTimeRegisterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBtnType];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        [self setBtnType];
    }
    return self;
}
-(void)setBtnType
{
    [self addSubview:self.lineView];
    self.timeNum = 120;
    [self addSubview:self.timeBtn];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.lineView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
}
-(void)btnClick:(UIButton *)btn
{
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(timeViewBtnClikWithView:)])
    {
        [self.delegate timeViewBtnClikWithView:self];
    }
}
-(void)timeRun
{
    self.timeNum--;
    if (self.timeNum == 0) {
        [self.timeBtn setTitle:@"获取验证码" forState:0];
        [self.timeBtn  setEnabled:YES];
        self.timeNum = 120;
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    [self.timeBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)",self.timeNum] forState:UIControlStateNormal];
}
-(void)stopTimeRun
{//重置
    self.timeBtn.enabled = YES;
    self.timeNum = 120;
    [self.timer invalidate];
    self.timer = nil;
}
-(void)beganTimeRun
{//开始计时
    self.timeBtn.enabled = NO;
   // self.timeBtn.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:244/255.f alpha:1];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
#pragma mark ----懒加载
-(UIButton *)timeBtn
{
    if (_timeBtn==nil)
    {
        _timeBtn = [[UIButton alloc]init];
//        _timeBtn.layer.borderWidth = 1;
        [_timeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_timeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        _timeBtn.layer.cornerRadius = 5;
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        _timeBtn.layer.borderColor = [UIColor orangeColor].CGColor;
//        _timeBtn.layer.masksToBounds = YES;
        _timeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _timeBtn;
}
-(void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
-(NSTimer *)timer
{
    if (_timer==nil)
    {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    }
    return _timer;
}
-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

@end
