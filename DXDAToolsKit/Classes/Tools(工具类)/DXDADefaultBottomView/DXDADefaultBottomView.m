//
//  DXDADefaultBottomView.m
//  x_App
//
//  Created by DXDA on 2018/1/23.
//  Copyright © 2018年 SimpleTable. All rights reserved.
//

#import "DXDADefaultBottomView.h"

@interface DXDADefaultBottomView ()

@property (nonatomic, copy) void(^buttonBlock)(NSInteger index, NSString *title);
@property (nonatomic, strong)NSString *type;
@end

static NSInteger const btnTag = 20000;

@implementation DXDADefaultBottomView
{
    NSArray<NSDictionary *> *titleArray;
}

+ (instancetype)createWithArray:(NSArray<NSDictionary *> *)array
                         action:(void(^)(NSInteger index, NSString *title))action {
    return [[self alloc] initWithArray:array action:action];
}
+ (instancetype)createWithArray2:(NSArray<NSDictionary *> *)array action:(void(^)(NSInteger index, NSString *title))action
{
     return [[self alloc] initWithArray2:array action:action];
}

- (instancetype)initWithArray:(NSArray<NSDictionary *> *)array
                       action:(void(^)(NSInteger index, NSString *title))action {
    if (self = [super init]) {
        titleArray = array;
        [self setup];
        
        [self setButtonBlock:^(NSInteger index, NSString *title) {
            !action ? : action(index, title);
        }];
    }
    return self;
}
- (instancetype)initWithArray2:(NSArray<NSDictionary *> *)array
                       action:(void(^)(NSInteger index, NSString *title))action {
    if (self = [super init]) {
        titleArray = array;
        [self setup2];
        
        [self setButtonBlock:^(NSInteger index, NSString *title) {
            !action ? : action(index, title);
        }];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = Dark_BackgroudColor;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    if (titleArray.count == 0) {
        return;
    }
    self.type = @"1";
    [self initButtonAction];
}
- (void)setup2 {
    self.backgroundColor = Dark_BackgroudColor;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    if (titleArray.count == 0) {
        return;
    }
    self.type = @"2";
    [self initButtonAction2];
}
- (void)initButtonAction {

    NSMutableArray *tempArray = [NSMutableArray array];
    
//     CGFloat btnW = (SCREEN_WIDTH-(titleArray.count+1)*10)/titleArray.count;
    
    for (int i = 0; i < titleArray.count; i++) {
        if (![titleArray[i] isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary *dic = titleArray[i];
        NSString *title = dic[@"title"];
        ButtonUseType type = [dic[@"type"] integerValue];
        
        CGSize size = [NSString calculateWith:title max:CGSizeMake(200, 35) fontSize:14];

        CGFloat btn_w = MAX(70, size.width + 20);
        CGFloat btn_h = 35;
        CGFloat btn_y = (self.height-btn_h)/2;
        CGFloat btn_x = self.width - btn_w - 15;
        [tempArray addObject:@(btn_x)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        button.frame = CGRectMake(((i+1)*10+(i)*btnW), 5, btnW, 40);
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 5;
        button.layer.borderWidth = 1;
        button.clipsToBounds = YES;
        button.backgroundColor = DXDA_DefaultColor;
        button.tag = btnTag + i;
        button.userInteractionEnabled = YES;
        if (i == 0) {
            button.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
        }
        else {
            CGFloat x = [tempArray[i-1] doubleValue];
            button.frame = CGRectMake(x - (btn_w + 10)*i, btn_y, btn_w, btn_h);
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        switch (type) {
            case ButtonUseType_normal:
            {
                button.backgroundColor = [UIColor setLightColor:[UIColor whiteColor] darkColor:RGB(89, 89, 89)];
                [button setTitleColor:DXDA_DefaultColor forState:UIControlStateNormal];
                button.layer.borderColor = DXDA_DefaultColor.CGColor;
            }
                break;
            case ButtonUseType_unuseful:
            {
                button.backgroundColor = [UIColor setLightColor:[UIColor whiteColor] darkColor:RGB(89, 89, 89)];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor grayColor].CGColor;
                button.userInteractionEnabled = NO;
            }
                break;
            case ButtonUseType_speacific:
            {
                button.backgroundColor = DXDA_DefaultColor;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.layer.borderColor = DXDA_DefaultColor.CGColor;
            }
                break;
                
            default:
                break;
        }
        
        [self addSubview:button];
    }
}
- (void)initButtonAction2 {

//    NSMutableArray *tempArray = [NSMutableArray array];
    
     CGFloat btnW = (SCREEN_WIDTH-(titleArray.count+1)*10)/titleArray.count;
    
    for (int i = 0; i < titleArray.count; i++) {
        if (![titleArray[i] isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary *dic = titleArray[i];
        NSString *title = dic[@"title"];
        ButtonUseType type = [dic[@"type"] integerValue];
        
//        CGSize size = [NSString calculateWith:title max:CGSizeMake(200, 35) fontSize:14];
//
//        CGFloat btn_w = MAX(70, size.width + 20);
//        CGFloat btn_h = 35;
//        CGFloat btn_y = (self.height-btn_h)/2;
//        CGFloat btn_x = self.width - btn_w - 15;
//        [tempArray addObject:@(btn_x)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(((i+1)*10+(i)*btnW), 5, btnW, 40);
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 5;
        button.layer.borderWidth = 1;
        button.clipsToBounds = YES;
        button.backgroundColor = DXDA_DefaultColor;
        button.tag = btnTag + i;
        button.userInteractionEnabled = YES;
//        if (i == 0) {
//            button.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
//        }
//        else {
//            CGFloat x = [tempArray[i-1] doubleValue];
//            button.frame = CGRectMake(x - (btn_w + 10)*i, btn_y, btn_w, btn_h);
//        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        switch (type) {
            case ButtonUseType_normal:
            {
                button.backgroundColor = [UIColor setLightColor:[UIColor whiteColor] darkColor:RGB(89, 89, 89)];
                [button setTitleColor:DXDA_DefaultColor forState:UIControlStateNormal];
                button.layer.borderColor = DXDA_DefaultColor.CGColor;
            }
                break;
            case ButtonUseType_unuseful:
            {
                button.backgroundColor = [UIColor setLightColor:[UIColor whiteColor] darkColor:RGB(89, 89, 89)];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor grayColor].CGColor;
                button.userInteractionEnabled = NO;
            }
                break;
            case ButtonUseType_speacific:
            {
                button.backgroundColor = DXDA_DefaultColor;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.layer.borderColor = DXDA_DefaultColor.CGColor;
            }
                break;
                
            default:
                break;
        }
        
        [self addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)sender {
    NSInteger index = sender.tag - btnTag;
    !self.buttonBlock ? : self.buttonBlock(index, sender.currentTitle);
}

- (void)changeButtonData:(NSArray<NSDictionary *> *)array {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    titleArray = array;
    if ([self.type isEqualToString:@"1"]) {
        [self initButtonAction];
    }else if([self.type isEqualToString:@"2"]){
        [self initButtonAction2];
    }
    
}

- (void)changeButtonType:(NSArray<NSNumber *> *)array {
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [self viewWithTag:btnTag + array[i].integerValue];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:DXDA_DefaultColor forState:UIControlStateNormal];
        button.layer.borderColor = DXDA_DefaultColor.CGColor;
        button.layer.borderWidth = 1;
    }
}

@end
