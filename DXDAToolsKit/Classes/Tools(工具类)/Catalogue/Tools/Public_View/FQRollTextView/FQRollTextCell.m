//
//  FQRollTextCell.m
//  FQRollText
//
//  Created by Erowin on 16/10/28.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "FQRollTextCell.h"

@interface FQRollTextCell ()

@property (weak, nonatomic) IBOutlet UILabel *newsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end

@implementation FQRollTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.newsLabel.text = title;
}

@end
