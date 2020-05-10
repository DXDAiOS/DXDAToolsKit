//
//  SwipeButton.m
//  SwipeTableView
//
//  Created by zhao on 16/8/11.
//  Copyright © 2016年 zhaoName. All rights reserved.
//

#import "SwipeButton.h"

#define NULL_STRING(string) [string isEqualToString:@""] || !string

@implementation SwipeButton

//只有title
+ (SwipeButton *)createSwipeButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor touchBlock:(TouchSwipeButtonBlock)block
{
    return [self createSwipeButtonWithTitle:title font:15 textColor:[UIColor blackColor] backgroundColor:backgroundColor  touchBlock:block];
}

+ (SwipeButton *)createSwipeButtonWithTitle:(NSString *)title font:(CGFloat)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor touchBlock:(TouchSwipeButtonBlock)block
{
    return [self createSwipeButtonWithTitle:title font:font textColor:textColor backgroundColor:backgroundColor image:nil touchBlock:block];
}


//只有图片
+ (SwipeButton *)createSwipeButtonWithImage:(UIImage *)image backgroundColor:(UIColor *)color touchBlock:(TouchSwipeButtonBlock)block
{
    return [self createSwipeButtonWithTitle:nil font:15 textColor:[UIColor blackColor] backgroundColor:color image:image touchBlock:block];
}

//图片、文字都有，且图片在上 文字在下
+ (SwipeButton *)createSwipeButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image touchBlock:(TouchSwipeButtonBlock)block
{
    return [self createSwipeButtonWithTitle:title font:15 textColor:[UIColor blackColor] backgroundColor:backgroundColor image:image touchBlock:block];
}

+ (SwipeButton *)createSwipeButtonWithTitle:(NSString *)title font:(CGFloat)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image touchBlock:(TouchSwipeButtonBlock)block
{
    SwipeButton *button = [self buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    [button setImage:image forState:UIControlStateNormal];
    button.touchBlock = block;
    
    // 算出文字的size
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, button.titleLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    // button的宽度去文字和图片两个中的最大宽度 其它值将在SwipeView中设置
    button.frame = CGRectMake(0, 0, MAX(titleSize.width+10, image.size.width+10), 0);
    
    if(!NULL_STRING(title) && !image)
    {
        button.titleEdgeInsets = UIEdgeInsetsMake(image.size.height, -image.size.width, 0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height, 0.5*titleSize.width, 0.5*titleSize.height, 0);
    }
    NSLog(@"%@",NSStringFromCGRect(button.frame));
    return button;
}



/**
 *  防止文字太长或图片太大 导致图片或文字的位置不在中间
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.titleLabel.text && self.imageView.image)
    {
        CGFloat marginH = (self.frame.size.height - self.imageView.frame.size.height - self.titleLabel.frame.size.height)/3;
        
        //图片
        CGPoint imageCenter = self.imageView.center;
        imageCenter.x = self.frame.size.width/2;
        imageCenter.y = self.imageView.frame.size.height/2 + marginH;
        self.imageView.center = imageCenter;
        //文字
        CGRect newFrame = self.titleLabel.frame;
        newFrame.origin.x = 0;
        newFrame.origin.y = self.frame.size.height - newFrame.size.height - marginH;
        newFrame.size.width = self.frame.size.width;
        self.titleLabel.frame = newFrame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}





+ (SwipeButton *)createSwipeButtonWithOrder:(NSArray *)orderArr backgroundColor:(UIColor *)backgroundColor touchBlock:(TouchSwipeButtonBlock)block
{
    SwipeButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    button.touchBlock = block;
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [button addSubview:view];
    view.frame = button.bounds;
    
    UILabel *title = [UILabel new];
    title.text = @"最新客户联络单";
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor orangeColor];
    title.frame = CGRectMake(10, 10, 120, 20);
    title.layer.cornerRadius = 10;
    title.layer.masksToBounds = YES;
    title.font = [UIFont systemFontOfSize:13];
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    
    NSDictionary *dic = orderArr[0];
    NSString *value = dic[@"value"];
   
    if (value.length == 0) {
        
        UILabel *label = [UILabel new];
        label.text = @"暂无单据";
        label.textAlignment = NSTextAlignmentCenter;
        label.font =[UIFont systemFontOfSize:16];
        [button addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.centerY.equalTo(button.mas_centerY);
        }];
        
    }else{
        
        UILabel *titleLab;
        UILabel *numberLab;
        UILabel *createmanLab;
        
        NSMutableArray *arr =  [NSMutableArray array];
        
        for (int i = 0; i < orderArr.count; i++) {
            
            if (i < orderArr.count - 3) {
                UILabel *label = [UILabel new];
                label.textColor = DXDA_G_textColor;
                label.font = [UIFont systemFontOfSize:14];
                if (i == 0) {
                    label.textColor = [UIColor blackColor];
                    label.font = [UIFont systemFontOfSize:15];
                }
                label.numberOfLines = 1;
                label.textAlignment = NSTextAlignmentLeft;
                label.frame = CGRectMake(10, (i*30)+40, SCREEN_WIDTH/2, 30);
                [view addSubview:label];
                
                NSDictionary *dic = orderArr[i];
                NSString *title = dic[@"title"];
                NSString *value = dic[@"value"];
                label.text = [NSString stringWithFormat:@"%@:%@",title,value];
                
                if ([title isEqualToString:@"客户"]) {
                    titleLab = label;
                }else if ([title isEqualToString:@"单号"]){
                    numberLab = label;
                }else if ([title isEqualToString:@"制表人"]){
                    createmanLab = label;
                }else if ([title isEqualToString:@"地址"] || [title isEqualToString:@"内容"]){
                    label.frame = CGRectMake(10, (i*30)+40, SCREEN_WIDTH - 20, 30);
                }
            }else{
                
                [arr addObject:orderArr[i]];
            }
            
        }
        
        for (int i = 0; i < arr.count; i++) {
            UILabel *label = [UILabel new];
            label.textColor = DXDA_G_textColor;
            label.font = [UIFont systemFontOfSize:14];
            label.numberOfLines = 1;
            label.textAlignment = NSTextAlignmentRight;
            label.frame = CGRectMake(SCREEN_WIDTH/2, (i*30)+40, (SCREEN_WIDTH/2-10), 30);
            [view addSubview:label];
            NSDictionary *dic = arr[i];
            NSString *title = dic[@"title"];
            NSString *value = dic[@"value"];
            if (i == 0) {
                label.text = value;
            }else if(i == 1){
                label.text = value;
            }else if(i == 2){
                label.text = [NSString stringWithFormat:@"%@:%@",title,value];
            }
        }
    }
    
    
    
    return button;
}

@end
