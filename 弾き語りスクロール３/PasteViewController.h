//
//  PasteViewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/13.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "TrackingManager.h"

@protocol PasteViewControllerDelegate;

@interface PasteViewController : UIViewController{
    NSString *screenName;
}

@property (nonatomic, assign) id<PasteViewControllerDelegate>delegate;
@end
@protocol PasteViewControllerDelegate

-(void)PasteButton;
-(void)dismiss;

@end
