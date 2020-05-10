//
//  DXDABubbleView.h
//  x_App
//
//  Created by 东信达 on 2017/7/4.
//  Copyright © 2017年 SimpleTable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXDABubbleView : UIView

+ (DXDABubbleView *)createWith:(NSArray *)titlaArr click:(void(^)(UIButton *but))but;

-(void)showPopoverView;

-(void)hidePopoverView;

-(void)remove;

@end
