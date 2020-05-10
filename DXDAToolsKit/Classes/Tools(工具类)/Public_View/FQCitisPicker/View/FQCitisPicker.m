//
//  FQCitisPicker.m
//  citisSelected4.28
//
//  Created by Erowin on 16/10/18.
//  Copyright © 2016年 Freedom. All rights reserved.
//

#import "FQCitisPicker.h"
#import "CitiesDatas.h"

@interface FQCitisPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSArray *citiesDatas;

@property(nonatomic,weak)CitiesDatas *cities;

@property(nonatomic,strong)UIToolbar *toolBar;

//@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)UIPickerView *pickerView;

@end

@implementation FQCitisPicker

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self addSubview:self.pickerView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self addSubview:self.pickerView];
    }
    return self;
}

-(NSArray *)citiesDatas
{
    if (_citiesDatas==nil)
    {
        _citiesDatas=[CitiesDatas citiesDatas];
    }
    return _citiesDatas;
}

-(UIToolbar *)toolBar
{
    if (_toolBar==nil)
    {
        _toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];
        
        _toolBar.barTintColor=[UIColor orangeColor];
        
        //        _toolBar.backgroundColor=[UIColor orangeColor
        
        UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCleck)];
        
        UIBarButtonItem *certain=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(certainCleck)];
        
        UIBarButtonItem *kong=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        _toolBar.items=@[cancel,kong,certain];
        
    }
    return _toolBar;
}

-(UIPickerView *)pickerView
{
    if (_pickerView==nil)
    {
        _pickerView=[[UIPickerView alloc]init];
        
        _pickerView.delegate=self;
        _pickerView.dataSource=self;
    }
    return _pickerView;
}

#pragma mark---------------------响应事件
-(void)cancelCleck
{
//    [self.view endEditing:YES];
}




//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.placeText.inputView =self.pickerView;
//    
//    self.placeText.inputAccessoryView=self.toolBar;
//    
//    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
//    [self pickerView:self.pickerView didSelectRow:0 inComponent:1];
//    
//}

-(void)certainCleck
{
    
}

#pragma mark-------------------数据源方法

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return self.citiesDatas.count;
    }
    else
    {
        NSInteger currRow = [pickerView selectedRowInComponent:0];
        
        CitiesDatas *data=self.citiesDatas[currRow];
        
        return data.cities.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        
        return [self.citiesDatas[row] name];
    }
    else
    {
        //       NSInteger currRow = [pickerView selectedRowInComponent:0];
        //
        //        CitiesDatas *data=self.citiesDatas[currRow];
        //
        //        return data.cities[row];
        
        
        return self.cities.cities[row];
        
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    if (component==0)
    {
        self.cities=self.citiesDatas[row];
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        NSInteger curRow = [pickerView selectedRowInComponent:1];
        CitiesDatas *data=self.citiesDatas[row];
        
        self.placeText=[NSString stringWithFormat:@"%@%@",data.name,data.cities[curRow]];
    }
    else
    {
        //        NSInteger curRow=[pickerView selectedRowInComponent:0];
        
        //        CitiesDatas *data=self.citiesDatas[curRow];
        
        
        self.placeText=[NSString stringWithFormat:@"%@%@",self.cities.name,self.cities.cities[row]];
    }
}

@end
