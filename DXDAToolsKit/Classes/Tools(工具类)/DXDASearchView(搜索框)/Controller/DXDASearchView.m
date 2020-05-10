//
//  DXDASearchView.m
//  NewApp3.0
//
//  Created by DXDA on 2020/1/6.
//  Copyright © 2020 DXDA. All rights reserved.
//

#import "DXDASearchView.h"
#import "HMScannerController.h"

@interface DXDASearchView ()<UITextFieldDelegate>
@property (nonatomic, strong) void(^searchAction)(NSString *text);

@end

@implementation DXDASearchView

+(instancetype)createWithFrame:(CGRect)frame superView:(UIView *)superView isScan:(BOOL)isScan placeholder:(NSString *)placeholder isHistoryView:(BOOL)isHistoryView searchAction:(void(^)(NSString *text))searchAction
{
    return [[self alloc]initWithFrame:frame superView:superView isScan:isScan placeholder:placeholder isHistoryView:isHistoryView searchAction:searchAction];
}

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView isScan:(BOOL)isScan placeholder:(NSString *)placeholder isHistoryView:(BOOL)isHistoryView searchAction:(void(^)(NSString *text))searchAction
{
    if (self = [super init]) {
        self.frame = frame;
        self.superView = superView;
        self.isScan = isScan;
        self.placeholder = placeholder;
        self.isHistoryView = isHistoryView;
        
        [self setup];
        
        [self setSearchAction:^(NSString *text) {
            searchAction ? searchAction(text) : @"";
        }];
        
    }
    return self;
}
-(void)setup
{
//    self.backgroundColor = UIColor.whiteColor;
    self.backgroundColor = Dark_BackgroudColor;
    [self.superView addSubview:self];
    
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-70, 35)];
    if (self.isScan) {
        tf.frame = CGRectMake(15, 5, SCREEN_WIDTH - 70, 35);
    }else{
        tf.frame = CGRectMake(15, 5, SCREEN_WIDTH - 30, 35);
    }
    self.searTextField =tf;
    tf.backgroundColor = [UIColor setLightColor:DXDA_LineColor darkColor:RGB(89, 89, 89)];
    [tf addTarget:self action:@selector(SearTextField:) forControlEvents:UIControlEventAllEditingEvents];
    tf.font = DXDA_font;
    tf.layer.cornerRadius = 5;
    tf.delegate = self;
    tf.placeholder = self.placeholder;
    tf.returnKeyType =UIReturnKeySearch;
    //修改clearButtonMode图片
    //获取到clearbutton 可以获取样式上
    UIButton *clearButton = [tf valueForKey:@"_clearButton"] ;
    
    [clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [clearButton setImage:[UIImage imageNamed:@"hn_close_icon"] forState:UIControlStateNormal];
    
    tf.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:tf];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    tf.leftView = leftView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftima = [[UIImageView alloc]initWithFrame:CGRectMake(7.5, 7.5, 15, 15)];
    leftima.image = [UIImage imageNamed:@"search"];
    [leftView addSubview:leftima];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightViewTap:)];
    [rightView addGestureRecognizer:tap];
    
    UIImageView *rightima = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    rightima.image = [UIImage imageNamed:@"QR"];
    
    [rightView addSubview:rightima];
    [self addSubview:rightView];
    
    weak(self)
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.right.equalTo(weakSelf.mas_right).offset(-8);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    if (self.isScan) {
        rightView.hidden = NO;
    }else{
        rightView.hidden = YES;
    }
    
}
#pragma mark - 取消搜索
- (void)SearTextField:(UITextField *)TextField
{
    if ([TextField.text isEqualToString:@""]) {
//        self.searchAction(@"");
    }
}

-(void)clearButtonClick:(UIButton *)button
{
    self.searchAction(@"");
    
    [self.searTextField resignFirstResponder];
    
    
}

#pragma mark - Return 搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     self.searchAction(textField.text);
    [self.searTextField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.isHistoryView ) {
        [self.historyView showView];
    }

    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.isHistoryView) {
       [self.historyView hideView];
    }
    
    return YES;
}


-(DXDASearchHistoryView *)historyView
{
    if (!_historyView) {
        
        weak(self)
        _historyView = [DXDASearchHistoryView createWith:self.superView searchAction:^(NSString * _Nonnull text) {
            weakSelf.searTextField.text = text;
            [weakSelf.historyView hideView];
            [weakSelf.historyView saveData:text];
            [weakSelf.searTextField resignFirstResponder];
            weakSelf.searchAction(text);
        }];
        _historyView.clearBlock = ^{
            weakSelf.searTextField.text = @"";
            [weakSelf.searTextField resignFirstResponder];
            weakSelf.searchAction(@"");
        };
    }
    return _historyView;
}
#pragma mark - 搜索点击扫码
- (void)rightViewTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击时间");
    NSString *cardName = @"";
    UIImage *avatar = [UIImage imageNamed:@"avatar"];
    weak(self)
    // 实例化扫描控制器
    HMScannerController *scanner = [HMScannerController scannerWithCardName:cardName avatar:avatar completion:^(NSString *stringValue) {
        weakSelf.searTextField.text = stringValue;
        NSLog(@"%@",stringValue);
        
        weakSelf.searchAction(stringValue);
        
        if (weakSelf.historyView) {
            [weakSelf.historyView hideView];
        }
        
    }];
    // 设置导航栏样式
    [scanner setTitleColor:DXDA_DefaultColor tintColor:[UIColor whiteColor]];
    // 展现扫描控制器
    [[UIResponder returnController] showDetailViewController:scanner sender:nil];
}

@end
