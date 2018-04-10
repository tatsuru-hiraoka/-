//
//  Font&ColorViewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/14.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entity.h"
#import "Button.h"
#import "TrackingManager.h"

@protocol Font_ColorViewControllerDelegate;

@interface Font_ColorViewController : UIViewController{
    int colorvalue1;
    int colorvalue2;
    int colorvalue3;
    int colorvalue4;
    UIButton *activeButton2;
    BOOL GuitarDiagram;
    BOOL GuitarDiagramLite;
    BOOL UkurereDiagram;
    BOOL UkurereDiagramLite;
    NSString *screenName;
}

@property(strong,nonatomic)Entity *detailItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) id<Font_ColorViewControllerDelegate>delegate;
@end
@protocol Font_ColorViewControllerDelegate

-(void)ChordFontButton:(int)getData;
-(void)LyricsFontButton:(int)getData;
-(void)ChordColorButton:(int)getData;
-(void)LyricsColorButton:(int)getData;


@end
