//
//  scoreviewController2.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//
#import "AppDelegate.h"
#import "scoreviewController2.h"
@interface scoreviewController2 ()
-(void)configureView;
-(void)makeNumberButton;
-(void)save;
-(void)dismiss;
-(void)maketempo;
@end

@implementation scoreviewController2
@synthesize managedObjectContext;
@synthesize Play;
@synthesize tempo;
//ラベル生成。
-(UILabel*)makeLabel:(CGPoint)pos text:(NSString*)text font:(UIFont*)font{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGRect rect=CGRectMake(pos.x, pos.y, size.width, size.height);
    CGPoint point=CGPointMake(pos.x, pos.y);
    UILabel* label=[[UILabel alloc]init];
    [label setCenter:point];
    [label setFrame:rect];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setNumberOfLines:0];
    [label setBackgroundColor:[UIColor clearColor]];
    return  label;
}

//textfield生成。
-(UITextField*)makeTextField:(CGRect)rect text:(NSString*)text{
    TextField *textfield=[[TextField alloc]init];
    [textfield setFrame:rect];
    [textfield setText:text];
    //[textfield setBorderStyle:UITextBorderStyleLine];
    textfield.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];
    textfield.adjustsFontSizeToFitWidth=YES;
    textfield.textAlignment=NSTextAlignmentCenter;
    [textfield setReturnKeyType:UIReturnKeyDone];
    textfield.delegate=self;
    return textfield;
}

-(UITextView*)makeTextView:(CGRect)rect text:(NSString*)text{
    TextView *textView=[[TextView alloc]init];
    textView.backgroundColor=[UIColor clearColor];
    textView.textAlignment=NSTextAlignmentCenter;
    textView.delegate=self;
    textView.font=[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:15];
    return textView;
}

//テキストボタンの生成
- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    //テキストボタンの生成
    Button* button=[Button buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    [button.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    //イベントリスナーの指定
    /*[button addTarget:self action:@selector(Diatonic:)
     forControlEvents:UIControlEventTouchUpInside];*/
    return button;
}

-(void)setDetailItem:(id)newDatailItem{
    if(_detailItem !=newDatailItem){
        _detailItem=newDatailItem;
        [self configureView];
    }
}

-(void)configureView{
    //このメソッドで初期値を登録すると、既に同じキーが存在する場合は初期値をセットせず、キーが存在しない場合だけ値をセットしてくれますので大変便利です。
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
    for (int i=0; i<=199; i++) {
        UITextField *textField0=[textFields objectAtIndex:i];
        textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];
    }
    NSNumber *num=self.detailItem.slider;
    value=[num intValue];
    NSNumber *num2=self.detailItem.tempo;
    value3=[num2 intValue];
    value1=[num2 intValue];
    if (self.detailItem) {
        self.navigationItem.title=self.detailItem.title;
        self.toolbarItems=items1;
        [TrackingManager sendEventTracking:@"detailItem" action:@"title"label:self.detailItem.title value:nil screen:screenName];
        [self.navigationItem setRightBarButtonItem:save animated:YES];
        dataarray=[[NSMutableArray alloc]init];
        for (int i=0; i<400; i++) {
            NSString *string=[NSString stringWithFormat:@""];
            [dataarray addObject:string];
        }
        [self makeColor];
        switch (value3) {
            case 0:tempolabel.title=[NSString stringWithFormat:@"3/4  %d",(int)(value+50)];break;
            case 1:tempolabel.title=[NSString stringWithFormat:@"4/4  %d",(int)(value+50)];break;
            case 2:tempolabel.title=[NSString stringWithFormat:@"2/4  %d",(int)(value+50)];break;
            case 3:tempolabel.title=[NSString stringWithFormat:@"5/4  %d",(int)(value+50)];break;
            case 4:tempolabel.title=[NSString stringWithFormat:@"6/8  %d",(int)(value+50)];break;
            case 5:tempolabel.title=[NSString stringWithFormat:@"12/8  %d",(int)(value+50)];break;
            case 6:tempolabel.title=[NSString stringWithFormat:@"2/2  %d",(int)(value+50)];break;
            case 7:tempolabel.title=[NSString stringWithFormat:@"4/2  %d",(int)(value+50)];break;
            default:break;
        }
    }
    if (self.detailItem.metronome!=nil) {
        Tempoarray=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.metronome];
        NSInteger cnt = [Tempoarray count];
        if (cnt>200) {
            for (int i=201; i<=cnt; i++) {
                [Tempoarray removeLastObject];
            }
            NSData *metronomedata=[NSKeyedArchiver archivedDataWithRootObject:Tempoarray];
            self.detailItem.metronome=metronomedata;
            NSError *error = nil;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }
    else{
        [Tempoarray removeAllObjects];
        for (int i=0; i<200; i++) {
            [Tempoarray addObject:num2];
        }
        NSData *metronomedata=[NSKeyedArchiver archivedDataWithRootObject:Tempoarray];
        self.detailItem.metronome=metronomedata;
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    //[self makeNumberButton];
    tempo=NO;
    [self dismiss];
    //NSLog(@"configureView");
}


//ビューが表示されたときに呼ばれる
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    screenName = NSStringFromClass([self class]);
    [TrackingManager sendScreenTracking:screenName];
    
    self.navigationController.toolbarHidden=NO;
    play=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(Play:)];
    stop=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(Stop:)];
    rewind=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(REwind:)];
    UIBarButtonItem *firstforward=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(FirstForward:)];
    UIBarButtonItem *spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    play.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    stop.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    rewind.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    firstforward.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    value3=1;
    value=70;
    
    [self maketempo];
    [self makeNumberButton];
    tempolabel.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    copy=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Font&Color", nil)] style:UIBarButtonItemStylePlain target:self action:@selector(Copy:)];
    copy.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    UIButton *i1=[UIButton buttonWithType:UIButtonTypeInfoDark];
    [i1 addTarget:self action:@selector(Info:) forControlEvents:UIControlEventTouchUpInside];
    ii=[[UIBarButtonItem alloc]initWithCustomView:i1];
    /*media=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Music", nil)] style:UIBarButtonItemStylePlain target:self action:@selector(Media:)];
     media.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];*/
    
    items1=[NSArray arrayWithObjects:tempolabel,spacer,copy,spacer,rewind,spacer,play,spacer,ii,nil];
    items2=[NSArray arrayWithObjects:spacer,rewind,spacer,stop,spacer,nil];
    items=[NSArray arrayWithObjects:spacer,spacer,rewind,spacer,firstforward,spacer,nil];
    NSArray *items3=[NSArray arrayWithObjects:spacer,spacer,spacer,ii,nil];
    self.toolbarItems=items3;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GDP:)name:@"GDP"object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GDLP:)name:@"GDLP"object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UDP:)name:@"UDP"object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UDLP:)name:@"UDLP"object:nil];
    
    tempo=NO;
    metronome4=YES;tempo=NO;Play2=NO;Pause=NO;
    numberButton=[[UIButton alloc]init];
    [self TrackingManager];
    
    [self dismiss];//viewの表示のため
    //NSLog(@"viewWillAppear");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[RBDMuteSwitch sharedInstance] setDelegate:self];
    //スクロールビュー作成
    scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    score2=[[UIView alloc]initWithFrame:CGRectMake(0,0,1366,7800)];//CABacicAnimationでは必要。scrollviewにViewを置いてアニメーションさせる。scrollviewは見るときに必要なだけでアニメーションさせるためにあるのではない。
    //scroll.backgroundColor=[UIColor lightGrayColor];
    //score2.backgroundColor=[UIColor blackColor];
    layer=score2.layer;
    //layer=scroll.layer;
    //layer.frame=CGRectMake(0,0,self.view.frame.size.width,7700);
    layer.position=CGPointMake(self.view.frame.size.width/2,3900);
    
    scroll.contentSize=CGSizeMake(0,8800);
    
    //layer.frame=CGRectMake(0,0,800,20000);
    //layer.position=CGPointMake(395,9950);
    
    compButtons=[[NSMutableArray alloc]init];
    textFields=[[NSMutableArray alloc]init];
    NumberButtonarray=[[NSMutableArray alloc]init];
    ChordButtonarray=[[NSMutableArray alloc]init];
    Tempoarray=[[NSMutableArray alloc]init];
    
    [scroll addSubview:score2];
    [self.view addSubview:scroll];
    /*save=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    [self.navigationItem setRightBarButtonItem:save animated:YES];*/
    
    scroll.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:scroll
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
    NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:0];
    NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:scroll
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:2000];
    NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:scroll
                                                                         attribute:NSLayoutAttributeRight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeRight
                                                                        multiplier:1
                                                                          constant:0];
    [self.view addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
    
    if (self.managedObjectContext==nil) {
        managedObjectContext=[(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];
    }
    //色の設定。
    [[UIBarButtonItem appearance]setTintColor:[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1]];
    
    for (int i=0; i<400; i++) {
        [textFields addObject:@""];
    }
    for (int i=0; i<=49; i++) {
        textField1=[self makeTextField:CGRectZero text:@""] ;
        [score2 addSubview:textField1];textField1.tag=(i*4)+1;
        [textFields replaceObjectAtIndex:i*4 withObject:textField1];
        textField1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:7.5];
        NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:33+(151*i)];
        NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:75];
        NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:scroll
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.245
                                                                                 constant:0];
        [scroll addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
    }
    for (int i=0; i<=49; i++) {
        textField2=[self makeTextField:CGRectZero text:@""] ;
        [score2 addSubview:textField2];textField2.tag=(i*4)+2;
        [textFields replaceObjectAtIndex:(i*4)+1 withObject:textField2];
        textField2.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:textField2
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:textField2
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField1
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:textField2
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:33+(151*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:textField2
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:75];
        
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    for (int i=0; i<=49; i++) {
        textField3=[self makeTextField:CGRectZero text:@""] ;
        [score2 addSubview:textField3];textField3.tag=(i*4)+3;
        [textFields replaceObjectAtIndex:(i*4)+2 withObject:textField3];
        textField3.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:textField3
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:textField3
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField2
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:textField3
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:33+(151*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:textField3
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:75];
        
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    for (int i=0; i<=49; i++) {
        textField4=[self makeTextField:CGRectZero text:@""] ;
        [score2 addSubview:textField4];textField4.tag=(i*4)+4;
        [textFields replaceObjectAtIndex:(i*4)+3 withObject:textField4];
        textField4.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:textField4
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:textField4
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField3
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:textField4
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:33+(151*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:textField4
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:75];
        
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    for (int i=0; i<=49; i++) {
        textview1=[self makeTextView:CGRectZero text:@""];
        [score2 addSubview:textview1];textview1.tag=(i*4)+201;
        [textFields replaceObjectAtIndex:(i*4)+200 withObject:textview1];
        textview1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:textview1
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:7.5];
        NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:textview1
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:107+(151*i)];
        NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:textview1
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:53];
        NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:textview1
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:scroll
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.245
                                                                                 constant:0];
        [scroll addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
    }
    for (int i=0; i<=49; i++) {
        textview2=[self makeTextView:CGRectZero text:@""];
        [score2 addSubview:textview2];textview2.tag=(i*4)+202;
        [textFields replaceObjectAtIndex:(i*4)+201 withObject:textview2];
        textview2.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:textview2
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:textview2
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField1
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:textview2
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:107+(151*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:textview2
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:53];
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    for (int i=0; i<=49; i++) {
        textview3=[self makeTextView:CGRectZero text:@""];
        [score2 addSubview:textview3];textview3.tag=(i*4)+203;
        [textFields replaceObjectAtIndex:(i*4)+202 withObject:textview3];
        textview3.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:textview3
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:textview3
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField2
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:textview3
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:107+(151*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:textview3
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:53];
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    for (int i=0; i<=49; i++) {
        textview4=[self makeTextView:CGRectZero text:@""];
        [score2 addSubview:textview4];textview4.tag=(i*4)+204;
        [textFields replaceObjectAtIndex:(i*4)+203 withObject:textview4];
        textview4.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:textview4
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:textview4
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField3
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:textview4
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:107+(151*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:textview4
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:53];
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0,0,1500,1500)];
    view.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:view];
    
    plus=[self makeLabel:CGPointMake(10,100) text:NSLocalizedString(@"Plus", nil)font:[UIFont systemFontOfSize:20]] ;
    plus.numberOfLines=0;//表示可能行数０は無制限
    [self.view addSubview:plus];
    
    NSString *metronome1=[[NSBundle mainBundle]pathForResource:@"metoro1_1"ofType:@"aif"];
    NSURL *url1=[NSURL fileURLWithPath:metronome1];
    metoro1 = [[ExtAudioFilePlayer alloc]initWithContentsOfURL:url1];
    NSString *metronome2=[[NSBundle mainBundle]pathForResource:@"metoro2"ofType:@"aif"];
    NSURL *url2=[NSURL fileURLWithPath:metronome2];
    metoro2 = [[ExtAudioFilePlayer alloc]initWithContentsOfURL:url2];
    
    chordarray1=[NSArray arrayWithObjects:@"C",@"D",@"E",@"F",@"G",@"A",@"B",@"#",@"♭",nil];
    chordarray2=[NSArray arrayWithObjects:@"M",@"m",@"7",@"7(2)",@"m7♭5",@"6",@"mM7",@"dim",@"aug",@"sus4",@"add9",nil];
    
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* pathC = [bundle pathForResource:@"C" ofType:@"plist"];
    chordarrayC=[NSArray arrayWithContentsOfFile:pathC];
    
    NSString* pathD = [bundle pathForResource:@"D" ofType:@"plist"];
    chordarrayD=[NSArray arrayWithContentsOfFile:pathD];
    
    NSString* pathE = [bundle pathForResource:@"E" ofType:@"plist"];
    chordarrayE=[NSArray arrayWithContentsOfFile:pathE];
    
    NSString* pathF = [bundle pathForResource:@"F" ofType:@"plist"];
    chordarrayF=[NSArray arrayWithContentsOfFile:pathF];
    
    NSString* pathG = [bundle pathForResource:@"G" ofType:@"plist"];
    chordarrayG=[NSArray arrayWithContentsOfFile:pathG];
    
    NSString* pathA = [bundle pathForResource:@"A" ofType:@"plist"];
    chordarrayA=[NSArray arrayWithContentsOfFile:pathA];
    
    NSString* pathB = [bundle pathForResource:@"B" ofType:@"plist"];
    chordarrayB=[NSArray arrayWithContentsOfFile:pathB];
    
    NSString* pathCS = [bundle pathForResource:@"CS" ofType:@"plist"];
    chordarrayCS=[NSArray arrayWithContentsOfFile:pathCS];
    
    NSString* pathDS = [bundle pathForResource:@"DS" ofType:@"plist"];
    chordarrayDS=[NSArray arrayWithContentsOfFile:pathDS];
    
    NSString* pathFS = [bundle pathForResource:@"FS" ofType:@"plist"];
    chordarrayFS=[NSArray arrayWithContentsOfFile:pathFS];
    
    NSString* pathGS = [bundle pathForResource:@"GS" ofType:@"plist"];
    chordarrayGS=[NSArray arrayWithContentsOfFile:pathGS];
    
    NSString* pathAS = [bundle pathForResource:@"AS" ofType:@"plist"];
    chordarrayAS=[NSArray arrayWithContentsOfFile:pathAS];
    
    NSString* pathDF = [bundle pathForResource:@"DF" ofType:@"plist"];
    chordarrayDF=[NSArray arrayWithContentsOfFile:pathDF];
    
    NSString* pathEF = [bundle pathForResource:@"EF" ofType:@"plist"];
    chordarrayEF=[NSArray arrayWithContentsOfFile:pathEF];
    
    NSString* pathGF = [bundle pathForResource:@"GF" ofType:@"plist"];
    chordarrayGF=[NSArray arrayWithContentsOfFile:pathGF];
    
    NSString* pathAF = [bundle pathForResource:@"AF" ofType:@"plist"];
    chordarrayAF=[NSArray arrayWithContentsOfFile:pathAF];
    
    NSString* pathBF = [bundle pathForResource:@"BF" ofType:@"plist"];
    chordarrayBF=[NSArray arrayWithContentsOfFile:pathBF];
    
    chordarrays=[NSArray arrayWithObjects:chordarrayC,chordarrayD,chordarrayE,chordarrayF,chordarrayG,chordarrayA,chordarrayB,chordarrayCS,chordarrayDS,chordarrayFS,chordarrayGS,chordarrayAS,chordarrayDF,chordarrayEF,chordarrayGF,chordarrayAF,chordarrayBF,nil];
    chordarraynumber=0;
    ButtonColorNumber1=0;ButtonColorNumber2=0;
    activeButton2Number1=0;activeButton2Number2=0;
    CC=YES;DD=NO;EE=NO;FF=NO;GG=NO;AA=NO;BB=NO;
    ButtonPopTipView=NO;activeButton2tag=NO;activeButton2tag2=NO;ChordCopy=NO;LyricsCopy=NO;
    FirstResponder=NO;
    [self makeKeyboard2];
    //NSLog(@"viewDidLoad");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //AppDelegateからの購入通知を解除する
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"GDP"object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"GDLP"object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UDP"object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UDLP"object:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil)
        self.view = nil;
}

-(void)TrackingManager{
    switch (colorvalue1) {
        case 0:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"黒" value:nil screen:screenName];break;
        case 1:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"赤" value:nil screen:screenName];break;
        case 2:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"ワインレッド" value:nil screen:screenName];break;
        case 3:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"金" value:nil screen:screenName];break;
        case 4:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"オレンジ" value:nil screen:screenName];break;
        case 5:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"灰" value:nil screen:screenName];break;
        case 6:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"紺" value:nil screen:screenName];break;
        case 7:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"緑" value:nil screen:screenName];break;
        case 8:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"抹茶" value:nil screen:screenName];break;
        case 9:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"紫" value:nil screen:screenName];break;
        case 10:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"茶" value:nil screen:screenName];break;
        case 11:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"桜" value:nil screen:screenName];break;
        case 12:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　colordata"label:@"ピンク" value:nil screen:screenName];break;
        default:break;
    }
    switch (colorvalue2) {
        case 0:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Apple SD Gothic Neo" value:nil screen:screenName];
            break;
        case 1:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Helvetica" value:nil screen:screenName];break;
        case 2:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Georgia-Italic" value:nil screen:screenName];break;
        case 3:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Bradley Hand" value:nil screen:screenName];break;
        case 4:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"EuphemiaUCAS-Italic" value:nil screen:screenName];
            break;
        case 5:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Chalkduster" value:nil screen:screenName];break;
        case 6:[TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Papyrus" value:nil screen:screenName];break;
        case 7:
            if (GuitarDiagram||GuitarDiagramLite) {
                [TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Chord-Diagram1" value:nil screen:screenName];
            }
            else{
                [TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Apple SD Gothic Neo" value:nil screen:screenName];
            }
            break;
        case 8:
            if (GuitarDiagram||GuitarDiagramLite) {
                [TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Chord-Diagram2" value:nil screen:screenName];
            }
            else{
                [TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Apple SD Gothic Neo" value:nil screen:screenName];
            }
            break;
        case 9:
            if (UkurereDiagram||UkurereDiagramLite) {
                [TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Ukurere-Diagram" value:nil screen:screenName];
            }
            else{
                [TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Apple SD Gothic Neo" value:nil screen:screenName];
            }
            break;
        case 10:
            if (UkurereDiagram||UkurereDiagramLite) {
                [TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Ukurere-Diagram2" value:nil screen:screenName];
            }
            else{
                [TrackingManager sendEventTracking:@"detailItem" action:@"chord　Fontdata"label:@"Apple SD Gothic Neo" value:nil screen:screenName];
            }
            break;
        default:
            break;
    }
    switch (colorvalue3) {
        case 0:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"黒" value:nil screen:screenName];break;
        case 1:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"赤" value:nil screen:screenName];break;
        case 2:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"ワインレッド" value:nil screen:screenName];break;
        case 3:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"金" value:nil screen:screenName];break;
        case 4:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"オレンジ" value:nil screen:screenName];break;
        case 5:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"灰" value:nil screen:screenName];break;
        case 6:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"紺" value:nil screen:screenName];break;
        case 7:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"緑" value:nil screen:screenName];break;
        case 8:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"抹茶" value:nil screen:screenName];break;
        case 9:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"紫" value:nil screen:screenName];break;
        case 10:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"茶" value:nil screen:screenName];break;
        case 11:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"桜" value:nil screen:screenName];break;
        case 12:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　colordata"label:@"ピンク" value:nil screen:screenName];break;
        default:
            break;
    }
    switch (colorvalue4) {
        case 0:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　Fontdata"label:@"Apple SD Gothic Neo" value:nil screen:screenName];break;
        case 1:[TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　Fontdata"label:@"Heiti TC" value:nil screen:screenName];break;
        case 2:
            [TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　Fontdata"label:@"Hiragino Kaku Gothic ProN" value:nil screen:screenName];break;
        case 3:
            [TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　Fontdata"label:@"Hiragino Mincho ProN" value:nil screen:screenName];
            break;
        case 4:
            [TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　Fontdata"label:@"EuphemiaUCAS-Italic" value:nil screen:screenName];
            break;
        case 5:
            [TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　Fontdata"label:@"Courier" value:nil screen:screenName];
            break;
        case 6:
            [TrackingManager sendEventTracking:@"detailItem" action:@"Lyrics　Fontdata"label:@"Futura-MediumItalic" value:nil screen:screenName];
            break;
        default:break;
    }
}

-(void)makeNumberButton{
    [NumberButtonarray removeAllObjects];
    UIButton *bt=[[UIButton alloc]init];
    for (int i=0; i<=200; i++) {
        [NumberButtonarray addObject:bt];
    }
    for (int i=0; i<200; i+=4) {
        UIView *oldView=[scroll viewWithTag:i+401];
        [oldView removeFromSuperview];
        NSString *labeltext=[NSString stringWithFormat:@"%d",i+1];
        UIButton *compButton1=[self makeButton:CGRectZero text:labeltext tag:i+401];
        [compButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [compButton1 addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
        [score2 addSubview:compButton1];
        [NumberButtonarray replaceObjectAtIndex:i withObject:compButton1];
        compButton1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:7.5];
        NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:scroll
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:9+(37.75*i)];
        NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:24];
        NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:textField1
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.25
                                                                                 constant:0];
        [scroll addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
    }
    for (int i=2; i<200; i+=4) {
        UIView *oldView=[scroll viewWithTag:i+400];
        [oldView removeFromSuperview];
        NSString *labeltext=[NSString stringWithFormat:@"%d",i];
        UIButton *compButton1=[self makeButton:CGRectZero text:labeltext tag:i+400];
        [compButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [compButton1 addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
        [score2 addSubview:compButton1];
        [NumberButtonarray replaceObjectAtIndex:i-1 withObject:compButton1];
        compButton1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField1
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.25
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField1
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:-66.5+(37.75*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:24];
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    for (int i=3; i<200; i+=4) {
        UIView *oldView=[scroll viewWithTag:i+400];
        [oldView removeFromSuperview];
        NSString *labeltext=[NSString stringWithFormat:@"%d",i];
        UIButton *compButton1=[self makeButton:CGRectZero text:labeltext tag:i+400];
        [compButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [compButton1 addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
        [score2 addSubview:compButton1];
        [NumberButtonarray replaceObjectAtIndex:i-1 withObject:compButton1];
        compButton1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField1
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.25
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField2
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:-104.5+(37.75*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:24];
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    for (int i=5; i<205; i+=4) {
        UIView *oldView=[scroll viewWithTag:i+399];
        [oldView removeFromSuperview];
        NSString *labeltext=[NSString stringWithFormat:@"%d",i-1];
        UIButton *compButton1=[self makeButton:CGRectZero text:labeltext tag:i+399];
        [compButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [compButton1 addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
        [score2 addSubview:compButton1];
        [NumberButtonarray replaceObjectAtIndex:i-2 withObject:compButton1];
        compButton1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:textField1
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.25
                                                                              constant:0];
        NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:textField3
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1
                                                                               constant:-1];
        NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:scroll
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:-180+(37.75*i)];
        NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:24];
        [scroll addConstraints:@[blueTopConstraint,blueLeftConstraint, blueRightConstraint, blueHeightConstraint]];
    }
    if (self.detailItem.title!=nil) {
        for (int i=0; i<=200; i++) {
            NSNumber *number6=[Tempoarray objectAtIndex:i];
            value6=[number6 intValue];
            NumberButton=[NumberButtonarray objectAtIndex:i];
            switch (value6) {
                case 0:NumberButton.backgroundColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];break;//3/4紺
                case 1:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];break;//4/4緑
                case 2:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];break;//2/4橙
                case 3:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];break;//5/4桃
                case 4:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];break;//6/8青
                case 5:NumberButton.backgroundColor=[UIColor brownColor];break;//12/8茶
                case 6:NumberButton.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];break;//2/2灰
                case 7:NumberButton.backgroundColor=[UIColor blackColor];break;//4/2黒
                case 8:NumberButton.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];break;//1/4//紫
                case 9:NumberButton.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;//3/8桜
                case 10:NumberButton.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];break;//1/2黄
                case 11:NumberButton.backgroundColor=[UIColor greenColor];break;//3/2
                default:break;
            }
        }
    }
}

-(void)maketempo{
    switch (value3) {
        case 0:
            tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"3/4  %d",(int)(value+50)] style:UIBarButtonItemStylePlain target:self action:@selector(tempo1:)];break;
        case 1:
            tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"4/4  %d",(int)(value+50)] style:UIBarButtonItemStylePlain target:self action:@selector(tempo1:)];break;
        case 2:
            tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"2/4  %d",(int)(value+50)] style:UIBarButtonItemStylePlain target:self action:@selector(tempo1:)];break;
        case 3:
            tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"5/4  %d",(int)(value+50)] style:UIBarButtonItemStylePlain target:self action:@selector(tempo1:)];break;
        case 4:
            tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"6/8  %d",(int)(value+50)] style:UIBarButtonItemStylePlain target:self action:@selector(tempo1:)];break;
        case 5:
            tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"12/8  %d",(int)(value+50)] style:UIBarButtonItemStylePlain target:self action:@selector(tempo1:)];break;
        case 6:
            tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"2/2  %d",(int)(value+50)] style:UIBarButtonItemStylePlain target:self action:@selector(tempo1:)];break;
        case 7:
            tempolabel=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"4/2  %d",(int)(value+50)] style:UIBarButtonItemStylePlain target:self action:@selector(tempo1:)];break;
        default:break;
    }
}

-(void)makeColor{
    if (self.detailItem.data!=nil) {
        dataarray2=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.data];
        for (UITextField *text in textFields) {
            text.text=nil;}
        for (int i=0; i<=399; i++) {
            UITextField *textFieldz=[textFields objectAtIndex:i];
            textFieldz.text=[dataarray2 objectAtIndex:i];
        }
    }
    else{
        for (UITextField *text in textFields) {
            text.text=nil;
        }
    }
    if (self.detailItem.diagram!=nil) {
        //NSLog(@"self.detailItem.diagram!=nil");
        GuitarDiagrmarray=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.diagram];
        //if (colorvalue2>=7) {
        for (UITextField *text in textFields) {
            text.text=nil;}
        for (int i=0; i<=399; i++) {
            UITextField *textFieldz=[textFields objectAtIndex:i];
            textFieldz.text=[GuitarDiagrmarray objectAtIndex:i];
        }
        //}
    }
    else{
        if (self.detailItem.data!=nil) {
            GuitarDiagrmarray=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.data];
            for (UITextField *text in textFields) {
                text.text=nil;}
            for (int i=0; i<=399; i++) {
                UITextField *textFieldz=[textFields objectAtIndex:i];
                textFieldz.text=[GuitarDiagrmarray objectAtIndex:i];
            }
        }
        else{
            for (UITextField *text in textFields) {
                text.text=nil;}
        }
    }
    if (self.detailItem.colordata!=nil) {
        NSMutableArray *dataarray3=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.colordata];
        NSNumber *num1=[dataarray3 objectAtIndex:0];colorvalue1=[num1 intValue];
        NSNumber *num2=[dataarray3 objectAtIndex:1];colorvalue2=[num2 intValue];
        NSNumber *num3=[dataarray3 objectAtIndex:2];colorvalue3=[num3 intValue];
        NSNumber *num4=[dataarray3 objectAtIndex:3];colorvalue4=[num4 intValue];
        [self makeFont];
        for (int i=0; i<=199; i++) {
            UITextField *textField0=[textFields objectAtIndex:i];
            switch (colorvalue1) {
                case 0:textField0.textColor=[UIColor blackColor];break;
                case 1:textField0.textColor=[UIColor redColor];break;
                case 2:textField0.textColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];break;//ワインレッド
                case 3:textField0.textColor=[UIColor colorWithRed:200/255.0 green:153/255.0 blue:50/255.0 alpha:1];break;//金
                case 4:textField0.textColor=[UIColor colorWithRed:255/255.0 green:110/255.0 blue:0/255.0 alpha:1];break;//オレンジ
                case 5:textField0.textColor=[UIColor darkGrayColor];break;//灰
                case 6:textField0.textColor=[UIColor colorWithRed:1/255.0 green:31/255.0 blue:141/255.0 alpha:1];break;//紺
                case 7:textField0.textColor=[UIColor colorWithRed:0/255.0 green:142/255.0 blue:42/255.0 alpha:1];break;//緑
                case 8:textField0.textColor=[UIColor colorWithRed:105/255.0 green:130/255.0 blue:27/255.0 alpha:1];break;//抹茶
                case 9:textField0.textColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];break;//紫
                case 10:textField0.textColor=[UIColor brownColor];break;//茶
                case 11:textField0.textColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;//桜
                case 12:textField0.textColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];break;//ピンク
                case 13:textField0.textColor=[UIColor colorWithRed:255/255.0 green:145/255.0 blue:51/255.0 alpha:1];break;
                case 14:textField0.textColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;
                case 15:textField0.textColor=[UIColor colorWithRed:151/255.0 green:12/255.0 blue:10/255.0 alpha:1];break;
                case 16:textField0.textColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];break;
                default:break;
            }
        }
        for (int i=200; i<=399; i++) {
            UITextField *textField0=[textFields objectAtIndex:i];
            NSInteger bytes=[textField0.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            switch (colorvalue3) {
                case 0:textField0.textColor=[UIColor blackColor];break;
                case 1:textField0.textColor=[UIColor redColor];break;
                case 2:textField0.textColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];break;//ワインレッド
                case 3:textField0.textColor=[UIColor colorWithRed:200/255.0 green:153/255.0 blue:50/255.0 alpha:1];break;//金
                case 4:textField0.textColor=[UIColor colorWithRed:255/255.0 green:110/255.0 blue:0/255.0 alpha:1];break;//オレンジ
                case 5:textField0.textColor=[UIColor darkGrayColor];break;//灰
                case 6:textField0.textColor=[UIColor colorWithRed:1/255.0 green:31/255.0 blue:141/255.0 alpha:1];break;//紺
                case 7:textField0.textColor=[UIColor colorWithRed:0/255.0 green:142/255.0 blue:42/255.0 alpha:1];break;//緑
                case 8:textField0.textColor=[UIColor colorWithRed:105/255.0 green:130/255.0 blue:27/255.0 alpha:1];break;//抹茶
                case 9:textField0.textColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];break;//紫
                case 10:textField0.textColor=[UIColor brownColor];break;//茶
                case 11:textField0.textColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;//桜
                case 12:textField0.textColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];break;//ピンク
                case 13:textField0.textColor=[UIColor colorWithRed:255/255.0 green:145/255.0 blue:51/255.0 alpha:1];break;
                case 14:textField0.textColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;
                case 15:textField0.textColor=[UIColor colorWithRed:151/255.0 green:12/255.0 blue:10/255.0 alpha:1];break;
                case 16:textField0.textColor=[UIColor colorWithRed:255/255.0 green:45/255.0 blue:142/255.0 alpha:1];break;
                default:break;
            }
            
            if (colorvalue4==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:19];
                if(textField0.text.length>=20) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:15];}
                //アルファベットは１バイトなので20文字目から小さくする。
            }
            else if(colorvalue4==1){textField0.font=[UIFont fontWithName:@"Heiti TC" size:20];
                if(textField0.text.length>=20) {textField0.font=[UIFont fontWithName:@"Heiti TC" size:15];}
                if(bytes>=51) {textField0.font=[UIFont fontWithName:@"Heiti TC" size:15];}
                //日本語は一文字３バイトなので１８文字目から小さくする。
            }
            else if(colorvalue4==2){textField0.font=[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:17];
                if(textField0.text.length>=20) {textField0.font=[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:13];}
                if(bytes>=51) {textField0.font=[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:13];}
            }
            else if(colorvalue4==3){
                if(bytes>=51) {textField0.font=[UIFont fontWithName:@"Hiragino Mincho ProN" size:13];}
                else if(textField0.text.length>=20) {textField0.font=[UIFont fontWithName:@"Hiragino Mincho ProN" size:13];}
                else{textField0.font=[UIFont fontWithName:@"Hiragino Mincho ProN" size:17];}
            }
            else if(colorvalue4==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:17];
                if(textField0.text.length>=20) {textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:13];}
                if(bytes>=51) {textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:13];}
            }
            else if(colorvalue4==5){textField0.font=[UIFont fontWithName:@"Courier" size:17];
                if(textField0.text.length>=20) {textField0.font=[UIFont fontWithName:@"Courier" size:15];}
                if(bytes>=51) {textField0.font=[UIFont fontWithName:@"Courier" size:15];}
            }
            else if(colorvalue4==6){textField0.font=[UIFont fontWithName:@"Futura-MediumItalic" size:17];
                if(textField0.text.length>=20) {textField0.font=[UIFont fontWithName:@"Futura-MediumItalic" size:14];}
                if(bytes>=51) {textField0.font=[UIFont fontWithName:@"Futura-MediumItalic" size:14];}
            }
        }
    }
    else{
        colorvalue1=0;
        colorvalue2=0;
        colorvalue3=0;
        colorvalue4=0;
        BOOL isJapanese;
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage isEqualToString:@"ja"];
        if (GuitarDiagram || GuitarDiagramLite) {
            //NSLog(@"GuitarDiagram");
            if (isJapanese==YES) {
                colorvalue2=7;
                for (int i=0; i<=199; i++) {
                    UITextField *textField0=[textFields objectAtIndex:i];
                    textField0.font=[UIFont fontWithName:@"Chord-Diagram" size:46];
                }
            }
            else{
                colorvalue2=8;
                for (int i=0; i<=199; i++) {
                    UITextField *textField0=[textFields objectAtIndex:i];
                    textField0.font=[UIFont fontWithName:@"Chord-Diagram2" size:46];
                }
            }
        }
        if(UkurereDiagram || UkurereDiagramLite){
            if (isJapanese==YES) {
                colorvalue2=10;
                for (int i=0; i<=199; i++) {
                    UITextField *textField0=[textFields objectAtIndex:i];
                    textField0.font=[UIFont fontWithName:@"Ukurere-Diagram" size:46];
                }
            }
            else{
                colorvalue2=11;
                for (int i=0; i<=199; i++) {
                    UITextField *textField0=[textFields objectAtIndex:i];
                    textField0.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:46];
                }
            }
        }
    }
}

-(void)makeFont{
    for (int i=0; i<=199; i++) {
        UITextField *textField0=[textFields objectAtIndex:i];
        if(GuitarDiagram&&UkurereDiagram){
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            if (colorvalue2<=6) {
                MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
                for (int x=0; x<=MutableString.length; x++) {
                    NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                    if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                    if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                    if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                    if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                    if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                    if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                    if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                    textField0.text=MutableString;
                }
            }
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Chord-Diagram" size:46];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Chord-Diagram2" size:46];}
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram" size:46];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:46];}
        }
        else if(GuitarDiagram&&UkurereDiagramLite){
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram" size:46];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:46];}
            if (colorvalue2<=6||colorvalue2>=9) {
                MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
                for (int x=0; x<=MutableString.length; x++) {
                    NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                    if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                    if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                    if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                    if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                    if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                    if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                    if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                    textField0.text=MutableString;
                }
            }
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Chord-Diagram" size:46];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Chord-Diagram2" size:46];}
        }
        else if(GuitarDiagramLite&&UkurereDiagram){
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Chord-Diagram" size:46];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Chord-Diagram2" size:46];}
            if (colorvalue2<=8) {
                MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
                for (int x=0; x<=MutableString.length; x++) {
                    NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                    if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                    if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                    if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                    if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                    if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                    if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                    if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                    textField0.text=MutableString;
                }
            }
            
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram" size:46];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:46];}
        }
        else if(GuitarDiagram){
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            if (colorvalue2<=6 || colorvalue2>=9) {
                //NSLog(@"GuitarDiagram");
                MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
                for (int x=0; x<=MutableString.length; x++) {
                    NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                    if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                    if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                    if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                    if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                    if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                    if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                    if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                    textField0.text=MutableString;
                }
            }
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Chord-Diagram" size:46];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Chord-Diagram2" size:46];}
        }
        else if(UkurereDiagram){
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            if (colorvalue2<=8) {
                MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
                for (int x=0; x<=MutableString.length; x++) {
                    NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                    if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                    if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                    if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                    if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                    if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                    if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                    if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                    if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                    textField0.text=MutableString;
                }
            }
            
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram" size:46];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:46];}
        }
        else if(GuitarDiagramLite&&UkurereDiagramLite){
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Chord-Diagram" size:46];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Chord-Diagram2" size:46];}
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram" size:46];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:46];}
            MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
            for (int x=0; x<=MutableString.length; x++) {
                NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                textField0.text=MutableString;
            }
        }
        else if(GuitarDiagramLite){
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Chord-Diagram" size:46];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Chord-Diagram2" size:46];}
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
            for (int x=0; x<=MutableString.length; x++) {
                NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                textField0.text=MutableString;
            }
        }
        else if(UkurereDiagramLite){
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram" size:46];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:46];}
            MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
            for (int x=0; x<=MutableString.length; x++) {
                NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                textField0.text=MutableString;
            }
        }
        else{
            if (colorvalue2==0) {textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==1){textField0.font=[UIFont fontWithName:@"Helvetica" size:30];}
            else if(colorvalue2==2){textField0.font=[UIFont fontWithName:@"Georgia-Italic" size:30];}
            else if(colorvalue2==3){textField0.font=[UIFont fontWithName:@"Bradley Hand" size:30];}
            else if(colorvalue2==4){textField0.font=[UIFont fontWithName:@"EuphemiaUCAS-Italic" size:30];}
            else if(colorvalue2==5){textField0.font=[UIFont fontWithName:@"Chalkduster" size:30];}
            else if(colorvalue2==6){textField0.font=[UIFont fontWithName:@"Papyrus" size:30];}
            else if(colorvalue2==7){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==8){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==9){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            else if(colorvalue2==10){textField0.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];}
            MutableString=[NSMutableString stringWithFormat:@"%@",[dataarray2 objectAtIndex:i]];
            for (int x=0; x<=MutableString.length; x++) {
                NSRange b=[MutableString rangeOfString:@"b"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange c=[MutableString rangeOfString:@"c"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange e=[MutableString rangeOfString:@"e"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange f=[MutableString rangeOfString:@"f"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange k=[MutableString rangeOfString:@"k"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange p=[MutableString rangeOfString:@"p"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange q=[MutableString rangeOfString:@"q"options:0 range:NSMakeRange(x, MutableString.length-x)];
                NSRange v=[MutableString rangeOfString:@"v"options:0 range:NSMakeRange(x, MutableString.length-x)];
                if (b.location!=NSNotFound) {if (b.location==x) {[MutableString replaceCharactersInRange:b withString:@""];}}
                if (c.location!=NSNotFound) {if (c.location==x) {[MutableString replaceCharactersInRange:c withString:@""];}}
                if (e.location!=NSNotFound) {if (e.location==x) {[MutableString replaceCharactersInRange:e withString:@""];}}
                if (f.location!=NSNotFound) {if (f.location==x) {[MutableString replaceCharactersInRange:f withString:@""];}}
                if (k.location!=NSNotFound) {if (k.location==x) {[MutableString replaceCharactersInRange:k withString:@""];}}
                if (p.location!=NSNotFound) {if (p.location==x) {[MutableString replaceCharactersInRange:p withString:@""];}}
                if (q.location!=NSNotFound) {if (q.location==x) {[MutableString replaceCharactersInRange:q withString:@""];}}
                if (v.location!=NSNotFound) {if (v.location==x) {[MutableString replaceCharactersInRange:v withString:@""];}}
                textField0.text=MutableString;
            }
        }
    }
}

-(void)makeKeyboard1{
    UIScreen *sc = [UIScreen mainScreen];
    [compButtons removeAllObjects];[ChordButtonarray removeAllObjects];
    scoreviewController2 *score=[[scoreviewController2 alloc]init];
    CGRect accessFrame=CGRectMake(0, 0, sc.bounds.size.width, 400);
    accessoryView=[[UIView alloc]initWithFrame:accessFrame];
    accessoryView.backgroundColor=[UIColor whiteColor];
    accessoryscroll2=[[UIScrollView alloc]init];
    accessoryscroll2.delegate=self;
    accessoryscroll2.translatesAutoresizingMaskIntoConstraints = NO;
    [accessoryView addSubview:accessoryscroll2];
    NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:accessoryView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:0];
    NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:accessoryView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:114];
    NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:230];
    NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                         attribute:NSLayoutAttributeRight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView
                                                                         attribute:NSLayoutAttributeRight
                                                                        multiplier:1
                                                                          constant:0];
    [accessoryView addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
    //NSLog(@"score2=%f",sc.bounds.size.width);
    //NSLog(@"accessoryView=%f",accessoryView.frame.size.width);
    for (int i=0; i<9; i++) {
        NSString *str7=[chordarray1 objectAtIndex:i];
        chordButton1=[self makeButton:CGRectMake(0, 0, 0, 0) text:str7 tag:i];
        [chordButton1 setTitle:str7 forState:UIControlStateNormal];
        [chordButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [chordButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
        [chordButton1 addTarget:self action:@selector(Diatonic:) forControlEvents:UIControlEventTouchUpInside];
        [accessoryView addSubview:chordButton1];[ChordButtonarray addObject:chordButton1];
        chordButton1.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:chordButton1
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.109
                                                                                 constant:0];
        NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:chordButton1
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1
                                                                                 constant:(score.view.frame.size.width/9)*i];
        NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:chordButton1
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:0];
        NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:chordButton1
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:55];
        [accessoryView addConstraints:@[firstTopConstraint, firstHeightConstraint ,firstWidthConstraint,firstLeftConstraint]];
        
        if (chordButton1.tag==7) {
            chordButton1.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
        }
        if (chordButton1.tag==8) {
            chordButton1.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
        }
        if (chordButton1.tag==ButtonColorNumber1) {
            chordButton1.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
        }
        if (chordButton1.tag==ButtonColorNumber2) {
            chordButton1.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
        }
    }
    for (int i=0; i<11; i++) {
        NSString *str7=[chordarray2 objectAtIndex:i];
        UIButton *compButton2=[self makeButton:CGRectZero text:str7 tag:1];
        compButton2.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
        [compButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [compButton2.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:29]];
        [compButton2 addTarget:self action:@selector(M:) forControlEvents:UIControlEventTouchUpInside];
        [accessoryView  addSubview:compButton2];
        compButton2.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:compButton2
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.089
                                                                                 constant:0];
        NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:compButton2
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:(score.view.frame.size.width/11)*i];
        NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:compButton2
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:57];
        NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton2
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:55];
        [accessoryView addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
    }
    for (int i=0; i<52; i++) {
        compButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [compButtons addObject:compButton];
        NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
        [compButton setTitle:str7 forState:UIControlStateNormal];
        [compButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (colorvalue2==7) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:50]];}
        else if(colorvalue2==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:50]];}
        else if(colorvalue2==9){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:50]];}
        else if(colorvalue2==10){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:50]];}
        compButton.backgroundColor=[UIColor groupTableViewBackgroundColor];
        compButton.tag=i;
        [compButton addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
        compButton.translatesAutoresizingMaskIntoConstraints = NO;
        [accessoryscroll2 addSubview:compButton];
        NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.095
                                                                                 constant:0];
        NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryscroll2
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:(score.view.frame.size.width/10)*i];
        NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryscroll2
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:1];
        NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:72];
        [accessoryView addConstraints:@[firstWidthConstraint ]];
        [accessoryscroll2 addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint  ]];
    }
    for (int i=0; i<52; i++) {
        compButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [compButtons addObject:compButton];
        NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i+52];
        [compButton setTitle:str7 forState:UIControlStateNormal];
        [compButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (colorvalue2==7) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:50]];}
        else if(colorvalue2==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:50]];}
        else if(colorvalue2==9){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:50]];}
        else if(colorvalue2==10){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:50]];}
        compButton.backgroundColor=[UIColor groupTableViewBackgroundColor];
        compButton.tag=i+52;
        [compButton addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
        compButton.translatesAutoresizingMaskIntoConstraints = NO;
        [accessoryscroll2 addSubview:compButton];
        NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.095
                                                                                 constant:0];
        NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryscroll2
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:(score.view.frame.size.width/10)*i];
        NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryscroll2
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:76];
        NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:72];
        [accessoryView addConstraints:@[firstWidthConstraint ]];
        [accessoryscroll2 addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint  ]];
    }
    for (int i=0; i<52; i++) {
        compButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [compButtons addObject:compButton];
        NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i+104];
        [compButton setTitle:str7 forState:UIControlStateNormal];
        [compButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (colorvalue2==7) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:50]];}
        else if(colorvalue2==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:50]];}
        else if(colorvalue2==9){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:50]];}
        else if(colorvalue2==10){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:50]];}
        compButton.backgroundColor=[UIColor groupTableViewBackgroundColor];
        compButton.tag=i+104;
        [compButton addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
        compButton.translatesAutoresizingMaskIntoConstraints = NO;
        [accessoryscroll2 addSubview:compButton];
        NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.095
                                                                                 constant:0];
        NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryscroll2
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:(score.view.frame.size.width/10)*i];
        NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryscroll2
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:151];
        NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:72];
        [accessoryView addConstraints:@[firstWidthConstraint ]];
        [accessoryscroll2 addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint]];
        if (i==51) {
            NSLayoutConstraint *firstRightConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                    attribute:NSLayoutAttributeRight
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:accessoryscroll2
                                                                                    attribute:NSLayoutAttributeRight
                                                                                   multiplier:1
                                                                                     constant:0];
            [accessoryscroll2 addConstraints:@[firstRightConstraint ]];
        }
    }
    compButton=activeButton;
    UIButton *compButton29=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"←"] tag:1];
    compButton29.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
    [compButton29.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:30]];
    [compButton29 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton29 addTarget:self action:@selector(back2:) forControlEvents:UIControlEventTouchDown];
    [accessoryView addSubview:compButton29];
    compButton29.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *WidthConstraint = [NSLayoutConstraint constraintWithItem:compButton29
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:.15
                                                                        constant:0];
    NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:compButton29
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:0];
    NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:compButton29
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:accessoryView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:342];
    NSLayoutConstraint *HeightConstraint = [NSLayoutConstraint constraintWithItem:compButton29
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:58];
    
    [accessoryView addConstraints:@[LeftConstraint, TopConstraint, HeightConstraint ,WidthConstraint ]];
    
    UIButton *compButton30=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"→"] tag:1];
    compButton30.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
    [compButton30.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:30]];
    [compButton30 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton30 addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchDown];
    [accessoryView addSubview:compButton30];
    compButton30.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *WidthConstraint2 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.15
                                                                         constant:0];
    NSLayoutConstraint *LeftConstraint2 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton29
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:5];
    NSLayoutConstraint *TopConstraint2 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:342];
    NSLayoutConstraint *HeightConstraint2 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:58];
    
    [accessoryView addConstraints:@[LeftConstraint2, TopConstraint2, HeightConstraint2 ,WidthConstraint2 ]];
    
    UIButton *compButton31=[self makeButton:CGRectZero text:NSLocalizedString(@"Space", nil) tag:1];
    compButton31.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [compButton31 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton31.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    [compButton31 addTarget:self action:@selector(space:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:compButton31];
    compButton31.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *WidthConstraint3 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.225
                                                                         constant:0];
    NSLayoutConstraint *LeftConstraint3 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton30
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:5];
    NSLayoutConstraint *TopConstraint3 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:342];
    NSLayoutConstraint *HeightConstraint3 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:58];
    
    [accessoryView addConstraints:@[LeftConstraint3, TopConstraint3, HeightConstraint3 ,WidthConstraint3 ]];
    
    UIButton *compButton32=[self makeButton:CGRectZero text:NSLocalizedString(@"Done", nil) tag:1];
    compButton32.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [compButton32 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton32.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    [compButton32 addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:compButton32];
    compButton32.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *WidthConstraint4 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.225
                                                                         constant:0];
    NSLayoutConstraint *LeftConstraint4 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton31
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:5];
    NSLayoutConstraint *TopConstraint4 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:342];
    NSLayoutConstraint *HeightConstraint4 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:58];
    
    [accessoryView addConstraints:@[LeftConstraint4, TopConstraint4, HeightConstraint4 ,WidthConstraint4 ]];
    
    
    UIButton *compButton33=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"×"] tag:1];
    compButton33.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [compButton33 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton33.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    [compButton33 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:compButton33];
    compButton33.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *WidthConstraint5 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.25
                                                                         constant:0];
    NSLayoutConstraint *LeftConstraint5 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton32
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:5];
    NSLayoutConstraint *TopConstraint5 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:342];
    NSLayoutConstraint *HeightConstraint5 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:58];
    [accessoryView addConstraints:@[LeftConstraint5, TopConstraint5, HeightConstraint5 ,WidthConstraint5 ]];
    FirstResponder=YES;
}

-(void)makeKeyboard2{
    CGRect accessFrame=CGRectMake(0, 0, 0, 324);
    accessoryView2=[[UIView alloc]initWithFrame:accessFrame];
    accessoryView2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIButton *compButton1=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"C"] tag:1];
    [compButton1.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    [compButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton1 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton1];compButton1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:9];
    NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:accessoryView2
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:17];
    NSLayoutConstraint *HeightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:52];
    NSLayoutConstraint *WidthConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:.129
                                                                        constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint, TopConstraint, HeightConstraint ,WidthConstraint ]];
    
    UIButton *compButton2=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"D"] tag:1];
    [compButton2.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    [compButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton2 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton2];compButton2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint2 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton1
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:10];
    NSLayoutConstraint *TopConstraint2 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:17];
    NSLayoutConstraint *HeightConstraint2 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:52];
    NSLayoutConstraint *WidthConstraint2 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.129
                                                                         constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint2, TopConstraint2, HeightConstraint2 ,WidthConstraint2 ]];
    
    UIButton *compButton3=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"E"] tag:1];
    [compButton3.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    [compButton3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton3 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton3];compButton3.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint3 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton2
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:10];
    NSLayoutConstraint *TopConstraint3 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:17];
    NSLayoutConstraint *HeightConstraint3 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:52];
    NSLayoutConstraint *WidthConstraint3 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.129
                                                                         constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint3, TopConstraint3, HeightConstraint3 ,WidthConstraint3 ]];
    
    UIButton *compButton4=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"F"] tag:1];
    [compButton4.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    [compButton4 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton4 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton4];compButton4.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint4 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton3
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:10];
    NSLayoutConstraint *TopConstraint4 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:17];
    NSLayoutConstraint *HeightConstraint4 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:52];
    NSLayoutConstraint *WidthConstraint4 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.129
                                                                         constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint4, TopConstraint4, HeightConstraint4 ,WidthConstraint4 ]];
    
    UIButton *compButton5=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"G"] tag:1];
    [compButton5.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    [compButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton5 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton5];compButton5.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint5 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton4
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:10];
    NSLayoutConstraint *TopConstraint5 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:17];
    NSLayoutConstraint *HeightConstraint5 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:52];
    NSLayoutConstraint *WidthConstraint5 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.129
                                                                         constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint5, TopConstraint5, HeightConstraint5 ,WidthConstraint5 ]];
    
    UIButton *compButton6=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"A"] tag:1];
    [compButton6.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    [compButton6 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton6 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton6];compButton6.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint6 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton5
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:10];
    NSLayoutConstraint *TopConstraint6 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:17];
    NSLayoutConstraint *HeightConstraint6 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:52];
    NSLayoutConstraint *WidthConstraint6 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.129
                                                                         constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint6, TopConstraint6, HeightConstraint6 ,WidthConstraint6 ]];
    
    UIButton *compButton7=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"B"] tag:1];
    [compButton7.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    [compButton7 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton7 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton7];compButton7.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint7 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton6
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:10];
    NSLayoutConstraint *TopConstraint7 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:17];
    NSLayoutConstraint *HeightConstraint7 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:52];
    NSLayoutConstraint *WidthConstraint7 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                        attribute:NSLayoutAttributeRight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:-9];
    [accessoryView2 addConstraints:@[LeftConstraint7, TopConstraint7, HeightConstraint7 ,WidthConstraint7 ]];
    
    UIButton *compButton8=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#"] tag:1];
    [compButton8.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:35]];
    compButton8.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];
    [compButton8 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton8 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton8];compButton8.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeLeft
                                                                      multiplier:1
                                                                        constant:9];
    NSLayoutConstraint *TopConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:77];
    NSLayoutConstraint *HeightConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:52];
    NSLayoutConstraint *WidthConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.111
                                                                         constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint8, TopConstraint8, HeightConstraint8 ,WidthConstraint8 ]];
    
    UIButton *compButton9=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭"] tag:1];
    [compButton9.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:35]];
    compButton9.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];
    [compButton9 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton9 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton9];compButton9.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint9 = [NSLayoutConstraint constraintWithItem:compButton9
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:compButton8
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:10];
    NSLayoutConstraint *TopConstraint9 = [NSLayoutConstraint constraintWithItem:compButton9
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:accessoryView2
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:77];
    NSLayoutConstraint *HeightConstraint9 = [NSLayoutConstraint constraintWithItem:compButton9
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:52];
    NSLayoutConstraint *WidthConstraint9 = [NSLayoutConstraint constraintWithItem:compButton9
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:.111
                                                                         constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint9, TopConstraint9, HeightConstraint9 ,WidthConstraint9 ]];
    
    UIButton *compButton10=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"maj7"] tag:1];
    [compButton10.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton10.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton10 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton10 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton10];compButton10.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint10 = [NSLayoutConstraint constraintWithItem:compButton10
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton9
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint10 = [NSLayoutConstraint constraintWithItem:compButton10
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:77];
    NSLayoutConstraint *HeightConstraint10 = [NSLayoutConstraint constraintWithItem:compButton10
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint10 = [NSLayoutConstraint constraintWithItem:compButton10
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint10, TopConstraint10, HeightConstraint10 ,WidthConstraint10 ]];
    
    UIButton *compButton11=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m"] tag:1];
    [compButton11.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton11.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton11 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton11 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton11];compButton11.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint11 = [NSLayoutConstraint constraintWithItem:compButton11
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton10
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint11 = [NSLayoutConstraint constraintWithItem:compButton11
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:77];
    NSLayoutConstraint *HeightConstraint11 = [NSLayoutConstraint constraintWithItem:compButton11
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint11 = [NSLayoutConstraint constraintWithItem:compButton11
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint11, TopConstraint11, HeightConstraint11 ,WidthConstraint11 ]];
    
    UIButton *compButton12=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m7"] tag:1];
    [compButton12.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton12.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton12 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton12 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton12];compButton12.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint12 = [NSLayoutConstraint constraintWithItem:compButton12
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton11
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint12 = [NSLayoutConstraint constraintWithItem:compButton12
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:77];
    NSLayoutConstraint *HeightConstraint12 = [NSLayoutConstraint constraintWithItem:compButton12
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint12 = [NSLayoutConstraint constraintWithItem:compButton12
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint12, TopConstraint12, HeightConstraint12 ,WidthConstraint12 ]];
    
    UIButton *compButton13=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"7"] tag:1];
    [compButton13.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton13.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton13 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton13 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton13];compButton13.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint13 = [NSLayoutConstraint constraintWithItem:compButton13
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton12
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint13 = [NSLayoutConstraint constraintWithItem:compButton13
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:77];
    NSLayoutConstraint *HeightConstraint13 = [NSLayoutConstraint constraintWithItem:compButton13
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint13 = [NSLayoutConstraint constraintWithItem:compButton13
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.110
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint13, TopConstraint13, HeightConstraint13 ,WidthConstraint13 ]];
    
    UIButton *compButton14=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m7-5"] tag:1];
    [compButton14.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton14.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton14 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton14 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton14];compButton14.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint14 = [NSLayoutConstraint constraintWithItem:compButton14
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton13
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint14 = [NSLayoutConstraint constraintWithItem:compButton14
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:77];
    NSLayoutConstraint *HeightConstraint14 = [NSLayoutConstraint constraintWithItem:compButton14
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint14 = [NSLayoutConstraint constraintWithItem:compButton14
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint14, TopConstraint14, HeightConstraint14 ,WidthConstraint14 ]];
    
    UIButton *compButton35=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"mmaj7"] tag:1];
    [compButton35.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton35.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton35 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton35 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton35];compButton35.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint35 = [NSLayoutConstraint constraintWithItem:compButton35
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton14
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint35 = [NSLayoutConstraint constraintWithItem:compButton35
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:77];
    NSLayoutConstraint *HeightConstraint35 = [NSLayoutConstraint constraintWithItem:compButton35
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint35 = [NSLayoutConstraint constraintWithItem:compButton35
                                                                         attribute:NSLayoutAttributeRight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeRight
                                                                        multiplier:1
                                                                          constant:-9];
    [accessoryView2 addConstraints:@[LeftConstraint35, TopConstraint35, HeightConstraint35 ,WidthConstraint35 ]];
    
    UIButton *compButton15=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"6"] tag:1];
    [compButton15.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton15.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton15 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton15 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton15];compButton15.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1
                                                                         constant:9];
    NSLayoutConstraint *TopConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:136];
    NSLayoutConstraint *HeightConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint15, TopConstraint15, HeightConstraint15 ,WidthConstraint15 ]];
    
    UIButton *compButton16=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m6"] tag:1];
    [compButton16.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton16.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton16 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton16 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton16];compButton16.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint16 = [NSLayoutConstraint constraintWithItem:compButton16
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton15
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint16 = [NSLayoutConstraint constraintWithItem:compButton16
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:136];
    NSLayoutConstraint *HeightConstraint16 = [NSLayoutConstraint constraintWithItem:compButton16
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint16 = [NSLayoutConstraint constraintWithItem:compButton16
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint16, TopConstraint16, HeightConstraint16 ,WidthConstraint16 ]];
    
    UIButton *compButton17=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"dim"] tag:1];
    [compButton17.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton17.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton17 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton17 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton17];compButton17.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint17 = [NSLayoutConstraint constraintWithItem:compButton17
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton16
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint17 = [NSLayoutConstraint constraintWithItem:compButton17
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:136];
    NSLayoutConstraint *HeightConstraint17 = [NSLayoutConstraint constraintWithItem:compButton17
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint17 = [NSLayoutConstraint constraintWithItem:compButton17
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint17, TopConstraint17, HeightConstraint17 ,WidthConstraint17 ]];
    
    UIButton *compButton18=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"aug"] tag:1];
    [compButton18.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton18.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton18 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton18 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton18];compButton18.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint18 = [NSLayoutConstraint constraintWithItem:compButton18
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton17
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint18 = [NSLayoutConstraint constraintWithItem:compButton18
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:136];
    NSLayoutConstraint *HeightConstraint18 = [NSLayoutConstraint constraintWithItem:compButton18
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint18 = [NSLayoutConstraint constraintWithItem:compButton18
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint18, TopConstraint18, HeightConstraint18 ,WidthConstraint18 ]];
    
    UIButton *compButton19=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"add9"] tag:1];
    [compButton19.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton19.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton19 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton19 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton19];compButton19.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint19 = [NSLayoutConstraint constraintWithItem:compButton19
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton18
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint19 = [NSLayoutConstraint constraintWithItem:compButton19
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:136];
    NSLayoutConstraint *HeightConstraint19 = [NSLayoutConstraint constraintWithItem:compButton19
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint19 = [NSLayoutConstraint constraintWithItem:compButton19
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint19, TopConstraint19, HeightConstraint19 ,WidthConstraint19 ]];
    
    UIButton *compButton20=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"sus4"] tag:1];
    [compButton20.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton20.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
    [compButton20 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton20 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton20];compButton20.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint20 = [NSLayoutConstraint constraintWithItem:compButton20
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton19
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint20 = [NSLayoutConstraint constraintWithItem:compButton20
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:136];
    NSLayoutConstraint *HeightConstraint20 = [NSLayoutConstraint constraintWithItem:compButton20
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint20 = [NSLayoutConstraint constraintWithItem:compButton20
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint20, TopConstraint20, HeightConstraint20 ,WidthConstraint20 ]];
    
    UIButton *compButton21=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"("] tag:1];
    [compButton21.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    compButton21.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [compButton21 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton21 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton21];compButton21.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint21 = [NSLayoutConstraint constraintWithItem:compButton21
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton20
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint21 = [NSLayoutConstraint constraintWithItem:compButton21
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:136];
    NSLayoutConstraint *HeightConstraint21 = [NSLayoutConstraint constraintWithItem:compButton21
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint21 = [NSLayoutConstraint constraintWithItem:compButton21
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint21, TopConstraint21, HeightConstraint21 ,WidthConstraint21 ]];
    
    UIButton *compButton36=[self makeButton:CGRectZero text:[NSString stringWithFormat:@")"] tag:1];
    [compButton36.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    compButton36.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [compButton36 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton36 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton36];compButton36.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint36 = [NSLayoutConstraint constraintWithItem:compButton36
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton21
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint36 = [NSLayoutConstraint constraintWithItem:compButton36
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:136];
    NSLayoutConstraint *HeightConstraint36 = [NSLayoutConstraint constraintWithItem:compButton36
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint36 = [NSLayoutConstraint constraintWithItem:compButton36
                                                                         attribute:NSLayoutAttributeRight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeRight
                                                                        multiplier:1
                                                                          constant:-9];
    [accessoryView2 addConstraints:@[LeftConstraint36, TopConstraint36, HeightConstraint36 ,WidthConstraint36 ]];
    
    UIButton *compButton22=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"9"] tag:1];
    [compButton22.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton22.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [compButton22 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton22 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton22];compButton22.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1
                                                                         constant:9];
    NSLayoutConstraint *TopConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:195];
    NSLayoutConstraint *HeightConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint22, TopConstraint22, HeightConstraint22 ,WidthConstraint22 ]];
    
    UIButton *compButton23=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#9"] tag:1];
    [compButton23.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton23.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [compButton23 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton23 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton23];compButton23.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint23 = [NSLayoutConstraint constraintWithItem:compButton23
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton22
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint23 = [NSLayoutConstraint constraintWithItem:compButton23
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:195];
    NSLayoutConstraint *HeightConstraint23 = [NSLayoutConstraint constraintWithItem:compButton23
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint23 = [NSLayoutConstraint constraintWithItem:compButton23
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint23, TopConstraint23, HeightConstraint23 ,WidthConstraint23 ]];
    
    UIButton *compButton24=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭9"] tag:1];
    [compButton24.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton24.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [compButton24 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton24 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton24];compButton24.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint24 = [NSLayoutConstraint constraintWithItem:compButton24
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton23
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint24 = [NSLayoutConstraint constraintWithItem:compButton24
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:195];
    NSLayoutConstraint *HeightConstraint24 = [NSLayoutConstraint constraintWithItem:compButton24
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint24 = [NSLayoutConstraint constraintWithItem:compButton24
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint24, TopConstraint24, HeightConstraint24 ,WidthConstraint24 ]];
    
    UIButton *compButton25=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"11"] tag:1];
    [compButton25.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton25.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [compButton25 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton25 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton25];compButton25.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint25 = [NSLayoutConstraint constraintWithItem:compButton25
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton24
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint25 = [NSLayoutConstraint constraintWithItem:compButton25
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:195];
    NSLayoutConstraint *HeightConstraint25 = [NSLayoutConstraint constraintWithItem:compButton25
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint25 = [NSLayoutConstraint constraintWithItem:compButton25
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint25, TopConstraint25, HeightConstraint25 ,WidthConstraint25 ]];
    
    UIButton *compButton26=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#11"] tag:1];
    [compButton26.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton26.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [compButton26 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton26 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton26];compButton26.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint26 = [NSLayoutConstraint constraintWithItem:compButton26
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton25
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint26 = [NSLayoutConstraint constraintWithItem:compButton26
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:195];
    NSLayoutConstraint *HeightConstraint26 = [NSLayoutConstraint constraintWithItem:compButton26
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint26 = [NSLayoutConstraint constraintWithItem:compButton26
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint26, TopConstraint26, HeightConstraint26 ,WidthConstraint26 ]];
    
    UIButton *compButton27=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"13"] tag:1];
    [compButton27.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton27.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [compButton27 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton27 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton27];compButton27.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint27 = [NSLayoutConstraint constraintWithItem:compButton27
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton26
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint27 = [NSLayoutConstraint constraintWithItem:compButton27
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:195];
    NSLayoutConstraint *HeightConstraint27 = [NSLayoutConstraint constraintWithItem:compButton27
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint27 = [NSLayoutConstraint constraintWithItem:compButton27
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint27, TopConstraint27, HeightConstraint27 ,WidthConstraint27 ]];
    
    UIButton *compButton28=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭13"] tag:1];
    [compButton28.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton28.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
    [compButton28 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton28 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton28];compButton28.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint28 = [NSLayoutConstraint constraintWithItem:compButton28
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton27
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint28 = [NSLayoutConstraint constraintWithItem:compButton28
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:195];
    NSLayoutConstraint *HeightConstraint28 = [NSLayoutConstraint constraintWithItem:compButton28
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint28 = [NSLayoutConstraint constraintWithItem:compButton28
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.111
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint28, TopConstraint28, HeightConstraint28 ,WidthConstraint28 ]];
    
    UIButton *compButton29=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"←"] tag:1];
    [compButton29.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    compButton29.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
    [compButton29 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton29 addTarget:self action:@selector(back2:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton29];compButton29.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:accessoryView2
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1
                                                                         constant:9];
    NSLayoutConstraint *TopConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:254];
    NSLayoutConstraint *HeightConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.09
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint29, TopConstraint29, HeightConstraint29 ,WidthConstraint29 ]];
    
    UIButton *compButton30=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"→"] tag:1];
    [compButton30.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    compButton30.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
    [compButton30 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton30 addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton30];compButton30.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint30 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton29
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint30 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:254];
    NSLayoutConstraint *HeightConstraint30 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint30 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.09
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint30, TopConstraint30, HeightConstraint30 ,WidthConstraint30 ]];
    
    UIButton *compButton37=[self makeButton:CGRectZero text:[NSString stringWithFormat:@","] tag:1];
    [compButton37.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    compButton37.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [compButton37 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton37 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton37];compButton37.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint37 = [NSLayoutConstraint constraintWithItem:compButton37
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton30
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint37 = [NSLayoutConstraint constraintWithItem:compButton37
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:254];
    NSLayoutConstraint *HeightConstraint37 = [NSLayoutConstraint constraintWithItem:compButton37
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint37 = [NSLayoutConstraint constraintWithItem:compButton37
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.09
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint37, TopConstraint37, HeightConstraint37 ,WidthConstraint37 ]];
    
    UIButton *compButton38=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"/"] tag:1];
    [compButton38.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    compButton38.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [compButton38 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton38 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton38];compButton38.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint38 = [NSLayoutConstraint constraintWithItem:compButton38
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton37
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint38 = [NSLayoutConstraint constraintWithItem:compButton38
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:254];
    NSLayoutConstraint *HeightConstraint38 = [NSLayoutConstraint constraintWithItem:compButton38
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint38 = [NSLayoutConstraint constraintWithItem:compButton38
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.09
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint38, TopConstraint38, HeightConstraint38 ,WidthConstraint38 ]];
    
    UIButton *compButton34=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"on"] tag:1];
    [compButton34.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton34.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
    [compButton34 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton34 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton34];compButton34.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint34 = [NSLayoutConstraint constraintWithItem:compButton34
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton38
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint34 = [NSLayoutConstraint constraintWithItem:compButton34
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:254];
    NSLayoutConstraint *HeightConstraint34 = [NSLayoutConstraint constraintWithItem:compButton34
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint34 = [NSLayoutConstraint constraintWithItem:compButton34
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.09
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint34, TopConstraint34, HeightConstraint34 ,WidthConstraint34 ]];
    
    UIButton *compButton31=[self makeButton:CGRectZero text:NSLocalizedString(@"Space", nil) tag:1];
    [compButton31.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton31.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [compButton31 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton31 addTarget:self action:@selector(space:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton31];compButton31.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint31 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton34
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint31 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:254];
    NSLayoutConstraint *HeightConstraint31 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint31 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.164
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint31, TopConstraint31, HeightConstraint31 ,WidthConstraint31 ]];
    
    UIButton *compButton32=[self makeButton:CGRectZero text:NSLocalizedString(@"Done", nil) tag:1];
    [compButton32.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
    compButton32.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [compButton32 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton32 addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton32];compButton32.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint32 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton31
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint32 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:254];
    NSLayoutConstraint *HeightConstraint32 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:52];
    NSLayoutConstraint *WidthConstraint32 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:.164
                                                                          constant:0];
    [accessoryView2 addConstraints:@[LeftConstraint32, TopConstraint32, HeightConstraint32 ,WidthConstraint32 ]];
    
    UIButton *compButton33=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"×"] tag:1];
    [compButton33.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
    compButton33.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
    [compButton33 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [compButton33 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView2 addSubview:compButton33];compButton33.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint33 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:compButton32
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:10];
    NSLayoutConstraint *TopConstraint33 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:accessoryView2
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:195];
    NSLayoutConstraint *HeightConstraint33 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:110];
    NSLayoutConstraint *WidthConstraint33 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                         attribute:NSLayoutAttributeRight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:accessoryView2
                                                                         attribute:NSLayoutAttributeRight
                                                                        multiplier:1
                                                                          constant:-9];
    [accessoryView2 addConstraints:@[LeftConstraint33, TopConstraint33, HeightConstraint33 ,WidthConstraint33 ]];
}

//textfieldをタップしたときに呼ばれる。
-(BOOL)textFieldShouldBeginEditing:(UITextField *)sender{
    activeField=sender;
    if ([self respondsToSelector:@selector(inputAssistantItem)]) {
        // iOS9.
        UITextInputAssistantItem* item = [self inputAssistantItem];
        item.leadingBarButtonGroups = @[];
        item.trailingBarButtonGroups = @[];
    }
    if (activeButton2tag2==YES) {
        ButtonPopTipView=NO;
    }
    if (activeField.tag>4) {
        float y = activeField.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-240);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    if (GuitarDiagram&&UkurereDiagram) {
        if (colorvalue2<7) {
            sender.inputView=accessoryView2;
        }
        if (colorvalue2>6) {
            if (FirstResponder==NO) {[self makeKeyboard1];}
            sender.inputView=accessoryView;
        }
    }
    else if((GuitarDiagram&&UkurereDiagramLite)||GuitarDiagram){
        if (colorvalue2==7||colorvalue2==8) {
            if (FirstResponder==NO) {
                [self makeKeyboard1];
            }
            sender.inputView=accessoryView;
        }
        else{
            sender.inputView=accessoryView2;
        }
    }
    else if((GuitarDiagramLite&&UkurereDiagram)||UkurereDiagram){
        if (colorvalue2<9) {
            sender.inputView=accessoryView2;
        }
        if (colorvalue2>8) {
            if (FirstResponder==NO) {
                [self makeKeyboard1];
            }
            sender.inputView=accessoryView;
        }
    }
    else{
        sender.inputView=accessoryView2;
    }
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    activeField2=textView;
    if (activeField2.tag>204) {
        float y = activeField2.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-315);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    CGRect accessFrame=CGRectMake(0, 0, 0, 44);
    UIView *accessoryView3=[[UIView alloc]initWithFrame:accessFrame];
    UIToolbar *toolbar1=[[UIToolbar alloc]initWithFrame:CGRectMake(0,0,1025,44)];
    toolbar1.tintColor=[UIColor groupTableViewBackgroundColor];
    UIBarButtonItem *Done=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Textviewclose:)];
    Done.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    UIBarButtonItem *next=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next2:)];
    next.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back3:)];
    back.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    NSArray *items4=[NSArray arrayWithObjects:Done,back,next,nil];
    toolbar1.items=items4;
    [accessoryView3 addSubview:toolbar1];
    
    textView.inputAccessoryView=accessoryView3;
    return YES;
}

//回転したときに呼ばれる
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    //point=CGPointMake(self.view.frame.size.width/2,4104);
    //NSLog(@"%f",self.view.frame.size.width);
    [activeField resignFirstResponder];
    FirstResponder=NO;
    //[self dismiss];
}

-(void)showPicker{
    PickerViewController *pickerViewController;
    pickerViewController = [[PickerViewController alloc]init];
    pickerViewController.delegate=self;
    pickerViewController.detailItem=self.detailItem;
    pickerViewController.preferredContentSize = CGSizeMake(150, 125);    // 表示サイズ指定（重要）
    pickerViewController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *presentationController =[pickerViewController popoverPresentationController];
    presentationController.permittedArrowDirections =UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
    presentationController.delegate=self;
    presentationController.backgroundColor=[UIColor lightGrayColor];
}

-(void)PickerViewControllerDelegateDidfinish:(NSInteger)getData{
    value1=getData;
    number1=[NSNumber numberWithInteger:value1];
    number2=[NSNumber numberWithInteger:value2];
    switch (value1) {
        case 0:tempolabel.title=[NSString stringWithFormat:@"3/4  %d",(int)(value2+50)];break;
        case 1:tempolabel.title=[NSString stringWithFormat:@"4/4  %d",(int)(value2+50)];break;
        case 2:tempolabel.title=[NSString stringWithFormat:@"2/4  %d",(int)(value2+50)];break;
        case 3:tempolabel.title=[NSString stringWithFormat:@"5/4  %d",(int)(value2+50)];break;
        case 4:tempolabel.title=[NSString stringWithFormat:@"6/8  %d",(int)(value2+50)];break;
        case 5:tempolabel.title=[NSString stringWithFormat:@"12/8  %d",(int)(value2+50)];break;
        case 6:tempolabel.title=[NSString stringWithFormat:@"2/2  %d",(int)(value2+50)];break;
        case 7:tempolabel.title=[NSString stringWithFormat:@"4/2  %d",(int)(value2+50)];break;
        default:break;
    }
    tempo=YES;
}

-(void)PickerViewControllerDelegateDidfinish2:(NSInteger)getData2;{
    value2=getData2;
    number1=[NSNumber numberWithInteger:value1];
    number2=[NSNumber numberWithInteger:value2];
    switch (value1) {
        case 0:tempolabel.title=[NSString stringWithFormat:@"3/4  %d",(int)(value2+50)];break;
        case 1:tempolabel.title=[NSString stringWithFormat:@"4/4  %d",(int)(value2+50)];break;
        case 2:tempolabel.title=[NSString stringWithFormat:@"2/4  %d",(int)(value2+50)];break;
        case 3:tempolabel.title=[NSString stringWithFormat:@"5/4  %d",(int)(value2+50)];break;
        case 4:tempolabel.title=[NSString stringWithFormat:@"6/8  %d",(int)(value2+50)];break;
        case 5:tempolabel.title=[NSString stringWithFormat:@"12/8  %d",(int)(value2+50)];break;
        case 6:tempolabel.title=[NSString stringWithFormat:@"2/2  %d",(int)(value2+50)];break;
        case 7:tempolabel.title=[NSString stringWithFormat:@"4/2  %d",(int)(value2+50)];break;
        default:break;
    }
    tempo=YES;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    if (tempo==YES) {
        //NSLog(@"ShouldDismissPopover");
        [self configureView];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)sender{
    [sender resignFirstResponder];
    if (self.detailItem!=nil){
        [self save];
    }
    return YES;
}

-(void)Play:(id)sender{
    //画面を明るいままにする。
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    self.toolbarItems=items2;
    Play=YES;
    NSNumber *num=self.detailItem.slider;
    value=[num intValue];
    NSNumber *num2=self.detailItem.tempo;
    value3=[num2 intValue];
    switch (value3) {
        case 0:beat=3.0;beat2=60.0;break;//3/4
        case 1:beat=4.0;beat2=60.0;break;//4/4
        case 2:beat=2.0;beat2=60.0;break;//2/4
        case 3:beat=5.0;beat2=60.0;break;//5/4
        case 4:beat=6.0;beat2=30.0;break;//6/8
        case 5:beat=12.0;beat2=30.0;break;//12/8
        case 6:beat=2.0;beat2=120.0;break;//2/2
        case 7:beat=4.0;beat2=120.0;break;//4/2
        default:break;
    }
    bpm=value+50.0;bpm2=beat2/bpm;
    metronome3=YES;
    [self beginDetection];
    [TrackingManager sendEventTracking:@"Button" action:@"Play"label:@"Play1" value:[NSNumber numberWithInt:value+50] screen:screenName];
}

-(void)Play2{
    if (Play==NO) {
        [UIApplication sharedApplication].idleTimerDisabled=YES;
        self.toolbarItems=items2;
        Play=YES;
        NSNumber *num=self.detailItem.slider;
        value=[num intValue];
        NSNumber *num2=self.detailItem.tempo;
        value3=[num2 intValue];
        
        switch (value3) {
            case 0:beat=3.0;beat2=60.0;break;//3/4
            case 1:beat=4.0;beat2=60.0;break;//4/4
            case 2:beat=2.0;beat2=60.0;break;//2/4
            case 3:beat=5.0;beat2=60.0;break;//5/4
            case 4:beat=6.0;beat2=30.0;break;//6/8
            case 5:beat=12.0;beat2=30.0;break;//12/8
            case 6:beat=2.0;beat2=120.0;break;//2/2
            case 7:beat=4.0;beat2=120.0;break;//4/2
            default:break;
        }
        bpm=value+50.0;bpm2=beat2/bpm;
        metronome3=YES;
        metronome4=NO;Play2=YES;
        barcount=activeButton2.tag-401;barcount3=activeButton2.tag-401;
        [self beginDetection];
    }
    [TrackingManager sendEventTracking:@"Button" action:@"Play"label:@"Play2" value:[NSNumber numberWithInt:value+50] screen:screenName];
}

-(void)Metronome{
    if (Play2==NO) {
        barcount=0;
    }
    barcount2=0;
    while (Play) {
        switch (value6) {
            case 0:NumberButton.backgroundColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];break;//3/4紺
            case 1:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];break;//4/4緑
            case 2:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];break;//2/4橙
            case 3:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];break;//5/4桃
            case 4:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];break;//6/8青
            case 5:NumberButton.backgroundColor=[UIColor brownColor];break;//12/8茶
            case 6:NumberButton.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];break;//2/2灰
            case 7:NumberButton.backgroundColor=[UIColor blackColor];break;//4/2黒
            case 8:NumberButton.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];break;//1/4//紫
            case 9:NumberButton.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;//3/8桜
            case 10:NumberButton.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];break;//1/2黄
            case 11:NumberButton.backgroundColor=[UIColor greenColor];break;//3/2
            default:break;
        }
        if (metronome3) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (Play2==NO) {
                    CGPoint scrollPoint = CGPointMake(0,-55);
                    [UIView animateWithDuration:2.0 animations:^ {
                        [scroll setContentOffset:scrollPoint animated:YES];
                    }];
                }
            });
            [self performSelector:@selector(Delay:)withObject:nil afterDelay:bpm2];//0.5
        }
        [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:bpm2*beat]];
    }
    if (Pause==NO) {
        barcount3=0;
    }
    barcount2=0;
    //NSLog(@"end");
}

- (void)tick:(NSTimer *)timer {
    if (barcount3<=beat+3) {
        switch (barcount3) {
            case 0:[metoro2 play];break;
            case 1:break;
            case 2:[metoro2 play];break;
            case 3:break;
            default:[metoro2 play];break;
        }
        barcount3++;
    }
    else{
        switch (barcount2) {
            case 0:{
                [metoro1 play];
                barcount++;
                numberButton=[NumberButtonarray objectAtIndex:barcount-1];
                NSNumber *number6=[Tempoarray objectAtIndex:barcount-1];
                value6=[number6 intValue];
                switch (value6) {
                    case 0:beat=3.0;beat2=60.0;break;//3/4
                    case 1:beat=4.0;beat2=60.0;break;//4/4
                    case 2:beat=2.0;beat2=60.0;break;//2/4
                    case 3:beat=5.0;beat2=60.0;break;//5/4
                    case 4:beat=6.0;beat2=30.0;break;//6/8
                    case 5:beat=12.0;beat2=30.0;break;//12/8
                    case 6:beat=2.0;beat2=120.0;break;//2/2
                    case 7:beat=4.0;beat2=120.0;break;//4/2
                    case 8:beat=1.0;beat2=60.0;break;//1/4
                    case 9:beat=3.0;beat2=30.0;break;//3/8
                    case 10:beat=1.0;beat2=120.0;break;//1/2
                    case 11:beat=3.0;beat2=120.0;break;//3/2
                    default:break;
                }
                barcount3=beat+4;
                float y = numberButton.frame.origin.y;
                float x = self.view.frame.size.width/2-10;
                if (numberButton.tag<411) {}
                else if (x<=numberButton.frame.origin.x) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        CGPoint scrollPoint = CGPointMake(0,y-215);
                        [UIView animateWithDuration:2.0 animations:^ {
                            [scroll setContentOffset:scrollPoint animated:YES];}];});
                }
                if (value6==8) {
                    barcount2=0;
                }
                else{
                    barcount2++;
                }
                //NSLog(@"%d",barcount2);
            }
                break;
            default:
                barcount2++;
                //NSLog(@"%d",barcount2);
                if (barcount2==beat) {
                    barcount2=0;
                    [metoro2 play];
                }
                else{
                    [metoro2 play];
                }
                break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:bpm2/(beat*beat)
                              delay:0.0
                            options: UIViewAnimationOptionAutoreverse //|             UIViewAnimationOptionRepeat
                         animations: ^{numberButton.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];}
                         completion: ^(BOOL finished){switch (value6) {
            case 0:NumberButton.backgroundColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];break;//3/4紺
            case 1:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];break;//4/4緑
            case 2:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];break;//2/4橙
            case 3:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];break;//5/4桃
            case 4:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];break;//6/8青
            case 5:NumberButton.backgroundColor=[UIColor brownColor];break;//12/8茶
            case 6:NumberButton.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];break;//2/2灰
            case 7:NumberButton.backgroundColor=[UIColor blackColor];break;//4/2黒
            case 8:NumberButton.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];break;//1/4//紫
            case 9:NumberButton.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;//3/8桜
            case 10:NumberButton.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];break;//1/2黄
            case 11:NumberButton.backgroundColor=[UIColor greenColor];break;//3/2
            default:break;
        }}
         ];
            });
    }
    if (barcount==200) {Play=NO;}
    metronome3=NO;
    //NSLog(@"a");
}

-(void)Delay:(id)sender{
    tm= [NSTimer scheduledTimerWithTimeInterval:beat2/bpm target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    [tm fire];
}

- (void)beginDetection {
    [[RBDMuteSwitch sharedInstance] setDelegate:self];
    [[RBDMuteSwitch sharedInstance] detectMuteSwitch];
    //NSLog(@"beginDetection");
}

- (void)isMuted:(BOOL)muted {
    //NSLog(@"isMuted");
    if (muted) {
        if (Pause==NO) {
            [self PlayAnimation:YES];
        }
        else{
            [self PauseAnimation:NO];
        }
        NotMuted=NO;
    }
    else {
        [self PlayAnimation:NO];
        NotMuted=YES;
    }
}

-(void)PlayAnimation:(BOOL)aPlay{
    if (aPlay) {
        animation=[CABasicAnimation animationWithKeyPath:@"position"];
        //animation.delegate=self;
        //layer=score.layer;
        //アニメーションの開始位置。ナビゲーションバーを消すため少し下げてからスタート。6837 7803 7600 3952
        animation.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width/2,4408)];//layer.position];
        animation.toValue=[NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width/2,-3900)];
        animation.duration=bpm2*beat*208;
        [layer addAnimation:animation forKey:@"changePosition"];
        //NSLog(@"Muted");//NSLog(@"%d",animation.duration);
        [TrackingManager sendEventTracking:@"Button" action:@"Play"label:@"Muted" value:[NSNumber numberWithInt:value+50] screen:screenName];
    }
    else{
        [NSThread detachNewThreadSelector:@selector(Metronome)toTarget:self withObject:nil];
        //NSLog(@"Not Muted");
        [TrackingManager sendEventTracking:@"Button" action:@"Play"label:@"Not Muted" value:[NSNumber numberWithInt:value+50] screen:screenName];
    }
}

//アニメーション一時停止の設定
-(void)PauseAnimation:(BOOL)aPause{
    if (aPause) {
        CFTimeInterval pausedTime=[layer convertTime:CACurrentMediaTime() fromLayer:nil];
        layer.speed=0;
        layer.timeOffset=pausedTime;
    }
    else {
        CFTimeInterval pausedTime=[layer timeOffset];
        layer.speed=1;
        layer.timeOffset=pausedTime;
        layer.beginTime=0;
        CFTimeInterval timeSincePause=[layer convertTime:CACurrentMediaTime() fromLayer:nil]-pausedTime;
        layer.beginTime=timeSincePause;
    }
}

-(void)Stop:(id)sender{
    Play=NO;
    Pause=YES;
    [self PauseAnimation:YES];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [UIApplication sharedApplication].statusBarHidden=NO;
    self.navigationController.navigationBarHidden=NO;
    stop.enabled=NO;
    rewind.enabled=NO;
    [self performSelector:@selector(toolbarItemsDelay:)withObject:nil afterDelay:bpm2*4];//連打できないようにするため１小節後にする
    [TrackingManager sendEventTracking:@"Button" action:@"Play"label:@"Pause" value:nil screen:screenName];
}

-(void)toolbarItemsDelay:(id)sender{
    self.toolbarItems=items;
    stop.enabled=YES;
    rewind.enabled=YES;
}

-(void)FirstForward:(id)sender{
    [self dismiss];
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    //self.navigationController.navigationBarHidden=YES;
    //[UIApplication sharedApplication].statusBarHidden=YES;
    self.toolbarItems=items2;
    metronome3=YES;
    Play=YES;
    Play2=YES;
    barcount2=0;
    if (NotMuted) {
        [self PlayAnimation:NO];
    }
    else{
        [self PauseAnimation:NO];
    }
    [TrackingManager sendEventTracking:@"Button" action:@"Play"label:@"FirstForward" value:nil screen:screenName];
}

-(void)REwind:(id)sender{
    Play=NO;
    Play2=NO;
    barcount=0;
    barcount3=0;
    barcount2=0;
    Pause=NO;
    [layer removeAllAnimations];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    //[UIApplication sharedApplication].statusBarHidden=NO;
    //self.navigationController.navigationBarHidden=NO;
    stop.enabled=NO;
    rewind.enabled=NO;
    play.enabled=NO;
    [self performSelector:@selector(toolbarItemsDelay2:)withObject:nil afterDelay:bpm2*4];//連打できないようにするため１小節後にする
    layer.speed=1;//CMPopTipViewを出すのに必要。
    [self dismiss];
    [TrackingManager sendEventTracking:@"Button" action:@"Play"label:@"REwind" value:nil screen:screenName];
}

-(void)toolbarItemsDelay2:(id)sender{
    stop.enabled=YES;
    rewind.enabled=YES;
    play.enabled=YES;
    self.toolbarItems=items1;
}

-(void)Diatonic:(id)sender{
    UIButton *bt = (UIButton *) sender;
    BOOL C =[bt.titleLabel.text isEqualToString:@"C"];BOOL D =[bt.titleLabel.text isEqualToString:@"D"];
    BOOL E =[bt.titleLabel.text isEqualToString:@"E"];BOOL F =[bt.titleLabel.text isEqualToString:@"F"];
    BOOL G =[bt.titleLabel.text isEqualToString:@"G"];BOOL A =[bt.titleLabel.text isEqualToString:@"A"];
    BOOL B =[bt.titleLabel.text isEqualToString:@"B"]; BOOL CS =[bt.titleLabel.text isEqualToString:@"#"];
    BOOL DF =[bt.titleLabel.text isEqualToString:@"♭"];
    
    if (C) {
        CC=YES;DD=NO;EE=NO;FF=NO;GG=NO;AA=NO;BB=NO;
        for (int i=0; i<=155; i++) {
            compButton=[compButtons objectAtIndex:i];
            NSString *str7=[chordarrayC objectAtIndex:i];
            [compButton setTitle:str7 forState:UIControlStateNormal];
        }
        chordarraynumber=0;ButtonColorNumber1=0;ButtonColorNumber2=0;
    }
    if (D) {
        CC=NO;DD=YES;EE=NO;FF=NO;GG=NO;AA=NO;BB=NO;
        for (int i=0; i<=155; i++) {
            compButton=[compButtons objectAtIndex:i];
            NSString *str7=[chordarrayD objectAtIndex:i];
            [compButton setTitle:str7 forState:UIControlStateNormal];
        }
        chordarraynumber=1;ButtonColorNumber1=1;ButtonColorNumber2=1;
    }
    if (E) {
        CC=NO;DD=NO;EE=YES;FF=NO;GG=NO;AA=NO;BB=NO;
        for (int i=0; i<=155; i++) {
            compButton=[compButtons objectAtIndex:i];
            NSString *str7=[chordarrayE objectAtIndex:i];
            [compButton setTitle:str7 forState:UIControlStateNormal];
        }
        chordarraynumber=2;ButtonColorNumber1=2;ButtonColorNumber2=2;
    }
    if (F) {
        CC=NO;DD=NO;EE=NO;FF=YES;GG=NO;AA=NO;BB=NO;
        for (int i=0; i<=155; i++) {
            compButton=[compButtons objectAtIndex:i];
            NSString *str7=[chordarrayF objectAtIndex:i];
            [compButton setTitle:str7 forState:UIControlStateNormal];
        }
        chordarraynumber=3;ButtonColorNumber1=3;ButtonColorNumber2=3;
    }
    if (G) {
        CC=NO;DD=NO;EE=NO;FF=NO;GG=YES;AA=NO;BB=NO;
        for (int i=0; i<=155; i++) {
            compButton=[compButtons objectAtIndex:i];
            NSString *str7=[chordarrayG objectAtIndex:i];
            [compButton setTitle:str7 forState:UIControlStateNormal];
        }
        chordarraynumber=4;ButtonColorNumber1=4;ButtonColorNumber2=4;
    }
    if (A) {
        CC=NO;DD=NO;EE=NO;FF=NO;GG=NO;AA=YES;BB=NO;
        for (int i=0; i<=155; i++) {
            compButton=[compButtons objectAtIndex:i];
            NSString *str7=[chordarrayA objectAtIndex:i];
            [compButton setTitle:str7 forState:UIControlStateNormal];
        }
        chordarraynumber=5;ButtonColorNumber1=5;ButtonColorNumber2=5;
    }
    if (B) {
        CC=NO;DD=NO;EE=NO;FF=NO;GG=NO;AA=NO;BB=YES;
        for (int i=0; i<=155; i++) {
            compButton=[compButtons objectAtIndex:i];
            NSString *str7=[chordarrayB objectAtIndex:i];
            [compButton setTitle:str7 forState:UIControlStateNormal];
        }
        chordarraynumber=6;ButtonColorNumber1=6;ButtonColorNumber2=6;
    }
    if (CS) {
        chordarraynumber=7;ButtonColorNumber1=0;ButtonColorNumber2=7;
        if (CC) {
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (DD) {
            chordarraynumber=8;ButtonColorNumber1=1;ButtonColorNumber2=7;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (FF) {
            chordarraynumber=9;ButtonColorNumber1=3;ButtonColorNumber2=7;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (EE) {
            EE=NO; FF=YES;
            chordarraynumber=3;ButtonColorNumber1=3;ButtonColorNumber2=3;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (GG) {
            chordarraynumber=10;ButtonColorNumber1=4;ButtonColorNumber2=7;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (AA) {
            chordarraynumber=11;ButtonColorNumber1=5;ButtonColorNumber2=7;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (BB) {
            BB=NO; CC=YES;
            chordarraynumber=0;ButtonColorNumber1=0;ButtonColorNumber2=0;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
    }
    if (DF) {
        if (DD) {
            chordarraynumber=12;ButtonColorNumber1=1;ButtonColorNumber2=8;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (EE) {
            chordarraynumber=13;ButtonColorNumber1=2;ButtonColorNumber2=8;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (FF) {
            FF=NO;EE=YES;
            chordarraynumber=2;ButtonColorNumber1=2;ButtonColorNumber2=2;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (GG) {
            chordarraynumber=14;ButtonColorNumber1=4;ButtonColorNumber2=8;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (AA) {
            chordarraynumber=15;ButtonColorNumber1=5;ButtonColorNumber2=8;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (BB) {
            chordarraynumber=16;ButtonColorNumber1=6;ButtonColorNumber2=8;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
        if (CC) {
            CC=NO;BB=YES;
            chordarraynumber=6;ButtonColorNumber1=6;ButtonColorNumber2=6;
            for (int i=0; i<=155; i++) {
                compButton=[compButtons objectAtIndex:i];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
            }
        }
    }
    for (int i=0; i<=8; i++) {
        chordButton1=[ChordButtonarray objectAtIndex:i];
        chordButton1.tag=i;
        chordButton1.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];
        if (chordButton1.tag==7) {
            chordButton1.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
        }
        if (chordButton1.tag==8) {
            chordButton1.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
        }
        if (chordButton1.tag==ButtonColorNumber1) {
            chordButton1.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
        }
        if (chordButton1.tag==ButtonColorNumber2) {
            chordButton1.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
        }
    }
    [TrackingManager sendEventTracking:@"Button" action:@"Diatonic"label:bt.titleLabel.text value:nil screen:screenName];
}

-(void)M:(id)sender{
    UIButton *bt = (UIButton *) sender;
    BOOL C1 =[bt.titleLabel.text isEqualToString:@"M"];BOOL C2 =[bt.titleLabel.text isEqualToString:@"m"];
    BOOL C3 =[bt.titleLabel.text isEqualToString:@"7"];BOOL C4 =[bt.titleLabel.text isEqualToString:@"m7♭5"];
    BOOL C5 =[bt.titleLabel.text isEqualToString:@"6"];BOOL C6 =[bt.titleLabel.text isEqualToString:@"mM7"];
    BOOL C7 =[bt.titleLabel.text isEqualToString:@"dim"];BOOL C8 =[bt.titleLabel.text isEqualToString:@"aug"];
    BOOL C9 =[bt.titleLabel.text isEqualToString:@"sus4"];BOOL C10 =[bt.titleLabel.text isEqualToString:@"add9"];
    BOOL C11 =[bt.titleLabel.text isEqualToString:@"7(2)"];
    
    int m=0;
    if (C1) {m=10;}
    if (C2) {m=16;}
    if (C3) {m=22;}
    if (C11) {m=32;}
    if (C4) {m=36;}
    if (C5) {m=38;}
    if (C6) {m=42;}
    if (C7) {m=42;}
    if (C8) {m=42;}
    if (C9) {m=42;}
    if (C10) {m=42;}
    UIButton *button=[compButtons objectAtIndex:m];
    float x = button.frame.origin.x;
    [accessoryscroll2 setContentOffset:CGPointMake(x,0) animated:YES];
    [TrackingManager sendEventTracking:@"Button" action:@"M"label:bt.titleLabel.text value:nil screen:screenName];
}

-(void)tempo1:(id)sender{
    PickerViewController *pickerViewController = [[PickerViewController alloc]init];
    pickerViewController.delegate=self;
    pickerViewController.detailItem=self.detailItem;
    pickerViewController.preferredContentSize = CGSizeMake(200, 200);    // 表示サイズ指定（重要）
    pickerViewController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *presentationController =[pickerViewController popoverPresentationController];
    presentationController.permittedArrowDirections =UIPopoverArrowDirectionAny;
    presentationController.delegate=self;
    presentationController.backgroundColor=[UIColor lightGrayColor];
    presentationController.barButtonItem = sender;
    [self presentViewController:pickerViewController animated: YES completion: nil];
}

-(void)Textviewclose:(id)sender{
    [activeField2 resignFirstResponder];
    if (self.detailItem!=nil){
        [self save];
    }
}

-(void)A:(id)sender{
    UIButton *bt = (UIButton *) sender;
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=5) {
        [activeField replaceRange: activeField.selectedTextRange withText: bt.titleLabel.text];
    }
    else{
        activeField.text=[activeField.text stringByAppendingString: bt.titleLabel.text];
    }
    [TrackingManager sendEventTracking:@"Button" action:@"A"label:bt.titleLabel.text value:nil screen:screenName];
}

-(void)space:(id)sender{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=5) {
        [activeField replaceRange: activeField.selectedTextRange withText:@" "];
    }
    else{
        activeField.text=[activeField.text stringByAppendingString:@" "];
    }
}

-(void)done:(id)sender{
    [activeField resignFirstResponder];
    FirstResponder=NO;
    if (self.detailItem!=nil){
        [self save];
    }
}

-(void)back:(id)sender{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
        NSUInteger len = [activeField.text length];
        if (activeField.text.length>0) {
            if (colorvalue2>=7) {
                activeField.text = [activeField.text substringToIndex:len-activeField.text.length];
            }
            else{
                activeField.text = [activeField.text substringToIndex:len-1];
            }
        }
    }
    /*else if ([[[UIDevice currentDevice]systemVersion]floatValue]>=5) {
     [activeField replaceRange: activeField.selectedTextRange withText:nil];
     }*/
    else{
        NSUInteger len = [activeField.text length];
        if (activeField.text.length>0) {
            activeField.text = [activeField.text substringToIndex:len-1];
        }
    }
    [TrackingManager sendEventTracking:@"Button" action:@"keyboard"label:@"back" value:nil screen:screenName];
}

-(void)next:(id)sender{
    if (activeField.tag<=199) {
        UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag+1];
        [nextResponder becomeFirstResponder];
        float y = activeField.frame.origin.y;
        //NSLog(@"%1f",y);
        CGPoint scrollPoint = CGPointMake(0,y-240);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    /*UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag+1];
    [nextResponder becomeFirstResponder];
    float y = activeField.frame.origin.y;//フォーカスされているtextfieldの座標y（高さ）を取得
    CGPoint scrollPoint = CGPointMake(0,y-248);
    [scroll setContentOffset:scrollPoint animated:YES];
    
    if(activeField.tag==200){
        UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag+0];
        [nextResponder becomeFirstResponder];
    }*/
    if (activeField.tag<=4) {
        float y = activeField.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-95);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    [TrackingManager sendEventTracking:@"Button" action:@"keyboard"label:@"next chord" value:nil screen:screenName];
}

-(void)back2:(id)sender{
    if (activeField.tag==1) {
    }
    else {
        UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag-1];
        [nextResponder becomeFirstResponder];
        float y = activeField.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-240);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    if (activeField.tag<=4) {
        UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag-0];
        [nextResponder becomeFirstResponder];
        float y = activeField.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-95);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    [TrackingManager sendEventTracking:@"Button" action:@"keyboard"label:@"back chord" value:nil screen:screenName];
}

-(void)next2:(id)sender{
    if(activeField2.tag<=399){
        UIResponder* nextResponder = [activeField2.superview viewWithTag:activeField2.tag+1];
        [nextResponder becomeFirstResponder];
        float y = activeField2.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-315);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    if (activeField2.tag<=204) {
        float y = activeField2.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-170);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    [TrackingManager sendEventTracking:@"Button" action:@"keyboard"label:@"next lyrics" value:nil screen:screenName];
}

-(void)back3:(id)sender{
    if(activeField2.tag>=202){
        UIResponder* nextResponder = [activeField2.superview viewWithTag:activeField2.tag-1];
        [nextResponder becomeFirstResponder];
        float y = activeField2.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-315);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    if (activeField2.tag<=204) {
        float y = activeField2.frame.origin.y;
        CGPoint scrollPoint = CGPointMake(0,y-170);
        [scroll setContentOffset:scrollPoint animated:YES];
    }
    [TrackingManager sendEventTracking:@"Button" action:@"keyboard"label:@"back lyrics" value:nil screen:screenName];
}

/*-(void)save:(id)sender{
    [self save];
}*/

-(void)Copy:(id)sender{
    //[self dismiss];
    Font_ColorViewController *font_ColorViewController = [[Font_ColorViewController alloc]init];
    font_ColorViewController.delegate=self;
    font_ColorViewController.detailItem=self.detailItem;
    font_ColorViewController.preferredContentSize = CGSizeMake(200, 160);    // 表示サイズ指定（重要）
    font_ColorViewController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *presentationController =[font_ColorViewController popoverPresentationController];
    presentationController.permittedArrowDirections =UIPopoverArrowDirectionAny;
    presentationController.delegate=self;
    presentationController.backgroundColor=[UIColor lightGrayColor];
    presentationController.barButtonItem = sender;
    [self presentViewController:font_ColorViewController animated: YES completion: nil];
}

-(void)GDP:(NSNotification *)notification{
    // NSLog(@"%@", NSStringFromSelector(_cmd));
    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
    [UserDefaults setBool:YES forKey:@"GuitarDiagram"];
    [UserDefaults synchronize];
    if (self.detailItem!=nil){
        [self save];
    }
    [self configureView];
}

-(void)GDLP:(NSNotification *)notification{
    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
    [UserDefaults setBool:YES forKey:@"GuitarDiagramLite"];
    [UserDefaults synchronize];
    if (self.detailItem!=nil){
        [self save];
    }
    [self configureView];
}

-(void)UDP:(NSNotification *)notification{
    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
    [UserDefaults setBool:YES forKey:@"UkirereDiagram"];
    [UserDefaults synchronize];
    if (self.detailItem!=nil){
        [self save];
    }
    [self configureView];
}

-(void)UDLP:(NSNotification *)notification{
    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
    [UserDefaults setBool:YES forKey:@"UkurereDiagramLite"];
    [UserDefaults synchronize];
    if (self.detailItem!=nil){
        [self save];
    }
    [self configureView];
}

-(void)menu:(id)sender{
    if (self.detailItem) {
        activeButton2=sender;
        if (ButtonPopTipView==NO){
            if (activeButton2tag==NO) {
                if (activeButton2tag2==NO) {
                    activeButton2.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
                    activeButton2tag=YES;
                    NSInteger tagNum1 =activeButton2.tag;
                    activeButton2Number1=tagNum1;
                    ButtonPopTipView=YES;
                    
                    BeetViewController *beetViewController;
                    beetViewController = [[BeetViewController alloc]init];
                    beetViewController.delegate=self;
                    beetViewController.preferredContentSize = CGSizeMake(200, 140);    // 表示サイズ指定（重要）
                    beetViewController.modalPresentationStyle = UIModalPresentationPopover;
                    UIPopoverPresentationController *presentationController =[beetViewController popoverPresentationController];
                    presentationController.permittedArrowDirections =UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
                    presentationController.delegate=self;
                    presentationController.backgroundColor=[UIColor lightGrayColor];
                    presentationController.sourceView = score2;
                    presentationController.sourceRect = activeButton2.frame;
                    [self presentViewController:beetViewController animated: YES completion: nil];
                    
                    barcount=activeButton2.tag-401;barcount3=activeButton2.tag-401;
                }
                else{
                    PasteViewController *pasteViewController;
                    pasteViewController = [[PasteViewController alloc]init];
                    pasteViewController.delegate=self;
                    pasteViewController.preferredContentSize = CGSizeMake(200, 135);    // 表示サイズ指定（重要）
                    pasteViewController.modalPresentationStyle = UIModalPresentationPopover;
                    UIPopoverPresentationController *presentationController =[pasteViewController popoverPresentationController];
                    presentationController.permittedArrowDirections =UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
                    presentationController.delegate=self;
                    presentationController.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];
                    presentationController.sourceView = score2;
                    presentationController.sourceRect = activeButton2.frame;
                    [self presentViewController:pasteViewController animated: YES completion: nil];
                }
            }
        }
        else if(activeButton2Number1==activeButton2.tag){
            [self dismiss];
            activeButton2tag=NO;ButtonPopTipView=NO;
        }
        else{
            CopyViewController *copyViewController;
            copyViewController = [[CopyViewController alloc]init];
            copyViewController.delegate=self;
            copyViewController.preferredContentSize = CGSizeMake(200, 140);    // 表示サイズ指定（重要）
            copyViewController.modalPresentationStyle = UIModalPresentationPopover;
            UIPopoverPresentationController *presentationController =[copyViewController popoverPresentationController];
            presentationController.permittedArrowDirections =UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
            presentationController.delegate=self;
            presentationController.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];
            presentationController.sourceView = score2;
            presentationController.sourceRect = activeButton2.frame;
            [self presentViewController:copyViewController animated: YES completion: nil];
        
            for (int i=0; i<200; i++) {
                NumberButton=[NumberButtonarray objectAtIndex:i];
                NSNumber *number6=[Tempoarray objectAtIndex:i];
                value6=[number6 intValue];
                NSInteger tagNum =activeButton2.tag;
                activeButton2Number2=tagNum;
                if (NumberButton.tag<=activeButton2Number2) {
                    NumberButton.backgroundColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
                }
                if ((NumberButton.tag<activeButton2Number1)||(NumberButton.tag>activeButton2Number2)) {
                    switch (value6) {
                        case 0:NumberButton.backgroundColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];break;//3/4紺
                        case 1:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];break;//4/4緑
                        case 2:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];break;//2/4橙
                        case 3:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];break;//5/4桃
                        case 4:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];break;//6/8青
                        case 5:NumberButton.backgroundColor=[UIColor brownColor];break;//12/8茶
                        case 6:NumberButton.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];break;//2/2灰
                        case 7:NumberButton.backgroundColor=[UIColor blackColor];break;//4/2黒
                        case 8:NumberButton.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];break;//1/4//紫
                        case 9:NumberButton.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;//3/8桜
                        case 10:NumberButton.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];break;//1/2黄
                        case 11:NumberButton.backgroundColor=[UIColor greenColor];break;//3/2
                        default:break;
                    }
                }
            }
            activeButton2tag2=NO;
        }
    }
}

-(void)BeetViewControllerDelegateDidfinish:(NSInteger)getData{
    value5=getData;
    //NSLog(@"%ld",(long)value5);
    NSNumber *number7=[NSNumber numberWithInteger:value5];
    [Tempoarray replaceObjectAtIndex:activeButton2.tag-401 withObject:number7];
    NSData *metronomedata=[NSKeyedArchiver archivedDataWithRootObject:Tempoarray];
    self.detailItem.metronome=metronomedata;
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self dismiss];
}

-(void)ChordCopyButton{
    ButtonPopTipView=NO;
    activeButton2tag=NO;
    activeButton2tag2=YES;
    ChordCopy=YES;
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"ChordCopyButton" value:nil screen:screenName];
}

-(void)LyricsCopyButton{
    ButtonPopTipView=NO;
    activeButton2tag=NO;
    activeButton2tag2=YES;
    LyricsCopy=YES;
    activeButton2Number1+=200;
    activeButton2Number2+=200;
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"LyricsCopyButton" value:nil screen:screenName];
}

-(void)PasteButton{
    for (int i=0; i<=399; i++) {
        UITextField *textFieldi=[textFields objectAtIndex:i];
        if (textFieldi.text!=nil) {
            [dataarray replaceObjectAtIndex:i withObject:textFieldi.text];
        }
    }
    NSInteger tagNum1 =activeButton2.tag;
    if (ChordCopy==YES) {
        if (activeButton2Number2-activeButton2Number1+tagNum1<=600) {
            if (activeButton2Number1<activeButton2Number2) {
                for (NSInteger i=activeButton2Number1; i<=activeButton2Number2; i++) {
                    [dataarray replaceObjectAtIndex:tagNum1++-1-400 withObject:[dataarray objectAtIndex:i-1-400]];
                }
            }
        }
    }
    if (LyricsCopy==YES) {
        tagNum1+=200;
        if (activeButton2Number2-activeButton2Number1+tagNum1<=800) {
            if (activeButton2Number1<activeButton2Number2) {
                for (NSInteger i=activeButton2Number1; i<=activeButton2Number2; i++) {
                    [dataarray replaceObjectAtIndex:tagNum1++-1-400 withObject:[dataarray objectAtIndex:i-1-400]];
                }
            }
        }
    }
    for (int i=0; i<=399; i++) {
        UITextField *textFieldz=[textFields objectAtIndex:i];
        textFieldz.text=[dataarray objectAtIndex:i];
    }
    ChordCopy=NO;
    LyricsCopy=NO;
    [self save];
    [self dismiss];
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"PasteButton" value:nil screen:screenName];
}

-(void)Flat{
    for (int i=0; i<=399; i++) {
        UITextField *textFieldi=[textFields objectAtIndex:i];
        if (textFieldi.text!=nil) {
            [dataarray replaceObjectAtIndex:i withObject:textFieldi.text];
        }
    }
    for (NSInteger i=activeButton2Number1; i<=activeButton2Number2; i++){
        str=[NSMutableString stringWithFormat:@"%@",[dataarray objectAtIndex:i-401]];
        for (int x=0; x<=str.length; x++) {
            NSRange C=[str rangeOfString:@"C"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Cs=[str rangeOfString:@"C#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Df=[str rangeOfString:@"D♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange D=[str rangeOfString:@"D"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Ds=[str rangeOfString:@"D#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Ef=[str rangeOfString:@"E♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange E=[str rangeOfString:@"E"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange F=[str rangeOfString:@"F"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Fs=[str rangeOfString:@"F#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Gf=[str rangeOfString:@"G♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange G=[str rangeOfString:@"G"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Gs=[str rangeOfString:@"G#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Af=[str rangeOfString:@"A♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange A=[str rangeOfString:@"A"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange As=[str rangeOfString:@"A#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Bf=[str rangeOfString:@"B♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange B=[str rangeOfString:@"B"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange S=[str rangeOfString:@"#"options:0 range:NSMakeRange(x, str.length-x)];
            
            if (C.location!=NSNotFound) {if (C.location==x) {[str replaceCharactersInRange:C withString:@"B"];}}
            if (Cs.location!=NSNotFound) {if (Cs.location==x) {[str replaceCharactersInRange:Cs withString:@"C"];}}
            if (Df.location!=NSNotFound) {if (Df.location==x) {[str replaceCharactersInRange:Df withString:@"C"];}}
            if (D.location!=NSNotFound) {if (Df.location==x) {[str replaceCharactersInRange:D withString:@"C"];}
                else if (D.location==x) {[str replaceCharactersInRange:D withString:@"D♭"];}}
            if (Ds.location!=NSNotFound) {if (Ds.location==x) {[str replaceCharactersInRange:Ds withString:@"D"];
                [str deleteCharactersInRange:S];}}
            if (Ef.location!=NSNotFound) {if (Ef.location==x) {[str replaceCharactersInRange:Ef withString:@"D"];}}
            if (E.location!=NSNotFound) {if (Ef.location==x) {[str replaceCharactersInRange:E withString:@"D"];}
                else if (E.location==x) {[str replaceCharactersInRange:E withString:@"E♭"];}}
            if (F.location!=NSNotFound) {if (F.location==x) {[str replaceCharactersInRange:F withString:@"E"];}}
            if (Fs.location!=NSNotFound) {if (Fs.location==x) {[str replaceCharactersInRange:Fs withString:@"F"];}}
            if (Gf.location!=NSNotFound) {if (Gf.location==x) {[str replaceCharactersInRange:Gf withString:@"F"];}}
            if (G.location!=NSNotFound) {if (Gf.location==x) {[str replaceCharactersInRange:G withString:@"F"];}
                else if (G.location==x) {[str replaceCharactersInRange:G withString:@"G♭"];}}
            if (Gs.location!=NSNotFound) {if (Gs.location==x) {[str replaceCharactersInRange:Gs withString:@"G"];
                [str deleteCharactersInRange:S];}}
            if (Af.location!=NSNotFound) {if (Af.location==x) {[str replaceCharactersInRange:Af withString:@"G"];}}
            if (A.location!=NSNotFound) {if (Af.location==x) {[str replaceCharactersInRange:A withString:@"G"];}
                else if (A.location==x) {[str replaceCharactersInRange:A withString:@"A♭"];}}
            if (As.location!=NSNotFound) {if (As.location==x) {[str replaceCharactersInRange:As withString:@"A"];
                [str deleteCharactersInRange:S];}}
            if (Bf.location!=NSNotFound) {if (Bf.location==x) {[str replaceCharactersInRange:Bf withString:@"A"];}}
            if (B.location!=NSNotFound) {if (Bf.location==x) {[str replaceCharactersInRange:B withString:@"A"];}
                else if (B.location==x) {[str replaceCharactersInRange:B withString:@"B♭"];}}
        }[dataarray replaceObjectAtIndex:i-401 withObject:str];
    }
    for (int i=0; i<=399; i++) {
        UITextField *textFieldz=[textFields objectAtIndex:i];
        textFieldz.text=[dataarray objectAtIndex:i];
    }
    [self save];
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"Flat" value:nil screen:screenName];
}

-(void)Sharp{
    for (int i=0; i<=399; i++) {
        UITextField *textFieldi=[textFields objectAtIndex:i];
        if (textFieldi.text!=nil) {
            [dataarray replaceObjectAtIndex:i withObject:textFieldi.text];
        }
    }
    for (NSInteger i=activeButton2Number1; i<=activeButton2Number2; i++){
        str=[NSMutableString stringWithFormat:@"%@",[dataarray objectAtIndex:i-401]];
        for (int x=0; x<=str.length; x++) {
            NSRange C=[str rangeOfString:@"C"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Cs=[str rangeOfString:@"C#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Df=[str rangeOfString:@"D♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange D=[str rangeOfString:@"D"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Ds=[str rangeOfString:@"D#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Ef=[str rangeOfString:@"E♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange E=[str rangeOfString:@"E"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange F=[str rangeOfString:@"F"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Fs=[str rangeOfString:@"F#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Gf=[str rangeOfString:@"G♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange G=[str rangeOfString:@"G"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Gs=[str rangeOfString:@"G#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Af=[str rangeOfString:@"A♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange A=[str rangeOfString:@"A"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange As=[str rangeOfString:@"A#"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange Bf=[str rangeOfString:@"B♭"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange B=[str rangeOfString:@"B"options:0 range:NSMakeRange(x, str.length-x)];
            NSRange S=[str rangeOfString:@"#"options:0 range:NSMakeRange(x, str.length-x)];
            
            if (C.location!=NSNotFound) {if (C.location==x) {[str replaceCharactersInRange:C withString:@"C#"];}}
            if (Cs.location!=NSNotFound) {if (Cs.location==x) {[str replaceCharactersInRange:Cs withString:@"D"];
                [str deleteCharactersInRange:S];}}
            if (Df.location!=NSNotFound) {if (Df.location==x) {[str replaceCharactersInRange:Df withString:@"D"];}}
            if (D.location!=NSNotFound) {if (Df.location==x) {[str replaceCharactersInRange:D withString:@"D"];}
                else if (D.location==x) {[str replaceCharactersInRange:D withString:@"D#"];}}
            if (Ds.location!=NSNotFound) {if (Ds.location==x) {[str replaceCharactersInRange:Ds withString:@"E"];
                [str deleteCharactersInRange:S];}}
            if (Ef.location!=NSNotFound) {if (Ef.location==x) {[str replaceCharactersInRange:Ef withString:@"E"];}}
            if (E.location!=NSNotFound) {if (Ef.location==x) {[str replaceCharactersInRange:E withString:@"E"];}
                else if (E.location==x) {[str replaceCharactersInRange:E withString:@"F"];}}
            if (F.location!=NSNotFound) {if (F.location==x) {[str replaceCharactersInRange:F withString:@"F#"];}}
            if (Fs.location!=NSNotFound) {if (Fs.location==x) {[str replaceCharactersInRange:Fs withString:@"G"];
                [str deleteCharactersInRange:S];}}
            if (Gf.location!=NSNotFound) {if (Gf.location==x) {[str replaceCharactersInRange:Gf withString:@"G"];}}
            if (G.location!=NSNotFound) {if (Gf.location==x) {[str replaceCharactersInRange:G withString:@"G"];}
                else if (G.location==x) {[str replaceCharactersInRange:G withString:@"G#"];}}
            if (Gs.location!=NSNotFound) {if (Gs.location==x) {[str replaceCharactersInRange:Gs withString:@"A"];
                [str deleteCharactersInRange:S];}}
            if (Af.location!=NSNotFound) {if (Af.location==x) {[str replaceCharactersInRange:Af withString:@"A"];}}
            if (A.location!=NSNotFound) {if (Af.location==x) {[str replaceCharactersInRange:A withString:@"A"];}
                else if (A.location==x) {[str replaceCharactersInRange:A withString:@"A#"];}}
            if (As.location!=NSNotFound) {if (As.location==x) {[str replaceCharactersInRange:As withString:@"B"];
                [str deleteCharactersInRange:S];}}
            if (Bf.location!=NSNotFound) {if (Bf.location==x) {[str replaceCharactersInRange:Bf withString:@"B"];}}
            if (B.location!=NSNotFound) {if (Bf.location==x) {[str replaceCharactersInRange:B withString:@"B"];}
                else if (B.location==x) {[str replaceCharactersInRange:B withString:@"C"];}}
        }[dataarray replaceObjectAtIndex:i-401 withObject:str];
    }
    for (int i=0; i<=399; i++) {
        UITextField *textFieldz=[textFields objectAtIndex:i];
        textFieldz.text=[dataarray objectAtIndex:i];
    }
    [self save];
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"Sharp" value:nil screen:screenName];
}

-(void)Dismiss:(id)sender{
    [self dismiss];
}

-(void)ChordFontButton:(int)getData{
    colorvalue2=getData;
    NSNumber *Number1=[NSNumber numberWithInteger:colorvalue1];
    NSNumber *Number2=[NSNumber numberWithInteger:colorvalue2];
    NSNumber *Number3=[NSNumber numberWithInteger:colorvalue3];
    NSNumber *Number4=[NSNumber numberWithInteger:colorvalue4];
    NSArray *colordata2=[NSArray arrayWithObjects:Number1,Number2,Number3,Number4,nil];
    NSData *color=[NSKeyedArchiver archivedDataWithRootObject:colordata2];
    self.detailItem.colordata=color;
    [self save];
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"ChordFontButton" value:nil screen:screenName];
    [self makeColor];
}

-(void)LyricsFontButton:(int)getData{
    colorvalue4=getData;
    NSNumber *Number1=[NSNumber numberWithInteger:colorvalue1];
    NSNumber *Number2=[NSNumber numberWithInteger:colorvalue2];
    NSNumber *Number3=[NSNumber numberWithInteger:colorvalue3];
    NSNumber *Number4=[NSNumber numberWithInteger:colorvalue4];
    NSArray *colordata2=[NSArray arrayWithObjects:Number1,Number2,Number3,Number4,nil];
    NSData *color=[NSKeyedArchiver archivedDataWithRootObject:colordata2];
    self.detailItem.colordata=color;
    [self save];
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"LyricsFontButton" value:nil screen:screenName];
    [self makeColor];
}

-(void)ChordColorButton:(int)getData{
    colorvalue1=getData;
    NSNumber *Number1=[NSNumber numberWithInteger:colorvalue1];
    NSNumber *Number2=[NSNumber numberWithInteger:colorvalue2];
    NSNumber *Number3=[NSNumber numberWithInteger:colorvalue3];
    NSNumber *Number4=[NSNumber numberWithInteger:colorvalue4];
    NSArray *colordata2=[NSArray arrayWithObjects:Number1,Number2,Number3,Number4,nil];
    NSData *color=[NSKeyedArchiver archivedDataWithRootObject:colordata2];
    self.detailItem.colordata=color;
    [self save];
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"ChordColorButton" value:nil screen:screenName];
    [self makeColor];
}

-(void)LyricsColorButton:(int)getData{
    colorvalue3=getData;
    NSNumber *Number1=[NSNumber numberWithInteger:colorvalue1];
    NSNumber *Number2=[NSNumber numberWithInteger:colorvalue2];
    NSNumber *Number3=[NSNumber numberWithInteger:colorvalue3];
    NSNumber *Number4=[NSNumber numberWithInteger:colorvalue4];
    NSArray *colordata2=[NSArray arrayWithObjects:Number1,Number2,Number3,Number4,nil];
    NSData *color=[NSKeyedArchiver archivedDataWithRootObject:colordata2];
    self.detailItem.colordata=color;
    [self save];
    [TrackingManager sendEventTracking:@"Button" action:@"Menu"label:@"LyricsColorButton" value:nil screen:screenName];
    [self makeColor];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)save{
    for (int i=0; i<=399; i++) {
        UITextField *textFieldi=[textFields objectAtIndex:i];
        if (textFieldi.text!=nil) {
            [dataarray replaceObjectAtIndex:i withObject:textFieldi.text];
        }
    }
    NSData *textdata=[NSKeyedArchiver archivedDataWithRootObject:dataarray];
    if (GuitarDiagram){
        if (colorvalue2==7||colorvalue2==8) {
            //NSLog(@"GuitarDiagramsave");
            self.detailItem.diagram=textdata;
            self.detailItem.data=textdata;
        }
        else{
            self.detailItem.data=textdata;
        }
    }
    if (UkurereDiagram) {
        if (colorvalue2==9||colorvalue2==10) {
            //NSLog(@"UkurereDiagramsave");
            self.detailItem.diagram=textdata;
            self.detailItem.data=textdata;
        }
        else{
            self.detailItem.data=textdata;
        }
    }
    else{
        self.detailItem.data=textdata;
    }
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    //キーボードを非表示にする
    [self.view endEditing:YES];
}

-(void)dismiss{
    activeButton2tag=NO;
    activeButton2tag2=NO;
    ButtonPopTipView=NO;
    LyricsCopy=NO;
    ChordCopy=NO;
    if (tempo) {
        NSNumber *num2=self.detailItem.tempo;
        value3=[num2 intValue];
        if (value3!=value1) {
            for (int i=0; i<200; i++) {
                [Tempoarray replaceObjectAtIndex:i withObject:number1];
            }
        }
        self.detailItem.slider=number2;
        self.detailItem.tempo=number1;
        NSData *metronomedata=[NSKeyedArchiver archivedDataWithRootObject:Tempoarray];
        self.detailItem.metronome=metronomedata;
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        tempo=NO;
    }
    if (self.detailItem) {
        for (int i=0; i<200; i++) {
            NumberButton=[NumberButtonarray objectAtIndex:i];
            NSNumber *number6=[Tempoarray objectAtIndex:i];
            value6=[number6 intValue];
            switch (value6) {
                case 0:NumberButton.backgroundColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];break;//3/4紺
                case 1:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1];break;//4/4緑
                case 2:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];break;//2/4橙
                case 3:NumberButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];break;//5/4桃
                case 4:NumberButton.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];break;//6/8青
                case 5:NumberButton.backgroundColor=[UIColor brownColor];break;//12/8茶
                case 6:NumberButton.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];break;//2/2灰
                case 7:NumberButton.backgroundColor=[UIColor blackColor];break;//4/2黒
                case 8:NumberButton.backgroundColor=[UIColor colorWithRed:85/255.0 green:32/255.0 blue:142/255.0 alpha:1];break;//1/4//紫
                case 9:NumberButton.backgroundColor=[UIColor colorWithRed:213/255.0 green:100/255.0 blue:143/255.0 alpha:1];break;//3/8桜
                case 10:NumberButton.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];break;//1/2黄
                case 11:NumberButton.backgroundColor=[UIColor greenColor];break;//3/2
                default:break;
            }
        }
    }
    if (self.detailItem.title==nil) {
        view.alpha=0.5;
        
    }
    else{
        view.alpha=0;
        plus.alpha=0;
    }
}

-(void)ClosePicker:(id)sender{
    NSNumber *number7=[NSNumber numberWithInteger:value5];
    [Tempoarray replaceObjectAtIndex:activeButton2.tag-401 withObject:number7];
    NSData *metronomedata=[NSKeyedArchiver archivedDataWithRootObject:Tempoarray];
    self.detailItem.metronome=metronomedata;
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self dismiss];
}

-(void)Info:(id)sender{
    DescriptionTableViewController *Description=[[DescriptionTableViewController alloc]init];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:Description];
    
    navigationController.modalPresentationStyle = UIModalPresentationPopover;
    navigationController.preferredContentSize = CGSizeMake(568, 320);
    
    UIPopoverPresentationController *presentationController = navigationController.popoverPresentationController;
    presentationController.delegate = self;
    presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    presentationController.sourceView = sender;
    [self presentViewController:navigationController animated:YES completion:NULL];
}


- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}

@end
