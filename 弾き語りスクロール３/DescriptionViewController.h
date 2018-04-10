//
//  DescriptionViewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "TextView.h"
#import "TextField.h"
#import "CMPopTipView.h"
#import "TrackingManager.h"
#import "PickerViewController.h"

@interface DescriptionViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UIPopoverPresentationControllerDelegate,PickerViewControllerDelegate>{
    UITextField *textField;
    UIBarButtonItem *tempolabel;
    UIBarButtonItem *copy;
    NSArray *array1;
    NSArray *array2;
    CMPopTipView *navBarLeftButtonPopTipView;
    CMPopTipView *navBarLeftButtonPopTipView2;
    UIButton *compButton1;
    UIButton *compButton2;
    UIButton *compButton3;
    UIButton *compButton4;
    UIButton *compButton5;
    UIButton *compButton8;
    UIScrollView *scroll;
}

@end
