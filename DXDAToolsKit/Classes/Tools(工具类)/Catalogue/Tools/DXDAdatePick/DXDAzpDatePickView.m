//
//  DXDAzpDatePickView.m
//  x_App
//
//  Created by DXDA on 2018/7/4.
//  Copyright © 2018年 SimpleTable. All rights reserved.
//

#import "DXDAzpDatePickView.h"

@interface DXDAzpDatePickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong) UIView *tempView;
@property (nonatomic,strong) UIView *toolBarView;

@property (nonatomic,copy) void(^cancelBlock)(void);
@property (nonatomic,copy) void(^confireBlock)(NSString *startdate,NSString *enddate);

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,assign) NSInteger selectRow;
@property (nonatomic,assign) zpDatePickType type;

@end

@implementation DXDAzpDatePickView

+(instancetype)create:(zpDatePickType)type confireBlock:(void (^)(NSString *_, NSString *))confireBlock cancel:(void (^)(void))cancelBlock
{
    return [[self alloc] initWith:type confireBlock:confireBlock cancel:cancelBlock];
}

-(instancetype)initWith:(zpDatePickType)type confireBlock:(void(^)(NSString *startdate,NSString *enddate))confireBlock cancel:(void(^)(void))cancelBlock {
    if (self = [super init]) {
        self.type = type;
        [self setup];
        [self createPickerView];
        
        [self setConfireBlock:^(NSString *startdate,NSString *enddate) {
            confireBlock ? confireBlock(startdate,enddate) : nil;
        }];
        
        [self setCancelBlock:^{
            cancelBlock ? cancelBlock() : nil;
        }];
        
    }
    return self;
}

-(void)setup {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    self.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)];
    [self addGestureRecognizer:tap];
    
    [self.window addSubview:self];
}

-(void)createPickerView {
    _tempView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 260+44)];
    _tempView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_tempView];
    
    _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    _toolBarView.backgroundColor = DXDA_DefaultColor;
    [_tempView addSubview:_toolBarView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 80, 44);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_tempView addSubview:cancelBtn];
    
    UIButton *confireBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confireBtn.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 44);
    [confireBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confireBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [confireBtn addTarget:self action:@selector(confireAction) forControlEvents:UIControlEventTouchUpInside];
    [_tempView addSubview:confireBtn];
    
    DXDAzpDateModel *model = [[DXDAzpDateModel alloc]init];
    self.dataArr = _type == week?model.getAllWeekDate:model.getAllMonthDate;
    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 260)];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    [_pickView selectRow:_type == week?model.defaultWeek:model.defaultMonth inComponent:0 animated:YES];
    _selectRow = _type == week?model.defaultWeek:model.defaultMonth;
    [_tempView addSubview:_pickView];
    
}

// pickDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArr.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *dateArr = self.dataArr[row];
    return dateArr[0];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSArray *dateArr = self.dataArr[row];
    UILabel *label = [UILabel createWithCenter:CGRectZero title:dateArr[0] titleColor:[UIColor blackColor] font:iPhone5_5s?16:19];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectRow = row;
}

-(void)cancelAction {
    [self hidePickerView];
}

-(void)confireAction {
    NSArray *dateArr = self.dataArr[_selectRow];
    self.confireBlock ? self.confireBlock(dateArr[1],dateArr[2]) : nil;
    [self hidePickerView];
}

-(void)showPickerView {
    self.window.hidden = NO;
    [_window addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        _tempView.transform = CGAffineTransformMakeTranslation(0, -_tempView.height);
    }];
}

-(void)hidePickerView {
    
    self.cancelBlock ? self.cancelBlock() : nil;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        _tempView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _window = nil;
    }];
}

#pragma mark - lazy
-(UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.windowLevel = UIWindowLevelAlert;
        _window.backgroundColor = [UIColor clearColor];
    }
    return _window;
}

-(void)dealloc {
    NSLog(@"picker dealloc");
}

@end
