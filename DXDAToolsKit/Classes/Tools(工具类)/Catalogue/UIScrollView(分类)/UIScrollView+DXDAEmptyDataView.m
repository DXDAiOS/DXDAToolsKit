//
//  UIScrollView+DXDAEmptyDataView.m
//  x_App
//
//  Created by DXDA on 2017/7/13.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import "UIScrollView+DXDAEmptyDataView.h"
#import <objc/runtime.h>
#import "DXDANormalTools.h"
#import "UIView+CHViewExel.h"
#import "UILabel+Convenience.h"
//MARK: - ------------------------------------ EmptyView
@interface EmptyView ()

@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic,strong) UIButton *refreshBtn;
@property (nonatomic,copy) void(^actionBlock)();
@property (nonatomic,copy) NSString *error;
@end

static NSString *const errorStr = @"网络异常，请稍后重试~~";

@implementation EmptyView

+(instancetype)createWith:(UIView *)view type:(EmptyType)type tips:(NSString *)tips refresh:(void(^)())refresh {
    return [[self alloc] initWith:view type:type tips:tips refresh:refresh];
}

-(instancetype)initWith:(UIView *)view type:(EmptyType)type tips:(NSString *)tips refresh:(void(^)())refresh{
    if (self = [super initWithFrame:view.bounds]) {
        self.hidden = YES;
        [view addSubview:self];
        self.backgroundColor = Dark_LineColor;
    
        self.emptyType = type;
        tips ? self.tips = tips : nil;

        [self setActionBlock:^{
            refresh ? refresh() : nil;
        }];
    }
    return self;
}

-(void)setEmptyType:(EmptyType)emptyType {
    _emptyType = emptyType;
    
    switch (emptyType) {
        case emptyType_empty:
            //
//            [self createEmptyView:@""];
//            self.tips = @"";
            [_refreshBtn removeFromSuperview];
            break;
        case emptyType_news:
            //
            [self createEmptyView:@"empty_news_icon"];
            self.tips = @"暂没有收到联系消息~~";
            [_refreshBtn removeFromSuperview];
            break;
        case emptyType_error:
            //
            [self createEmptyView:@"empty_error_icon"];
            self.tips = errorStr;
            [self addSubview:self.refreshBtn];
            break;
        case emptyType_order:
            //
            [self createEmptyView:@"empty_order_icon"];
            self.tips = @"暂没有收到单据消息~~";
            [_refreshBtn removeFromSuperview];
            break;
        case emptyType_refresh:
            //
            [self createEmptyView:@"empty_error_icon"];
            [self addSubview:self.refreshBtn];
            break;
        case emptyType_custom:
            //
            [self createEmptyView:@"empty_order_icon"];
            self.tips = @"暂没有相关客户资料~~";
            [self addSubview:self.refreshBtn];
            break;
        case emptyType_supplier:
            //
            [self createEmptyView:@"empty_order_icon"];
            self.tips = @"暂没有相关供应商资料~~";
            [self addSubview:self.refreshBtn];
            break;
            
        default:
            break;
    }
}

-(void)setTips:(NSString *)tips {
    if (_tips.length == 0) {
        _tips = tips ? : errorStr;
    }
    self.tipsLabel.text = _tips;
    
    if (_emptyType == emptyType_empty) {
        self.tipsLabel.text = @"";
    }
    else if (_emptyType == emptyType_error) {
        self.tipsLabel.text = errorStr;
    }
    self.tipsLabel.frame = CGRectMake(15, self.picView.bottom, self.width-15*2, 18);
    _refreshBtn.frame = CGRectMake((self.width-100)/2, _tipsLabel.bottom+40, 100, 30);
    [self addSubview:self.tipsLabel];
}

-(void)createEmptyView:(NSString *)picPath {
    UIImage *picImage = [UIImage imageNamed:picPath];
    CGSize picSize = picImage.size;
    if (CGSizeEqualToSize(picSize, CGSizeZero)) {
        return;
    }
    CGFloat pic_w = self.width*0.6;
    CGFloat pic_h = pic_w/(picSize.width/picSize.height);
    CGFloat pic_x = (self.width-pic_w)/2;
    CGFloat pic_y = (self.height-pic_h)/2;
    self.picView.frame = CGRectMake(pic_x, pic_y, pic_w, pic_h);
    self.picView.image = picImage;
    [self addSubview:self.picView];
}

-(void)refreshAction {
    self.actionBlock ? self.actionBlock() : nil;
}

#pragma mark - lazy
-(UIImageView *)picView {
    if (!_picView) {
        _picView = [[UIImageView alloc] init];
    }
    return _picView;
}

-(UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel createWithCenter:CGRectMake(15, self.picView.bottom, self.width-15*2, 18) title:@"" titleColor:GrayRGB(200) font:18];
//        _tipsLabel.numberOfLines = 0;
    }
    return _tipsLabel;
}

-(UIButton *)refreshBtn {
    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreshBtn.frame = CGRectMake((self.width-100)/2, _tipsLabel.bottom+40, 100, 30);
        _refreshBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_refreshBtn setBackgroundImage:[UIImage imageNamed:@"oval_icon"] forState:UIControlStateNormal];
        [_refreshBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
        [_refreshBtn setTitleColor:DXDA_DefaultColor forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

-(void)dealloc {
    NSLog(@"123ok");
}

@end

//MARK: - ------------------------------------ 方法交换
#pragma mark - 方法交换
@implementation NSObject (swizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSel
           WithSwizzledSelector:(SEL)swizzledSel
{
    Method originMethod = class_getInstanceMethod(self, originalSel);
    Method swizzedMehtod = class_getInstanceMethod(self, swizzledSel);
    BOOL methodAdded = class_addMethod(self, originalSel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));

    if (methodAdded) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}

@end

static const char emptyKey = '\0';

@implementation UIScrollView (DXDAEmptyDataView)

#pragma mark - get set
-(void)setEmptyView:(EmptyView *)emptyView {
    objc_setAssociatedObject(self, &emptyKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(EmptyView *)emptyView {
    return objc_getAssociatedObject(self, &emptyKey);
}

@end

//MARK: - ------------------------------------ UITableView
@implementation UITableView (DXDAEmptyDataView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSelector:@selector(reloadData) WithSwizzledSelector:@selector(cz_reloadData)];
    });
}

- (void)cz_reloadData {
    [self cz_checkEmpty];
    [self cz_reloadData];
}

- (void)cz_checkEmpty {

    BOOL isEmpty = YES;
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (int i = 0; i < sections; i++) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }

    self.emptyView.hidden = !isEmpty;
}

@end

//MARK: - ------------------------------------ UICollectionView
@implementation UICollectionView (DXDAEmptyDataView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSelector:@selector(reloadData) WithSwizzledSelector:@selector(cz_reloadData)];
    });
}

- (void)cz_reloadData {
    [self cz_checkEmpty];
    [self cz_reloadData];
}

- (void)cz_checkEmpty {

    BOOL isEmpty = YES;
    id<UICollectionViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [src numberOfSectionsInCollectionView:self];
    }
    for (int i = 0; i < sections; i++) {
        NSInteger rows = [src collectionView:self numberOfItemsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    self.emptyView.hidden = !isEmpty;
}

@end
