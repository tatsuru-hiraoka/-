//
//  CopyViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/12.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import "CopyViewController.h"

@interface CopyViewController ()

@end

@implementation CopyViewController

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
    
    UIButton *CopyButton1=[self makeButton:CGRectMake(0, 0, 200, 35) text:NSLocalizedString(@"Chord Copy", nil) tag:500];
    [CopyButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton1 addTarget:self action:@selector(ChordCopyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton1];
    
    UIButton *CopyButton2=[self makeButton:CGRectMake(0, 35, 200, 35) text:NSLocalizedString(@"Lyrics Copy", nil) tag:500];
    [CopyButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [CopyButton2 addTarget:self action:@selector(LyricsCopyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton2];
    
    UIButton *CopyButton3=[self makeButton:CGRectMake(0, 70, 100, 35) text:@"♭" tag:500];
    [CopyButton3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton3.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [CopyButton3 addTarget:self action:@selector(Flat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton3];
    
    UIButton *CopyButton4=[self makeButton:CGRectMake(100, 70, 100, 35) text:@"#" tag:500];
    [CopyButton4 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton4.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [CopyButton4 addTarget:self action:@selector(Sharp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton4];
    
    UIButton *CopyButton5=[self makeButton:CGRectMake(0, 105, 200, 35) text:@"×" tag:500];
    [CopyButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton5.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [CopyButton5 addTarget:self action:@selector(Dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)ChordCopyButton:(id)sender{
    [self.delegate ChordCopyButton];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)LyricsCopyButton:(id)sender{
    [self.delegate LyricsCopyButton];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)Sharp:(id)sender{
    [self.delegate Sharp];
}

-(void)Flat:(id)sender{
    [self.delegate Flat];
}

-(void)Dismiss:(id)sender{
    [self.delegate dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
