//
//  DescriptionViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//
#import "DescriptionViewController.h"

@interface DescriptionViewController ()
@end

@implementation DescriptionViewController


//ラベル生成。
-(UILabel*)makeLabel:(CGPoint)pos text:(NSString*)text font:(UIFont*)font{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGRect rect=CGRectMake(pos.x, pos.y, size.width, size.height);
    CGPoint point=CGPointMake(pos.x, pos.y);
    UILabel* label=[[UILabel alloc]init];
    label.adjustsFontSizeToFitWidth=YES;
    label.numberOfLines=0;
    [label setCenter:point];
    [label setFrame:rect];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    return  label;
}
//textfield生成。
-(UITextField*)makeTextField:(CGRect)rect text:(NSString*)text{
    TextField *textfield=[[TextField alloc]init];
    [textfield setFrame:rect];
    [textfield setText:text];
    textfield.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];
    textfield.adjustsFontSizeToFitWidth=YES;
    textfield.textAlignment=NSTextAlignmentCenter;
    [textfield setReturnKeyType:UIReturnKeyDone];
    textfield.enabled=NO;
    textfield.delegate=self;
    return textfield;
}

-(UITextView*)makeTextView:(CGRect)rect text:(NSString*)text{
    TextView *textView=[[TextView alloc]init];
    textView.backgroundColor=[UIColor clearColor];
    CGSize result=[[UIScreen mainScreen]bounds].size;
    CGFloat scale=[UIScreen mainScreen].scale;
    result=CGSizeMake(result.width*scale, result.height*scale);
    if (result.width>=1136) {
        textView.textAlignment=NSTextAlignmentCenter;
        textView.font=[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:15];
    }
    else{textView.font=[UIFont systemFontOfSize:12];
    }
    textView.editable=NO;
    textView.delegate=self;
    return textView;
}

//テキストボタンの生成
- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    Button* button=[Button buttonWithType:UIButtonTypeRoundedRect];
    [button.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    return button;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *screenName = NSStringFromClass([self class]);
    [TrackingManager sendScreenTracking:screenName];
    [TrackingManager sendEventTracking:@"DescriptionViewController" action:@"DescriptionViewController"label:self.navigationItem.title value:nil screen:screenName];
    self.navigationController.toolbarHidden=NO;
    self.navigationController.navigationBarHidden=NO;
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(torikeshi:)];
    self.navigationItem.leftBarButtonItem=cancel;
    //self.view.frame=CGRectMake(0, 0, 480, 330);
    scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scroll.autoresizingMask=UIViewAutoresizingFlexibleWidth;//iOS7では必要
    [self.view addSubview:scroll];
    UITextField *textField1=[self makeTextField:CGRectMake(7,29,self.view.frame.size.width/3.9,75) text:@""];
    [scroll addSubview:textField1];textField1.tag=1;
    textField1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll.safeAreaLayoutGuide
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:7];
    NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:scroll
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:29];
    NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:75];
    NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:.245
                                                                             constant:0];
    [scroll addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
    
    UITextField *textField2=[self makeTextField:CGRectMake(textField1.frame.origin.x+self.view.frame.size.width/3.9-1,29,self.view.frame.size.width/3.9,75) text:@""];
    [scroll addSubview:textField2];textField2.tag=2;
    textField2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint2 = [NSLayoutConstraint constraintWithItem:textField2
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField1.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint2 = [NSLayoutConstraint constraintWithItem:textField2
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:29];
    NSLayoutConstraint *firstHeightConstraint2 = [NSLayoutConstraint constraintWithItem:textField2
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:75];
    NSLayoutConstraint *firstWidthConstraint2 = [NSLayoutConstraint constraintWithItem:textField2
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint2, firstTopConstraint2, firstHeightConstraint2 ,firstWidthConstraint2 ]];
    
    UITextField *textField3=[self makeTextField:CGRectZero text:@""];
    [scroll addSubview:textField3];textField3.tag=3;
    textField3.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint3 = [NSLayoutConstraint constraintWithItem:textField3
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField2.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint3 = [NSLayoutConstraint constraintWithItem:textField3
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:29];
    NSLayoutConstraint *firstHeightConstraint3 = [NSLayoutConstraint constraintWithItem:textField3
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:75];
    NSLayoutConstraint *firstWidthConstraint3 = [NSLayoutConstraint constraintWithItem:textField3
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint3, firstTopConstraint3, firstHeightConstraint3 ,firstWidthConstraint3 ]];
    
    UITextField *textField4=[self makeTextField:CGRectZero text:@""];
    [scroll addSubview:textField4];textField4.tag=4;
    textField4.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint4 = [NSLayoutConstraint constraintWithItem:textField4
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField3.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint4 = [NSLayoutConstraint constraintWithItem:textField4
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:29];
    NSLayoutConstraint *firstHeightConstraint4 = [NSLayoutConstraint constraintWithItem:textField4
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:75];
    NSLayoutConstraint *firstWidthConstraint4 = [NSLayoutConstraint constraintWithItem:textField4
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint4, firstTopConstraint4, firstHeightConstraint4 ,firstWidthConstraint4 ]];
    
    UITextField *textField5=[self makeTextField:CGRectZero text:@""];
    [scroll addSubview:textField5];textField5.tag=5;
    textField5.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint5 = [NSLayoutConstraint constraintWithItem:textField5
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1
                                                                             constant:7];
    NSLayoutConstraint *firstTopConstraint5 = [NSLayoutConstraint constraintWithItem:textField5
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:175];
    NSLayoutConstraint *firstHeightConstraint5 = [NSLayoutConstraint constraintWithItem:textField5
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:75];
    NSLayoutConstraint *firstWidthConstraint5 = [NSLayoutConstraint constraintWithItem:textField5
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint5, firstTopConstraint5, firstHeightConstraint5 ,firstWidthConstraint5 ]];
    
    UITextField *textField6=[self makeTextField:CGRectZero text:@""];
    [scroll addSubview:textField6];textField6.tag=6;
    textField6.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint6 = [NSLayoutConstraint constraintWithItem:textField6
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField5.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint6 = [NSLayoutConstraint constraintWithItem:textField6
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:175];
    NSLayoutConstraint *firstHeightConstraint6 = [NSLayoutConstraint constraintWithItem:textField6
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:75];
    NSLayoutConstraint *firstWidthConstraint6 = [NSLayoutConstraint constraintWithItem:textField6
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint6, firstTopConstraint6, firstHeightConstraint6 ,firstWidthConstraint6 ]];
    
    UITextField *textField7=[self makeTextField:CGRectZero text:@""];
    [scroll addSubview:textField7];textField7.tag=7;
    textField7.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint7 = [NSLayoutConstraint constraintWithItem:textField7
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField6.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint7 = [NSLayoutConstraint constraintWithItem:textField7
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:175];
    NSLayoutConstraint *firstHeightConstraint7 = [NSLayoutConstraint constraintWithItem:textField7
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:75];
    NSLayoutConstraint *firstWidthConstraint7 = [NSLayoutConstraint constraintWithItem:textField7
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint7, firstTopConstraint7, firstHeightConstraint7 ,firstWidthConstraint7 ]];
    
    UITextField *textField8=[self makeTextField:CGRectZero text:@""];
    [scroll addSubview:textField8];textField8.tag=8;
    textField8.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint8 = [NSLayoutConstraint constraintWithItem:textField8
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField7.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint8 = [NSLayoutConstraint constraintWithItem:textField8
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:175];
    NSLayoutConstraint *firstHeightConstraint8 = [NSLayoutConstraint constraintWithItem:textField8
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:75];
    NSLayoutConstraint *firstWidthConstraint8 = [NSLayoutConstraint constraintWithItem:textField8
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint8, firstTopConstraint8, firstHeightConstraint8 ,firstWidthConstraint8 ]];
    
    compButton1=[self makeButton:CGRectZero text:@"1" tag:0];
    [compButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [scroll addSubview:compButton1];
    compButton1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint9 = [NSLayoutConstraint constraintWithItem:compButton1
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1
                                                                             constant:7];
    NSLayoutConstraint *firstTopConstraint9 = [NSLayoutConstraint constraintWithItem:compButton1
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:5];
    NSLayoutConstraint *firstHeightConstraint9 = [NSLayoutConstraint constraintWithItem:compButton1
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:24];
    NSLayoutConstraint *firstWidthConstraint9 = [NSLayoutConstraint constraintWithItem:compButton1
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField1.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.25
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint9, firstTopConstraint9, firstHeightConstraint9 ,firstWidthConstraint9 ]];
    
    compButton2=[self makeButton:CGRectZero text:@"2" tag:0];
    [compButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [scroll addSubview:compButton2];
    compButton2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint10 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField1.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint10 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:5];
    NSLayoutConstraint *firstHeightConstraint10 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:24];
    NSLayoutConstraint *firstWidthConstraint10 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField2.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.25
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint10, firstTopConstraint10, firstHeightConstraint10 ,firstWidthConstraint10 ]];
    
    compButton3=[self makeButton:CGRectMake(self.view.frame.size.width/2-1,5,self.view.frame.size.width/16,24) text:@"3" tag:0];
    [compButton3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton3.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [scroll addSubview:compButton3];
    compButton3.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint11 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField2.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint11 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:5];
    NSLayoutConstraint *firstHeightConstraint11 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:24];
    NSLayoutConstraint *firstWidthConstraint11 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField3.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.25
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint11, firstTopConstraint11, firstHeightConstraint11 ,firstWidthConstraint11 ]];
    
    compButton4=[self makeButton:CGRectZero text:@"4" tag:0];
    [compButton4 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton4.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [scroll addSubview:compButton4];
    compButton4.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint12 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField3.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint12 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:5];
    NSLayoutConstraint *firstHeightConstraint12 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:24];
    NSLayoutConstraint *firstWidthConstraint12 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField4.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.25
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint12, firstTopConstraint12, firstHeightConstraint12 ,firstWidthConstraint12 ]];
    
    compButton5=[self makeButton:CGRectMake(7,151,self.view.frame.size.width/16,24) text:@"5" tag:5];
    [compButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton5.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [scroll addSubview:compButton5];
    compButton5.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint13 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1
                                                                              constant:7];
    NSLayoutConstraint *firstTopConstraint13 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:151];
    NSLayoutConstraint *firstHeightConstraint13 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:24];
    NSLayoutConstraint *firstWidthConstraint13 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField1.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.25
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint13, firstTopConstraint13, firstHeightConstraint13 ,firstWidthConstraint13 ]];
    
    UIButton *compButton6=[self makeButton:CGRectZero text:@"6" tag:0];
    [compButton6 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton6.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [scroll addSubview:compButton6];
    compButton6.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint14 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField1.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint14 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:151];
    NSLayoutConstraint *firstHeightConstraint14 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:24];
    NSLayoutConstraint *firstWidthConstraint14 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField2.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.25
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint14, firstTopConstraint14, firstHeightConstraint14 ,firstWidthConstraint14 ]];
    
    UIButton *compButton7=[self makeButton:CGRectZero text:@"7" tag:0];
    [compButton7 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton7.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [scroll addSubview:compButton7];
    compButton7.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint15 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField2.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint15 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:151];
    NSLayoutConstraint *firstHeightConstraint15 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:24];
    NSLayoutConstraint *firstWidthConstraint15 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField3.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.25
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint15, firstTopConstraint15, firstHeightConstraint15 ,firstWidthConstraint15 ]];
    
    compButton8=[self makeButton:CGRectZero text:@"8" tag:0];
    [compButton8 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton8.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [scroll addSubview:compButton8];
    compButton8.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint16 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField3.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint16 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:151];
    NSLayoutConstraint *firstHeightConstraint16 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:24];
    NSLayoutConstraint *firstWidthConstraint16 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField4.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.25
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint16, firstTopConstraint16, firstHeightConstraint16 ,firstWidthConstraint16 ]];
    
    UITextView *textview1=[self makeTextView:CGRectZero text:@""];
    [scroll addSubview:textview1];
    textview1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint17 = [NSLayoutConstraint constraintWithItem:textview1
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1
                                                                              constant:7];
    NSLayoutConstraint *firstTopConstraint17 = [NSLayoutConstraint constraintWithItem:textview1
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:98];
    NSLayoutConstraint *firstHeightConstraint17 = [NSLayoutConstraint constraintWithItem:textview1
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:53];
    NSLayoutConstraint *firstWidthConstraint17 = [NSLayoutConstraint constraintWithItem:textview1
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.245
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint17, firstTopConstraint17, firstHeightConstraint17 ,firstWidthConstraint17 ]];
    
    UITextView *textview2=[self makeTextView:CGRectZero text:@""];
    [scroll addSubview:textview2];
    textview2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint18 = [NSLayoutConstraint constraintWithItem:textview2
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField1.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint18 = [NSLayoutConstraint constraintWithItem:textview2
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:98];
    NSLayoutConstraint *firstHeightConstraint18 = [NSLayoutConstraint constraintWithItem:textview2
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:53];
    NSLayoutConstraint *firstWidthConstraint18 = [NSLayoutConstraint constraintWithItem:textview2
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.245
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint18, firstTopConstraint18, firstHeightConstraint18 ,firstWidthConstraint18 ]];
    
    UITextView *textview3=[self makeTextView:CGRectZero text:@""];
    [scroll addSubview:textview3];
    textview3.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint19 = [NSLayoutConstraint constraintWithItem:textview3
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField2.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint19 = [NSLayoutConstraint constraintWithItem:textview3
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:98];
    NSLayoutConstraint *firstHeightConstraint19 = [NSLayoutConstraint constraintWithItem:textview3
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:53];
    NSLayoutConstraint *firstWidthConstraint19 = [NSLayoutConstraint constraintWithItem:textview3
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.245
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint19, firstTopConstraint19, firstHeightConstraint19 ,firstWidthConstraint19 ]];
    
    UITextView *textview4=[self makeTextView:CGRectZero text:@""];
    [scroll addSubview:textview4];
    textview4.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint20 = [NSLayoutConstraint constraintWithItem:textview4
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField3.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint20 = [NSLayoutConstraint constraintWithItem:textview4
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:98];
    NSLayoutConstraint *firstHeightConstraint20 = [NSLayoutConstraint constraintWithItem:textview4
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:53];
    NSLayoutConstraint *firstWidthConstraint20 = [NSLayoutConstraint constraintWithItem:textview4
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.245
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint20, firstTopConstraint20, firstHeightConstraint20 ,firstWidthConstraint20 ]];
    
    UITextView *textview5=[self makeTextView:CGRectZero text:@""];
    [scroll addSubview:textview5];
    textview5.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint21 = [NSLayoutConstraint constraintWithItem:textview5
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1
                                                                              constant:7];
    NSLayoutConstraint *firstTopConstraint21 = [NSLayoutConstraint constraintWithItem:textview5
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:244];
    NSLayoutConstraint *firstHeightConstraint21 = [NSLayoutConstraint constraintWithItem:textview5
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:53];
    NSLayoutConstraint *firstWidthConstraint21 = [NSLayoutConstraint constraintWithItem:textview5
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.245
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint21, firstTopConstraint21, firstHeightConstraint21 ,firstWidthConstraint21 ]];
    
    UITextView *textview6=[self makeTextView:CGRectZero text:@""];
    [scroll addSubview:textview6];
    textview6.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint22 = [NSLayoutConstraint constraintWithItem:textview6
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField5.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint22 = [NSLayoutConstraint constraintWithItem:textview6
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:244];
    NSLayoutConstraint *firstHeightConstraint22 = [NSLayoutConstraint constraintWithItem:textview6
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:53];
    NSLayoutConstraint *firstWidthConstraint22 = [NSLayoutConstraint constraintWithItem:textview6
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.245
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint22, firstTopConstraint22, firstHeightConstraint22 ,firstWidthConstraint22 ]];
    
    UITextView *textview7=[self makeTextView:CGRectZero text:@""];
    [scroll addSubview:textview7];
    textview7.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint23 = [NSLayoutConstraint constraintWithItem:textview7
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField6.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint23 = [NSLayoutConstraint constraintWithItem:textview7
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:244];
    NSLayoutConstraint *firstHeightConstraint23 = [NSLayoutConstraint constraintWithItem:textview7
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:53];
    NSLayoutConstraint *firstWidthConstraint23 = [NSLayoutConstraint constraintWithItem:textview7
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.245
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint23, firstTopConstraint23, firstHeightConstraint23 ,firstWidthConstraint23 ]];
    
    UITextView *textview8=[self makeTextView:CGRectZero text:@""];
    [scroll addSubview:textview8];
    textview8.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint24 = [NSLayoutConstraint constraintWithItem:textview8
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField7.safeAreaLayoutGuide
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-1];
    NSLayoutConstraint *firstTopConstraint24 = [NSLayoutConstraint constraintWithItem:textview8
                                                                            attribute:NSLayoutAttributeTop
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:244];
    NSLayoutConstraint *firstHeightConstraint24 = [NSLayoutConstraint constraintWithItem:textview8
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:53];
    NSLayoutConstraint *firstWidthConstraint24 = [NSLayoutConstraint constraintWithItem:textview8
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll.safeAreaLayoutGuide
                                                                              attribute:NSLayoutAttributeWidth
                                                                             multiplier:.245
                                                                               constant:0];
    [scroll addConstraints:@[firstLeftConstraint24, firstTopConstraint24, firstHeightConstraint24 ,firstWidthConstraint24 ]];
    
    UIBarButtonItem *play=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:nil];
    UIBarButtonItem *stop=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:nil];
    UIBarButtonItem *rewind=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:nil];
    UIBarButtonItem *spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    play.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    stop.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    rewind.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"4/4  %d",120] style:UIBarButtonItemStylePlain target:self action:nil];
    tempolabel.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    copy=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Font&Color", nil)] style:UIBarButtonItemStylePlain target:self action:nil];
    copy.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    
    NSArray *items1=[NSArray arrayWithObjects:tempolabel,spacer,copy,spacer,rewind,spacer,play,spacer,nil];
    
    self.toolbarItems=items1;
    if ([self.title isEqualToString:NSLocalizedString(@"The input of the chord and lyrics", nil)]) {
        [self menu4];
    }
    else if ([self.title isEqualToString:NSLocalizedString(@"Scrolling and Tempo", nil)]) {
        [self showPicker];
    }
    else if([self.title isEqualToString:NSLocalizedString(@"Change the time signature in the midddle of a song", nil)]) {
        [self menu];
    }
    else if([self.title isEqualToString:NSLocalizedString(@"Start from the middle of the song", nil)]) {
        [self menu];
    }
    else if([self.title isEqualToString:NSLocalizedString(@"Transposition and copy paste", nil)]) {
        [self menu2];
    }
    else if([self.title isEqualToString:NSLocalizedString(@"Change of color and font", nil)]) {
        [self menu3];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//ピッカーの列を指定。
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    switch (pickerView.tag) {
        case 1:
            return 2;
            break;
        case 2:
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
            switch (component) {
                case 0:return 8;
                case 1:return 151;
                default:return 0;
            }
            break;
        case 2:
            return 5;
            break;
        default:
            break;
    }
    return YES;
}

//ピッカーに表示される文字や数値を設定。
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 1:
            array1=[NSArray arrayWithObjects:@"3/4",@"4/4",@"2/4",@"5/4",@"6/8",@"12/8",@"2/2",@"4/2",nil];
            array2=[NSArray arrayWithObjects:@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",@"81",@"82",@"83",@"84",@"85",@"86",@"87",@"88",@"89",@"90",@"91",@"92",@"93",@"94",@"95",@"96",@"97",@"98",@"99",@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"109",@"110",@"111",@"112",@"113",@"114",@"115",@"116",@"117",@"118",@"119",@"120",@"121",@"122",@"123",@"124",@"125",@"126",@"127",@"128",@"129",@"130",@"131",@"132",@"133",@"134",@"135",@"136",@"137",@"138",@"139",@"140",@"141",@"142",@"143",@"144",@"145",@"146",@"147",@"148",@"149",@"150",@"151",@"152",@"153",@"154",@"155",@"156",@"157",@"158",@"159",@"160",@"161",@"162",@"163",@"164",@"165",@"166",@"167",@"168",@"169",@"170",@"171",@"172",@"173",@"174",@"175",@"176",@"177",@"178",@"179",@"180",@"181",@"182",@"183",@"184",@"185",@"186",@"187",@"188",@"189",@"190",@"191",@"192",@"193",@"194",@"195",@"196",@"197",@"198",@"199",@"200",nil];
            switch (component) {
                case 0:return [array1 objectAtIndex:row];
                case 1:return [array2 objectAtIndex:row];
            }
            break;
        case 2:
            array1=[NSArray arrayWithObjects:@"1/4",@"2/4",@"3/4",@"4/4",@"5/4",nil];
            return [array1 objectAtIndex:row];
            break;
        default:
            break;
    }
    return @"";
}

-(void)showPicker{
    navBarLeftButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"A maseege"];
    [self.view addSubview:navBarLeftButtonPopTipView];
    navBarLeftButtonPopTipView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:compButton5
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:-5];
    NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view.safeAreaLayoutGuide
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-130];
    [self.view addConstraints:@[LeftConstraint,TopConstraint ]];
    navBarLeftButtonPopTipView.backgroundColor=[UIColor lightGrayColor];
        
    UIView *alertController=[[UIView alloc]initWithFrame:CGRectMake(3, 7, 148, 100)];
    alertController.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [navBarLeftButtonPopTipView addSubview:alertController];
    alertController.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint1 = [NSLayoutConstraint constraintWithItem:alertController
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:navBarLeftButtonPopTipView
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:3];
    NSLayoutConstraint *blueRightConstraint1 = [NSLayoutConstraint constraintWithItem:alertController
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:navBarLeftButtonPopTipView
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:0
                                                                             constant:148];
    NSLayoutConstraint *blueHeightConstraint1 = [NSLayoutConstraint constraintWithItem:alertController
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:100];
    NSLayoutConstraint *blueTopConstraint1 = [NSLayoutConstraint constraintWithItem:alertController
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:navBarLeftButtonPopTipView
                                                                          attribute:NSLayoutAttributeTop                                                                        multiplier:1
                                                                           constant:0];
    [navBarLeftButtonPopTipView addConstraints:@[blueLeftConstraint1, blueRightConstraint1, blueHeightConstraint1 ,blueTopConstraint1 ]];
    UIPickerView *pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 148, 100)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator=YES;
    pickerView.tag=1;
    
    [pickerView selectRow:70 inComponent:1 animated:NO];
    
    [pickerView selectRow:1 inComponent:0 animated:NO];
    [alertController addSubview:pickerView];
    
    UIButton *CopyButton5=[self makeButton:CGRectMake(3, 100, 148, 30) text:@"×" tag:500];
    [CopyButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton5.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton5.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton5];
    navBarLeftButtonPopTipView.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];
    
    UILabel *label1=[self makeLabel:CGPointZero text:NSLocalizedString(@"Tempo", nil)font:[UIFont systemFontOfSize:20]];
    label1.backgroundColor=[UIColor yellowColor];
    [alertController addSubview:label1];
    label1.numberOfLines=0;
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:alertController
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
    NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:alertController
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:1.5
                                                                            constant:0];
    NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:50];
    NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:alertController
                                                                         attribute:NSLayoutAttributeTop                                                                        multiplier:1
                                                                          constant:-10];
    [alertController addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
        
    UILabel *label2=[self makeLabel:CGPointZero text:NSLocalizedString(@"Scroll", nil)font:[UIFont systemFontOfSize:20]];
    label2.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:label2];
    label2.numberOfLines=0;
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint2 = [NSLayoutConstraint constraintWithItem:label2
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view.safeAreaLayoutGuide
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1
                                                                            constant:-40];
    NSLayoutConstraint *blueRightConstraint2 = [NSLayoutConstraint constraintWithItem:label2
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view.safeAreaLayoutGuide
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:0
                                                                             constant:148];
    NSLayoutConstraint *blueHeightConstraint2 = [NSLayoutConstraint constraintWithItem:label2
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:50];
    NSLayoutConstraint *blueTopConstraint2 = [NSLayoutConstraint constraintWithItem:label2
                                                                          attribute:NSLayoutAttributeBottom
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view.safeAreaLayoutGuide
                                                                          attribute:NSLayoutAttributeBottom
                                                                         multiplier:1
                                                                           constant:-10];
    [self.view addConstraints:@[blueLeftConstraint2, blueRightConstraint2, blueHeightConstraint2 ,blueTopConstraint2 ]];
}

-(void)PickerViewControllerDelegateDidfinish:(NSInteger)getData{
    
}

-(void)PickerViewControllerDelegateDidfinish2:(NSInteger)getData2;{
    
}

-(void)menu{
    navBarLeftButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"A maseege"];
    [self.view addSubview:navBarLeftButtonPopTipView];
    navBarLeftButtonPopTipView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:compButton1
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:-5];
    NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:compButton1
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-5];
    [self.view addConstraints:@[LeftConstraint,TopConstraint ]];
    navBarLeftButtonPopTipView.backgroundColor=[UIColor lightGrayColor];
    
    UIView *alertController=[[UIView alloc]initWithFrame:CGRectMake(5, 7, 150, 90)];
    alertController.backgroundColor=[UIColor lightGrayColor];
    [navBarLeftButtonPopTipView addSubview:alertController];
    UIPickerView *pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 150, 90)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator=YES;
    pickerView.tag=2;
    [alertController addSubview:pickerView];
    
    UIButton *CopyButton5=[self makeButton:CGRectMake(5, 95, 50, 30) text:@"×" tag:500];
    [CopyButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton5.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton5.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton5];
    UIButton *CopyButton6=[self makeButton:CGRectMake(55, 95, 50, 30) text:NSLocalizedString(@"Done", nil) tag:500];
    [CopyButton6 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton6.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton6.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton6];
    UIButton *CopyButton7=[self makeButton:CGRectMake(105, 95, 50, 30) text:NSLocalizedString(@"▶︎", nil) tag:500];
    [CopyButton7 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton7.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton7.backgroundColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton7];
    
    UILabel *label1=[self makeLabel:CGPointZero text:NSLocalizedString(@"Start", nil)font:[UIFont systemFontOfSize:15]];
    label1.backgroundColor=[UIColor yellowColor];
    [alertController addSubview:label1];
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:alertController
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
    NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:alertController
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:2
                                                                            constant:0];
    NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:100];
    NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:alertController
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1
                                                                          constant:30];
    [alertController addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
}

-(void)menu2{
    navBarLeftButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"A maseege"];
    [self.view addSubview:navBarLeftButtonPopTipView];
    navBarLeftButtonPopTipView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:compButton4
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:-5];
    NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:compButton4
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-5];
    [self.view addConstraints:@[LeftConstraint,TopConstraint ]];
    UIButton *CopyButton1=[self makeButton:CGRectMake(5, 7, 140, 30) text:NSLocalizedString(@"Chord Copy", nil) tag:500];
    [CopyButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    [navBarLeftButtonPopTipView addSubview:CopyButton1];
    
    UIButton *CopyButton2=[self makeButton:CGRectMake(5, 37, 140, 30) text:NSLocalizedString(@"Lyrics Copy", nil) tag:500];
    [CopyButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton2];
    
    UIButton *CopyButton3=[self makeButton:CGRectMake(5, 67, 70, 30) text:@"♭" tag:500];
    [CopyButton3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton3.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton3.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton3];
    
    UIButton *CopyButton4=[self makeButton:CGRectMake(75, 67, 70, 30) text:@"#" tag:500];
    [CopyButton4 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton4.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton4.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton4];
    
    UIButton *CopyButton5=[self makeButton:CGRectMake(5, 97, 140, 28) text:@"×" tag:500];
    [CopyButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton5.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton5.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton5];
    
    compButton1.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
    compButton2.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
    compButton3.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
    compButton4.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
    
    navBarLeftButtonPopTipView2 = [[CMPopTipView alloc] initWithMessage:@"A maseege"];
    [self.view addSubview:navBarLeftButtonPopTipView2];
    navBarLeftButtonPopTipView2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint2 = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView2
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton5
                                                                       attribute:NSLayoutAttributeLeft
                                                                      multiplier:1
                                                                        constant:-5];
    NSLayoutConstraint *TopConstraint2 = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView2
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:compButton5
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1
                                                                       constant:-5];
    [self.view addConstraints:@[LeftConstraint2,TopConstraint2 ]];
    UIButton *CopyButton6=[self makeButton:CGRectMake(5, 7, 140, 83) text:@"Paste" tag:500];
    [CopyButton6 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [navBarLeftButtonPopTipView2 addSubview:CopyButton6];
    
    UIButton *CopyButton7=[self makeButton:CGRectMake(5, 85, 140, 30) text:@"×" tag:500];
    [CopyButton7 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton7.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton7.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [navBarLeftButtonPopTipView2 addSubview:CopyButton7];
    
    UILabel *label1=[self makeLabel:CGPointZero text:NSLocalizedString(@"Copy", nil)font:[UIFont systemFontOfSize:15]];
    label1.backgroundColor=[UIColor yellowColor];
    [CopyButton7 addSubview:label1];
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:CopyButton7
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
    NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:CopyButton7
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:2
                                                                            constant:0];
    NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:100];
    NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:CopyButton7
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:-220];
    [CopyButton7 addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
    
    UILabel *label2=[self makeLabel:CGPointZero text:NSLocalizedString(@"Transpose", nil)font:[UIFont systemFontOfSize:20]];
    label2.backgroundColor=[UIColor yellowColor];
    [CopyButton5 addSubview:label2];
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint2 = [NSLayoutConstraint constraintWithItem:label2
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:CopyButton5
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1
                                                                            constant:0];
    NSLayoutConstraint *blueRightConstraint2 = [NSLayoutConstraint constraintWithItem:label2
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:CopyButton5
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:1
                                                                             constant:0];
    NSLayoutConstraint *blueHeightConstraint2 = [NSLayoutConstraint constraintWithItem:label2
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:100];
    NSLayoutConstraint *blueTopConstraint2 = [NSLayoutConstraint constraintWithItem:label2
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:CopyButton5
                                                                          attribute:NSLayoutAttributeBottom
                                                                         multiplier:1
                                                                           constant:5];
    [CopyButton5 addConstraints:@[blueLeftConstraint2, blueRightConstraint2, blueHeightConstraint2 ,blueTopConstraint2 ]];
}
-(void)menu3{
    navBarLeftButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"A massege"];
    [self.view addSubview:navBarLeftButtonPopTipView];
    navBarLeftButtonPopTipView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:compButton2
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:-5];
    NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:navBarLeftButtonPopTipView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view.safeAreaLayoutGuide
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-140];
    [self.view addConstraints:@[LeftConstraint,TopConstraint ]];
    UIButton *CopyButton1=[self makeButton:CGRectMake(5, 7, 148, 25) text:@"Chord Font" tag:500];
    [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    [CopyButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [navBarLeftButtonPopTipView addSubview:CopyButton1];
    
    UIButton *CopyButton2=[self makeButton:CGRectMake(5, 32, 148, 25) text:@"Lyrics Font" tag:500];
    [CopyButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    [CopyButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton2];
    
    UIButton *CopyButton3=[self makeButton:CGRectMake(5, 57, 148, 25) text:@"Chord Color" tag:500];
    [CopyButton3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton3.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton3.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton3];
    
    UIButton *CopyButton4=[self makeButton:CGRectMake(5, 82, 148, 25) text:@"Lyrics Color" tag:500];
    [CopyButton4 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton4.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton4.backgroundColor=[UIColor colorWithRed:1/255.0 green:31/255.0 blue:141/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton4];
    
    UIButton *CopyButton5=[self makeButton:CGRectMake(5, 107, 148, 27) text:@"×" tag:500];
    [CopyButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton5.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton5.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [navBarLeftButtonPopTipView addSubview:CopyButton5];
    
    UILabel *label1=[self makeLabel:CGPointZero text:NSLocalizedString(@"Font", nil)font:[UIFont systemFontOfSize:15]];
    label1.backgroundColor=[UIColor yellowColor];
    [CopyButton1 addSubview:label1];
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:CopyButton1
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
    NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:CopyButton1
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:1
                                                                            constant:0];
    NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:50];
    NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:CopyButton1
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:-10];
    [CopyButton1 addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
}

-(void)menu4{
    UILabel *label1=[self makeLabel:CGPointZero text:NSLocalizedString(@"Onpu", nil)font:[UIFont systemFontOfSize:20]];
    label1.backgroundColor=[UIColor yellowColor];
    [scroll addSubview:label1];
    label1.numberOfLines=0;//表示可能行数０は無制限
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:scroll.safeAreaLayoutGuide
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:70];
    NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll.safeAreaLayoutGuide
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:.7
                                                                            constant:1];
    NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:100];
    NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:scroll
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:60];
    [scroll addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}

-(void)dismiss{
    [navBarLeftButtonPopTipView dismissAnimated:YES];
}

-(void)configureView{
    
}

-(void)torikeshi:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismiss];
}

@end
