//
//  scoreviewController2.h
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
#import "DescriptionTableViewController.h"
#import "Entity.h"
#import "TextField.h"
#import "TextView.h"
#import "Button.h"
//#import "CMPopTipView.h"
#import "ExtAudioFilePlayer.h"
#import "TrackingManager.h"
#import "BeetViewController.h"
#import "CopyViewController.h"
#import "PasteViewController.h"
#import "PickerViewController.h"
#import "Font&ColorViewController.h"
#import "RBDMuteSwitch.h"

@interface scoreviewController2:UIViewController<UISplitViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIPopoverPresentationControllerDelegate,UIScrollViewDelegate,BeetViewControllerDelegate,CopyViewControllerDelegate,PasteViewControllerDelegate,PickerViewControllerDelegate,Font_ColorViewControllerDelegate,RBDMuteSwitchDelegate>{
    NSString *screenName;
    UIView *view;
    UILabel *plus;
    UITextField *activeField;
    UITextView *activeField2;
    UITextView *activeField3;
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
    UIView *score2;
    UIView *accessoryView;
    UIView *accessoryView2;
    UIBarButtonItem *save;
    UIBarButtonItem *tempolabel;
    UIBarButtonItem *copy;
    UIBarButtonItem *ii;
    UIBarButtonItem *play;
    UIBarButtonItem *stop;
    UIBarButtonItem *rewind;
    UIButton *compButton;
    UIButton *chordButton1;
    UIButton *activeButton;
    UIButton *activeButton2;
    UIButton *NumberButton;
    UIButton *numberButton;
    UIToolbar *toolbar;
    NSArray *items1;
    NSArray *items2;
    NSArray *items;
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
    NSMutableArray *compButtons;
    NSMutableArray *ChordButtonarray;
    NSMutableArray *dataarray;
    NSMutableArray *dataarray2;
    NSMutableArray *GuitarDiagrmarray;
    NSMutableArray *NumberButtonarray;
    NSMutableArray *Tempoarray;
    NSInteger value1;
    NSInteger value2;
    int colorvalue1;
    int colorvalue2;
    int colorvalue3;
    int colorvalue4;
    int chordarraynumber;
    int ButtonColorNumber1;
    int ButtonColorNumber2;
    NSInteger activeButton2Number1;
    NSInteger activeButton2Number2;
    NSNumber *number1;
    NSNumber *number2;
    UIBarButtonItem *media;
    //MPMusicPlayerController *player;
    //NSString *NowPlayingItem;
    NSMutableString *str;
    //MPMediaItem *nowPlayingItem;
    NSMutableString *MutableString;
    //CMPopTipView *navBarLeftButtonPopTipView;
    //CMPopTipView *navBarLeftButtonPopTipView2;
    //CMPopTipView *navBarLeftButtonPopTipView6;
    ExtAudioFilePlayer *metoro1;
    ExtAudioFilePlayer *metoro2;
    float beat;
    float beat2;
    int bpm;
    float width;
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
    BOOL ChordCopy;BOOL LyricsCopy;BOOL metronome3;BOOL metronome4;BOOL tempo;BOOL Play2;BOOL Pause;BOOL FirstResponder;BOOL NotMuted;
}
@property(strong,nonatomic)Entity *detailItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) BOOL Play;
@property (nonatomic, assign) BOOL tempo;
@end
