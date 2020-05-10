//
//  DXDARedNumLabel.m
//  NewApp3.0
//
//  Created by Erowin on 16/10/25.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "DXDARedNumLabel.h"

@implementation DXDARedNumLabel

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect newRect = CGRectMake(frame.origin.x, frame.origin.y, 18, 18);
    if (self=[super initWithFrame:newRect])
    {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat mini = [self miniSizeWithRect:self.frame];
    
    [[UIColor redColor] set];
    
    CGContextAddArc(context, mini*0.5, mini*0.5, mini*0.5, 0, 2*M_PI, 0);
    
    CGContextFillPath(context);
    
    [super drawRect:rect];
}

-(CGFloat)miniSizeWithRect:(CGRect )rect
{
    CGFloat mini = rect.size.height < rect.size.width ? rect.size.height:rect.size.width;
    return mini;
}


@end
