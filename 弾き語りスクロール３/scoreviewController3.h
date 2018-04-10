//
//  scoreviewController3.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "tableviewController.h"
#import "TextField.h"
#import "TextView.h"
#import "Button.h"
//#import "CMPopTipView.h"
#import "ExtAudioFilePlayer.h"
#import "TrackingManager.h"
#import "RBDMuteSwitch.h"
#import "BeetViewController.h"
#import "CopyViewController.h"
#import "PasteViewController.h"
#import "PickerViewController.h"
#import "Font&ColorViewController.h"
#import "Entity.h"

@interface scoreviewController3:UIViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,RBDMuteSwitchDelegate,BeetViewControllerDelegate,UIPopoverPresentationControllerDelegate,CopyViewControllerDelegate,PasteViewControllerDelegate,PickerViewControllerDelegate,Font_ColorViewControllerDelegate>{
    NSString *screenName;
    UITextField *activeField;
    UITextView *activeField2;
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
    UITextField *textField4;
    UITextView *textview1;
    UITextView *textview2;
    UITextView *textview3;
    UITextView *textview4;
    UIScrollView *scroll;
    UIScrollView *accessoryscroll2;
    CALayer *layer;
    CABasicAnimation *animation;
    //MPMusicPlayerController *player;
    UIView *score;
    UIView *accessoryView;
    UIView *accessoryView2;
    UIButton *compButton;
    UIButton *activeButton;
    UIButton *activeButton2;
    UIButton *chordButton1;
    UIButton *NumberButton;
    UIButton *numberButton;
    UIBarButtonItem *tempolabel;
    UIBarButtonItem *copy;
    UIBarButtonItem *play;
    UIBarButtonItem *stop;
    UIBarButtonItem *rewind;
    NSArray *items1;
    NSArray *items2;
    NSArray *items;
    UIToolbar *toolbar;
    NSArray *array1;
    NSArray *array2;
    NSArray *array3;
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
    NSMutableArray *textFields;
    NSMutableArray *dataarray;
    NSMutableArray *storedataarray;
    NSMutableArray *dataarray2;
    NSMutableArray *GuitarDiagrmarray;
    NSMutableArray *compButtons;
    NSMutableArray *copyarray;
    NSMutableArray *NumberButtonarray;
    NSMutableArray *ChordButtonarray;
    NSMutableArray *Tempoarray;
    NSMutableString *MutableString;
    NSMutableString *str;
    //NSString *NowPlayingItem;
    NSInteger value1;
    NSInteger value2;
    int colorvalue1;
    int colorvalue2;
    int colorvalue3;
    int colorvalue4;
    int storevalue1;
    int chordarraynumber;
    int ButtonColorNumber1;
    int ButtonColorNumber2;
    NSInteger activeButton2Number1;
    NSInteger activeButton2Number2;
    NSNumber *number1;
    NSNumber *number2;
    //CMPopTipView *navBarLeftButtonPopTipView;
    //CMPopTipView *navBarLeftButtonPopTipView2;
    float beat;
    float beat2;
    int bpm;
    float bpm2;
    long barcount;
    long barcount2;
    long barcount3;
    NSTimer *tm;
    int value;int value3; float count1;double value4;NSInteger value5;int value6;
    BOOL GuitarDiagram;
    BOOL GuitarDiagramLite;
    BOOL UkurereDiagram;
    BOOL UkurereDiagramLite;
    BOOL CC;BOOL DD;BOOL EE;BOOL FF;BOOL GG;BOOL AA;BOOL BB;
    BOOL activeButton2tag;BOOL ButtonPopTipView;BOOL activeButton2tag2;
    BOOL ChordCopy;BOOL LyricsCopy;BOOL metronome3;BOOL metronome4;BOOL tempo;BOOL Play2;BOOL Pause;BOOL FirstResponder;
    BOOL NotMuted;
    ExtAudioFilePlayer *metoro1;
    ExtAudioFilePlayer *metoro2;
}
@property(strong,nonatomic)Entity *detailItem;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) BOOL Play;
//@property (nonatomic, assign) BOOL metronome;
@property (nonatomic,copy)NSNumber *colordata;

@end
