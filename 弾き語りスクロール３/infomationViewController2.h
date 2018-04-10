//
//  infomationViewController2.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableviewController.h"
#import "Entity.h"
#import "scoreviewController3.h"
#import "TrackingManager.h"
@interface infomationViewController2 : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>{
    UITextField *activeField;
    UIView *info;
    UIScrollView *scroll;
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
    UIBarButtonItem *save;
    UITextView *textview;
    BOOL GuitarDiagram;
    BOOL GuitarDiagramLite;
    BOOL UkurereDiagram;
    BOOL UkurereDiagramLite;
}
@property(strong,nonatomic)Entity *detailItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain)scoreviewController3 *scoreviewcontroller3;

@end
