//
//  infomationViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "infomationViewController.h"
#import "AppDelegate.h"
#import "Entity.h"
@interface infomationViewController ()
-(void)configureView;
@end

@implementation infomationViewController
@synthesize managedObjectContext;

//ラベル生成。
-(UILabel*)makeLabel:(CGPoint)pos text:(NSString*)text font:(UIFont*)font{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGRect rect=CGRectMake(pos.x, pos.y, size.width, size.height);
    CGPoint point=CGPointMake(pos.x, pos.y);
    
    UILabel* label=[[UILabel alloc]init];
    [label setCenter:point];
    [label setFrame:rect];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setBackgroundColor:[UIColor clearColor]];
    return  label;
}

//textfield生成。
-(UITextField*)makeTextField:(CGRect)rect text:(NSString*)text{
    UITextField* textField=[[UITextField alloc]init];
    [textField setFrame:rect];
    [textField setText:text];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setTextAlignment:NSTextAlignmentCenter];
    textField.adjustsFontSizeToFitWidth=YES;
    [textField setReturnKeyType:UIReturnKeyDone];
    textField.delegate=self;
    
    return textField;
}

-(void)setDetailItem:(id)newDatailItem{
    if(_detailItem !=newDatailItem){
        _detailItem=newDatailItem;
    }
}

-(void)configureView{
    [self becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.toolbarHidden=YES;
    self.navigationController.navigationBarHidden=NO;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //必要
    if (self.managedObjectContext==nil) {
        managedObjectContext=[(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];
    }
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(torikeshi:)];
    self.navigationItem.leftBarButtonItem=cancel;
    
    save=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    [self.navigationItem setRightBarButtonItem:save animated:YES];
    self.navigationController.toolbarHidden=YES;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
        info=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1100)];
        scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];//frameだと回転時にずれる
        [scroll addSubview:info];
        scroll.contentSize=CGSizeMake(0,500);
        [self.view addSubview:scroll];
        UILabel *label1=[self makeLabel:CGPointZero text:NSLocalizedString(@"Title", nil)font:[UIFont systemFontOfSize:20]];
        CGPoint point1=CGPointMake(160,20);label1.center=point1;
        [info addSubview:label1];
        UILabel *label2=[self makeLabel:CGPointZero text:NSLocalizedString(@"Artist", nil) font:[UIFont systemFontOfSize:20]];
        CGPoint point2=CGPointMake(160,85);label2.center=point2;
        [info addSubview:label2];
        UILabel *label3=[self makeLabel:CGPointZero text:NSLocalizedString(@"Composer", nil)font:[UIFont systemFontOfSize:20]];
        CGPoint point3=CGPointMake(160,155);label3.center=point3;
        [info addSubview:label3];
        textField1=[self makeTextField:CGRectMake(0, 0, info.frame.size.width, 30) text:@""];
        CGPoint point4=CGPointMake(160,50);textField1.center=point4;
        [scroll addSubview:textField1];
        textField2=[self makeTextField:CGRectMake(0, 0, info.frame.size.width, 30) text:@""];
        CGPoint point5=CGPointMake(160,120);textField2.center=point5;
        [scroll addSubview:textField2];textField2.tag=1;
        textField3=[self makeTextField:CGRectMake(0, 0, info.frame.size.width, 30) text:@""];
        CGPoint point6=CGPointMake(160,190);textField3.center=point6;
        [scroll addSubview:textField3];
        UILabel *label4=[self makeLabel:CGPointZero text:NSLocalizedString(@"Memo", nil)font:[UIFont systemFontOfSize:20]];
        CGPoint point7=CGPointMake(160,225);label4.center=point7;
        [info addSubview:label4];
        textview=[[UITextView alloc]initWithFrame:CGRectMake(0, 245, info.frame.size.width, 400)];
        textview.font=[UIFont systemFontOfSize:20];textview.delegate=self;
        [[textview layer]setCornerRadius:8];
        [textview setClipsToBounds:YES];
        [[textview layer]setBorderColor:[[UIColor lightGrayColor]CGColor]];
        [[textview layer]setBorderWidth:1];
        [scroll addSubview:textview];
    }
    else{
        info=[[UIView alloc]initWithFrame:self.view.frame];
        scroll=[[UIScrollView alloc]initWithFrame:self.view.frame];
        [scroll addSubview:info];
        scroll.contentSize=CGSizeMake(0,500);
        [self.view addSubview:scroll];
        UILabel *label1=[self makeLabel:CGPointZero text:NSLocalizedString(@"Title", nil)font:[UIFont systemFontOfSize:20]];
        //label1.backgroundColor=[UIColor greenColor];
        [info addSubview:label1];
        label1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:info
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1
                                                                               constant:90];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:info
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:-90];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:20];
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:label1
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:info
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1
                                                                              constant:10];
        [info addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
        UILabel *label2=[self makeLabel:CGPointZero text:NSLocalizedString(@"Artist", nil)font:[UIFont systemFontOfSize:20]];
        //label2.backgroundColor=[UIColor magentaColor];
        [info addSubview:label2];
        label2.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:label2
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:info
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:90];
        NSLayoutConstraint *RightConstraint = [NSLayoutConstraint constraintWithItem:label2
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:info
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1
                                                                            constant:-90];
        NSLayoutConstraint *HeightConstraint = [NSLayoutConstraint constraintWithItem:label2
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:20];
        NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:label2
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:info
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:80];
        [info addConstraints:@[LeftConstraint, RightConstraint, HeightConstraint ,TopConstraint ]];
        UILabel *label3=[self makeLabel:CGPointZero text:NSLocalizedString(@"Composer", nil)font:[UIFont systemFontOfSize:20]];
        //label3.backgroundColor=[UIColor cyanColor];
        [info addSubview:label3];
        label3.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *LeftConstraint3 = [NSLayoutConstraint constraintWithItem:label3
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:info
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:90];
        NSLayoutConstraint *RightConstraint3 = [NSLayoutConstraint constraintWithItem:label3
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:info
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-90];
        NSLayoutConstraint *HeightConstraint3 = [NSLayoutConstraint constraintWithItem:label3
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:20];
        NSLayoutConstraint *TopConstraint3 = [NSLayoutConstraint constraintWithItem:label3
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:info
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:150];
        [info addConstraints:@[LeftConstraint3, RightConstraint3, HeightConstraint3 ,TopConstraint3 ]];
        UILabel *label4=[self makeLabel:CGPointZero text:NSLocalizedString(@"Memo", nil)font:[UIFont systemFontOfSize:20]];
        //label4.backgroundColor=[UIColor yellowColor];
        [info addSubview:label4];
        label4.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *LeftConstraint4 = [NSLayoutConstraint constraintWithItem:label4
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:info
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:90];
        NSLayoutConstraint *RightConstraint4 = [NSLayoutConstraint constraintWithItem:label4
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:info
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-90];
        NSLayoutConstraint *HeightConstraint4 = [NSLayoutConstraint constraintWithItem:label4
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:20];
        NSLayoutConstraint *TopConstraint4 = [NSLayoutConstraint constraintWithItem:label4
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:info
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:220];
        [info addConstraints:@[LeftConstraint4, RightConstraint4, HeightConstraint4 ,TopConstraint4 ]];
        textField1=[self makeTextField:CGRectZero text:@""];
        textField1.placeholder=NSLocalizedString(@"setumei", nil);
        [info addSubview:textField1];
        textField1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *LeftConstraint5 = [NSLayoutConstraint constraintWithItem:textField1
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:info
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:90];
        NSLayoutConstraint *RightConstraint5 = [NSLayoutConstraint constraintWithItem:textField1
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:info
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-90];
        NSLayoutConstraint *HeightConstraint5 = [NSLayoutConstraint constraintWithItem:textField1
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:30];
        NSLayoutConstraint *TopConstraint5 = [NSLayoutConstraint constraintWithItem:textField1
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:info
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:40];
        [info addConstraints:@[LeftConstraint5, RightConstraint5, HeightConstraint5 ,TopConstraint5 ]];
        textField2=[self makeTextField:CGRectZero text:@""];
        textField2.tag=1;
        [info addSubview:textField2];
        textField2.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *LeftConstraint6 = [NSLayoutConstraint constraintWithItem:textField2
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:info
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:90];
        NSLayoutConstraint *RightConstraint6 = [NSLayoutConstraint constraintWithItem:textField2
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:info
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-90];
        NSLayoutConstraint *HeightConstraint6 = [NSLayoutConstraint constraintWithItem:textField2
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:30];
        NSLayoutConstraint *TopConstraint6 = [NSLayoutConstraint constraintWithItem:textField2
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:info
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:110];
        [info addConstraints:@[LeftConstraint6, RightConstraint6, HeightConstraint6 ,TopConstraint6 ]];
        textField3=[self makeTextField:CGRectZero text:@""];
        [info addSubview:textField3];
        textField3.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *LeftConstraint7 = [NSLayoutConstraint constraintWithItem:textField3
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:info
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:90];
        NSLayoutConstraint *RightConstraint7 = [NSLayoutConstraint constraintWithItem:textField3
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:info
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-90];
        NSLayoutConstraint *HeightConstraint7 = [NSLayoutConstraint constraintWithItem:textField3
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:30];
        NSLayoutConstraint *TopConstraint7 = [NSLayoutConstraint constraintWithItem:textField3
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:info
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:180];
        [info addConstraints:@[LeftConstraint7, RightConstraint7, HeightConstraint7 ,TopConstraint7 ]];
        
        textview=[[UITextView alloc]initWithFrame:CGRectZero];
        textview.delegate=self;
        textview.font=[UIFont systemFontOfSize:20];
        [[textview layer]setCornerRadius:8];
        [textview setClipsToBounds:YES];
        [[textview layer]setBorderColor:[[UIColor lightGrayColor]CGColor]];
        [[textview layer]setBorderWidth:1];
        [info addSubview:textview];
        textview.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *LeftConstraint8 = [NSLayoutConstraint constraintWithItem:textview
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:info
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:90];
        NSLayoutConstraint *RightConstraint8 = [NSLayoutConstraint constraintWithItem:textview
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:info
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-90];
        NSLayoutConstraint *HeightConstraint8 = [NSLayoutConstraint constraintWithItem:textview
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:200];
        NSLayoutConstraint *TopConstraint8 = [NSLayoutConstraint constraintWithItem:textview
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:info
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:250];
        [info addConstraints:@[LeftConstraint8, RightConstraint8, HeightConstraint8 ,TopConstraint8 ]];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else{
        return (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)sender{
    [sender resignFirstResponder];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            [scroll setContentOffset:CGPointMake(0, -55) animated:YES];
        }
        else{
            [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            float y = sender.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-83);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
        else{
            float y = sender.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-33);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
    }
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            float y = textview.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-100);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
        else{
            float y = textview.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-33);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
        CGRect accessFrame=CGRectMake(0, 0, 0, 50);
        UIView *accessoryView=[[UIView alloc]initWithFrame:accessFrame];
        accessoryView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
        UIButton *compButton1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        compButton1.frame=CGRectMake(0, 1, 75, 50);
        [compButton1 setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
        [compButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [compButton1 addTarget:self action:@selector(Textviewclose:) forControlEvents:UIControlEventTouchDown];
        [accessoryView addSubview:compButton1];
        textView.inputAccessoryView=accessoryView;
        return YES;
    }
    else{
        CGSize result=[[UIScreen mainScreen]bounds].size;
        CGFloat scale=[UIScreen mainScreen].scale;
        result=CGSizeMake(result.width*scale, result.height*scale);
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            float y = textview.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-75);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
        else{
            float y = textview.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-25);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
        if (result.height==1136) {
            CGRect accessFrame=CGRectMake(0, 0, 0, 30);
            UIView *accessoryView=[[UIView alloc]initWithFrame:accessFrame];
            UIToolbar *toolbar1=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 568, 32)];
            toolbar1.tintColor=[UIColor scrollViewTexturedBackgroundColor];
            UIBarButtonItem *Done=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Textviewclose:)];
            Done.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
            UIBarButtonItem *spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            NSArray *items3=[NSArray arrayWithObjects:spacer,Done,nil];
            toolbar1.items=items3;
            [accessoryView addSubview:toolbar1];
            textView.inputAccessoryView=accessoryView;
        }
        else{
            CGRect accessFrame=CGRectMake(0, 0, 0, 30);
            UIView *accessoryView=[[UIView alloc]initWithFrame:accessFrame];
            UIToolbar *toolbar1=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 480, 32)];
            toolbar1.tintColor=[UIColor scrollViewTexturedBackgroundColor];
            UIBarButtonItem *Done=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Textviewclose:)];
            Done.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
            UIBarButtonItem *spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            NSArray *items3=[NSArray arrayWithObjects:spacer,Done,nil];
            toolbar1.items=items3;
            [accessoryView addSubview:toolbar1];
            textView.inputAccessoryView=accessoryView;
        }
        [UIApplication sharedApplication].statusBarHidden=YES;
        self.navigationController.navigationBarHidden=YES;
        return YES;
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView*)textView{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            float y = textview.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-305);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
        else{
            [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    return YES;
}

-(void)torikeshi:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save:(id)sender{
    if (textField1.text.length>0) {
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Entity"inManagedObjectContext:self.managedObjectContext];
        [newManagedObject setValue:textField1.text forKey:@"title"];
        if (textField2.text.length>0) {
            [newManagedObject setValue:textField2.text forKey:@"artist"];}
        if (textField3.text.length>0) {
            [newManagedObject setValue:textField3.text forKey:@"composer"];}
        if (textview.text.length>0) {
            [newManagedObject setValue:textview.text forKey:@"memo"];}
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Textviewclose:(id)sender{
    [textview resignFirstResponder];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            float y = textview.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-305);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
        else{
            [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    else{
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            float y = textview.frame.origin.y;
            CGPoint scrollPoint = CGPointMake(0,y-263);
            [scroll setContentOffset:scrollPoint animated:YES];
        }
        else{
            [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        [UIApplication sharedApplication].statusBarHidden=NO;
        self.navigationController.navigationBarHidden=NO;
    }
}

@end
