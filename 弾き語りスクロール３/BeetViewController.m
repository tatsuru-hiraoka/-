//
//  BeetViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/04.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import "BeetViewController.h"
#import "Entity.h"

@interface BeetViewController ()

@end

@implementation BeetViewController


//テキストボタンの生成
- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    Button* button=[Button buttonWithType:UIButtonTypeRoundedRect];
    [button.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    return button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenName = NSStringFromClass([self class]);
    [TrackingManager sendScreenTracking:screenName];
    
    NSNumber *num2=self.detailItem.tempo;

    NSInteger value1=[num2 intValue];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    UIPickerView *pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator=YES;
    if (value1<=3) {
        pickerView.tag=1;
    }
    else if(value1<=5){
        pickerView.tag=2;
    }
    else if(value1<=7){
        pickerView.tag=3;
    }
    [self.view addSubview:pickerView];
    UIButton *CopyButton6=[self makeButton:CGRectMake(0, 105, 100, 35) text:NSLocalizedString(@"Done", nil) tag:500];
    [CopyButton6 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton6.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [CopyButton6 addTarget:self action:@selector(ClosePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton6];
    UIButton *CopyButton7=[self makeButton:CGRectMake(100, 105, 100, 35) text:NSLocalizedString(@"▶︎", nil) tag:500];
    [CopyButton7 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton7.backgroundColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    [CopyButton7 addTarget:self action:@selector(Play2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton7];
    //[TrackingManager sendEventTracking:@"Button" action:@"ShowPicker"label:@"ShowPicker2" value:nil screen:screenName];
    value5=18;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//ピッカーの列を指定。
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    switch (pickerView.tag) {
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return YES;
}

//列それぞれの行数を指定。
-(NSInteger) pickerView:(UIPickerView*)pView numberOfRowsInComponent:(NSInteger)component{
    switch (pView.tag) {
        case 1:
            return 5;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 4;
            break;
        default:
            return 0;
            break;
    }
}

//ピッカーに表示される文字や数値を設定。
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 1:
            array1=[NSArray arrayWithObjects:@"1/4",@"2/4",@"3/4",@"4/4",@"5/4",nil];
            return [array1 objectAtIndex:row];
            break;
        case 2:
            array1=[NSArray arrayWithObjects:@"3/8",@"6/8",@"12/8",nil];
            return [array1 objectAtIndex:row];
            break;
        case 3:
            array1=[NSArray arrayWithObjects:@"1/2",@"2/2",@"3/2",@"4/2",nil];
            return [array1 objectAtIndex:row];
            break;
        default:
            break;
    }
    return @"";
}

//ピッカーの選択された値を取得してTextFieldに反映する。
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:
            switch ([pickerView selectedRowInComponent:0]) {
                case 0://1/4
                    value5=8;
                    break;
                case 1://2/4
                    value5=2;
                    break;
                case 2://3/4
                    value5=0;
                    break;
                case 3://4/4
                    value5=1;
                    break;
                case 4://5/4
                    value5=3;
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch ([pickerView selectedRowInComponent:0]) {
                case 0://3/8
                    value5=9;
                    break;
                case 1://6/8
                    value5=4;
                    break;
                case 2://12/8
                    value5=5;
                    break;
                default:
                    break;
            }
            break;
        case 3:
            switch ([pickerView selectedRowInComponent:0]) {
                case 0://1/2
                    value5=10;
                    break;
                case 1://2/2
                    value5=6;
                    break;
                case 2://3/2
                    value5=11;
                    break;
                case 3://4/2
                    value5=7;
                default:
                    break;
            }
            break;
        default:
            value5=[pickerView selectedRowInComponent:0];
            break;
    }
}

-(void)ClosePicker:(id)sender{
    if (value5!=18) {
        [self.delegate BeetViewControllerDelegateDidfinish:value5];
    }
    //NSLog(@"C%ld",(long)value5);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)Play2:(id)sender{
    //scoreviewController3 *score3=[[scoreviewController3 alloc]init];
    //[score3 Play2];
    [self.delegate Play2];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
