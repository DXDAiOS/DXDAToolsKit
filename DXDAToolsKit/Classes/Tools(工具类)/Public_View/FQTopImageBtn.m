//
//  FQTopImageBtn.m
//  NewApp3.0
//
//  Created by Erowin on 16/12/28.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "FQTopImageBtn.h"

@interface FQTopImageBtn ()


@end

@implementation FQTopImageBtn

-(void)setType
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    [self.titleLabel sizeToFit];
    CGRect rect = self.imageView.frame;
    rect.origin.x = (self.frame.size.width-self.imageView.frame.size.width)*0.5;
    rect.origin.y =0;
    
    self.imageView.frame = rect;
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = (self.frame.size.width - self.titleLabel.frame.size.width)*0.5;
    titleRect.origin.y = CGRectGetMaxY(self.imageView.frame)+2;
    self.titleLabel.frame = titleRect;
    
    if (self.imageView.weiht>self.titleLabel.weiht)
    {
        self.weiht = self.imageView.weiht;
    }else
    {
        self.weiht = self.titleLabel.weiht+2;
    }
    
    self.height = CGRectGetMaxY(self.titleLabel.frame);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setType];
    
}

@end
