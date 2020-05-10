//
//  DXDAzpDateModel.h
//  NewApp3.0
//
//  Created by DXDA on 2018/7/5.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDAzpDateModel : NSObject

@property (nonatomic, assign) NSInteger defaultWeek; // 当前是第几周
@property (nonatomic, assign) NSInteger defaultMonth;// 当前是第几月

- (NSArray *)getAllWeekDate;

- (NSArray *)getAllMonthDate;

@end
