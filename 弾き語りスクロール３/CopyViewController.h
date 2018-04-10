//
//  CopyViewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/12.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "TrackingManager.h"
//#import "scoreviewController3.h"

@protocol CopyViewControllerDelegate;

@interface CopyViewController : UIViewController{
    NSString *screenName;
}

@property (nonatomic, assign) id<CopyViewControllerDelegate>delegate;
@end
@protocol CopyViewControllerDelegate

-(void)ChordCopyButton;
-(void)LyricsCopyButton;
-(void)Flat;
-(void)Sharp;
-(void)dismiss;

@end
