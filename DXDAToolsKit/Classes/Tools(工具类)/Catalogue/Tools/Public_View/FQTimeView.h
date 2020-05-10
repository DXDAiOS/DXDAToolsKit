//
//  FQTimeView.h
//  TeXFG
//
//  Created by Erowin on 16/9/14.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FQTimeView;

@protocol FQTimeViewDelegate <NSObject>
/**
 *  点击事件
 */
-(void)timeViewBtnClikWithView:(FQTimeView *)timeView;

@end

@interface FQTimeView : UIView

@property(nonatomic,weak)id<FQTimeViewDelegate> delegate;
/**
 *  停止计时
 */
-(void)stopTimeRun;
/**
 *  开始计时
 */
-(void)beganTimeRun;

@end
