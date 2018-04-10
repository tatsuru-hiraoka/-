//
//  PickerViewViewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/13.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "Entity.h"
#import "TrackingManager.h"

@protocol PickerViewControllerDelegate;

@interface PickerViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSString *screenName;
}

@property(strong,nonatomic)Entity *detailItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) id<PickerViewControllerDelegate>delegate;
@end
@protocol PickerViewControllerDelegate

-(void)PickerViewControllerDelegateDidfinish:(NSInteger)getData;
-(void)PickerViewControllerDelegateDidfinish2:(NSInteger)getData;
-(void)dismiss;
-(void)configureView;
//- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController;

@end
