//
//  StoreViewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#import "Button.h"
#import "TrackingManager.h"
#import "scoreviewController2.h"
@interface StoreViewController : UIViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate,UITextFieldDelegate,UITextViewDelegate>{
    NSString *screenName;
    UITextField *textField;
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
    UITextField *textField4;
    UITextView *text1;
    UITextField *activeField;
    NSMutableArray *array;
    NSMutableArray *textFields;
    UIButton *Buy;
    UIButton *Restore;
    UIButton *compButton;
    UIButton *GDL;
    UIButton *UDL;
    UIButton *GD;
    UIButton *UD;
    UIButton *Orientation;
    UIButton *chordfont;
    UIButton *chordButton1;
    UIButton *activeButton;
    UILabel *Price;
    UIScrollView *scroll;
    UIView *view;
    UIView *accessoryView;
    UIPickerView *pickerView1;
    UIActivityIndicatorView *kurukuru;
    SKProduct *myProduct1;
    SKProduct *myProduct2;
    SKProduct *myProduct3;
    SKProduct *myProduct4;
    NSNumberFormatter *numberFormatter;
    UITextView *activeField2;
    UIScrollView *accessoryscroll2;
    NSArray *chordarray1;
    NSArray *chordarray2;
    NSArray *chordarrayC;
    NSArray *chordarrayD;
    NSArray *chordarrayE;
    NSArray *chordarrayF;
    NSArray *chordarrayG;
    NSArray *chordarrayA;
    NSArray *chordarrayB;
    NSArray *chordarrayCS;
    NSArray *chordarrayDS;
    NSArray *chordarrayFS;
    NSArray *chordarrayGS;
    NSArray *chordarrayAS;
    NSArray *chordarrayDF;
    NSArray *chordarrayEF;
    NSArray *chordarrayGF;
    NSArray *chordarrayAF;
    NSArray *chordarrayBF;
    NSArray *chordarrays;
    NSMutableArray *compButtons;
    NSMutableString *MutableString;
    NSMutableArray *chordButtonarray;
    NSInteger value1;
    NetworkStatus status;
    int ButtonColorNumber1;
    int ButtonColorNumber2;
    int chordarraynumber;
    float x1;
    float y1;
    BOOL CC;BOOL DD;BOOL EE;BOOL FF;BOOL GG;BOOL AA;BOOL BB;
    BOOL BGD;BOOL BGDL; BOOL BUD; BOOL BUDL;
}

@property(nonatomic,retain) IBOutlet UIButton *Buy;
@property(nonatomic,retain) IBOutlet UILabel *Price;
@property(nonatomic,retain) IBOutlet UITextView *text1;
@property(nonatomic,retain) IBOutlet UIButton *Restore;
@property(nonatomic,retain) IBOutlet UITextField *textField1;
@property(nonatomic,retain) IBOutlet UITextField *textField2;
@property(nonatomic,retain) IBOutlet UITextField *textField3;
@property(nonatomic,retain) IBOutlet UITextField *textField4;
@property(nonatomic,retain) IBOutlet UIButton *GDL;
@property(nonatomic,retain) IBOutlet UIButton *UDL;
@property(nonatomic,retain) IBOutlet UIButton *GD;
@property(nonatomic,retain) IBOutlet UIButton *UD;
@property(nonatomic,retain) IBOutlet UIButton *chordfont;
@property(nonatomic,retain) IBOutlet UIButton *Orientation;

-(IBAction) Buy:(UIButton*)sender;
-(IBAction) Restore:(UIButton*)sender;
-(IBAction) GDL:(UIButton*)sender;
-(IBAction) UDL:(UIButton*)sender;
-(IBAction) GD:(UIButton*)sender;
-(IBAction) UD:(UIButton*)sender;
-(IBAction) chordfont:(UIButton*)sender;
-(IBAction) Orientation:(UIButton*)sender;

@end
