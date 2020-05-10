//
//  DXDAIconBtn.m
//  NewApp3.0
//
//  Created by Erowin on 16/10/24.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "DXDAIconBtn.h"

@implementation DXDAIconBtn

-(void)setType
{
    //    self.imageView
//    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //   [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[playerview]-0-|" options:0 metrics:nil views:@{@"playerview":playVc.view}]];
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    [self.titleLabel sizeToFit];
    CGRect rect = self.imageView.frame;
    rect.origin.x = self.frame.size.width*0.5 - self.imageView.frame.size.width*0.5;
    rect.origin.y =0;
    
    self.imageView.frame = rect;
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = self.frame.size.width*0.5 - self.titleLabel.frame.size.width*0.5;
    titleRect.origin.y = CGRectGetMaxY(self.imageView.frame)+2;
    self.titleLabel.frame = titleRect;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setType];
    
}

@end
