//
//  DXDABottomLineBtn.m
//  NewApp3.0
//
//  Created by Erowin on 16/12/7.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "DXDABottomLineBtn.h"

@implementation DXDABottomLineBtn


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 2);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 70.0 / 255.0, 241.0 / 255.0, 241.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, self.frame.size.height);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);   //终点坐标
    
    CGContextStrokePath(context);
}


@end
