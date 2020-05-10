//
//  FQRollTextView.m
//  FQRollText
//
//  Created by Erowin on 16/10/28.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "FQRollTextView.h"
#import "FQRollTextCell.h"

@interface FQRollTextView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation FQRollTextView

static CGFloat num = 0;

+(instancetype)sharedRollTextView
{
    static dispatch_once_t onceToken;
    static FQRollTextView *view;
    dispatch_once(&onceToken, ^{
        view = [[FQRollTextView alloc]init];
    });
    return view;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        [self setSubView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self setSubView];
    }
    return self;
}

-(void)setSubView
{
    [self addSubview:self.tableView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    self.frame = CGRectMake(0, 0, width, 30);
    self.tableView.frame = self.bounds;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
static NSString *rollTextCellID = @"rollTextCellID";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FQRollTextCell *cell = [tableView dequeueReusableCellWithIdentifier:rollTextCellID];
    cell.title = self.datas[indexPath.row];
    return cell;
}


-(void)timerClick
{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentOffset = CGPointMake(0,num);
        num = num+30;
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y==self.datas.count*30)
    {
        [self.timer setFireDate:[NSDate distantFuture]];
        self.hidden = YES;
    }
}

-(void)setDatas:(NSArray *)datas
{
    _datas = datas;
    [self.tableView reloadData];
    num=0;
    [self.timer setFireDate:[NSDate distantPast]];
    self.hidden = NO;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight=30;
        [_tableView registerNib:[UINib nibWithNibName:@"FQRollTextCell" bundle:nil] forCellReuseIdentifier:rollTextCellID];
    }
    return _tableView;
}

-(NSTimer *)timer
{
    if (!_timer)
    {
        _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
