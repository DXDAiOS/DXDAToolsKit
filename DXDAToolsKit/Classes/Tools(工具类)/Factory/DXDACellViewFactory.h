//
//  DXDACellViewFactory.h
//  NewApp3.0
//
//  Created by DXDA on 2017/7/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXDACZDatePickerView.h"
#import "DXDACalendarPickerView.h"

/**
 CRMTextViewLineMode 线的样式

 - CRMTextViewLineMode_up: 显示 上 line
 - CRMTextViewLineMode_down: 显示 下 line
 - CRMTextViewLineMode_all: 显示 一整条 line
 - CRMTextViewLineMode_hide: 隐藏 line
 */
typedef NS_ENUM(NSInteger, CRMTextViewLineMode) {
    CRMTextViewLineMode_up,
    CRMTextViewLineMode_down,
    CRMTextViewLineMode_all,
    CRMTextViewLineMode_hide,
};

/*
  ViewType_normal 点击类型 例：选择客户
  ViewType_site 地址类型 例:收获地址
 
 */

typedef NS_ENUM(NSInteger, ViewType) {
    ViewType_textField = 0,
    ViewType_normal,
    ViewType_singleTitle,
    ViewType_date,
    ViewType_calendar,
    ViewType_emptyItem,
    ViewType_addItem,
    ViewType_addItem_Gx,
    ViewType_addItem_Cl,
    ViewType_remark,
    ViewType_remarkAutoHeight,
    ViewType_sumItem,
    ViewType_headItem,
    ViewType_noticeHeadItem,
    ViewType_forCash,
    ViewType_siteView,
    ViewType_textView,
    ViewType_textViewNoTitle,
    ViewType_input,
    ViewType_CRMTextView,
    ViewType_CRMTextView_effect,
    ViewType_CRMRemarkView,
    ViewType_writeAndChoose,
    ViewType_newNormal,
    ViewType_TypeTitle,
    ViewType_SelAndWriteAddr,
    ViewType_textFieldAndSelect,
    ViewType_QuetoYiYuanXiShu,
    ViewType_textFieldAndScan,
    ViewType_textFieldAndBtn,
    ViewType_twoSelectBtn,
    ViewType_Switch,
    ViewType_textFieldAutoHeight,//自适应高度
};


@interface DefineTextView : UITextView

@property (nonatomic, copy) NSString *placeText;

@end

@interface DXDACellViewFactory : UIView

+(instancetype)createWith:(ViewType)type
                    title:(NSString *)title
              placeHolder:(NSString *)text
             keyboardType:(UIKeyboardType)keyboardType
             buttonAction:(void(^)(NSString *text))buttonAction;

// 收付款专用
+(instancetype)createWithForCashPaymentType:(ViewType)type
                                       left:(NSString *)left
                                     center:(NSString *)center
                                      right:(NSString *)right
                               buttonAction:(void(^)(NSString *text, NSString *text2))buttonAction;

-(void)changeFrameAction:(UITextField *)textField;

//MARK: - normalType 更新内容
- (void)updateForNormalType:(NSString *)text handle:(void(^)(CGFloat height))handle;

//MARK: - 自适应视图 (上层视图)
- (void)upView:(DXDACellViewFactory *)upview height:(CGFloat)hetight;
//MARK: - 更新自适应视图 (上层视图)
- (void)upDataUpView:(DXDACellViewFactory *)upview height:(CGFloat)hetight;
//MARK: - 更新内容和高度
- (void)updateForNewNormalType:(NSString *)text handle:(void(^)(CGFloat height))handle;


#pragma mark - 改变 pickerView UIDatePickerMode
- (void)changePickerDateMode:(UIDatePickerMode)mode;
- (void)changeMiniDate:(NSString *)string;      // 改变最小日期
- (void)changeMaxDate:(NSString *)string;       // 改变最大日期
- (void)changeCalendarMinDate:(BOOL)boo;

// CRM method
- (void)showUpLineAction;
- (void)showDownLineAction;
- (void)showAllLineAction;
- (void)hideLineAction;
- (void)changePointCount:(NSInteger)count;
//MARK: - 改变按钮颜色
- (void)changeColorAction:(NSInteger)index;

//根据bool值，判断是选择还输入；
-(void)viewIsChoose:(BOOL)isChoose;
-(void)updateAutoTextViewText:(NSString *)text;

@property (nonatomic, assign) BOOL isEffect;     // for CRM 拜访总结 是否
@property (nonatomic,copy) void(^effectBlokc)(NSInteger self_point);

@property (nonatomic, assign) CRMTextViewLineMode lineMode;

// 调用时间
@property (nonatomic,copy) void(^actionBlock)(NSString *text);

// 临时
@property (nonatomic,copy) void(^btnBlock)(void);

// 来自按钮
@property (nonatomic,copy) void(^sourceBtnBlock)(void);
@property (nonatomic, strong)void(^addItemViewTagBlock)(void);

// 编辑按钮
@property (nonatomic,copy) void(^editBtnBlock)(UIButton *sender);

@property (nonatomic,strong) UILabel *rightLabel;       // for newNormal

@property (nonatomic, strong) UISwitch *swi;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *sumOrderLabel;
@property (nonatomic,strong) UILabel *addItemTitle;
@property (nonatomic,strong) UILabel *headStateLabel;
@property (nonatomic,strong) UILabel *blockChainLabel;
@property (nonatomic,strong) UILabel *rightDateLabel;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITextView *remarkField;
@property (nonatomic,strong) UILabel *mobNoLabel;
@property (nonatomic,strong) UILabel *contactManLabel;
@property (nonatomic,strong) UILabel *siteLabel;
@property (nonatomic,strong) UIButton *emptyAddGoodsBtn;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic,strong) DXDACZDatePickerView *datePickerView;
@property (nonatomic, strong) DXDACalendarPickerView *calenderPickerView;

@property (nonatomic,strong) UIImageView *rightArrow;  // 箭头
@property (nonatomic,strong)UIButton *cellBtn;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *sourceBtn;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UIButton *scanBtn;

@property (nonatomic,strong) UIButton *chooseBtnY;
@property (nonatomic,strong) UIButton *chooseBtnN;
@property (nonatomic,strong) UILabel *chooseTitleN;
@property (nonatomic,strong) UILabel *chooseTitleY;
/// 内容textView
@property (nonatomic,strong) DefineTextView *textView;

@property (nonatomic,assign) BOOL openLimitnumber;  // 是否打开手机号限制输入

// for cash payment
@property (nonatomic,strong) UILabel *centerLabel;
@property (nonatomic,strong) UITextField *l_textField;
@property (nonatomic,strong) UITextField *r_textField;
@property (nonatomic,strong) UITextField *c_textField;
@property (nonatomic,strong) UILabel *currencyLabel;
@property (nonatomic,strong) UILabel *currencyLabel2;

@property (nonatomic, assign) NSInteger maxFontNum; //最大输入限制

@property (nonatomic, assign)BOOL isAdaptiveTextView;

@property (nonatomic,copy) NSAttributedString *sumAttributeStr;

@property (nonatomic, assign) CGFloat initHeight;
@property (nonatomic, strong) UITextView *autoTextView;
@property (nonatomic, strong) UILabel *placeholderLabel;


@end
