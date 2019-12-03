//
//  ZXXKeyBoard.m
//  demo
//
//  Created by zoekebi_Mac on 2017/5/26.
//  Copyright © 2017年 zoekebi_Mac. All rights reserved.
//

#import "ZXXKeyBoard.h"
#define screen_w [UIScreen mainScreen].bounds.size.width
#define screen_h [UIScreen mainScreen].bounds.size.height

@interface ZXXKeyBoard()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak,nonatomic)UIButton *cancel;
@property (weak,nonatomic)UIButton *sure;
@property (copy,nonatomic)NSString *content;

/**省会加载*/
@property(nonatomic,strong)NSArray *provinces;
/**城市的加载*/
@property(nonatomic,strong)NSArray *citys;
/**区域的加载*/
@property(nonatomic,strong)NSArray *towns;
@property (strong, nonatomic) NSArray *selectedArray;
/**pickerView的字典*/
@property(nonatomic,strong)NSDictionary *pickerDic;
@end
@implementation ZXXKeyBoard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
 - (void)drawRect:(CGRect)rect {
     UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(0, rect.size.height-230, rect.size.width, 230)];
     [[UIColor whiteColor] setFill];
     [path2 fill];
     UIBezierPath *path = [UIBezierPath bezierPath];
     [path moveToPoint:CGPointMake(0, screen_h-230)];
     [path addLineToPoint:CGPointMake(rect.size.width, screen_h-230)];
     [path moveToPoint:CGPointMake(0, screen_h-230+44)];
     [path addLineToPoint:CGPointMake(rect.size.width, screen_h-230+44)];
     [[UIColor colorWithWhite:0.894 alpha:1.000] set];
     [path stroke];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    ZXXLog(@"释放了ZXXKeyBoard");
}
-(instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canselevent) name:UIKeyboardWillHideNotification object:nil];
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.095];
        UITapGestureRecognizer *tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(canselevent)];
        [self addGestureRecognizer:tapgr];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.frame = CGRectMake(0, 0, screen_w, screen_h);
        
        UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, screen_h - 230 + 44, screen_w, 186)];
        [self addSubview:pickView];
        pickView.delegate = self;
        pickView.dataSource = self;
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:cancel];
        cancel.frame = CGRectMake(14, screen_h-230+14, 40, 20);
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
        cancel.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
        [cancel addTarget:self action:@selector(canselevent) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:sure];
        sure.frame = CGRectMake(screen_w-54, screen_h-230+14, 40, 20);
        [sure setTitle:@"完成" forState:UIControlStateNormal];
        [sure setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
        sure.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
        [sure addTarget:self action:@selector(sureEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setUpData];
        
    }
    return self;
}
-(void)setUpData{
    // 加载plist文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Address.plist" ofType:nil];
    
    self.pickerDic = [[NSDictionary alloc]initWithContentsOfFile:filePath];
    self.provinces = [self.pickerDic allKeys];
    
    // 默认选中第一组
    self.selectedArray = [self.pickerDic objectForKey:[self.provinces objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.citys = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.citys.count > 0) {
        self.towns = [[self.selectedArray objectAtIndex:0] objectForKey:[self.citys objectAtIndex:0]];
    }
    self.content = [NSString stringWithFormat:@"%@/%@/%@",self.provinces.firstObject,self.citys.firstObject,self.towns.firstObject];
}
- (void)canselevent{
    [self removeFromSuperview];
}
- (void)sureEvent:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZXXKeyBoardAccptContent" object:self.content];
    [self removeFromSuperview];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) { // 描述省
        return self.provinces.count;
    }else if(component == 1){
        return self.citys.count;
    }else{
        return self.towns.count;
    }
}
#pragma mark -UIPickerView的代理
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = FONT(18);
    }
    if (component == 0) { // 描述省会
        pickerLabel.text = [self.provinces objectAtIndex:row];
    }else if(component == 1){
        pickerLabel.text = [self.citys objectAtIndex:row];
    }else{
        pickerLabel.text = [self.towns objectAtIndex:row];
    }
    return pickerLabel;
    
}
// 全局断点就是帮我们定位到出bug的那一行。

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinces objectAtIndex:row]]; // 选中第一组
        if (self.selectedArray.count > 0) {
            self.citys = [[self.selectedArray objectAtIndex:0] allKeys];
        }else{
            self.citys = nil;
        }
        if (self.citys.count >0) {
            self.towns = [[self.selectedArray objectAtIndex:0]objectForKey:[self.citys objectAtIndex:0]];
        }else{
            self.towns = nil;
        }
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    }else if(component == 1){
        if (self.selectedArray.count >0 && self.citys.count >0) {
            self.towns = [[self.selectedArray objectAtIndex:0]objectForKey:[self.citys objectAtIndex:row]];
        }else{
            self.towns = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    }else{
        
    }
    NSInteger index0 = [pickerView selectedRowInComponent:0];
    NSString *provinces0 = [self.provinces objectAtIndex:index0];
    
    NSInteger index1 = [pickerView selectedRowInComponent:1];
    NSString *city1;
    if (self.citys.count-1>=index1) {
        city1 = [self.citys objectAtIndex:index1];
    }else{
        city1 = [self.citys objectAtIndex:self.citys.count-1];
    }
    
    NSInteger index2 = [pickerView selectedRowInComponent:2];
    NSString *town2;
    if (self.towns.count-1>=index2) {
        town2 = [self.towns objectAtIndex:index2];
    }else{
        town2 = [self.towns objectAtIndex:self.towns.count-1];
    }
    
    NSString *text = [NSString stringWithFormat:@"%@/%@/%@",provinces0,city1,town2];
    
    self.content = text;
    
}

@end
