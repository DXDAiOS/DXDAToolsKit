//
//  UIView+CHViewExel.m
//
//  Created by Freedom on 16/5/16.
//  Copyright © 2016年 Freedom. All rights reserved.
//

#import "UIView+CHViewExel.h"

@implementation UIView (CHViewExel)


-(void)setX:(CGFloat)x
{
   CGRect frame = self.frame;
    
    frame.origin.x=x;
    
    self.frame=frame;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}


-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    
    frame.origin.y=y;
    
    self.frame=frame;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    
    frame.size.height=height;
    
    self.frame=frame;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setWeiht:(CGFloat)weiht
{
    CGRect frame = self.frame;
    
    frame.size.width=weiht;
    
    self.frame=frame;
}

-(CGFloat)weiht
{
    return self.frame.size.width;
}



// ccz add property
-(void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame=frame;
}

-(CGFloat)width {
    return self.frame.size.width;
}

-(void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    
    frame.origin.y = bottom;
    
    self.frame = frame;
}

-(CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

-(void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    
    frame.origin.y = top;
    
    self.frame = frame;
}

-(CGFloat)top {
    return self.frame.origin.y;
}

-(void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    
    frame.origin.x = right;
    
    self.frame = frame;
}

-(CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

-(void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    
    frame.origin.x = left;
    
    self.frame = frame;
}

-(CGFloat)left {
    return self.frame.origin.x;
}

@end
