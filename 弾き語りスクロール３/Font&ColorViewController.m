//
//  Font&ColorViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/07/14.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import "Font&ColorViewController.h"

@interface Font_ColorViewController ()

@end

@implementation Font_ColorViewController

- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    Button* button=[Button buttonWithType:UIButtonTypeRoundedRect];
    [button.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    return button;
}

-(void)configureView{
    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dataDictionary=[NSMutableDictionary dictionary];
    [dataDictionary setObject:@"NO" forKey:@"GuitarDiagram"];
    [dataDictionary setObject:@"NO" forKey:@"GuitarDiagramLite"];
    [dataDictionary setObject:@"NO" forKey:@"UkurereDiagram"];
    [dataDictionary setObject:@"NO" forKey:@"UkurereDiagramLite"];
    [UserDefaults registerDefaults:dataDictionary];
    GuitarDiagram=[UserDefaults boolForKey:@"GuitarDiagram"];
    GuitarDiagramLite=[UserDefaults boolForKey:@"GuitarDiagramLite"];
    UkurereDiagram=[UserDefaults boolForKey:@"UkurereDiagram"];
    UkurereDiagramLite=[UserDefaults boolForKey:@"UkurereDiagramLite"];
    if (self.detailItem.colordata!=nil) {
        NSMutableArray *dataarray3=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.colordata];
        NSNumber *num1=[dataarray3 objectAtIndex:0];colorvalue1=[num1 intValue];
        NSNumber *num2=[dataarray3 objectAtIndex:1];colorvalue2=[num2 intValue];
        NSNumber *num3=[dataarray3 objectAtIndex:2];colorvalue3=[num3 intValue];
        NSNumber *num4=[dataarray3 objectAtIndex:3];colorvalue4=[num4 intValue];
    }
    else{
        colorvalue1=0;
        colorvalue2=0;
        colorvalue3=0;
        colorvalue4=0;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenName = NSStringFromClass([self class]);
    [TrackingManager sendScreenTracking:screenName];
    
    [self configureView];
    UIButton *CopyButton1=[self makeButton:CGRectMake(0, 0, 200, 40) text:@"Chord Font" tag:500];
    [CopyButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    if (GuitarDiagramLite&&UkurereDiagramLite) {
        if (colorvalue2==0) {[CopyButton1 setTitle:@"Chord Font" forState:UIControlStateNormal];//必要
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==1){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:25]];}
        else if(colorvalue2==2){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Georgia-Italic" size:25]];}
        else if(colorvalue2==3){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];}
        else if(colorvalue2==4){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
        else if(colorvalue2==5){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:25]];}
        else if(colorvalue2==6){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Papyrus" size:25]];}
        else if(colorvalue2==7){[CopyButton1 setTitle:@"Guitar Diagram" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==8){[CopyButton1 setTitle:@"Guitar Diagram" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==9){[CopyButton1 setTitle:@"Ukurere Diagram" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==10){[CopyButton1 setTitle:@"Ukurere Diagram" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    }
    else if (GuitarDiagramLite) {
        if (colorvalue2==0) {[CopyButton1 setTitle:@"Chord Font" forState:UIControlStateNormal];//必要
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==1){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:25]];}
        else if(colorvalue2==2){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Georgia-Italic" size:25]];}
        else if(colorvalue2==3){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];}
        else if(colorvalue2==4){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
        else if(colorvalue2==5){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:25]];}
        else if(colorvalue2==6){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Papyrus" size:25]];}
        else if(colorvalue2==7){[CopyButton1 setTitle:@"Guitar Diagram" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==8){[CopyButton1 setTitle:@"Guitar Diagram" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==9){[CopyButton1 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==10){[CopyButton1 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    }
    else if(UkurereDiagramLite){
        if (colorvalue2==0) {[CopyButton1 setTitle:@"Chord Font" forState:UIControlStateNormal];//必要
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==1){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:25]];}
        else if(colorvalue2==2){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Georgia-Italic" size:25]];}
        else if(colorvalue2==3){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];}
        else if(colorvalue2==4){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
        else if(colorvalue2==5){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:25]];}
        else if(colorvalue2==6){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Papyrus" size:25]];}
        else if(colorvalue2==7){[CopyButton1 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==8){[CopyButton1 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==9){[CopyButton1 setTitle:@"Ukurere Diagram" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==10){[CopyButton1 setTitle:@"Ukurere Diagram" forState:UIControlStateNormal];
            [CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    }
    else{
        if (colorvalue2==0) {[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==1){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:25]];}
        else if(colorvalue2==2){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Georgia-Italic" size:25]];}
        else if(colorvalue2==3){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];}
        else if(colorvalue2==4){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
        else if(colorvalue2==5){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:25]];}
        else if(colorvalue2==6){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Papyrus" size:25]];}
        else if(colorvalue2==7){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==8){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==9){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==10){[CopyButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    }
    [CopyButton1 addTarget:self action:@selector(ChordFontButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton1];
    
    UIButton *CopyButton2=[self makeButton:CGRectMake(0, 40, 200, 40) text:@"Lyrics Font" tag:500];
    [CopyButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    CopyButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    if (colorvalue4==0) {[CopyButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    else if(colorvalue4==1){[CopyButton2.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:25]];}
    else if(colorvalue4==2){[CopyButton2.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:25]];}
    else if(colorvalue4==3){[CopyButton2.titleLabel setFont:[UIFont fontWithName:@"Hiragino Mincho ProN" size:25]];}
    else if(colorvalue4==4){[CopyButton2.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
    else if(colorvalue4==5){[CopyButton2.titleLabel setFont:[UIFont fontWithName:@"Courier" size:25]];}
    else if(colorvalue4==6){[CopyButton2.titleLabel setFont:[UIFont fontWithName:@"Futura-MediumItalic" size:25]];}
    [CopyButton2 addTarget:self action:@selector(LyricsFontButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton2];
    
    UIButton *CopyButton3=[self makeButton:CGRectMake(0, 80, 200, 40) text:@"Chord Color" tag:500];
    [CopyButton3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    if (colorvalue1==0) {CopyButton3.backgroundColor=[UIColor blackColor];}
    else if(colorvalue1==1){CopyButton3.backgroundColor=[UIColor redColor];}
    else if(colorvalue1==2){CopyButton3.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];}//ワインレッド
    else if(colorvalue1==3){CopyButton3.backgroundColor=[UIColor colorWithRed:200/255.0 green:153/255.0 blue:50/255.0 alpha:1];}//金
    else if(colorvalue1==4){CopyButton3.backgroundColor=[UIColor colorWithRed:255/255.0 green:110/255.0 blue:0/255.0 alpha:1];}//オレンジ
    else if(colorvalue1==5){CopyButton3.backgroundColor=[UIColor darkGrayColor];}//灰
    else if(colorvalue1==6){CopyButton3.backgroundColor=[UIColor colorWithRed:1/255.0 green:31/255.0 blue:141/255.0 alpha:1];}//紺
    else if(colorvalue1==7){CopyButton3.backgroundColor=[UIColor colorWithRed:0/255.0 green:142/255.0 blue:42/255.0 alpha:1];}//緑
    else if(colorvalue1==8){CopyButton3.backgroundColor=[UIColor colorWithRed:105/255.0 green:130/255.0 blue:27/255.0 alpha:1];}//抹茶
    else if(colorvalue1==9){CopyButton3.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];}//紫
    else if(colorvalue1==10){CopyButton3.backgroundColor=[UIColor brownColor];}//茶
    else if(colorvalue1==11){CopyButton3.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];}//桜
    else if(colorvalue1==12){CopyButton3.backgroundColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];}//ピンク
    else if(colorvalue1==13){CopyButton3.backgroundColor=[UIColor colorWithRed:255/255.0 green:145/255.0 blue:51/255.0 alpha:1];}
    else if(colorvalue1==14){CopyButton3.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];}
    else if(colorvalue1==15){CopyButton3.backgroundColor=[UIColor colorWithRed:151/255.0 green:12/255.0 blue:10/255.0 alpha:1];}
    else if(colorvalue1==16){CopyButton3.backgroundColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];}
    [CopyButton3 addTarget:self action:@selector(ChordColorButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton3];
    
    UIButton *CopyButton4=[self makeButton:CGRectMake(0, 120, 200, 40) text:@"Lyrics Color" tag:500];
    [CopyButton4 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    if (colorvalue3==0) {CopyButton4.backgroundColor=[UIColor blackColor];}
    else if(colorvalue3==1){CopyButton4.backgroundColor=[UIColor redColor];}
    else if(colorvalue3==2){CopyButton4.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];}//ワインレッド
    else if(colorvalue3==3){CopyButton4.backgroundColor=[UIColor colorWithRed:200/255.0 green:153/255.0 blue:50/255.0 alpha:1];}//金
    else if(colorvalue3==4){CopyButton4.backgroundColor=[UIColor colorWithRed:255/255.0 green:110/255.0 blue:0/255.0 alpha:1];}//オレンジ
    else if(colorvalue3==5){CopyButton4.backgroundColor=[UIColor darkGrayColor];}//灰
    else if(colorvalue3==6){CopyButton4.backgroundColor=[UIColor colorWithRed:1/255.0 green:31/255.0 blue:141/255.0 alpha:1];}//紺
    else if(colorvalue3==7){CopyButton4.backgroundColor=[UIColor colorWithRed:0/255.0 green:142/255.0 blue:42/255.0 alpha:1];}//緑
    else if(colorvalue3==8){CopyButton4.backgroundColor=[UIColor colorWithRed:105/255.0 green:130/255.0 blue:27/255.0 alpha:1];}//抹茶
    else if(colorvalue3==9){CopyButton4.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];}//紫
    else if(colorvalue3==10){CopyButton4.backgroundColor=[UIColor brownColor];}//茶
    else if(colorvalue3==11){CopyButton4.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];}//桜
    else if(colorvalue3==12){CopyButton4.backgroundColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];}//ピンク
    else if(colorvalue1==13){CopyButton4.backgroundColor=[UIColor colorWithRed:255/255.0 green:145/255.0 blue:51/255.0 alpha:1];}
    else if(colorvalue1==14){CopyButton4.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];}
    else if(colorvalue1==15){CopyButton4.backgroundColor=[UIColor colorWithRed:151/255.0 green:12/255.0 blue:10/255.0 alpha:1];}
    else if(colorvalue1==16){CopyButton4.backgroundColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];}
    [CopyButton4 addTarget:self action:@selector(LyricsColorButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CopyButton4];
    
    /*UIButton *CopyButton5=[self makeButton:CGRectMake(-20, 107, 148, 27) text:@"×" tag:500];
    [CopyButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [CopyButton5.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    CopyButton5.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [CopyButton5 addTarget:self action:@selector(Dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [navBarLeftButtonPopTipView addSubview:CopyButton5];*/

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)ChordFontButton:(id)sender{
    activeButton2=sender;
    if (GuitarDiagramLite&&UkurereDiagramLite) {
        if (colorvalue2==0) {colorvalue2=1;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:25]];}
        else if(colorvalue2==1){colorvalue2=2;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Georgia-Italic" size:25]];}
        else if(colorvalue2==2){colorvalue2=3;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];}
        else if(colorvalue2==3){colorvalue2=4;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
        else if(colorvalue2==4){colorvalue2=5;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:25]];}
        else if(colorvalue2==5){colorvalue2=6;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Papyrus" size:25]];}
        else if(colorvalue2==6){colorvalue2=7;[activeButton2 setTitle:@"Guitar Diagram" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==7){colorvalue2=8;[activeButton2 setTitle:@"Guitar Diagram" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==8){colorvalue2=9;[activeButton2 setTitle:@"Ukurere Diagram" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==9){colorvalue2=10;[activeButton2 setTitle:@"Ukurere Diagram" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==10){colorvalue2=0;[activeButton2 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    }
    else if(GuitarDiagramLite) {
        //colorvalue2に次の数字をいれる
        if (colorvalue2==0) {colorvalue2=1;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:25]];}
        else if(colorvalue2==1){colorvalue2=2;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Georgia-Italic" size:25]];}
        else if(colorvalue2==2){colorvalue2=3;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];}
        else if(colorvalue2==3){colorvalue2=4;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
        else if(colorvalue2==4){colorvalue2=5;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:25]];}
        else if(colorvalue2==5){colorvalue2=6;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Papyrus" size:25]];}
        else if(colorvalue2==6){colorvalue2=7;[activeButton2 setTitle:@"Guitar Diagram" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==7){colorvalue2=8;[activeButton2 setTitle:@"Guitar Diagram" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==8){colorvalue2=0;[activeButton2 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==9){colorvalue2=0;[activeButton2 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==10){colorvalue2=0;[activeButton2 setTitle:@"Chord Font" forState:UIControlStateNormal];
                            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    }
    else if(UkurereDiagramLite){
        if (colorvalue2==0) {colorvalue2=1;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:25]];}
        else if(colorvalue2==1){colorvalue2=2;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Georgia-Italic" size:25]];}
        else if(colorvalue2==2){colorvalue2=3;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];}
        else if(colorvalue2==3){colorvalue2=4;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
        else if(colorvalue2==4){colorvalue2=5;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:25]];}
        else if(colorvalue2==5){colorvalue2=6;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Papyrus" size:25]];}
        else if(colorvalue2==6){colorvalue2=9;[activeButton2 setTitle:@"Ukurere Diagram" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==7){colorvalue2=0;[activeButton2 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==8){colorvalue2=0;[activeButton2 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==9){colorvalue2=10;[activeButton2 setTitle:@"Ukurere Diagram" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==10){colorvalue2=0;[activeButton2 setTitle:@"Chord Font" forState:UIControlStateNormal];
            [activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    }
    else{
        if (colorvalue2==0) {colorvalue2=1;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:25]];}
        else if(colorvalue2==1){colorvalue2=2;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Georgia-Italic" size:25]];}
        else if(colorvalue2==2){colorvalue2=3;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];}
        else if(colorvalue2==3){colorvalue2=4;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
        else if(colorvalue2==4){colorvalue2=5;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:25]];}
        else if(colorvalue2==5){colorvalue2=6;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Papyrus" size:25]];}
        else if(colorvalue2==6){colorvalue2=0;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==7){colorvalue2=0;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==8){colorvalue2=0;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==9){colorvalue2=0;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==10){colorvalue2=0;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
        else if(colorvalue2==11){colorvalue2=0;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    }
    [self.delegate ChordFontButton:colorvalue2];
}

-(void)LyricsFontButton:(id)sender{
    activeButton2=sender;
    if (colorvalue4==0) {colorvalue4=1;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:25]];}
    else if(colorvalue4==1){colorvalue4=2;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:25]];}
    else if(colorvalue4==2){colorvalue4=3;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Hiragino Mincho ProN" size:25]];}
    else if(colorvalue4==3){colorvalue4=4;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:25]];}
    else if(colorvalue4==4){colorvalue4=5;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Courier" size:25]];}
    else if(colorvalue4==5){colorvalue4=6;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Futura-MediumItalic" size:25]];}
    else if(colorvalue4==6){colorvalue4=0;[activeButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:25]];}
    [self.delegate LyricsFontButton:colorvalue4];
}

-(void)ChordColorButton:(id)sender{
    activeButton2=sender;
    if (colorvalue1==0) {colorvalue1=1;activeButton2.backgroundColor=[UIColor redColor];}
    else if(colorvalue1==1){colorvalue1=2;activeButton2.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];}
    else if(colorvalue1==2){colorvalue1=3;activeButton2.backgroundColor=[UIColor colorWithRed:200/255.0 green:153/255.0 blue:50/255.0 alpha:1];}
    else if(colorvalue1==3){colorvalue1=4;activeButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:110/255.0 blue:0/255.0 alpha:1];}
    else if(colorvalue1==4){colorvalue1=5;activeButton2.backgroundColor=[UIColor darkGrayColor];}
    else if(colorvalue1==5){colorvalue1=6;activeButton2.backgroundColor=[UIColor colorWithRed:1/255.0 green:31/255.0 blue:141/255.0 alpha:1];}
    else if(colorvalue1==6){colorvalue1=7;activeButton2.backgroundColor=[UIColor colorWithRed:0/255.0 green:142/255.0 blue:42/255.0 alpha:1];}
    else if(colorvalue1==7){colorvalue1=8;activeButton2.backgroundColor=[UIColor colorWithRed:105/255.0 green:130/255.0 blue:27/255.0 alpha:1];}
    else if(colorvalue1==8){colorvalue1=9;activeButton2.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];}
    else if(colorvalue1==9){colorvalue1=10;activeButton2.backgroundColor=[UIColor brownColor];}
    else if(colorvalue1==10){colorvalue1=11;activeButton2.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];}
    else if(colorvalue1==11){colorvalue1=12;activeButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];}
    else if(colorvalue1==12){colorvalue1=0;activeButton2.backgroundColor=[UIColor blackColor];}
    else if(colorvalue1==13){colorvalue1=0;activeButton2.backgroundColor=[UIColor blackColor];}
    else if(colorvalue1==14){colorvalue1=0;activeButton2.backgroundColor=[UIColor blackColor];}
    else if(colorvalue1==15){colorvalue1=0;activeButton2.backgroundColor=[UIColor blackColor];}
    else if(colorvalue1==16){colorvalue1=0;activeButton2.backgroundColor=[UIColor blackColor];}
    [self.delegate ChordColorButton:colorvalue1];
}

-(void)LyricsColorButton:(id)sender{
    activeButton2=sender;
    if (colorvalue3==0) {colorvalue3=1;activeButton2.backgroundColor=[UIColor redColor];}
    else if(colorvalue3==1){colorvalue3=2;activeButton2.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];}
    else if(colorvalue3==2){colorvalue3=3;activeButton2.backgroundColor=[UIColor colorWithRed:200/255.0 green:153/255.0 blue:50/255.0 alpha:1];}
    else if(colorvalue3==3){colorvalue3=4;activeButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:110/255.0 blue:0/255.0 alpha:1];}
    else if(colorvalue3==4){colorvalue3=5;activeButton2.backgroundColor=[UIColor darkGrayColor];}
    else if(colorvalue3==5){colorvalue3=6;activeButton2.backgroundColor=[UIColor colorWithRed:1/255.0 green:31/255.0 blue:141/255.0 alpha:1];}
    else if(colorvalue3==6){colorvalue3=7;activeButton2.backgroundColor=[UIColor colorWithRed:0/255.0 green:142/255.0 blue:42/255.0 alpha:1];}
    else if(colorvalue3==7){colorvalue3=8;activeButton2.backgroundColor=[UIColor colorWithRed:105/255.0 green:130/255.0 blue:27/255.0 alpha:1];}
    else if(colorvalue3==8){colorvalue3=9;activeButton2.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];}
    else if (colorvalue3==9) {colorvalue3=10;activeButton2.backgroundColor=[UIColor brownColor];}
    else if(colorvalue3==10){colorvalue3=11;activeButton2.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];}
    else if(colorvalue3==11){colorvalue3=12;activeButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];}
    else if(colorvalue3==12){colorvalue3=0;activeButton2.backgroundColor=[UIColor blackColor];}
    else if(colorvalue3==13){colorvalue3=0;activeButton2.backgroundColor=[UIColor blackColor];}
    else if(colorvalue3==14){colorvalue3=0;activeButton2.backgroundColor=[UIColor blackColor];}
    else if(colorvalue3==15){colorvalue3=0;activeButton2.backgroundColor=[UIColor blackColor];}
    else if(colorvalue3==16){colorvalue3=0;activeButton2.backgroundColor=[UIColor blackColor];}
    [self.delegate LyricsColorButton:colorvalue3];
}

@end
