//
//  infomationViewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableviewController.h"
#import "scoreviewController2.h"
#import <GameKit/GameKit.h>
#import "Entity.h"

@interface infomationViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate,GKSessionDelegate>{
    UITextField *activeField;
    UIView *info;
    UIScrollView *scroll;
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
    UIBarButtonItem *save;
    UITextView *textview;
}
@property(strong,nonatomic)Entity *detailItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
