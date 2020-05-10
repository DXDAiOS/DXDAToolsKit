//
//  DXDACellViewFactory.m
//  NewApp3.0
//
//  Created by DXDA on 2017/7/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "DXDACellViewFactory.h"
#import "HMScannerController.h"

@interface DXDACellViewFactory ()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,copy) void(^actionBlock2)(NSString *text, NSString *text2);

@property (nonatomic, strong) CALayer *crm_lineLayer;

@end

static CGFloat const normal_h = 44;
static CGFloat const n_fontSize = 15;
static NSInteger const effectTag = 3000;

@implementation DXDACellViewFactory
{
    // CRMTextView property
    UILabel *pointLabel;
    NSString *placeText;
    ViewType _viewType;
}

+(instancetype)createWith:(ViewType)type
                    title:(NSString *)title
              placeHolder:(NSString *)text
             keyboardType:(UIKeyboardType)keyboardType
             buttonAction:(void(^)(NSString *text))buttonAction
{
    return [[self alloc] initWith:type title:title placeHolder:text keyboardType:keyboardType buttonAction:buttonAction];
}

+(instancetype)createWithForCashPaymentType:(ViewType)type
                                       left:(NSString *)left
                                     center:(NSString *)center
                                      right:(NSString *)right
                               buttonAction:(void(^)(NSString *text, NSString *text2))buttonAction
{
    return [[self alloc] initWithForCashPaymentType:type left:left center:center right:right buttonAction:buttonAction];
}

-(instancetype)initWith:(ViewType)type
                  title:(NSString *)title
            placeHolder:(NSString *)text
           keyboardType:(UIKeyboardType)keyboardType
           buttonAction:(void(^)(NSString *text))buttonAction {
    if (self = [super init]) {
        
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = Dark_BackgroudColor;
        _viewType = type;
        placeText = text;
        
        switch (type) {
            case ViewType_normal:
                [self normal_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_date:
                [self date_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_calendar:
                [self calender_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_remark:
                [self remark_setup:title];
                break;
            case ViewType_remarkAutoHeight:
                [self remark_setupAutoHeight:title];
                break;
            case ViewType_addItem:
                [self addItem_setup:title];
                break;
            case ViewType_sumItem:
                [self sumItem_setup:title];
                break;
            case ViewType_emptyItem:
                [self emptyItem_setup:title];
                break;
            case ViewType_headItem:
                [self headItem_setup:title date:text];
                break;
            case ViewType_singleTitle:
                [self singleTitle_setup:title date:text];
                break;
            case ViewType_textField:
                [self textField_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_siteView:
                [self textView_setup:title TextAlignment:NSTextAlignmentRight];
                break;
            case ViewType_textView:
                [self textView_setup:title];
                break;
            case ViewType_textViewNoTitle:
                [self textView_setupNoTitle:title];
                break;
            case ViewType_noticeHeadItem:
                [self noticeHeadItem_setup:title date:text];
                break;
            case ViewType_input:
                [self input_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_CRMTextView:
                [self CRMTextView_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_CRMTextView_effect:
                [self CRMTextView_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_CRMRemarkView:
                [self CRMRemarkView_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_writeAndChoose:
                [self normal_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_newNormal:
                [self newNormal_setup:title text:text];
                break;
            case ViewType_TypeTitle:
                [self TypeTitle_setup:title];
                break;
            case ViewType_SelAndWriteAddr:
                [self selAndWriteAddr_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_textFieldAndSelect:
                [self textFieldAndSelect_setup:title text:text keyboardType:keyboardType];
                break;
            case ViewType_addItem_Gx:
                [self addItem_gx:title];
                break;
            case ViewType_addItem_Cl:
                [self addItem_cl:title];
                break;
            case ViewType_QuetoYiYuanXiShu:
                [self priceAndXishu];
                break;
            case ViewType_textFieldAndScan:
                [self textFieldAndScan:title];
                break;
            case ViewType_textFieldAndBtn:
                [self textFieldAndBtn:title];
                break;
            case ViewType_twoSelectBtn:
                [self ViewType_twoSelectBtn:title text:text];
                break;
            case ViewType_Switch:
                [self ViewType_Switch:title];
                break;
            case ViewType_textFieldAutoHeight:
                [self textFieldAutoHeightWithTitle:title text:text];
                break;
            default:
                break;
        }
        
       
        
       if (@available(iOS 13.0, *)) {//黑暗模式
           UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                  if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                      return GrayRGB(50);
                  }
                  else {
                      return UIColor.whiteColor;
                  }
              }];
           
           _leftTitleLabel.textColor = dyColor;
           _textField.textColor = dyColor;
           _remarkField.textColor = dyColor;
           _addItemTitle.textColor = dyColor;
       }
        
        [self setActionBlock:^ (NSString *text){
            buttonAction ? buttonAction(text) : nil;
        }];
    }
    return self;
}

-(void)textFieldAutoHeightWithTitle:(NSString *)title text:(NSString *)text
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
     CGSize size = [NSString calculateWith:title max:CGSizeMake(300, normal_h) fontSize:n_fontSize];
    size.width = MAX(100, size.width);
       
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, size.width, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    weak(self)
    [_leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.width.mas_equalTo(size.width);
    }];
    // 记录初始高度
    
    _initHeight = normal_h;
    self.clipsToBounds = NO;
    
    // 添加textView
    CGFloat w = SCREEN_WIDTH - 15 - size.width - 10 - 15;
    self.autoTextView = [[UITextView alloc]initWithFrame:CGRectMake(15 + size.width + 5, 5, w, normal_h-10)];
    self.autoTextView.font = [UIFont systemFontOfSize:n_fontSize];
    
    [self addSubview:self.autoTextView];
    self.autoTextView.delegate = (id)self;
    self.autoTextView.textAlignment = NSTextAlignmentRight;
    self.autoTextView.backgroundColor = [UIColor clearColor];
    
    // 添加placeholderLabel
    self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + size.width , 5, w, normal_h-10)];
    self.placeholderLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.placeholderLabel];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    self.placeholderLabel.text = text;
    self.placeholderLabel.font = [UIFont systemFontOfSize:15];
//    [self.placeholderLabel sizeToFit];
//    self.placeholderLabel.center = self.autoTextView.center;
}



-(void)ViewType_Switch:(NSString *)title
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
     CGSize size = [NSString calculateWith:title max:CGSizeMake(300, normal_h) fontSize:n_fontSize];
    size.width = MAX(100, size.width);
       
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, size.width, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    UISwitch *swi = [[UISwitch alloc]init];
    _swi = swi;

    [swi setOnTintColor:DXDA_DefaultColor];
//    [swi setOn:YES];
    [swi addTarget:self action:@selector(swiClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:swi];
    weak(self)
    [swi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(65);
    }];
}
-(void)swiClick:(UISwitch *)swi
{
    if (swi.isOn) {
         self.actionBlock ? self.actionBlock(@"Y") : nil;
    }else{
         self.actionBlock ? self.actionBlock(@"N") : nil;
    }
}
-(void)textFieldAndSelect_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    
    CGSize size = [NSString calculateWith:title max:CGSizeMake(300, normal_h) fontSize:n_fontSize];
    
    size.width = MAX(100, size.width);
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, size.width, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    CGFloat btn_w= 40;
    _sourceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sourceBtn.frame = CGRectMake(self.width-btn_w-10, 0, btn_w, normal_h);
    [_sourceBtn setImage:[UIImage imageNamed:@"扫码"] forState:UIControlStateNormal];
    [_sourceBtn addTarget:self action:@selector(sourceAction) forControlEvents:UIControlEventTouchUpInside];
    _sourceBtn.hidden = NO;
    [self addSubview:_sourceBtn];
    
    CGFloat text_w = self.width-CGRectGetMaxX(_leftTitleLabel.frame)-5-15;
    
    _textField = [UITextField createWithRight:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame)+5, 0, text_w, normal_h) placeHolder:text keyboardType:keyboardType fontSize:n_fontSize];
    _textField.textColor = GrayRGB(50);
    
    [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self addSubview:_textField];
    weak(self)
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.sourceBtn.mas_left).offset(-5);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_leftTitleLabel.mas_right).mas_offset(5);
        make.height.mas_equalTo(normal_h);
    }];
    
    
}

-(instancetype)initWithForCashPaymentType:(ViewType)type
                                     left:(NSString *)left
                                   center:(NSString *)center
                                    right:(NSString *)right
                             buttonAction:(void(^)(NSString *text, NSString *text2))buttonAction
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        switch (type) {
            case ViewType_forCash:
                [self forCash_setup:left discountAmount:center currentAmount:right];
                break;
                
            default:
                break;
        }
        
        [self setActionBlock2:^ (NSString *text, NSString *text2){
            buttonAction ? buttonAction(text, text2) : nil;
        }];
    }
    return self;
}

//MARK: - 重写 userInteractionEnabled 设置是否隐藏 _rightArrow
-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    super.userInteractionEnabled = userInteractionEnabled;
    _rightArrow.hidden = !userInteractionEnabled;
    
    CGFloat space_w = 0.00;
    space_w = userInteractionEnabled ? _rightArrow.width : 5;
    CGFloat text_w = self.width-CGRectGetMaxX(_leftTitleLabel.frame)-5-space_w-5-5;
    
    _textField.width = text_w;
    
    if (!_textField || !_leftTitleLabel || !_rightArrow) {
        return;
    }
    
    if (!userInteractionEnabled) {
        
        weak(self)
        [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.top.mas_equalTo(0);
            make.left.equalTo(weakSelf.leftTitleLabel.mas_right).offset(5);

            make.height.mas_equalTo(self.height);
        }];
    }
    else {
        
        weak(self)
        [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).offset(-33);
            make.right.equalTo(weakSelf.rightArrow.mas_left).offset(-5);
            make.top.mas_equalTo(0);
            make.left.equalTo(weakSelf.leftTitleLabel.mas_right).offset(5);
            make.height.mas_equalTo(self.height);
        }];
    }
    
    [self layoutIfNeeded];
    
}

//MARK: - -------------------------- ViewType_newNormal
- (void)newNormal_setup:(NSString *)title text:(NSString *)text {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectZero title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    [_leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12);
//        make.height.mas_equalTo(normal_h);
    }];
    
    _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查看"]];
    [self addSubview:_rightArrow];
    weak(self)
    [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        
    }];

    _rightLabel = [UILabel createWithRight:CGRectZero title:text titleColor:GrayRGB(50) font:n_fontSize];
    _rightLabel.textColor = GrayRGB(215);
    _rightLabel.numberOfLines = 0;
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftTitleLabel.mas_right).mas_offset(15);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(_rightArrow.mas_left).mas_offset(-5);
        make.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(normal_h);
    }];
    
    UIButton *cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cellBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cellBtn];
    [cellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

//MARK: - 更新 rect
- (void)updateForNormalType:(NSString *)text handle:(void (^)(CGFloat))handle {
    _rightLabel.text = text.length > 0 ? text : placeText;
    _rightLabel.textColor = text.length > 0 ? [UIColor blackColor] : GrayRGB(215);
    [_rightLabel layoutIfNeeded];
    !handle ? : handle(self.height);
}

-(void)viewIsChoose:(BOOL)isChoose
{
    _rightArrow.hidden = !isChoose;
    _textField.userInteractionEnabled = !isChoose;
    _cellBtn.userInteractionEnabled = isChoose;
    
    CGFloat space_w = 0.00;
    space_w = isChoose ? _rightArrow.width : 5;
    CGFloat text_w = self.width-CGRectGetMaxX(_leftTitleLabel.frame)-5-space_w-5-5;
    
    _textField.width = text_w;
    
    if (!_textField || !_leftTitleLabel || !_rightArrow) {
        return;
    }
    
    if (!isChoose) {
        [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(_leftTitleLabel.mas_right).mas_offset(5);
            make.height.mas_equalTo(self.height);
        }];

    }
    else {
        [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_rightArrow.mas_left).mas_offset(-5);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(_leftTitleLabel.mas_right).mas_offset(5);
            make.height.mas_equalTo(self.height);
        }];
    }
    [self layoutIfNeeded];
}

//MARK: - -------------------------- ViewType_normal
-(void)normal_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    
    //    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(150, normal_h) fontSize:n_fontSize];
    
    CGSize size = [NSString calculateWith:title max:CGSizeMake(200, normal_h) fontSize:n_fontSize];
    CGFloat titleWidth = MAX(125, size.width);
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, titleWidth, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查看"]];
    _rightArrow.frame = CGRectMake(self.width-18-5, (self.height-18)/2, 18, 18);
    [self addSubview:_rightArrow];
    weak(self)
    [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        
    }];
    
    CGFloat text_w = self.width-CGRectGetMaxX(_leftTitleLabel.frame)-5-_rightArrow.width-5-5;
    
    _textField = [UITextField createWithRight:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame)+5, 0, text_w, normal_h) placeHolder:text keyboardType:keyboardType fontSize:n_fontSize];
    _textField.textColor = GrayRGB(50);
    //    _textField.n
    _textField.userInteractionEnabled = NO;
    [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self addSubview:_textField];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-33);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_leftTitleLabel.mas_right).mas_offset(5);
        make.height.mas_equalTo(normal_h);
    }];
    
    if (_viewType == ViewType_writeAndChoose) {
        CGFloat btn_w = 18 + 10 + 5;
        CGFloat btn_h = self.height;
        CGFloat btn_y = 0;
        CGFloat btn_x = self.width - btn_w;
        UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        arrowBtn.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
        [arrowBtn addTarget:self action:@selector(buttonMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:arrowBtn];
        
        _rightArrow.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else {
        UIButton *cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cellBtn.frame = self.bounds;
        [cellBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cellBtn];
        _cellBtn = cellBtn;
    }
}

-(void)buttonMethod {
    !self.btnBlock ? : self.btnBlock();
}

-(void)buttonAction {
    self.actionBlock ? self.actionBlock(@"") : nil;
}

//MARK: - -------------------------- ViewType_date
-(void)date_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    
//    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(200, normal_h) fontSize:n_fontSize];
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, 100, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查看"]];
    _rightArrow.frame = CGRectMake(self.width-18-5, (self.height-18)/2, 18, 18);
    [self addSubview:_rightArrow];
    
    CGFloat text_w = self.width-CGRectGetMaxX(_leftTitleLabel.frame)-5-_rightArrow.width-5-5;
    
    _textField = [UITextField createWithRight:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame)+5, 0, text_w, normal_h) placeHolder:text keyboardType:keyboardType fontSize:n_fontSize];
    _textField.textColor = GrayRGB(50);
    _textField.userInteractionEnabled = NO;
    //    [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self addSubview:_textField];
    
    UIButton *cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cellBtn.frame = self.bounds;
    [cellBtn addTarget:self action:@selector(chooseDateAction) forControlEvents:UIControlEventTouchUpInside];
    _cellBtn = cellBtn;
    [self addSubview:cellBtn];
    
}

#pragma mark - 改变 pickerView UIDatePickerMode
- (void)changePickerDateMode:(UIDatePickerMode)mode {
    [self.datePickerView changeDateMode:mode];
}

#pragma mark - 改变最小日期
- (void)changeMiniDate:(NSString *)string {
    [self.datePickerView changeMiniDate:string];
}

#pragma mark - 改变最大日期
- (void)changeMaxDate:(NSString *)string {
    [self.datePickerView changeMaxDate:string];
}

-(void)chooseDateAction {
    [self.datePickerView showPickerView];
}

-(DXDACZDatePickerView *)datePickerView {
    if (!_datePickerView) {
        weak(self)
        _datePickerView = [DXDACZDatePickerView create:^(NSString *timeText) {
            weakSelf.textField.text = timeText;
            weakSelf.actionBlock ? weakSelf.actionBlock(timeText) : nil;
        } cancel:^{
            
        }];
    }
    return _datePickerView;
}

//MARK: - -------------------------- ViewType_calender
-(void)calender_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    
    //    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(200, normal_h) fontSize:n_fontSize];
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, 100, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查看"]];
    _rightArrow.frame = CGRectMake(self.width-18-5, (self.height-18)/2, 18, 18);
    [self addSubview:_rightArrow];
    
    CGFloat text_w = self.width-CGRectGetMaxX(_leftTitleLabel.frame)-5-_rightArrow.width-5-5;
    
    _textField = [UITextField createWithRight:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame)+5, 0, text_w, normal_h) placeHolder:text keyboardType:keyboardType fontSize:n_fontSize];
    _textField.textColor = GrayRGB(50);
    _textField.userInteractionEnabled = NO;
    //    [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self addSubview:_textField];
    
    UIButton *cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cellBtn.frame = self.bounds;
    [cellBtn addTarget:self action:@selector(choosecalenderAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cellBtn];
    
}
-(void)choosecalenderAction {
    [self.calenderPickerView showFillteView];
}


-(DXDACalendarPickerView *)calenderPickerView
{
    if (!_calenderPickerView) {
        weak(self)
        DXDACalendarPickerView *view = [DXDACalendarPickerView create:^(NSString *timeText) {
            weakSelf.textField.text = timeText;
            weakSelf.actionBlock ? weakSelf.actionBlock(timeText) : nil;
        } cancel:^{
            
        }];
        view.isMinToday = YES;
        view.layer.cornerRadius =3;
        view.layer.masksToBounds = YES;
        _calenderPickerView = view;
    }
    return _calenderPickerView;
}
-(void)changeCalendarMinDate:(BOOL)boo
{
    self.calenderPickerView.isMinToday = boo;
}

//MARK: - -------------------------- ViewType_remark
-(void)remark_setup:(NSString *)title {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    
    title = title ? : @"备注信息";
    
    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(100, normal_h) fontSize:n_fontSize];
    
    UILabel *remarkTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, titleSize.width+10, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:remarkTitleLabel];
    self.leftTitleLabel = remarkTitleLabel;
    
    _remarkField = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(remarkTitleLabel.frame), 5, self.width-CGRectGetMaxX(remarkTitleLabel.frame)-15, normal_h)];
    _remarkField.font = [UIFont systemFontOfSize:15];
    _remarkField.delegate = self;
    _remarkField.textColor = Dark_TextColor;
    [self addSubview:_remarkField];
}

-(NSString *)textDidChange:(NSString *)text textView:(UITextView *)textView
{
    
    NSInteger maxFontNum = self.maxFontNum;//最大输入限制
    
    NSString *toBeString = text;
    
    NSString *str = text;
    
    // 获取键盘输入模式
    
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    
    if ([lang isEqualToString:@"zh-Hans"]) { // zh-Hans代表简体中文输入，包括简体拼音，健体五笔，简体手写
        
        UITextRange *selectedRange = [textView markedTextRange];
        
        //获取高亮部分
        
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        
        if (!position) {
            
            if (toBeString.length > maxFontNum) {
                
                
                str = [toBeString substringToIndex:maxFontNum];//超出限制则截取最大限制的文本
                
                
            } else {
                
            }
            
        }
        
    } else {// 中文输入法以外的直接统计
        
        if (toBeString.length > maxFontNum) {
            
            str = [toBeString substringToIndex:maxFontNum];
            
        } else {
            
        }
        
    }
    
    return str;
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"%@",text);
    
    if (self.maxFontNum > 0) {
        
        NSString *str = [self textDidChange:textView.text textView:textView];
        
        if (textView.text.length > self.maxFontNum) {
            textView.text = str;
            return NO;
        }else{
            return YES;
        }
        
        
    }
    
    return YES;
}

-(void)updateAutoTextViewText:(NSString *)text
{
    self.autoTextView.text = text;
    [self autoTextViewDidChangeAction:self.autoTextView];
}
-(void)autoTextViewDidChangeAction:(UITextView *)textView
{
    // 计算高度
    CGSize size = CGSizeMake(self.autoTextView.frame.size.width, CGFLOAT_MAX);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.autoTextView.font,NSFontAttributeName, nil];
    CGFloat curheight = [textView.text boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:dic
                                                    context:nil].size.height;
    // 如果高度小于初始化时的高度，则不赋值(仍采用最初的高度)
    if (curheight < _initHeight-10) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _initHeight);
        self.autoTextView.frame = CGRectMake(self.autoTextView.frame.origin.x, self.autoTextView.frame.origin.y, self.autoTextView.frame.size.width, _initHeight-10);
    }else{
        // 重新给frame赋值(改变高度)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, curheight+30);
        self.autoTextView.frame = CGRectMake(self.autoTextView.frame.origin.x, self.autoTextView.frame.origin.y, self.autoTextView.frame.size.width, curheight+20);
    }
    
    // 如果文本为空，显示placeholder
    if (textView.text.length == 0) {
        self.placeholderLabel.hidden = NO;
//        self.placeholderLabel.center = self.autoTextView.center;
    }else{
        self.placeholderLabel.hidden = YES;
    }
     
    self.actionBlock ? self.actionBlock(textView.text) : nil;
}


#pragma mark - textView delegate method
-(void)textViewDidChange:(UITextView *)textView {
    
//    if ([textView isEqual:_remarkField]) {
//        NSDictionary *dic = @{NSForegroundColorAttributeName:Dark_TextColor};
//        _remarkField.attributedText =  [[NSAttributedString alloc] initWithString:textView.text attributes:dic];
//    }
    
    if ([textView isEqual:_autoTextView]) {
        [self autoTextViewDidChangeAction:textView];
        return;
    }
   
    
    self.actionBlock ? self.actionBlock(textView.text) : nil;
    // 没找到方法，暂用
    if (_viewType == ViewType_CRMTextView || _viewType == ViewType_CRMTextView_effect || self.isAdaptiveTextView) {
        CGSize size = [NSString calculateWith:[NSString stringWithFormat:@"%@",textView.text] max:CGSizeMake(_leftTitleLabel.width-16, 2000) fontSize:14];
        if (size.height>100) {
            self.textView.height = size.height + 16;
            self.height = self.textView.bottom + 10;
            
            if (_viewType == ViewType_CRMTextView || _viewType == ViewType_CRMTextView_effect) {
                if ([self.leftTitleLabel.text isEqualToString:@"*拜访简述"]) {
                    [self showDownLineAction];
                }
                else if ([self.leftTitleLabel.text isEqualToString:@"*总体效果"])
                {
                    [self showAllLineAction];
                }
                else
                {
                    [self showUpLineAction];
                }
            }

            UITextRange *range1 = self.textView.selectedTextRange;
            //光标位置
            CGRect  rect = [self.textView caretRectForPosition:range1.start];
            CGFloat h = (_viewType == ViewType_CRMTextView || self.isAdaptiveTextView) ? 50 : 10;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTextViewSize" object:@{@"location":[NSString stringWithFormat:@"%f",rect.origin.y + self.y +10 - h]}];
        }
    }
}


-(void)remark_setupAutoHeight:(NSString *)title
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    
    title = title ? : @"备注信息";
    
    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(100, normal_h) fontSize:n_fontSize];
    
    UILabel *remarkTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, titleSize.width+10, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:remarkTitleLabel];
    
    weak(self)
    [remarkTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.height.mas_equalTo(normal_h);
        make.width.mas_equalTo(titleSize.width+10);
    }];
    
    self.leftTitleLabel = remarkTitleLabel;
    
    _remarkField = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(remarkTitleLabel.frame), 5, self.width-CGRectGetMaxX(remarkTitleLabel.frame)-15, normal_h)];
    _remarkField.font = [UIFont systemFontOfSize:15];
    _remarkField.delegate = self;
    _remarkField.textColor = Dark_TextColor;
    
    [self addSubview:_remarkField];
    
}
/*
 - (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
 - (BOOL)textViewShouldEndEditing:(UITextView *)textView;

 - (void)textViewDidBeginEditing:(UITextView *)textView;
 - (void)textViewDidEndEditing:(UITextView *)textView;

 - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
 - (void)textViewDidChange:(UITextView *)textView;

 - (void)textViewDidChangeSelection:(UITextView *)textView;

 - (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction API_AVAILABLE(ios(10.0));
 - (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction API_AVAILABLE(ios(10.0));

 - (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange API_DEPRECATED_WITH_REPLACEMENT("textView:shouldInteractWithURL:inRange:forInteractionType:", ios(7.0, 10.0));
 - (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange API_DEPRECATED_WITH_REPLACEMENT("textView:shouldInteractWithTextAttachment:inRange:forInteractionType:", ios(7.0, 10.0));
 */


//MARK: - -------------------------- ViewType_addItem
-(void)addItem_setup:(NSString *)title {

    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    self.tag = 0;
    title = title ? : @"名称";
    
//    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(100, normal_h) fontSize:n_fontSize];
    
    _addItemTitle = [UILabel createWithLeft:CGRectMake(15, 0, SCREEN_WIDTH-15*2, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_addItemTitle];
    
    CGFloat btn_w = 40;
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(self.width-btn_w-10, 0, btn_w, normal_h);
    [_addBtn setImage:[UIImage imageNamed:@"添加物品"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    _sourceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sourceBtn.frame = CGRectMake(_addBtn.left-btn_w, 0, btn_w, normal_h);
    [_sourceBtn setImage:[UIImage imageNamed:@"查应付-(1)"] forState:UIControlStateNormal];
    [_sourceBtn addTarget:self action:@selector(sourceAction) forControlEvents:UIControlEventTouchUpInside];
    _sourceBtn.hidden = YES;
    [self addSubview:_sourceBtn];
    
//    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _editBtn.frame = CGRectMake(_sourceBtn.left-btn_w-10, 0, btn_w+10, normal_h);
//    _editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    [_editBtn setTitleColor:DXDA_DefaultColor forState:UIControlStateNormal];
//    [_editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    _editBtn.hidden = YES;
//    [self addSubview:_editBtn];
}

-(void)sourceAction {
    !self.sourceBtnBlock ? : self.sourceBtnBlock();
}

//-(void)editBtnAction:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    !self.editBtnBlock ? : self.editBtnBlock(sender);
//}
-(void)addItem_gx:(NSString *)title
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    self.tag = 1;
    title = title ? : @"名称";
    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(100, normal_h) fontSize:n_fontSize];
    
    _addItemTitle = [UILabel createWithLeft:CGRectMake(15, 0, titleSize.width, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_addItemTitle];
    
    CGFloat btn_w = 40;
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(self.width-btn_w-10, 0, btn_w, normal_h);
    [_addBtn setImage:[UIImage imageNamed:@"添加物品"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    _sourceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sourceBtn.frame = CGRectMake(_addBtn.left-btn_w, 0, btn_w, normal_h);
    [_sourceBtn setImage:[UIImage imageNamed:@"查应付-(1)"] forState:UIControlStateNormal];
    [_sourceBtn addTarget:self action:@selector(sourceAction) forControlEvents:UIControlEventTouchUpInside];
    _sourceBtn.hidden = NO;
    [self addSubview:_sourceBtn];
    
    _tipsLabel = [UILabel new];
    _tipsLabel.backgroundColor = DXDA_LineColor;
    _tipsLabel.textAlignment = NSTextAlignmentLeft;
    _tipsLabel.font = [UIFont systemFontOfSize:14];
    _tipsLabel.layer.cornerRadius = 3;
    _tipsLabel.layer.masksToBounds = YES;
    [self addSubview:_tipsLabel];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addItemTitle.mas_centerY);
        make.left.equalTo(_addItemTitle.mas_right).offset(5);
        make.right.equalTo(_sourceBtn.mas_left).offset(-5);
        make.height.mas_equalTo(25);
    }];
    _tipsLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagLabelClick)];
    [_tipsLabel addGestureRecognizer:tap];
    
}
-(void)tagLabelClick
{
    !self.addItemViewTagBlock ? : self.addItemViewTagBlock();
}

-(void)addItem_cl:(NSString *)title
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    self.tag = 2;
    title = title ? : @"名称";
    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(100, normal_h) fontSize:n_fontSize];
    
    _addItemTitle = [UILabel createWithLeft:CGRectMake(15, 0, titleSize.width, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_addItemTitle];
    
    CGFloat btn_w = 40;
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(self.width-btn_w-10, 0, btn_w, normal_h);
    [_addBtn setImage:[UIImage imageNamed:@"添加物品"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    _sourceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sourceBtn.frame = CGRectMake(_addBtn.left-btn_w, 0, btn_w, normal_h);
    [_sourceBtn setImage:[UIImage imageNamed:@"查应付-(1)"] forState:UIControlStateNormal];
    [_sourceBtn addTarget:self action:@selector(sourceAction) forControlEvents:UIControlEventTouchUpInside];
    _sourceBtn.hidden = YES;
    [self addSubview:_sourceBtn];
    
    _tipsLabel = [UILabel new];
    _tipsLabel.backgroundColor = DXDA_LineColor;
    _tipsLabel.textAlignment = NSTextAlignmentLeft;
    _tipsLabel.font = [UIFont systemFontOfSize:14];
    _tipsLabel.layer.cornerRadius = 3;
    _tipsLabel.layer.masksToBounds = YES;
    [self addSubview:_tipsLabel];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addItemTitle.mas_centerY);
        make.left.equalTo(_addItemTitle.mas_right).offset(5);
        make.right.equalTo(_sourceBtn.mas_left).offset(-5);
        make.height.mas_equalTo(25);
    }];
    _tipsLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagLabelClick)];
    [_tipsLabel addGestureRecognizer:tap];
}

//MARK: - -------------------------- ViewType_sumItem
-(void)sumItem_setup:(NSString *)title {
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    
    title = title ? : @"共0种商品，￥0.00";
    
    _sumOrderLabel = [UILabel createWithRight:CGRectMake(15, 0, self.width-15*2, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_sumOrderLabel];
}

-(void)setSumAttributeStr:(NSAttributedString *)sumAttributeStr {
    _sumAttributeStr = sumAttributeStr;
    
    _sumOrderLabel.attributedText = sumAttributeStr;
}

//MARK: - -------------------------- ViewType_emptyItem
-(void)emptyItem_setup:(NSString *)title {

    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400);
    self.backgroundColor = GrayRGB(245);
    
    UILabel *emptyTitleLabel = [UILabel createWithCenter:CGRectMake((self.width-200)/2, 15, 200, 20) title:title titleColor:GrayRGB(140) font:n_fontSize];
    [self addSubview:emptyTitleLabel];
    
    CGFloat btnW = 60;
    CGFloat btnH = 25;
    CGFloat btnX = (self.width-btnW)/2;
    _emptyAddGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _emptyAddGoodsBtn.frame = CGRectMake(btnX, emptyTitleLabel.bottom+10, btnW, btnH);
    [_emptyAddGoodsBtn setBackgroundImage:[UIImage imageNamed:@"oval_icon"] forState:UIControlStateNormal];
    [_emptyAddGoodsBtn setTitle:@"添加" forState:UIControlStateNormal];
    [_emptyAddGoodsBtn setTitleColor:DXDA_DefaultColor forState:UIControlStateNormal];
    _emptyAddGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_emptyAddGoodsBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_emptyAddGoodsBtn];
    
    CGFloat bgH = 248;
    CGFloat bgW = 248*0.77;
    CGFloat bgX = (self.width-bgW)/2;
    UIImageView *emptyBgView = [[UIImageView alloc] initWithFrame:CGRectMake(bgX, _emptyAddGoodsBtn.bottom, bgW, bgH)];
    emptyBgView.image = [UIImage imageNamed:@"组-12"];
    emptyBgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:emptyBgView];
    
    self.height = CGRectGetMaxY(emptyBgView.frame)+10;
}

//MARK: - -------------------------- ViewType_headItem
-(void)headItem_setup:(NSString *)title date:(NSString *)date {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
    
    CGFloat top_y = 5;
    CGFloat title_h = 30;
    _titleLabel = [UILabel createWithLeft:CGRectMake(15, top_y, self.width-15*2 - 80, title_h+7) title:title titleColor:GrayRGB(50) font:15];
    _titleLabel.numberOfLines = 2;
    [self addSubview:_titleLabel];

    _dateLabel = [UILabel createWithLeft:CGRectMake(15, top_y+title_h+7, self.width-15*2, 20) title:date titleColor:[UIColor grayColor] font:n_fontSize];
    [self addSubview:_dateLabel];
    
    CGFloat state_w = 200;
    CGFloat state_h = 20;
    CGFloat state_x = SCREEN_WIDTH-state_w-15;
    CGFloat state_y = 12; //(self.height-state_h)/2;
    _headStateLabel = [UILabel createWithRight:CGRectMake(state_x, state_y, state_w, state_h) title:@"状态" titleColor:DXDA_DefaultColor font:14];
    [self addSubview:_headStateLabel];
    
    UILabel *dateLabe = [UILabel createWithRight:CGRectMake(state_x, top_y+title_h, state_w, state_h) title:@"" titleColor:DXDA_G_textColor font:14];
    _rightDateLabel = dateLabe;
    [self addSubview:dateLabe];
    
    _blockChainLabel = [UILabel createWithRight:CGRectMake(state_x, top_y+title_h, state_w, state_h) title:@"" titleColor:DXDA_BlockChainColor font:14];
    [self addSubview:_blockChainLabel];
}

//MARK: - -------------------------- ViewType_noticeHeadItem
-(void)noticeHeadItem_setup:(NSString *)title date:(NSString *)date {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 73);

    _titleLabel = [UILabel createWithLeft:CGRectMake(15, 15, SCREEN_WIDTH-15*2, 20) title:@"" titleColor:[UIColor blackColor] font:15];
    [self addSubview:_titleLabel];
    
    _dateLabel = [UILabel createWithLeft:CGRectMake(15, _titleLabel.bottom+5, 200, 20) title:@"" titleColor:GrayRGB(120) font:15];
    [self addSubview:_dateLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height-3, self.width, 3)];
    lineImageView.frame = CGRectMake(0, self.height-3, self.width, 3);
//    lineImageView.backgroundColor = DXDA_DefaultColor;
    lineImageView.theme_backgroundColor = globalDefaultColorPicker;
    lineImageView.image = [UIImage imageNamed:@""];  // image
    [self addSubview:lineImageView];
    
}

//MARK: - -------------------------- ViewType_singleTitle
-(void)singleTitle_setup:(NSString *)title date:(NSString *)date {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 65);
    
    _titleLabel = [UILabel createWithLeft:CGRectMake(15, 5, self.width-15*2, 30) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_titleLabel];

}

//MARK: - -------------------------- ViewType_textField
-(void)textField_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);

    CGSize size = [NSString calculateWith:title max:CGSizeMake(300, normal_h) fontSize:n_fontSize];
    
    size.width = MAX(100, size.width);
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, size.width, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    
    CGFloat text_w = self.width-CGRectGetMaxX(_leftTitleLabel.frame)-5-15;
    
    _textField = [UITextField createWithRight:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame)+5, 0, text_w, normal_h) placeHolder:text keyboardType:keyboardType fontSize:n_fontSize];
    _textField.textColor = GrayRGB(50);

    [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self addSubview:_textField];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_leftTitleLabel.mas_right).mas_offset(5);
        make.height.mas_equalTo(normal_h);
    }];

}

-(void)textFieldChange:(UITextField *)textField {
    self.actionBlock ? self.actionBlock(textField.text) : nil;
}

//MARK: - textField delegate method
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_openLimitnumber) {
        NSInteger currentLength = textField.text.length;
        NSInteger rangeLength = range.length;
        NSInteger replaceLength = string.length;
        
        NSInteger result = currentLength - rangeLength + replaceLength;
        if (result > 11) {
            return NO;
        }
    }
    return YES;
}

//MARK: - -------------------------- forCash
-(void)forCash_setup:(NSString *)amount discountAmount:(NSString *)discountAmount currentAmount:(NSString *)currentAmount {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    
    CGFloat font_h = 30;
    
    UILabel *amountTitle = [UILabel createWithLeft:CGRectMake(15, 5, 70, font_h) title:amount titleColor:GrayRGB(80) font:14];
    [self addSubview:amountTitle];
    
    _centerLabel = [UILabel createWithCenter:CGRectMake((SCREEN_WIDTH-70)/2, 5, 70, font_h) title:discountAmount titleColor:GrayRGB(80) font:14];
    [self addSubview:_centerLabel];
    
    UILabel *currentTitle = [UILabel createWithRight:CGRectMake(SCREEN_WIDTH-100-15, 5, 100, font_h) title:currentAmount titleColor:GrayRGB(80) font:14];
    [self addSubview:currentTitle];
    
    CGFloat field_w = self.width/3;
    
    _l_textField = [UITextField createWithLeft:CGRectMake(amountTitle.x, amountTitle.bottom, field_w-15, 20) placeHolder:@"" keyboardType:UIKeyboardTypeDecimalPad fontSize:14];
    _l_textField.text = @"￥0.00";
    _l_textField.textColor = DXDA_FontColor;
    _l_textField.userInteractionEnabled = NO;
    [self addSubview:_l_textField];
    
    _c_textField = [UITextField createWithCenter:CGRectMake(_l_textField.right, amountTitle.bottom, field_w, 20) placeHolder:@"" keyboardType:UIKeyboardTypeDecimalPad fontSize:14];
    _c_textField.text = @"0.00";
    _c_textField.textColor = DXDA_FontColor;
    _c_textField.delegate = self;
    [self changeFrameAction:_c_textField];
    [_c_textField addTarget:self action:@selector(pay_textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self addSubview:_c_textField];
    
    _currencyLabel = [UILabel createWithRight:CGRectMake(_c_textField.left-15, _c_textField.y, 15, 20) title:@"￥" titleColor:DXDA_FontColor font:14];
    [self addSubview:_currencyLabel];
    
    _r_textField = [UITextField createWithRight:CGRectMake(SCREEN_WIDTH-field_w-15, amountTitle.bottom, field_w, 20) placeHolder:@"" keyboardType:UIKeyboardTypeDecimalPad fontSize:14];
    _r_textField.text = @"0.00";
    _r_textField.textColor = DXDA_DefaultColor;
    _r_textField.delegate = self;
    _r_textField.userInteractionEnabled = NO;
    [self changeFrameAction:_r_textField];
    [_r_textField addTarget:self action:@selector(pay_textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self addSubview:_r_textField];
    
    _currencyLabel2 = [UILabel createWithRight:CGRectMake(_r_textField.left-15, _r_textField.y, 15, 20) title:@"￥" titleColor:DXDA_DefaultColor font:14];
    [self addSubview:_currencyLabel2];
    
}
-(void)priceAndXishu
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [saveBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    saveBtn.backgroundColor = [UIColor orangeColor];
    saveBtn.layer.cornerRadius =2;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(priceAndXishuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveBtn];
    weak(self)
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.right.equalTo(weakSelf.mas_right).offset(-5);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(40);
    }];
    
    _r_textField = [UITextField createWithLeft:CGRectZero placeHolder:@"" keyboardType:UIKeyboardTypeDecimalPad fontSize:14];
    _r_textField.text = @"";
    _r_textField.textColor = UIColor.blackColor;
    _r_textField.font = [UIFont systemFontOfSize:13];
    [self addSubview:_r_textField];
    [_r_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(saveBtn.mas_left).offset(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
    
    UILabel *xiLab = [UILabel createWithLeft:CGRectZero title:@"系数：" titleColor:GrayRGB(80) font:14];
    [self addSubview:xiLab];
    [xiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.r_textField.mas_left).offset(0);
        make.width.mas_equalTo(50);
    }];
    
    UILabel *priceLab = [UILabel createWithLeft:CGRectZero title:@"价格：" titleColor:GrayRGB(80) font:14];
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];
    
    _l_textField = [UITextField createWithLeft:CGRectZero placeHolder:@"" keyboardType:UIKeyboardTypeDecimalPad fontSize:14];
    _l_textField.text = @"";
    _l_textField.textColor = UIColor.blackColor;
    _l_textField.userInteractionEnabled = NO;
    [self addSubview:_l_textField];
    [_l_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(xiLab.mas_left).offset(-5);
        make.height.mas_equalTo(20);
        make.left.equalTo(priceLab.mas_right).offset(0);
    }];
    
    
}
-(void)priceAndXishuBtnClick
{
    if (_r_textField.text.length == 0) {
        return;
    }
    self.actionBlock(_r_textField.text);
}

#pragma mark - textField delegate method
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%.2f",textField.text.doubleValue];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField selectAll:self];
}

-(void)pay_textFieldChange:(UITextField *)textField {
    [self changeFrameAction:textField];
    self.actionBlock2 ? self.actionBlock2 (_c_textField.text, _r_textField.text) : nil;
}



-(void)changeFrameAction:(UITextField *)textField {
    if (textField == _c_textField) {
        NSString *string = [NSString stringWithFormat:@"%@",[NSString formatNumberWith_AmountNumber:_c_textField.text.doubleValue]];
//        NSString *string = [NSString stringWithFormat:@"%.2f",_c_textField.text.doubleValue];
        CGSize size = [NSString calculateWith:string max:CGSizeMake(SCREEN_WIDTH/3, 20) fontSize:14];
        _c_textField.frame = CGRectMake((SCREEN_WIDTH-size.width)/2, 30+5, size.width, 20);
        _currencyLabel.x = _c_textField.left-15;
    }
    else if (textField == _r_textField) {
        NSString *string = [NSString stringWithFormat:@"%@",[NSString formatNumberWith_AmountNumber:_r_textField.text.doubleValue]];
//        NSString *string = [NSString stringWithFormat:@"%.2f",_r_textField.text.doubleValue];
        CGSize size = [NSString calculateWith:string max:CGSizeMake(SCREEN_WIDTH/3, 20) fontSize:14];
        _r_textField.frame = CGRectMake(SCREEN_WIDTH-size.width-15, 30+5, size.width, 20);
        _currencyLabel2.x = _r_textField.left-15;
    }
    
}

//MARK: - -------------------------- ViewType_site
- (void)textView_setup:(NSString *)title TextAlignment:(NSTextAlignment)TextAlignment
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 88);
    
    CGSize size = [DXDATools boundingRectWithFont:DXDA_font String:title size:CGSizeMake(200, 2000)];
    
    UILabel *titleLabel = [UILabel createWithLeft:CGRectMake(15, 0, size.width+10, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:titleLabel];
    self.leftTitleLabel = titleLabel;
    
    _mobNoLabel = [UILabel createWithRight:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, size.width+10, normal_h) title:@"" titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_mobNoLabel];
    [_mobNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-28);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
    }];
    
    _contactManLabel = [[UILabel alloc] init];
    _contactManLabel.font = DXDA_font;
    _contactManLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_contactManLabel];
    [_contactManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-_mobNoLabel.left-30);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
        make.left.mas_equalTo(size.width+30);
    }];
    
    _siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 44, self.width-CGRectGetMaxX(titleLabel.frame)-28, 40)];
    _siteLabel.font = [UIFont systemFontOfSize:n_fontSize];
    _siteLabel.numberOfLines = 2;
    _siteLabel.textAlignment = TextAlignment;
    [self addSubview:_siteLabel];
    
    _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查看"]];
    _rightArrow.frame = CGRectMake(self.width-18-5, (self.height-18)/2, 18, 18);
    [self addSubview:_rightArrow];
    
    UIButton *cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cellBtn.frame = self.bounds;
    [cellBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cellBtn];

}

//MARK: - -------------------------- ViewType_textView
-(void)textView_setup:(NSString *)title {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 145);
    
    title = title ? : @"内容";
    
    CGSize titleSize = [NSString calculateWith:title max:CGSizeMake(100, normal_h) fontSize:n_fontSize];
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, titleSize.width+10, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    _textView = [[DefineTextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.delegate = self;
    _textView.placeText = placeText;
    _textView.layer.borderColor = DXDA_LineColor.CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.cornerRadius = 5;
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(normal_h);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-5);
    }];
}


-(void)textView_setupNoTitle:(NSString *)title
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 145);
    _textView = [[DefineTextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.delegate = self;
    _textView.placeText = placeText;
    _textView.layer.borderColor = DXDA_LineColor.CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.cornerRadius = 5;
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-5);
    }];
}

//MARK: - -------------------------- ViewType_input
-(void)input_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 125);
    
    title = title ? : @"金额";
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 5, 200, 30) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    _currencyLabel = [UILabel createWithRight:CGRectMake(15, _leftTitleLabel.bottom+35, 20, 20) title:@"￥" titleColor:DXDA_FontColor font:18];
    [self addSubview:_currencyLabel];
    
    _l_textField = [UITextField createWithLeft:CGRectMake(_currencyLabel.right+15, _currencyLabel.bottom - 38, self.width-_currencyLabel.right-15, 42) placeHolder:text keyboardType:keyboardType fontSize:38];
    _l_textField.delegate = self;
    _l_textField.textColor = DXDA_DefaultColor;
    [_l_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self addSubview:_l_textField];
    
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(_currencyLabel.x, _currencyLabel.bottom+15, self.width-15*2, 1);
    lineLayer.backgroundColor = DXDA_LineColor.CGColor;
    [self.layer addSublayer:lineLayer];
}

//MARK: - -------------------------- ViewType_CRMTextView
-(void)CRMTextView_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 145);

    [self.layer addSublayer:self.crm_lineLayer];
    
    pointLabel = [UILabel createWithCenter:CGRectMake(10, 8, 25, 25) title:@"1" titleColor:[UIColor whiteColor] font:15];
    pointLabel.backgroundColor = DXDA_CRMColor;
    pointLabel.layer.cornerRadius = 25/2;
    pointLabel.clipsToBounds = YES;
    [self addSubview:pointLabel];
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(pointLabel.right + 10, 11, SCREEN_WIDTH - pointLabel.right - 20, 20) title:title titleColor:DXDA_CRMColor font:15];
    [self addSubview:_leftTitleLabel];
    
    CGFloat bottom = _leftTitleLabel.bottom + 3;
    
    if (_viewType == ViewType_CRMTextView_effect) {
        NSArray *effectAry = @[@"好", @"中", @"差"];
        
        CGFloat btn_w = 55;
        CGFloat btn_h = 30;
        
        for (NSInteger i = 0; i < effectAry.count; i++) {
            NSString *string = effectAry[i];
            UIButton *e_button = [UIButton buttonWithType:UIButtonTypeCustom];
            e_button.frame = CGRectMake(_leftTitleLabel.x + (btn_w + 10)*i, _leftTitleLabel.bottom + 5, btn_w, btn_h);
            e_button.titleLabel.font = [UIFont systemFontOfSize:14];
            [e_button setTitle:string forState:UIControlStateNormal];
            [e_button setTitleColor:DXDA_CRM_G_textColor forState:UIControlStateNormal];
            e_button.layer.borderColor = DXDA_CRM_G_textColor.CGColor;
            e_button.layer.borderWidth = 1;
            e_button.layer.cornerRadius = 3;
            e_button.clipsToBounds = YES;
            e_button.tag = effectTag + i;
            [e_button addTarget:self action:@selector(effectAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:e_button];
            
            bottom = e_button.bottom + 8;
        }
        
    }
    
    _textView = [[DefineTextView alloc] initWithFrame:CGRectMake(_leftTitleLabel.left - 5, bottom, _leftTitleLabel.width, 100)];
//    _textView = [[DefineTextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.text = text;
    _textView.placeText = placeText;
    _textView.delegate = self;
    _textView.textColor = GrayRGB(200);
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = DXDA_LineColor.CGColor;
    _textView.layer.borderWidth = 1;
    [self addSubview:_textView];
    
    self.height = _textView.bottom + 10;
}

//MARK: - 按钮action
- (void)effectAction:(UIButton *)sender {
    [self changeColorAction:sender.tag - effectTag];
    !self.effectBlokc ? : self.effectBlokc(sender.tag - effectTag + 1);
}


//MARK: - 改变按钮颜色
- (void)changeColorAction:(NSInteger)index {    
    for (NSInteger i = effectTag; i < effectTag + 3; i++) {
        UIButton *e_button = [self viewWithTag:i];
        BOOL isChange = e_button.tag == index + effectTag;
        [e_button setTitleColor:isChange ? [UIColor whiteColor] : DXDA_CRM_G_textColor forState:UIControlStateNormal];
        e_button.layer.borderColor = isChange ? DXDA_CRMColor.CGColor :  DXDA_CRM_G_textColor.CGColor;
        e_button.backgroundColor = isChange ? DXDA_CRMColor : [UIColor whiteColor];
    }
}


- (void)changePointCount:(NSInteger)count {
    pointLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
}

- (void)setLineMode:(CRMTextViewLineMode)lineMode {
    switch (lineMode) {
        case CRMTextViewLineMode_up:
            [self showUpLineAction];
            break;
        case CRMTextViewLineMode_down:
            [self showDownLineAction];
            break;
        case CRMTextViewLineMode_all:
            [self showAllLineAction];
            break;
        case CRMTextViewLineMode_hide:
            [self hideLineAction];
            break;
            
        default:
            break;
    }
}

- (void)showUpLineAction {
    CGFloat x = (pointLabel.width-3)/2 + 10;
    _crm_lineLayer.frame = CGRectMake(x, 0, 3, pointLabel.top);
}

- (void)showDownLineAction {
    CGFloat x = (pointLabel.width-3)/2 + 10;
    _crm_lineLayer.frame = CGRectMake(x, pointLabel.bottom, 3, _textView.bottom + 10 + 5);
}

- (void)showAllLineAction {
    CGFloat x = (pointLabel.width-3)/2 + 10;
    _crm_lineLayer.frame = CGRectMake(x, 0, 3, _textView.bottom + 10 + 5);
}

- (void)hideLineAction {
    [_crm_lineLayer removeFromSuperlayer];
}

- (CALayer *)crm_lineLayer {
    if (!_crm_lineLayer) {
        _crm_lineLayer = [CALayer layer];
        _crm_lineLayer.backgroundColor = DXDA_CRMColor.CGColor;
    }
    return _crm_lineLayer;
}

//MARK: - -------------------------- ViewType_CRMRemarkView
-(void)CRMRemarkView_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 135);

    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 11, SCREEN_WIDTH - pointLabel.right - 20, 20) title:title titleColor:DXDA_CRM_G_textColor font:15];
    [self addSubview:_leftTitleLabel];
    
    _textView = [[DefineTextView alloc] initWithFrame:CGRectMake(_leftTitleLabel.left - 5, _leftTitleLabel.bottom + 3, _leftTitleLabel.width, 100)];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.text = text;
    _textView.placeText = placeText;
    _textView.delegate = self;
    _textView.textColor = GrayRGB(200);
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = DXDA_LineColor.CGColor;
    _textView.layer.borderWidth = 1;
    
    [self addSubview:_textView];
    
    self.height = _textView.bottom + 10;
}

-(void)selAndWriteAddr_setup:(NSString *)title text:(NSString *)text keyboardType:(UIKeyboardType)keyboardType
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 135);
    
    CGSize size1 = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:n_fontSize] String:title size:CGSizeMake(200, 2000)];
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, size1.width + 5, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"查看"]];
    _rightArrow.frame = CGRectMake(self.width-18-5, (normal_h-18)/2, 18, 18);
    [self addSubview:_rightArrow];
    
    CGFloat text_w = self.width-CGRectGetMaxX(_leftTitleLabel.frame)-5-_rightArrow.width-5-5;
    _textField = [UITextField createWithRight:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame)+5, 0, text_w, normal_h) placeHolder:@"省市区" keyboardType:keyboardType fontSize:n_fontSize];
    _textField.textColor = GrayRGB(50);
    _textField.userInteractionEnabled = NO;
    [self addSubview:_textField];
    
    UIButton *cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cellBtn.frame = self.bounds;
    [cellBtn addTarget:self action:@selector(chooseAreaPickerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cellBtn];
    
    _textView = [[DefineTextView alloc] initWithFrame:CGRectMake(15, normal_h + 3, (SCREEN_WIDTH - 30), 60)];
    _textView.font = [UIFont systemFontOfSize:14];
//    _textView.text = text;
    _textView.placeText = placeText;
    _textView.delegate = self;
    _textView.textColor = GrayRGB(200);
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = DXDA_LineColor.CGColor;
    _textView.layer.borderWidth = 1;
    [self addSubview:_textView];
    
    self.height = _textView.bottom + 10;
}
-(void)chooseAreaPickerAction
{
    weak(self)
    [KKAreaPicker showPickerWithTitle:@"省市区选择" pickerType:KKAreaPickerTypeProviceCityArea defaultValue:nil onCancel:^(KKAreaPicker *picker) {
        
    } onCommit:^(KKAreaPicker *picker, KKAdrress *address) {
        NSString *str = @"";
        if (address.area.length != 0) {
            str = [NSString stringWithFormat:@"%@%@%@",address.provice,address.city,address.area];
        } else {
            str = [NSString stringWithFormat:@"%@%@",address.provice,address.city];
        }
        weakSelf.textView.text = [NSString stringWithFormat:@"%@%@",weakSelf.textView.text,str];
        weakSelf.actionBlock ? weakSelf.actionBlock(weakSelf.textView.text) : nil;
    }];
}



//MARK: - -------------------------- ViewType_TypeTitle
-(void)TypeTitle_setup:(NSString *)title {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    
    UILabel *makeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 5, 20)];
    makeLabel.backgroundColor = DXDA_DefaultColor;
    [self addSubview:makeLabel];
    
    _titleLabel = [UILabel createWithLeft:CGRectMake(15, 0, self.width-15*2, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_titleLabel];
    
}
-(void)textFieldAndScan:(NSString *)title
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    CGSize size1 = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:n_fontSize] String:title size:CGSizeMake(200, 2000)];
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 3, size1.width + 5, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"扫码"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(scanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _scanBtn = btn;
    btn.frame = CGRectMake(SCREEN_WIDTH-10-26, 12, 26, 26);
    [self addSubview:btn];
    
    CGFloat text_w = (SCREEN_WIDTH - 10 - 26) - CGRectGetMaxX(_leftTitleLabel.frame)-5;
    _textField = [UITextField createWithRight:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame)+5, 5, text_w, 40) placeHolder:@"" keyboardType:UIKeyboardTypeDefault fontSize:n_fontSize];
    _textField.textColor = UIColor.blackColor;
    _textField.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 1)];
    _textField.rightViewMode = UITextFieldViewModeAlways;
    [self addSubview:_textField];
//    [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    _textField.layer.borderColor = DXDA_LineColor.CGColor;
    _textField.layer.borderWidth = 1;
    _textField.layer.cornerRadius = 3;
    _textField.layer.masksToBounds = YES;
}
-(void)scanBtnClick:(UIButton *)button
{
    // 实例化扫描控制器
    weak(self)
    UIImage *avatar = [UIImage imageNamed:@"avatar"];
    HMScannerController *scanner = [HMScannerController scannerWithCardName:@"" avatar:avatar completion:^(NSString *stringValue) {
        NSLog(@"物料代号");
        _textField.text = stringValue;
         weakSelf.actionBlock ? weakSelf.actionBlock(stringValue) : nil;
    }];
    // 设置导航栏样式
    [scanner setTitleColor:DXDA_DefaultColor tintColor:[UIColor whiteColor]];
    // 展现扫描控制器
    [[UIResponder returnController] showDetailViewController:scanner sender:nil];
}

-(void)textFieldAndBtn:(NSString *)title
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    CGSize size1 = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:n_fontSize] String:title size:CGSizeMake(200, 2000)];
    
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, size1.width + 5, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
    [self addSubview:_leftTitleLabel];
 
       
       UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
       [btn setImage:[UIImage imageNamed:@"电话-(3)"] forState:UIControlStateNormal];
       [btn addTarget:self action:@selector(fabtnClick:) forControlEvents:UIControlEventTouchUpInside];
       _scanBtn = btn;
       btn.frame = CGRectMake(SCREEN_WIDTH-10-26, 7, 26, 26);
       [self addSubview:btn];
       
       CGFloat text_w = (SCREEN_WIDTH - 10 - 26) - CGRectGetMaxX(_leftTitleLabel.frame)-5;
       _textField = [UITextField createWithRight:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame)+5, 0, text_w, 44) placeHolder:@"" keyboardType:UIKeyboardTypeNumberPad fontSize:n_fontSize];
       _textField.textColor = UIColor.blackColor;
       [self addSubview:_textField];
    _textField.userInteractionEnabled = NO;
       
}

-(void)ViewType_twoSelectBtn:(NSString *)title text:(NSString *)text
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, normal_h);
    NSArray *arr = [text componentsSeparatedByString:@" "];
    NSString *y = arr.firstObject;
    NSString *n = arr.lastObject;
     CGSize size1 = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:n_fontSize] String:y size:CGSizeMake(200, 2000)];
     CGSize size2 = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:n_fontSize] String:n size:CGSizeMake(200, 2000)];
    UILabel *tY = [UILabel new];
    tY.text = y;
    tY.frame = CGRectMake(SCREEN_WIDTH - 15-size1.width, 0, size1.width, normal_h);
    tY.font = [UIFont systemFontOfSize:n_fontSize];
    tY.textColor = Dark_TextColor;
    [self addSubview:tY];
    _chooseTitleY = tY;
    
    UIButton *yBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yBtn.tag =1;
    yBtn.frame = CGRectMake(CGRectGetMinX(tY.frame)-5-20, 12, 20, 20);
    [yBtn setImage:[UIImage imageNamed:@"login_select_not"] forState:UIControlStateNormal];
    [yBtn setImage:[UIImage imageNamed:@"rigister_select"] forState:UIControlStateSelected];
    [yBtn addTarget:self action:@selector(twoBtnViewClick:) forControlEvents:UIControlEventTouchUpInside];
    _chooseBtnY = yBtn;
    [self addSubview:yBtn];
    
    UILabel *NY = [UILabel new];
    NY.text = n;
    NY.frame = CGRectMake(CGRectGetMinX(yBtn.frame)-15-size2.width, 0, size2.width, normal_h);
    NY.font = [UIFont systemFontOfSize:n_fontSize];
    NY.textColor = Dark_TextColor;
    [self addSubview:NY];
    _chooseTitleN = NY;
    
    UIButton *Nbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    Nbtn.tag = 2;
    Nbtn.frame = CGRectMake(CGRectGetMinX(NY.frame)-5-20, 12, 20, 20);
    [Nbtn setImage:[UIImage imageNamed:@"login_select_not"] forState:UIControlStateNormal];
    [Nbtn setImage:[UIImage imageNamed:@"rigister_select"] forState:UIControlStateSelected];
    [Nbtn addTarget:self action:@selector(twoBtnViewClick:) forControlEvents:UIControlEventTouchUpInside];
    _chooseBtnN = Nbtn;
    [self addSubview:Nbtn];
    
     CGSize size = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:n_fontSize] String:title size:CGSizeMake(200, 2000)];
    _leftTitleLabel = [UILabel createWithLeft:CGRectMake(15, 0, size.width + 5, normal_h) title:title titleColor:GrayRGB(50) font:n_fontSize];
       [self addSubview:_leftTitleLabel];
}
-(void)twoBtnViewClick:(UIButton *)button
{
    if (button.tag == 1) {
        if (_chooseBtnY.isSelected) {
        }else{
            _chooseBtnY.selected = YES;
            _chooseBtnN.selected = NO;
        }
    }else{
        if (_chooseBtnN.isSelected) {
        }else{
            _chooseBtnN.selected = YES;
            _chooseBtnY.selected = NO;
        }
    }
    if (_chooseBtnY.isSelected) {
        self.actionBlock ? self.actionBlock(@"1"):nil;
    }else{
        self.actionBlock ? self.actionBlock(@"0"):nil;
    }
}


-(void)fabtnClick:(UIButton *)button
{
    self.actionBlock ? self.actionBlock(@"") : nil;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.textColor = Dark_TextColor;
    if ([textView.text isEqualToString:placeText]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.text = placeText;
        textView.textColor = [UIColor setLightColor:GrayRGB(200) darkColor:UIColor.whiteColor] ;
    }
}

- (void)upView:(DXDACellViewFactory *)upview height:(CGFloat)hetight
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(upview.mas_bottom).mas_offset(hetight);
        make.height.mas_equalTo(self.height);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void)upDataUpView:(DXDACellViewFactory *)upview height:(CGFloat)hetight
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(upview.mas_bottom).mas_offset(hetight);
        make.height.mas_equalTo(self.height);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void)updateForNewNormalType:(NSString *)text handle:(void(^)(CGFloat height))handle
{
    CGSize size1 = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:15] String:self.leftTitleLabel.text size:CGSizeMake(200, 2000)];
//    CGSize size = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:15] String:text size:CGSizeMake(self.rightLabel.width, 2000)];
    CGSize size = [DXDATools boundingRectWithFont:[UIFont systemFontOfSize:15] String:text size:CGSizeMake(SCREEN_WIDTH - size1.width - 50, 2000)];
    CGFloat selfH = MAX(44,size.height+10);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(selfH);
    }];
    
    _rightLabel.text = text.length > 0 ? text : placeText;
    _rightLabel.textColor = text.length > 0 ? [UIColor blackColor] : GrayRGB(215);
    [_rightLabel layoutIfNeeded];
    !handle ? : handle(self.height);
}

@end

@implementation DefineTextView

- (void)setText:(NSString *)text {
    [super setText:text];
    self.textColor = [text isEqualToString:_placeText] ? GrayRGB(200) : [UIColor blackColor];
}

@end
