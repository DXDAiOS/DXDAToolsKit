//
//  DXDASelectPhotoManager.m
//  NewApp3.0
//
//  Created by DXDA on 2018/3/6.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import "DXDASelectPhotoManager.h"
#import "DXDAShowImageAlertView.h"
#import "XLPhotoBrowser.h"

@interface DXDASelectPhotoManager()

//@property (nonatomic, assign) NSInteger currentIndex;           // 当前下标
//@property (nonatomic, assign) NSInteger currentPhotoCount;      // 当前图片数组个数

@end

static NSInteger const viewTag  = 10000;        // 图片框 tag
static NSInteger const photoTag = 10100;        // 图片 tag
static NSInteger const resetTag = 10200;        // 重选图片按钮 tag
static NSInteger const cleanTag = 10300;        // 删除图片按钮 tag
static NSInteger const alphaTag = 10400;        // loadingView tag
static NSInteger const errorTag = 10500;        // 重新上传按钮 tag
static NSInteger const selectTag  = 10600;      // 选择图片按钮 tag

static NSString *const cz_indexKey = @"index";

@implementation DXDASelectPhotoManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        [self addPhotoView:0];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    
    _view_w = 100;
    
    _viewArray = [NSMutableArray array];
    _photoArray = [NSMutableArray array];
    _urlDic = [NSMutableDictionary dictionary];
    
    // 默认数量 1
    _maxSelectCount = 1;
    _maxCount = 1;
}

- (void)addPhotoView:(NSInteger)serialNum {
    [_viewArray addObject:[self createPhotoView:serialNum]];
}

//MARK: - 默认 maxCount >= maxSelectCount  最大数量 >= 最大选择数量
- (void)setMaxSelectCount:(NSInteger)maxSelectCount {
    _maxSelectCount = maxSelectCount;
    _maxCount = _maxCount >= maxSelectCount ? _maxCount : maxSelectCount;
}

//MARK: - 改变最大数量 maxCount
- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
}

/**
 创建图片框

 @param serialNum 创建序号
 */
- (UIView *)createPhotoView:(NSInteger)serialNum {
    
    CGFloat view_h = _view_w;
    
    UIView *otherView;
    if (serialNum != 0 && _viewArray.count != 0) {
        otherView = [self viewWithTag:viewTag + _viewArray.count - 1];
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = DXDA_LineColor;
    view.tag = viewTag + serialNum;
    view.frame = CGRectMake(0, 0, _view_w, view_h);
    [self addSubview:view];
    if (otherView) {
        CGFloat judge_w = otherView.right + 20 + _view_w;
        view.frame = CGRectMake(otherView.right + 20, otherView.y, _view_w, view_h);
        if (judge_w > SCREEN_WIDTH) {
            view.frame = CGRectMake(15, otherView.bottom + 15, _view_w, view_h);
        }
    }
    else {
        view.frame = CGRectMake(15, 15, _view_w, view_h);
    }
    
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(@0);
//        if (otherView) {
//            make.left.mas_equalTo(otherView.mas_right).offset(15);
//        }
//        else {
//            make.left.mas_equalTo(@10);
//        }
//        make.width.height.mas_equalTo(view_w);
//    }];
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = view.bounds;
    tempBtn.tag = selectTag + serialNum;
    [tempBtn setImage:[UIImage imageNamed:@"bank_photo_icon"] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(selectPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:tempBtn];
    
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.tag = photoTag + serialNum;
    photoView.frame = view.bounds;
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    photoView.clipsToBounds = YES;
    [view addSubview:photoView];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:tempBtn.bounds];
    alphaView.hidden = YES;
    alphaView.tag = alphaTag + serialNum;
    alphaView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    [view addSubview:alphaView];
    
    CGFloat w = 50;
    CGFloat x = (alphaView.width-w)/2;
    CGFloat y = (alphaView.height-w)/2;
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x, y, w, w)];
    indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [indicatorView startAnimating];
    [alphaView addSubview:indicatorView];
    
    CGFloat e_w = 23;
    CGFloat e_x = (tempBtn.width-e_w)/2;
    CGFloat e_y = (tempBtn.height-e_w)/2;
    UIButton *errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    errorBtn.frame = CGRectMake(e_x, e_y, e_w, e_w);
    [errorBtn setTitle:@"!" forState:UIControlStateNormal];
    [errorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    errorBtn.backgroundColor = [UIColor redColor];
    errorBtn.layer.cornerRadius = e_w/2;
    errorBtn.clipsToBounds = YES;
    errorBtn.hidden = YES;
    errorBtn.tag = errorTag + serialNum;
    [errorBtn addTarget:self action:@selector(reUploadPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:errorBtn];
    
    //MARK: - 重新上传按钮
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = CGRectMake(0, tempBtn.height-25, tempBtn.width, 25);
    [resetBtn setTitle:@"更换图片" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resetBtn.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    resetBtn.tag = resetTag + serialNum;
    [resetBtn addTarget:self action:@selector(resetPicAction:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.hidden = YES;
    [view addSubview:resetBtn];
    
    //        UILabel *titleLabel = [UILabel createWithCenter:CGRectMake(button.x, button.bottom, btn_w, 20) title:btnArray[i] titleColor:DXDA_FontColor font:14];
    //        [self addSubview:titleLabel];
    
    //MARK: - 删除按钮
    CGFloat clean_w = 30;
    CGFloat clean_h = clean_w;
    CGFloat clean_y = view.top-clean_h/2;
    CGFloat clean_x = view.right-clean_w/2;
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBtn.frame = CGRectMake(clean_x, clean_y, clean_w, clean_h);
    cleanBtn.tag = cleanTag + serialNum;
    [cleanBtn addTarget:self action:@selector(cleanPicAction:) forControlEvents:UIControlEventTouchUpInside];
    cleanBtn.hidden = YES;
    [cleanBtn setImage:[UIImage imageNamed:@"mission_refuse_icon"] forState:UIControlStateNormal];
    [self addSubview:cleanBtn];
    
    self.size = CGSizeMake(view.right + 10, view.bottom + 15);
    if (_viewArray.count >= 3) {
        self.size = CGSizeMake(SCREEN_WIDTH, view.bottom + 15);
    }
    
    // 更新 size
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnUpdateRect:)]) {
        [self.delegate returnUpdateRect:self.size];
    }
    
    return view;
}

//MARK: - 设置图片只读
- (void)setReadonly:(BOOL)readonly {
    _readonly = readonly;
    
    for (NSInteger i = 0; i < _viewArray.count; i++) {
        UIImageView *imageView = [self viewWithTag:i + photoTag];
        UIView *alphaView = [self viewWithTag:i + alphaTag];
        if (imageView.image == nil || alphaView.hidden == NO) {
            return;
        }
        
        UIButton *cleanBtn = [self viewWithTag:i + cleanTag];
        cleanBtn.hidden = readonly;
        
        UIButton *resetBtn = [self viewWithTag:i + resetTag];
        resetBtn.hidden = readonly;
    }
}

//MARK: - 更新图片数据
- (void)updatePhotoData:(NSArray<NSString *> *)array {
    
    if (array.count == 0) {
        [self.delegate returnUpdateRect:CGSizeZero];
        return;
    }

    // 清空url
    [_urlDic removeAllObjects];
    [_photoArray removeAllObjects];
    for (NSInteger i = 0; i < array.count; i++) {
        NSString *indexKey = [NSString stringWithFormat:@"%@_%ld",cz_indexKey,(long)i];
        _urlDic[indexKey] = array[i];
        
        [_photoArray addObject:[UIImage imageNamed:@"暂无图片"]];
    }
    
    // 判断是否 新增/移除 图片框
    NSInteger count = array.count - _viewArray.count;
    if (count > 0) {
        do {
            [self addPhotoView:_viewArray.count];
        } while (array.count > _viewArray.count);
    }
    else if (count < 0) {
        do {
            UIView *view = _viewArray.lastObject;
            NSInteger currentIndex = view.tag - viewTag;
            UIButton *cleanBtn = [self viewWithTag:currentIndex + cleanTag];
            [cleanBtn removeFromSuperview];
            [view removeFromSuperview];
            [_viewArray removeLastObject];
            view = nil;
            cleanBtn = nil;
        } while (array.count < _viewArray.count);
    }
    
    for (NSInteger i = 0; i < array.count; i++) {
        UIImageView *photoView = [self viewWithTag:i + photoTag];
        NSURL *url = [NSURL URLWithString:array[i]];
        
        __block UIView *alphaView = [self viewWithTag:i + alphaTag];
        alphaView.hidden = NO;
        
        __block UIButton *cleanBtn = [self viewWithTag:i + cleanTag];
        __block UIButton *resetBtn = [self viewWithTag:i + resetTag];
        cleanBtn.hidden = YES;
        resetBtn.hidden = YES;

        weak(self)
        [photoView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            alphaView.hidden = YES;

            cleanBtn.hidden = weakSelf.readonly;
            
            resetBtn.hidden = weakSelf.readonly;

        }];
    }
    
    // 更新 size
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnUpdateRect:)]) {
        [self.delegate returnUpdateRect:self.size];
    }
    
    // 判断是否 添加 图片框
    if (_readonly) {
        return;
    }
    
    if (_viewArray.count == _maxCount) {
        return;
    }
    
    [self addPhotoView:_viewArray.count];
}

//MARK: - 选择图片
- (void)selectPhotoAction:(UIButton *)sender {
        UIButton *cleanBtn = [self viewWithTag:(sender.tag - selectTag + cleanTag)];
        
        // 查看图片
        if (_readonly || cleanBtn.hidden == NO) {
            UIImageView *tempView = [self viewWithTag:(sender.tag - selectTag + photoTag)];
            
            if (tempView.image) {
                NSMutableArray *imageArr = [NSMutableArray array];
                for (int i = 0; i<self.photoArray.count; i++) {
                    UIImageView *tempView1 = [self viewWithTag:(photoTag + i)];
                    if (tempView1.image)
                    {
                        [imageArr addObject:tempView1.image];
                    }
                    else
                    {
                        UIImage *image = [UIImage imageNamed:@"暂无图片"];
                        [imageArr addObject:image];
                    }
                }
                //            [DXDAShowImageAlertView showWith:tempView];
                [XLPhotoBrowser showPhotoBrowserWithImages:imageArr currentImageIndex:(sender.tag - selectTag)];
            }
        
        return;
    }
    
    //设置照片最大选择数
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
    NSInteger maxCount = _maxSelectCount - _photoArray.count;
    
    if (maxCount <= 0) {
        return;
    }
    
    actionSheet.maxSelectCount = maxCount;
    //设置照片最大预览数
    //    actionSheet.maxPreviewCount = 20;
    weak(self)
    [actionSheet showPreviewPhotoWithSender:[UIResponder returnController] animate:YES lastSelectPhotoModels:nil completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        [weakSelf uploadImage:selectPhotos];
    }];
    
}

//MARK: - 重选图片
- (void)resetPicAction:(UIButton *)sender {
    
    __block NSInteger re_index = sender.tag - resetTag;
    
    // 重选图片只能选一张
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
    actionSheet.maxSelectCount = 1;

    weak(self)
    [actionSheet showPreviewPhotoWithSender:[UIResponder returnController] animate:YES lastSelectPhotoModels:nil completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        weakSelf.photoArray[re_index] = selectPhotos[0];
        [weakSelf reUploadAction:re_index];
    }];
}

//MARK: - 重新上传
- (void)reUploadPhotoAction:(UIButton *)sender {
    if (_readonly) {
        return;
    }
    
    NSInteger e_index = sender.tag - errorTag;
    
    [self reUploadAction:e_index];
}

//MARK: - 重新上传
- (void)reUploadAction:(NSInteger)up_index {
    UIView *alphaView = [self viewWithTag:up_index + alphaTag];
    alphaView.hidden = NO;
    
    UIButton *errorBtn = [self viewWithTag:up_index + errorTag];
    errorBtn.hidden = YES;
    
    UIButton *cleanBtn = [self viewWithTag:up_index + cleanTag];
    cleanBtn.hidden = YES;
    
    UIButton *resetBtn = [self viewWithTag:up_index + resetTag];
    resetBtn.hidden = YES;
    
    UIImageView *photoView = [self viewWithTag:up_index + photoTag];
    
    if (up_index >= _photoArray.count) {
        return;
    }
    UIImage *image = _photoArray[up_index];
    photoView.image = image;
    
    // 上传图片
    weak(self)
    if (self.delegate && [self.delegate respondsToSelector:@selector(uploadPhotoMethod:handle:fail:)]) {
        [self.delegate uploadPhotoMethod:photoView handle:^(NSInteger index, NSString *url, UIImageView *imageV) {
            [weakSelf updateOperation:imageV URL:url];
        } fail:^(NSInteger index, UIImageView *imageV) {
            [weakSelf failOperation:imageV];
        }];
    }
}

//MARK: - 清除图片
- (void)cleanPicAction:(UIButton *)sender {
    NSInteger cl_index = sender.tag - cleanTag;
    
    NSMutableArray<NSValue *> *rectArray = [NSMutableArray array];
    // 存储 frame 更新urlDic
    for (NSInteger i = cl_index; i < _viewArray.count; i++) {
        UIView *objView = [self viewWithTag:i + viewTag];
        [rectArray addObject:[NSValue valueWithCGRect:objView.frame]];
        
        NSString *l_indexKey = [NSString stringWithFormat:@"%@_%ld",cz_indexKey,i];     // 当前dic 的 key
        NSString *n_indexKey = [NSString stringWithFormat:@"%@_%ld",cz_indexKey,i+1];   // 下一个dic 的 key
        
        _urlDic[l_indexKey] = @"";      // 先置空
        _urlDic[l_indexKey] = _urlDic[n_indexKey] ? : @"";    // 把下一个dic 的值 赋值给 上一个dic
        _urlDic[n_indexKey] = @"";      // 赋值完 置空
    }
    
    // 移除视图
    UIView *view = [self viewWithTag:cl_index + viewTag];
    UIButton *cleanBtn = [self viewWithTag:cl_index + cleanTag];
    [_viewArray removeObject:view];
    [view removeFromSuperview];
    [cleanBtn removeFromSuperview];
    view = nil;
    cleanBtn = nil;
    
    if (cl_index >= _photoArray.count) {
        return;
    }
    [_photoArray removeObjectAtIndex:cl_index];

    // 遍历更新视图
    for (NSInteger i = cl_index; i < _viewArray.count; i++) {
        UIView *tempView        = [self viewWithTag:i + 1 + viewTag];
        UIImageView *photoView  = [self viewWithTag:i + 1 + photoTag];
        UIButton *resetBtn      = [self viewWithTag:i + 1 + resetTag];
        UIButton *cleanBtn      = [self viewWithTag:i + 1 + cleanTag];
        UIView *alphaView       = [self viewWithTag:i + 1 + alphaTag];
        UIButton *errorBtn      = [self viewWithTag:i + 1 + errorTag];
        UIButton *selectBtn     = [self viewWithTag:i + 1 + selectTag];
        tempView.tag    = i + viewTag;
        photoView.tag   = i + photoTag;
        resetBtn.tag    = i + resetTag;
        cleanBtn.tag    = i + cleanTag;
        alphaView.tag   = i + alphaTag;
        errorBtn.tag    = i + errorTag;
        selectBtn.tag   = i + selectTag;
        [UIView animateWithDuration:0.25 animations:^{
            tempView.frame = rectArray[i-cl_index].CGRectValue;
            cleanBtn.origin = CGPointMake(tempView.right - cleanBtn.width/2, tempView.y - cleanBtn.height/2);
        }];
    }
    
    // 更新路径数组
    [self updateURLArray];
    
    // 判断是否需要新增 图片框
    NSInteger calcuCount = _photoArray.count - _viewArray.count;
    if (calcuCount < 0) {
        UIView *lastView = [self viewWithTag:viewTag + _viewArray.count - 1];
        self.size = CGSizeMake(lastView.right + 10, lastView.bottom + 15);
        if (_viewArray.count >= 3) {
            self.size = CGSizeMake(SCREEN_WIDTH, lastView.bottom + 15);
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(returnUpdateRect:)]) {
            [self.delegate returnUpdateRect:self.size];
        }
    }
    else {
        [self addPhotoView:_viewArray.count];
    }
    
}

//MARK: - 上传图片
- (void)uploadImage:(NSArray<UIImage *> *)images {
    NSInteger currentPhotoCount = _photoArray.count;
    
    [_photoArray addObjectsFromArray:images];
    
    // 判断是否添加 图片框
    while (_viewArray.count < _photoArray.count) {
        [self addPhotoView:_viewArray.count];
    }
    
    // 遍历 赋值 上传图片
    weak(self)
    for (NSInteger i = currentPhotoCount; i < _photoArray.count; i++) {
        UIImageView *imageView = [self viewWithTag:photoTag + i];
        imageView.image = _photoArray[i];
        
        UIView *alphaView = [self viewWithTag:alphaTag + i];
        alphaView.hidden = NO;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(uploadPhotoMethod:handle:fail:)]) {
            [self.delegate uploadPhotoMethod:imageView handle:^(NSInteger index, NSString *url, UIImageView *imageV) {
                [weakSelf updateOperation:imageV URL:url];
            } fail:^(NSInteger index, UIImageView *imageV) {
                [weakSelf failOperation:imageV];
            }];
        }
    }
    
    // 是否添加 图片框
    if (_viewArray.count < _maxCount) {
        [self addPhotoView:_viewArray.count];
    }
}

//MARK: - 上传成功 保存数据 更新操作
- (void)updateOperation:(UIImageView *)imageView URL:(NSString *)url {
    
    NSInteger index = imageView.tag - photoTag;
    
    NSString *indexKey = [NSString stringWithFormat:@"%@_%ld",cz_indexKey,index];
    
    _urlDic[indexKey] = url ? : @"";
    
    UIView *alphaView = [self viewWithTag:index + alphaTag];
    alphaView.hidden = YES;
    
    UIButton *resetBtn = [self viewWithTag:index + resetTag];
    resetBtn.hidden = NO;
    
    UIButton *cleanBtn = [self viewWithTag:index + cleanTag];
    [self addSubview:cleanBtn];
    cleanBtn.hidden = NO;
    
    [self updateURLArray];
}

//MARK: - 上传失败 更新操作
- (void)failOperation:(UIImageView *)imageView {
    
    NSInteger index = imageView.tag - photoTag;
    
    UIView *alphaView = [self viewWithTag:index + alphaTag];
    alphaView.hidden = YES;
    
    UIButton *errorBtn = [self viewWithTag:index + errorTag];
    errorBtn.hidden = NO;
    
    UIButton *cleanBtn = [self viewWithTag:index + cleanTag];
    cleanBtn.hidden = NO;
    
    UIButton *resetBtn = [self viewWithTag:index + resetTag];
    resetBtn.hidden = NO;
}

//MARK: - 返回当前路径数组
- (void)updateURLArray {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < _viewArray.count; i++) {
        NSString *indexKey = [NSString stringWithFormat:@"%@_%ld",cz_indexKey, i];
        NSString *url = _urlDic[indexKey] ? : @"";
        [array addObject:url];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnCurrentURLs:)]) {
        [self.delegate returnCurrentURLs:[array mutableCopy]];
    }
}

- (void)dealloc {
    NSLog(@"photo dealloc");
}

@end
