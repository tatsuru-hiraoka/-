//
//  PickerViewViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/13.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    Button* button=[Button buttonWithType:UIButtonTypeRoundedRect];
    [button.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    return button;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    screenName = NSStringFromClass([self class]);
    [TrackingManager sendScreenTracking:screenName];
    
    UIPickerView *pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 200, 165)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator=YES;
    pickerView.tag=1;
    if (self.detailItem) {
        NSNumber *num=self.detailItem.slider;
        int tempovalue1=[num intValue];
        [pickerView selectRow:tempovalue1 inComponent:1 animated:NO];
        NSNumber *num2=self.detailItem.tempo;
        int tempovalue=[num2 intValue];
        [pickerView selectRow:tempovalue inComponent:0 animated:NO];
    }
    [self.view addSubview:pickerView];
    
    UIButton *CopyButton6=[self makeButton:CGRectMake(0, 165, 100, 35) text:NSLocalizedString(@"Cancel", nil) tag:500];
    [CopyButton6 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton6.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [CopyButton6 addTarget:self action:@selector(Cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton6];
    UIButton *CopyButton7=[self makeButton:CGRectMake(100, 165, 100, 35) text:NSLocalizedString(@"Done", nil) tag:500];
    [CopyButton7 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton7.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [CopyButton7 addTarget:self action:@selector(ClosePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton7];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//ピッカーの列を指定。
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//列それぞれの行数を指定。
-(NSInteger) pickerView:(UIPickerView*)pView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:return 8;
        case 1:return 151;
        default:return 0;
    }
}

//ピッカーに表示される文字や数値を設定。
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSArray *array1=[NSArray arrayWithObjects:@"3/4",@"4/4",@"2/4",@"5/4",@"6/8",@"12/8",@"2/2",@"4/2",nil];
    NSArray *array2=[NSArray arrayWithObjects:@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",@"81",@"82",@"83",@"84",@"85",@"86",@"87",@"88",@"89",@"90",@"91",@"92",@"93",@"94",@"95",@"96",@"97",@"98",@"99",@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"109",@"110",@"111",@"112",@"113",@"114",@"115",@"116",@"117",@"118",@"119",@"120",@"121",@"122",@"123",@"124",@"125",@"126",@"127",@"128",@"129",@"130",@"131",@"132",@"133",@"134",@"135",@"136",@"137",@"138",@"139",@"140",@"141",@"142",@"143",@"144",@"145",@"146",@"147",@"148",@"149",@"150",@"151",@"152",@"153",@"154",@"155",@"156",@"157",@"158",@"159",@"160",@"161",@"162",@"163",@"164",@"165",@"166",@"167",@"168",@"169",@"170",@"171",@"172",@"173",@"174",@"175",@"176",@"177",@"178",@"179",@"180",@"181",@"182",@"183",@"184",@"185",@"186",@"187",@"188",@"189",@"190",@"191",@"192",@"193",@"194",@"195",@"196",@"197",@"198",@"199",@"200",nil];
    switch (component) {
        case 0:return [array1 objectAtIndex:row];
        case 1:return [array2 objectAtIndex:row];
    }
    return @"";
}

//ピッカーの選択された値を取得してTextFieldに反映する。
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    long value1=[pickerView selectedRowInComponent:0];
    long value2=[pickerView selectedRowInComponent:1];
    
    [self.delegate PickerViewControllerDelegateDidfinish:value1];
    [self.delegate PickerViewControllerDelegateDidfinish2:value2];
}

-(void)Cancel:(id)sender{
    [self.delegate configureView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ClosePicker:(id)sender{
    [self.delegate dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
