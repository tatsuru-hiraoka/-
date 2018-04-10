//
//  PasteViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/13.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import "PasteViewController.h"

@interface PasteViewController ()

@end

@implementation PasteViewController

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
    
    UIButton *CopyButton1=[self makeButton:CGRectMake(0, 0, 200, 100) text:NSLocalizedString(@"Paste", nil) tag:500];
    [CopyButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton1 addTarget:self action:@selector(PasteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton1];
    
    UIButton *CopyButton5=[self makeButton:CGRectMake(0, 100, 200, 35) text:@"×" tag:500];
    [CopyButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton5.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [CopyButton5 addTarget:self action:@selector(Dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)PasteButton:(id)sender{
    [self.delegate PasteButton];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)Dismiss:(id)sender{
    [self.delegate dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
