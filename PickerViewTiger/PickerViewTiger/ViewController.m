//
//  ViewController.m
//  PickerViewTiger
//
//  Created by qingyun on 15/11/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;

@property (nonatomic) NSInteger level;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _level = 3;
    [self doing:nil];
}
- (IBAction)changeLevel:(UISegmentedControl *)sender {
    _level = sender.selectedSegmentIndex + 3;
}
- (IBAction)doing:(UIButton *)sender {
   
    _winLabel.text = nil;
    
    int compareRow = 0 ;
    int equelNum = 1;
    
    BOOL isWin = NO;
    
    NSURL *sound = [[NSBundle mainBundle]URLForResource:@"crunch" withExtension:@"wav"];
    [self playSound:sound];
    
    for (int i = 0; i < 5; i ++) {
        CGFloat row = round(random()%6);
        [_pickerView selectRow:row inComponent:i animated:YES];
        
        if (i == 0) {
            compareRow = row;
            equelNum = 1;
        }else{
            if (compareRow == row) {
                equelNum ++;
            }else{
                equelNum = 1;
            }
            compareRow = row;
        }
        if (equelNum >= _level) {
            isWin = YES;
        }
    }
    if (isWin) {
        _winLabel.text = @"win";
        NSURL *win = [[NSBundle mainBundle]URLForResource:@"win" withExtension:@"wav"];
        [self playSound:win];
    }
    
}

- (void)playSound:(NSURL *)path
{
    SystemSoundID soundID;
    CFURLRef ref = (__bridge CFURLRef)(path);
    
    AudioServicesCreateSystemSoundID(ref, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 6;
}

#pragma mark - picker view delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    if (row == 0) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"apple"]];
        return imageView;
    }else if (row == 1){
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bar"]];
        return imageView;
    }else if (row == 2){
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cherry"]];
        return imageView;
    }else if (row == 3){
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"crown"]];
        return imageView;
    }else if (row == 4){
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lemon"]];
        return imageView;
    }else if (row == 5){
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"seven"]];
        return imageView;
    }
    return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
#if 0
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger first ;
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        first = [pickerView selectedRowInComponent:i];
        [result addObject:@(first)];
    }
    NSString *str = [self compareArray:result andDefault:2];
    _winLabel.text = str;
}

- (NSString *)compareArray:(NSArray *)array andDefault:(NSInteger)count
{
    for (int i = 0; i < array.count - count - 1; i ++) {
        NSArray *arr = [array subarrayWithRange:NSMakeRange(i, count)];

        for ( int k = 0; k < count - 1; k ++) {
            if (arr[k] != arr[k + 1]) {
                return nil;
            }
        }
    }
    return  @"win";
}
#endif

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
