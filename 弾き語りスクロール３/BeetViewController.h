//
//  BeetViewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/04.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "Entity.h"
#import "TrackingManager.h"

@protocol BeetViewControllerDelegate;

@interface BeetViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray *array1;
    NSInteger value5;
    NSString *screenName;
}
@property(strong,nonatomic)Entity *detailItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) id<BeetViewControllerDelegate>delegate;
@end
@protocol BeetViewControllerDelegate

-(void)BeetViewControllerDelegateDidfinish:(NSInteger)getData;
-(void)Play2;
@end
