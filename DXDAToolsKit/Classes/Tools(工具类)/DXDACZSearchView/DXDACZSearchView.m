//
//  DXDACZSearchView.m
//  NewApp3.0
//
//  Created by DXDA on 2017/5/4.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "DXDACZSearchView.h"
#import "DXDASearchHistoryView.h"

@interface DXDACZSearchView ()<UISearchBarDelegate>

@property (nonatomic,copy) void (^searchBlock)();
@property (nonatomic,copy) void (^cancelBlock)();

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong)DXDASearchHistoryView *historyView;
@property (nonatomic, strong)UIButton *cancelBtn;

@end

@implementation DXDACZSearchView

+(instancetype)createWith:(UIView *)view searchAction:(void(^)())search cancelAction:(void(^)())cancel {
    return [[self alloc] initWith:view searchAction:search cancelAction:cancel];
}

-(instancetype)initWith:(UIView *)view searchAction:(void(^)())search cancelAction:(void(^)())cancel {
    if (self = [super init]) {
        if (view) {
            _superView = view;
            [view addSubview:self];
        }
        
        
        [self setup];
        
        self.searchBlock = ^() {
            search ? search() : nil;
        };
        
        self.cancelBlock = ^() {
            cancel ? cancel() : nil;
        };
    }
    return self;
}

-(void)setup {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
//    self.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = DXDA_LineColor;
//    self.barTintColor = Dark_BackgroudColor;

//    UIView *textView = [[[self.subviews firstObject] subviews] lastObject];
//    textView.backgroundColor = [UIColor setLightColor:DXDA_LineColor darkColor:Dark_BackgroudColor_Gray];;
    
    self.searchBarStyle = UISearchBarStyleMinimal;
    self.placeholder = @"关键字";
    self.delegate = self;
    
//    //更改输入框背景色
//    UIImage * searchBarBg = [self GetImageWithColor:[UIColor greenColor] andHeight:36.0f];
//    [self setBackgroundImage:searchBarBg];
//    [self setBackgroundColor:[UIColor orangeColor]];
//    [self setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
//    //更改输入框圆角
//    self.layer.cornerRadius = 4.0f;
//    self.layer.masksToBounds = YES;
//
//    //更改输入框字号
//    UITextField  *seachTextFild = (UITextField*)[self subViewOfClassName:@"UISearchBarTextField" view:self];
//    seachTextFild.font = [UIFont systemFontOfSize:14];
//    
}
- (UIView*)subViewOfClassName:(NSString*)className view:(UIView *)view{
    for (UIView* subView in view.subviews) {
        NSLog(@"======%@",subView.class);
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        UIView* resultFound = [self subViewOfClassName:className view:subView];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}

#pragma mark - searchBar delegate method
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self setShowsCancelButton:NO animated:YES];
    [self resignFirstResponder];
    [self.historyView hideView];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self setShowsCancelButton:NO animated:YES];
    [self resignFirstResponder];
    self.searchBlock();
    [self.historyView hideView];
    [self.historyView saveData:searchBar.text];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self setShowsCancelButton:YES animated:YES];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            _cancelBtn = btn;
//            [btn setTitleColor:DXDA_DefaultColor forState:UIControlStateNormal];
        }
    }
//    [self setShowsCancelButton:YES animated:YES];
    
    [self.historyView showView];
    return YES;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.cancelBlock();
    }
}




-(DXDASearchHistoryView *)historyView
{
    if (!_historyView) {
        
        weak(self)
        _historyView = [DXDASearchHistoryView createWith:_superView searchAction:^(NSString * _Nonnull text) {
            weakSelf.text = text;
            [weakSelf.historyView hideView];
            [weakSelf.historyView saveData:text];
            weakSelf.searchBlock();
            [weakSelf resignFirstResponder];
        }];
        _historyView.clearBlock = ^{
            weakSelf.showsCancelButton = NO;
            [weakSelf resignFirstResponder];
            weakSelf.text = @"";
            
        };
    }
    return _historyView;
}
@end
