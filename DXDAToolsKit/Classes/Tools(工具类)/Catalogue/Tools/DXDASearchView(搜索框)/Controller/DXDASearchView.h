//
//  DXDASearchView.h
//  NewApp3.0
//
//  Created by DXDA on 2020/1/6.
//  Copyright © 2020 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXDASearchHistoryView.h"


NS_ASSUME_NONNULL_BEGIN

@interface DXDASearchView : UIView
+(instancetype)createWithFrame:(CGRect)frame superView:(UIView *)superView isScan:(BOOL)isScan placeholder:(NSString *)placeholder isHistoryView:(BOOL)isHistoryView searchAction:(void(^)(NSString *text))searchAction;

@property (nonatomic, strong)UIView *superView;
@property (nonatomic, assign)BOOL isScan;
@property (nonatomic, assign)BOOL isHistoryView;
@property (nonatomic, strong)UITextField *searTextField;
@property (nonatomic, strong)NSString *placeholder;

@property (nonatomic, strong)DXDASearchHistoryView *historyView;
@end

NS_ASSUME_NONNULL_END
