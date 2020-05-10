//
//  DXDLineLabel.m
//  RxdaApp
//
//  Created by 东信达 on 16/6/1.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import "DXDLineLabel.h"

@implementation DXDLineLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置颜色
    [self.textColor setStroke];
    // 画线
    CGFloat y = rect.size.height * 0.5;
    CGContextMoveToPoint(ctx, 0, y);
    
    CGFloat endX = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}].width;
    CGContextAddLineToPoint(ctx, endX, y);
    
    // 渲染
    CGContextStrokePath(ctx);
}


@end
