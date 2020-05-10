//
//  DXDAzpDatePickView.h
//  x_App
//
//  Created by DXDA on 2018/7/4.
//  Copyright © 2018年 SimpleTable. All rights reserved.
//

typedef enum : NSInteger {
    week,
    month
} zpDatePickType;

#import <UIKit/UIKit.h>
#import "DXDAzpDateModel.h"

@interface DXDAzpDatePickView : UIView

+(instancetype)create:(zpDatePickType)type confireBlock:(void(^)(NSString *startdate,NSString *enddate))confireBlock cancel:(void(^)(void))cancelBlock;

-(void)showPickerView;

@end
