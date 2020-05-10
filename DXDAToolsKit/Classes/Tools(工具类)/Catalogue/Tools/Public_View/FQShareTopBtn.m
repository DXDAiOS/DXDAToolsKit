//
//  FQShareTopBtn.m
//  NewApp3.0
//
//  Created by Erowin on 17/1/17.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "FQShareTopBtn.h"

@implementation FQShareTopBtn

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
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setType];
    
}

@end
