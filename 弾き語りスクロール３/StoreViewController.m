//
//  StoreViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "AppDelegate.h"
#import "StoreViewController.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface StoreViewController ()
@end

@implementation StoreViewController
@synthesize textField1;
@synthesize textField2;
@synthesize textField3;
@synthesize textField4;
@synthesize Buy;
@synthesize Restore;
@synthesize GDL;
@synthesize UDL;
@synthesize GD;
@synthesize UD;
@synthesize chordfont;
@synthesize Orientation;
@synthesize text1;
@synthesize Price;

//ラベル生成。
-(UILabel*)makeLabel:(CGPoint)pos text:(NSString*)text font:(UIFont*)font{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGRect rect=CGRectMake(pos.x, pos.y, size.width, size.height);
    CGPoint point=CGPointMake(pos.x, pos.y);
    UILabel* label=[[UILabel alloc]init];
    label.adjustsFontSizeToFitWidth=YES;
    [label setCenter:point];
    [label setFrame:rect];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    return  label;
}
//textfield生成。
-(UITextField*)makeTextField:(CGRect)rect text:(NSString*)text{
    textField=[[UITextField alloc]init];
    [textField setFrame:rect];
    [textField setText:text];
    [textField setBorderStyle:UITextBorderStyleLine];
    textField.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];
    textField.adjustsFontSizeToFitWidth=YES;
    textField.textAlignment=NSTextAlignmentCenter;
    [textField setReturnKeyType:UIReturnKeyDone];
    textField.delegate=self;
    return textField;
}

//テキストボタンの生成
- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    Button* button=[Button buttonWithType:UIButtonTypeRoundedRect];
    [button.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:15]];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    return button;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden=YES;
    self.navigationController.navigationBarHidden=NO;
    self.title=NSLocalizedString(@"Store", nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenName = NSStringFromClass([self class]);
    [TrackingManager sendScreenTracking:screenName];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(torikeshi:)];
        self.navigationItem.leftBarButtonItem=cancel;
    }
    textFields=[NSMutableArray arrayWithObjects:textField1,textField2,textField3,textField4,nil];
    chordButtonarray=[[NSMutableArray alloc]init];
    array=[NSMutableArray arrayWithObjects:@"C",@"A7(♭13)",@"Dm7",@"G7",nil];
    
    /*scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scroll.autoresizingMask=UIViewAutoresizingFlexibleWidth;//iOS7では必要
    scroll.contentSize=CGSizeMake(0,250);
    [self.view addSubview:scroll];
    
    UITextField *textField1=[self makeTextField:CGRectZero text:@"C"];
    [textFields addObject:textField1];
    [scroll addSubview:textField1];textField1.tag=1;
    textField1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1
                                                                            constant:7];
    NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:scroll
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:10];
    NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1
                                                                              constant:70];
    NSLayoutConstraint *firstWidthConstraint = [NSLayoutConstraint constraintWithItem:textField1
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:scroll
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:.245
                                                                             constant:0];
    [scroll addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
    
    UITextField *textField2=[self makeTextField:CGRectZero text:@"A7(♭13)"];
    [textFields addObject:textField2];
    [scroll addSubview:textField2];textField2.tag=2;
    textField2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint2 = [NSLayoutConstraint constraintWithItem:textField2
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField1
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint2 = [NSLayoutConstraint constraintWithItem:textField2
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:10];
    NSLayoutConstraint *firstHeightConstraint2 = [NSLayoutConstraint constraintWithItem:textField2
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:70];
    NSLayoutConstraint *firstWidthConstraint2 = [NSLayoutConstraint constraintWithItem:textField2
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint2, firstTopConstraint2, firstHeightConstraint2 ,firstWidthConstraint2 ]];
    
    UITextField *textField3=[self makeTextField:CGRectZero text:@"Dm7"];
    [textFields addObject:textField3];
    [scroll addSubview:textField3];textField3.tag=3;
    textField3.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint3 = [NSLayoutConstraint constraintWithItem:textField3
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField2
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint3 = [NSLayoutConstraint constraintWithItem:textField3
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:10];
    NSLayoutConstraint *firstHeightConstraint3 = [NSLayoutConstraint constraintWithItem:textField3
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:70];
    NSLayoutConstraint *firstWidthConstraint3 = [NSLayoutConstraint constraintWithItem:textField3
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint3, firstTopConstraint3, firstHeightConstraint3 ,firstWidthConstraint3 ]];
    
    UITextField *textField4=[self makeTextField:CGRectZero text:@"G7"];
    [textFields addObject:textField4];
    [scroll addSubview:textField4];textField4.tag=4;
    textField4.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *firstLeftConstraint4 = [NSLayoutConstraint constraintWithItem:textField4
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:textField3
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1
                                                                             constant:-1];
    NSLayoutConstraint *firstTopConstraint4 = [NSLayoutConstraint constraintWithItem:textField4
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:scroll
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:10];
    NSLayoutConstraint *firstHeightConstraint4 = [NSLayoutConstraint constraintWithItem:textField4
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:70];
    NSLayoutConstraint *firstWidthConstraint4 = [NSLayoutConstraint constraintWithItem:textField4
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:scroll
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:.245
                                                                              constant:0];
    [scroll addConstraints:@[firstLeftConstraint4, firstTopConstraint4, firstHeightConstraint4 ,firstWidthConstraint4 ]];
    
    Buy=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
    [Buy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Buy.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:20]];
    [Buy addTarget:self action:@selector(Buy:) forControlEvents:UIControlEventTouchDown];
    Buy.backgroundColor=[UIColor colorWithRed:170/255.0 green:202/255.0 blue:219/255.0 alpha:1];
    [scroll addSubview:Buy];
    Buy.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:Buy
                                                                      attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:scroll
                                                                      attribute:NSLayoutAttributeWidth
                                                                     multiplier:.3
                                                                       constant:1];
    NSLayoutConstraint *RightConstraint = [NSLayoutConstraint constraintWithItem:Buy
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:textField4
                                                                       attribute:NSLayoutAttributeLeft
                                                                      multiplier:1
                                                                        constant:-60];
    NSLayoutConstraint *HeightConstraint = [NSLayoutConstraint constraintWithItem:Buy
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:30];
    NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:Buy
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:textField4
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:20];
    [scroll  addConstraints:@[LeftConstraint, RightConstraint, HeightConstraint ,TopConstraint ]];
    
    Price=[self makeLabel:CGPointZero text:@""font:[UIFont systemFontOfSize:17]];
    Price.backgroundColor=[UIColor colorWithRed:170/255.0 green:202/255.0 blue:219/255.0 alpha:1];
    [scroll addSubview:Price];
    Price.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint2 = [NSLayoutConstraint constraintWithItem:Price
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:scroll
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:.3
                                                                        constant:1];
    NSLayoutConstraint *RightConstraint2 = [NSLayoutConstraint constraintWithItem:Price
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:textField4
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1
                                                                         constant:-60];
    NSLayoutConstraint *HeightConstraint2 = [NSLayoutConstraint constraintWithItem:Price
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:20];
    NSLayoutConstraint *TopConstraint2 = [NSLayoutConstraint constraintWithItem:Price
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:Buy
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1
                                                                       constant:5];
    [scroll  addConstraints:@[LeftConstraint2, RightConstraint2, HeightConstraint2 ,TopConstraint2 ]];
    
    text1=[[UITextView alloc]initWithFrame:CGRectZero];
    text1.editable=NO;
    text1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    text1.font=[UIFont systemFontOfSize:10];
    [scroll addSubview:text1];
    text1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint3 = [NSLayoutConstraint constraintWithItem:text1
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:scroll
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:.3
                                                                        constant:1];
    NSLayoutConstraint *RightConstraint3 = [NSLayoutConstraint constraintWithItem:text1
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:textField4
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1
                                                                         constant:-60];
    NSLayoutConstraint *HeightConstraint3 = [NSLayoutConstraint constraintWithItem:text1
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:90];
    NSLayoutConstraint *TopConstraint3 = [NSLayoutConstraint constraintWithItem:text1
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:Price
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1
                                                                       constant:0];
    [scroll addConstraints:@[LeftConstraint3, RightConstraint3, HeightConstraint3 ,TopConstraint3 ]];
    
    Restore=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [Restore setTitle:NSLocalizedString(@"Restore", nil) forState:UIControlStateNormal];
    [Restore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Restore.titleLabel setFont:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:20]];
    [Restore addTarget:self action:@selector(Restore:) forControlEvents:UIControlEventTouchDown];
    Restore.backgroundColor=[UIColor colorWithRed:170/255.0 green:202/255.0 blue:219/255.0 alpha:1];
    [scroll addSubview:Restore];
    Restore.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *LeftConstraint4 = [NSLayoutConstraint constraintWithItem:Restore
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:scroll
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:.3
                                                                        constant:1];
    NSLayoutConstraint *RightConstraint4 = [NSLayoutConstraint constraintWithItem:Restore
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:textField4
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1
                                                                         constant:-60];
    NSLayoutConstraint *HeightConstraint4 = [NSLayoutConstraint constraintWithItem:Restore
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:30];
    NSLayoutConstraint *TopConstraint4 = [NSLayoutConstraint constraintWithItem:Restore
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:text1
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1
                                                                       constant:0];
    [scroll  addConstraints:@[LeftConstraint4, RightConstraint4, HeightConstraint4 ,TopConstraint4 ]];*/
    text1.editable=NO;
    view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor=[UIColor darkGrayColor];
    view.alpha=0;
    [self.view addSubview:view];
    kurukuru=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    kurukuru.center=CGPointMake(view.bounds.size.width*0.5f,view.bounds.size.height*0.5f);
    kurukuru.color=[UIColor lightGrayColor];
    [kurukuru startAnimating];
    [view addSubview:kurukuru];
    
    [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];

    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    status = [reachability currentReachabilityStatus];
    if (status == ReachableViaWiFi) {
        // wifi接続時
        //NSLog(@"wifi");
        NSSet *set = [NSSet setWithObjects:@"Guitar.Diagrm.application.productid",@"Guitar.Diagram.Lite.application.productid",@"Ukurere.Diagram.application.productid",@"Ukurere.Diagram.Lite.application.productid", nil];
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        productsRequest.delegate = self;
        [productsRequest start];
        Buy.enabled=YES;
        Restore.enabled=YES;
    } else if (status == ReachableViaWWAN) {
        // 3G接続時
        //NSLog(@"3G");
        NSSet *set = [NSSet setWithObjects:@"Guitar.Diagrm.application.productid",@"Guitar.Diagram.Lite.application.productid",@"Ukurere.Diagram.application.productid",@"Ukurere.Diagram.Lite.application.productid", nil];
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        productsRequest.delegate = self;
        [productsRequest start];
        Buy.enabled=YES;
        Restore.enabled=YES;
    } else if (status == NotReachable) {
        // 接続不可
        //NSLog(@"接続不可");
        text1.text=NSLocalizedString(@"Not connected to the Internet.", nil);
        Buy.enabled=NO;
        Restore.enabled=NO;
    }
    compButtons=[[NSMutableArray alloc]init];
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
    // chordarraynumber=0;//chordarrays:objectAtIndex
    // ButtonColorNumber1=0;ButtonColorNumber2=0;
    CC=YES;DD=NO;EE=NO;FF=NO;GG=NO;AA=NO;BB=NO;
    BGD=NO;BGDL=NO;BUD=NO;BUDL=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // 無効なアイテムがないかチェック
    if ([response.invalidProductIdentifiers count] > 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", nil)
                                                                                 message:NSLocalizedString(@"Incorrect Item ID", nil) preferredStyle:UIAlertControllerStyleAlert];
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];

        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    // 購入処理開始(「iTunes Storeにサインイン」ポップアップが表示)
    for (SKProduct *product in response.products) {
        //SKPayment *payment = [SKPayment paymentWithProduct:product];
        //[[SKPaymentQueue defaultQueue] addPayment:payment];
        if([product.productIdentifier isEqualToString:@"Guitar.Diagrm.application.productid"]){
            myProduct1 = product;//NSLog(@"myProduct1");
        }
        if([product.productIdentifier isEqualToString:@"Guitar.Diagram.Lite.application.productid"]){
            myProduct2 = product;//NSLog(@"myProduct2");
        }
        if([product.productIdentifier isEqualToString:@"Ukurere.Diagram.application.productid"]){
            myProduct3 = product;//NSLog(@"myProduct3");
        }
        if([product.productIdentifier isEqualToString:@"Ukurere.Diagram.Lite.application.productid"]){
            myProduct4 = product;//NSLog(@"myProduct4");
        }
        //リストアで全てのリストア完了が呼ばれるために必要
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        //myProduct=product;
    }
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
}

-(IBAction)Buy:(id)sender{
    if (![SKPaymentQueue canMakePayments]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", nil)
                                                                                 message:NSLocalizedString(@"In-App Purchasing disabled", nil)//@"アプリ内課金が制限されています。"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];

        }
    else{
        if (BGD) {
            //TransactionObserverが削除されてから購入する場合に必要
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            SKPayment *payment = [SKPayment paymentWithProduct:myProduct1];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
        else if (BGDL) {
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            SKPayment *payment = [SKPayment paymentWithProduct:myProduct2];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
        else if (BUD) {
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            SKPayment *payment = [SKPayment paymentWithProduct:myProduct3];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
        else if (BUDL) {
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            SKPayment *payment = [SKPayment paymentWithProduct:myProduct4];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", nil)
                                                                                     message:NSLocalizedString(@"Please select an item", nil)//@"アイテムを選択してください。"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    //Buy.enabled=NO;
}

-(IBAction)Restore:(id)sender{
    if (![SKPaymentQueue canMakePayments]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", nil)
                                                                                 message:NSLocalizedString(@"In-App Purchasing disabled", nil)
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        //return NO;
    }
    else{
        //NSLog(@"%@", NSStringFromSelector(_cmd));
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];//TransactionObserverが削除されてからリストアする場合に必要
        [[SKPaymentQueue defaultQueue]restoreCompletedTransactions];
        view.alpha=0.5;
    }
    Restore.enabled=NO;
}

-(void)purchased:(NSNotification*)notification{
    Buy.enabled=NO;
    Restore.enabled=NO;
}
// トランザクション処理
#pragma mark SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        /*int cnt=[transactions count];
         NSLog(@"%d",cnt);*/
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                //NSLog(@"購入処理中");
                view.alpha=0.5;
                break;
            case SKPaymentTransactionStatePurchased:{
                view.alpha=0;
                //NSLog(@"購入成功");
                [queue finishTransaction:transaction];
                Restore.enabled=NO;
                if(BGD){
                    //NSLog(@"購入成功GuitarDiagram");
                    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
                    [UserDefaults setBool:YES forKey:@"GuitarDiagram"];
                    [UserDefaults setBool:YES forKey:@"GuitarDiagramLite"];
                    [UserDefaults synchronize];
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                        //購入処理が成功したことを通知する
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"GDP"object:transaction];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"GDLP"object:transaction];
                    }
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"transactions" action:@"Purchased" label:@"GuitarDiagram" value:nil]build]];
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createTransactionWithId:@"UA-57821300-1"
                                                                                                  affiliation:@"App-Store"
                                                                                                      revenue:@3.0
                                                                                                          tax:@0
                                                                                                     shipping:@0
                                                                                                 currencyCode:@"USD"]build]];
                    
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createItemWithTransactionId:@"UA-57821300-1"
                                                                                                             name:@"GuitarDiagram"
                                                                                                              sku:@"UA-57821300-1"
                                                                                                         category:@"music"
                                                                                                            price:@3.0
                                                                                                         quantity:@1
                                                                                                     currencyCode:@"USD"]build]];
                }
                else if (BGDL) {
                    //NSLog(@"購入成功GuitarDiagramLite");
                    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
                    [UserDefaults setBool:YES forKey:@"GuitarDiagramLite"];
                    [UserDefaults synchronize];
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"GDLP"object:transaction];
                    }
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"transactions" action:@"Purchased" label:@"GuitarDiagramLite" value:nil]build]];
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createTransactionWithId:@"UA-57821300-1"
                                                                                                  affiliation:@"App-Store"
                                                                                                      revenue:@1.0
                                                                                                          tax:@0
                                                                                                     shipping:@0
                                                                                                 currencyCode:@"USD"]build]];
                    
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createItemWithTransactionId:@"UA-57821300-1"
                                                                                                             name:@"GuitarDiagramLite"
                                                                                                              sku:@"UA-57821300-1"
                                                                                                         category:@"music"
                                                                                                            price:@1.0
                                                                                                         quantity:@1
                                                                                                     currencyCode:@"USD"]build]];
                }
                else if (BUD) {
                    //NSLog(@"購入成功UkurereDiagram");
                    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
                    [UserDefaults setBool:YES forKey:@"UkurereDiagram"];
                    [UserDefaults setBool:YES forKey:@"UkurereDiagramLite"];
                    [UserDefaults synchronize];
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"UDP"object:transaction];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"UDLP"object:transaction];
                    }
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"transactions" action:@"Purchased" label:@"UkurereDiagram" value:nil]build]];
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createTransactionWithId:@"UA-57821300-1"
                                                                                                  affiliation:@"App-Store"
                                                                                                      revenue:@3.0
                                                                                                          tax:@0
                                                                                                     shipping:@0
                                                                                                 currencyCode:@"USD"]build]];
                    
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createItemWithTransactionId:@"UA-57821300-1"
                                                                                                             name:@"UkurereDiagram"
                                                                                                              sku:@"UA-57821300-1"
                                                                                                         category:@"music"
                                                                                                            price:@3.0
                                                                                                         quantity:@1
                                                                                                     currencyCode:@"USD"]build]];
                }
                else if (BUDL) {
                    //NSLog(@"購入成功UkurereDiagramLite");
                    NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
                    [UserDefaults setBool:YES forKey:@"UkurereDiagramLite"];
                    [UserDefaults synchronize];
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"UDLP"object:transaction];
                    }
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"transactions" action:@"Purchased" label:@"UkurereDiagramLite" value:nil]build]];
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createTransactionWithId:@"UA-57821300-1"
                                                                                                  affiliation:@"App-Store"
                                                                                                      revenue:@1.0
                                                                                                          tax:@0
                                                                                                     shipping:@0
                                                                                                 currencyCode:@"USD"]build]];
                    
                    [[[GAI sharedInstance]defaultTracker] send:[[GAIDictionaryBuilder createItemWithTransactionId:@"UA-57821300-1"
                                                                                                             name:@"UkurereDiagramLite"
                                                                                                              sku:@"UA-57821300-1"
                                                                                                         category:@"music"
                                                                                                            price:@1.0
                                                                                                         quantity:@1
                                                                                                     currencyCode:@"USD"]build]];
                }
                break;
            }
            case SKPaymentTransactionStateFailed:{
                view.alpha=0;
                //NSLog(@"購入失敗: %@, %@", transaction.transactionIdentifier, transaction.error);
                [queue finishTransaction:transaction];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", nil)
                                                                                         message:NSLocalizedString(@"Purchase operation failed", nil)//@"購入処理を失敗しました。"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                Buy.enabled=YES;
                [TrackingManager sendEventTracking:@"transactions" action:@"Purchase operation failed"label:@"transactions" value:nil screen:screenName];
                break;
            }
            case SKPaymentTransactionStateRestored:{
                NSString *strID = transaction.originalTransaction.payment.productIdentifier;
                //リストア処理
                 //NSLog(@"以前に購入した機能を復元");
                //for (SKPaymentTransaction *Restoretransaction in transactions) {
                [queue finishTransaction:transaction];
                //NSLog(@"%@",strID);
                NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
                if([strID isEqualToString:@"Guitar.Diagrm.application.productid"]){
                    [UserDefaults setBool:YES forKey:@"GuitarDiagram"];
                    [UserDefaults setBool:YES forKey:@"GuitarDiagramLite"];
                }
                if([strID isEqualToString:@"Guitar.Diagram.Lite.application.productid"]){
                    [UserDefaults setBool:YES forKey:@"GuitarDiagramLite"];
                }
                if([strID isEqualToString:@"Ukurere.Diagram.application.productid"]){
                    [UserDefaults setBool:YES forKey:@"UkurereDiagram"];
                    [UserDefaults setBool:YES forKey:@"UkurereDiagramLite"];
                }
                if([strID isEqualToString:@"Ukurere.Diagram.Lite.application.productid"]){
                    [UserDefaults setBool:YES forKey:@"UkurereDiagramLite"];
                }
                [UserDefaults synchronize];
                break;
            }
            default:
                [queue finishTransaction:transaction];
                break;
        }
    }
}
// リストア処理結果
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    view.alpha=0;
    //NSLog(@"リストア失敗:%@", error);
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"RestoreFailed"object:error];
    // TODO: 失敗のアラート表示等
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", nil)
                                                                             message:NSLocalizedString(@"Restore failed", nil)//@"リストアに失敗しました。"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];

    Restore.enabled=YES;
    [TrackingManager sendEventTracking:@"transactions" action:@"Restore failed"label:@"GuitarDiagram" value:nil screen:screenName];
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    view.alpha=0;
    //NSLog(@"全てのリストア完了");
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Purchased"object:self];
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:NSLocalizedString(@"Restore complete", nil)//@"リストアを完了しました。"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    BGD=NO;BGDL=NO;BUD=NO;BUDL=NO;
    Buy.enabled=NO;
    [TrackingManager sendEventTracking:@"transactions" action:@"Restore complete"label:@"GuitarDiagram" value:nil screen:screenName];
}
//トランザクションオブザーバの削除を行います。（トランザクションが終了すると呼び出される）
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    view.alpha=0;
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    BGD=NO;BGDL=NO;BUD=NO;BUDL=NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(IBAction)GDL:(id)sender{
    [activeField resignFirstResponder];
    BUD=NO;
    BUDL=NO;
    BGD=NO;
    BGDL=YES;
    for (int i=0; i<=3; i++) {
        textField=[textFields objectAtIndex:i];
        if (textField.text!=nil) {
            [array replaceObjectAtIndex:i withObject:textField.text];
            MutableString=[NSMutableString stringWithFormat:@"%@",[array objectAtIndex:i]];
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
                textField.text=MutableString;
            }
        }
        BOOL isJapanese;
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage isEqualToString:@"ja"];
        
        if (isJapanese==YES) {
            textField.font=[UIFont fontWithName:@"Chord-Diagram" size:41];
            value1=1;
        }
        else {
            textField.font=[UIFont fontWithName:@"Chord-Diagram2" size:41];
            value1=2;
        }
    }
    BOOL isPurchasedGD=[[NSUserDefaults standardUserDefaults]boolForKey:@"GuitarDiagram"];
    BOOL isPurchasedGDL=[[NSUserDefaults standardUserDefaults]boolForKey:@"GuitarDiagramLite"];
    if(isPurchasedGD || isPurchasedGDL){
        [Buy setTitle:NSLocalizedString(@"Purchased", nil) forState:UIControlStateNormal];
        Buy.enabled=NO;
        Restore.enabled=NO;
        Price.text=nil;
        text1.text=nil;
    }
    else{
        if (status == ReachableViaWiFi) {
            // wifi接続時
            [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
            Buy.enabled=YES;
            Restore.enabled=YES;
            [numberFormatter setLocale:myProduct2.priceLocale];
            NSString *localizedPrice = [numberFormatter stringFromNumber:myProduct2.price];
            Price.text=localizedPrice;
            text1.text=myProduct2.localizedDescription;
        } else if (status == ReachableViaWWAN) {
            // 3G接続時
            [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
            Buy.enabled=YES;
            Restore.enabled=YES;
            [numberFormatter setLocale:myProduct2.priceLocale];
            NSString *localizedPrice = [numberFormatter stringFromNumber:myProduct2.price];
            Price.text=localizedPrice;
            text1.text=myProduct2.localizedDescription;
        } else if (status == NotReachable) {
            // 接続不可
        }
    }
}

-(IBAction)UDL:(id)sender{
    [activeField resignFirstResponder];
    BUD=NO;;
    BUDL=YES;
    BGD=NO;
    BGDL=NO;
    for (int i=0; i<=3; i++) {
        textField=[textFields objectAtIndex:i];
        if (textField.text!=nil) {
            [array replaceObjectAtIndex:i withObject:textField.text];
            MutableString=[NSMutableString stringWithFormat:@"%@",[array objectAtIndex:i]];
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
                textField.text=MutableString;
            }
        }
        BOOL isJapanese;
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage isEqualToString:@"ja"];
        
        if (isJapanese==YES) {
            textField.font=[UIFont fontWithName:@"Ukurere-Diagram" size:41];
            value1=3;
        }
        else {
            textField.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:41];
            value1=4;
        }
    }
    BOOL isPurchasedUD=[[NSUserDefaults standardUserDefaults]boolForKey:@"UkurereDiagram"];
    BOOL isPurchasedUDL=[[NSUserDefaults standardUserDefaults]boolForKey:@"UkurereDiagramLite"];
    if(isPurchasedUD || isPurchasedUDL){
        [Buy setTitle:NSLocalizedString(@"Purchased", nil) forState:UIControlStateNormal];
        Buy.enabled=NO;
        Restore.enabled=NO;
        Price.text=nil;
        text1.text=nil;
    }
    else{
        if (status == ReachableViaWiFi) {
            // wifi接続時
            [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
            Buy.enabled=YES;
            Restore.enabled=YES;
            [numberFormatter setLocale:myProduct4.priceLocale];
            NSString *localizedPrice = [numberFormatter stringFromNumber:myProduct4.price];
            Price.text=localizedPrice;
            text1.text=myProduct4.localizedDescription;
        } else if (status == ReachableViaWWAN) {
            // 3G接続時
            [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
            Buy.enabled=YES;
            Restore.enabled=YES;
            [numberFormatter setLocale:myProduct4.priceLocale];
            NSString *localizedPrice = [numberFormatter stringFromNumber:myProduct4.price];
            Price.text=localizedPrice;
            text1.text=myProduct4.localizedDescription;
        } else if (status == NotReachable) {
            // 接続不可
        }
    }
}

-(IBAction)GD:(id)sender{
    [activeField resignFirstResponder];
    BUD=NO;
    BUDL=NO;
    BGD=YES;
    BGDL=NO;
    for (int i=0; i<=3; i++) {
        textField=[textFields objectAtIndex:i];
        BOOL isJapanese;
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage isEqualToString:@"ja"];
        
        if (isJapanese==YES) {
            textField.font=[UIFont fontWithName:@"Chord-Diagram" size:41];
            value1=5;
        }
        else {
            textField.font=[UIFont fontWithName:@"Chord-Diagram2" size:41];
            value1=6;
        }
    }
    BOOL isPurchased=[[NSUserDefaults standardUserDefaults]boolForKey:@"GuitarDiagram"];
    if(isPurchased==YES){
        [Buy setTitle:NSLocalizedString(@"Purchased", nil) forState:UIControlStateNormal];
        Buy.enabled=NO;
        Restore.enabled=NO;
        Price.text=nil;
        text1.text=nil;
    }
    else{
        if (status == ReachableViaWiFi) {
            // wifi接続時
            [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
            Buy.enabled=YES;
            Restore.enabled=YES;
            [numberFormatter setLocale:myProduct1.priceLocale];
            NSString *localizedPrice = [numberFormatter stringFromNumber:myProduct1.price];
            Price.text=localizedPrice;
            text1.text=myProduct1.localizedDescription;
        } else if (status == ReachableViaWWAN) {
            // 3G接続時
            [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
            Buy.enabled=YES;
            Restore.enabled=YES;
            [numberFormatter setLocale:myProduct1.priceLocale];
            NSString *localizedPrice = [numberFormatter stringFromNumber:myProduct1.price];
            Price.text=localizedPrice;
            text1.text=myProduct1.localizedDescription;
        } else if (status == NotReachable) {
            // 接続不可
        }
    }
}

-(IBAction)UD:(id)sender{
    [activeField resignFirstResponder];
    BUD=YES;
    BUDL=NO;
    BGD=NO;
    BGDL=NO;
    for (int i=0; i<=3; i++) {
        textField=[textFields objectAtIndex:i];
        BOOL isJapanese;
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage isEqualToString:@"ja"];
        
        if (isJapanese==YES) {
            textField.font=[UIFont fontWithName:@"Ukurere-Diagram" size:41];
            value1=7;
        }
        else {
            textField.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:41];
            value1=8;
        }
    }
    BOOL isPurchased=[[NSUserDefaults standardUserDefaults]boolForKey:@"UkurereDiagram"];
    if(isPurchased==YES){
        [Buy setTitle:NSLocalizedString(@"Purchased", nil) forState:UIControlStateNormal];
        Buy.enabled=NO;
        Restore.enabled=NO;
        Price.text=nil;
        text1.text=nil;
    }
    else{
        if (status == ReachableViaWiFi) {
            // wifi接続時
            [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
            Buy.enabled=YES;
            Restore.enabled=YES;
            [numberFormatter setLocale:myProduct3.priceLocale];
            NSString *localizedPrice = [numberFormatter stringFromNumber:myProduct3.price];
            Price.text=localizedPrice;
            text1.text=myProduct3.localizedDescription;
        } else if (status == ReachableViaWWAN) {
            // 3G接続時
            [Buy setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
            Buy.enabled=YES;
            Restore.enabled=YES;
            [numberFormatter setLocale:myProduct3.priceLocale];
            NSString *localizedPrice = [numberFormatter stringFromNumber:myProduct3.price];
            Price.text=localizedPrice;
            text1.text=myProduct3.localizedDescription;
        } else if (status == NotReachable) {
            // 接続不可
        }
    }
}

-(IBAction)chordfont:(id)sender{
    [activeField resignFirstResponder];
    BUD=NO;
    BUDL=NO;
    BGD=NO;
    BGDL=NO;
    for (int i=0; i<=3; i++) {
        textField=[textFields objectAtIndex:i];
        if (textField.text!=nil) {
            [array replaceObjectAtIndex:i withObject:textField.text];
            MutableString=[NSMutableString stringWithFormat:@"%@",[array objectAtIndex:i]];
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
                textField.text=MutableString;
            }
        }
        textField.font=[UIFont fontWithName:@"Apple SD Gothic Neo" size:30];
    }
    Price.text=nil;
    text1.text=nil;
    value1=0;
}

-(IBAction)Orientation:(id)sender{
    switch (value1) {
        case 1:
            for (int i=0; i<=3; i++) {
                textField=[textFields objectAtIndex:i];
                textField.font=[UIFont fontWithName:@"Chord-Diagram2" size:41];
            }
            value1=2;
            break;
        case 2:
            for (int i=0; i<=3; i++) {
                textField=[textFields objectAtIndex:i];
                textField.font=[UIFont fontWithName:@"Chord-Diagram" size:41];
            }
            value1=1;
            break;
        case 3:
            for (int i=0; i<=3; i++) {
                textField=[textFields objectAtIndex:i];
                textField.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:41];
            }
            value1=4;
            break;
        case 4:
            for (int i=0; i<=3; i++) {
                textField=[textFields objectAtIndex:i];
                textField.font=[UIFont fontWithName:@"Ukurere-Diagram" size:41];
            }
            value1=3;
            break;
        case 5:
            for (int i=0; i<=3; i++) {
                textField=[textFields objectAtIndex:i];
                textField.font=[UIFont fontWithName:@"Chord-Diagram2" size:41];
            }
            value1=6;
            break;
        case 6:
            for (int i=0; i<=3; i++) {
                textField=[textFields objectAtIndex:i];
                textField.font=[UIFont fontWithName:@"Chord-Diagram" size:41];
            }
            value1=5;
            break;
        case 7:
            for (int i=0; i<=3; i++) {
                textField=[textFields objectAtIndex:i];
                textField.font=[UIFont fontWithName:@"Ukurere-Diagram2" size:41];
            }
            value1=8;
            break;
        case 8:
            for (int i=0; i<=3; i++) {
                textField=[textFields objectAtIndex:i];
                textField.font=[UIFont fontWithName:@"Ukurere-Diagram" size:41];
            }
            value1=7;
            break;
        default:
            break;
    }
}

//textfieldをタップしたときに呼ばれる。
-(BOOL)textFieldShouldBeginEditing:(UITextField *)sender {
    activeField=sender;
    [compButtons removeAllObjects];[chordButtonarray removeAllObjects];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([self respondsToSelector:@selector(inputAssistantItem)]) {
            // iOS9.
            UITextInputAssistantItem* item = [self inputAssistantItem];
            item.leadingBarButtonGroups = @[];
            item.trailingBarButtonGroups = @[];
        }
        scoreviewController2 *score2=[[scoreviewController2 alloc]init];
        if (value1>=5) {
            CGRect accessFrame=CGRectMake(0, 0, 0, 400);
            accessoryView=[[UIView alloc]initWithFrame:accessFrame];
            accessoryView.backgroundColor=[UIColor whiteColor];
            accessoryscroll2=[[UIScrollView alloc]init];
            accessoryscroll2.delegate=self;
            accessoryscroll2.translatesAutoresizingMaskIntoConstraints = NO;
            [accessoryView addSubview:accessoryscroll2];
            NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                                  attribute:NSLayoutAttributeLeft
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:accessoryView.safeAreaLayoutGuide
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
                                                                                    toItem:accessoryView.safeAreaLayoutGuide
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:0];
            [accessoryView addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
            
            for (int i=0; i<9; i++) {
                NSString *str7=[chordarray1 objectAtIndex:i];
                chordButton1=[self makeButton:CGRectZero text:str7 tag:i];
                [chordButton1 setTitle:str7 forState:UIControlStateNormal];
                [chordButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
                [chordButton1.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
                [chordButton1 addTarget:self action:@selector(Diatonic:) forControlEvents:UIControlEventTouchUpInside];
                [accessoryView addSubview:chordButton1];[chordButtonarray addObject:chordButton1];
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
                                                                                        constant:(score2.view.frame.size.width/9)*i];
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
                
                [accessoryView addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
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
                                                                                        constant:(score2.view.frame.size.width/11)*i];
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
                if (value1==5) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:50]];}
                else if(value1==6){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:50]];}
                else if(value1==7){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:50]];}
                else if(value1==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:50]];}
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
                                                                                        constant:(score2.view.frame.size.width/10)*i];
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
                if (value1==5) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:50]];}
                else if(value1==6){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:50]];}
                else if(value1==7){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:50]];}
                else if(value1==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:50]];}
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
                                                                                        constant:(score2.view.frame.size.width/10)*i];
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
                if (value1==5) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:50]];}
                else if(value1==6){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:50]];}
                else if(value1==7){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:50]];}
                else if(value1==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:50]];}
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
                                                                                        constant:(score2.view.frame.size.width/10)*i];
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
            
            sender.inputView=accessoryView;
            return YES;
        }
        else {
            CGRect accessFrame=CGRectMake(0, 0, 0, 324);
            accessoryView=[[UIView alloc]initWithFrame:accessFrame];
            accessoryView.backgroundColor=[UIColor groupTableViewBackgroundColor];
            
            UIButton *compButton1=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"C"] tag:1];
            [compButton1.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            [compButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton1 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton1];compButton1.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1
                                                                               constant:9];
            NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:accessoryView
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
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:.129
                                                                                constant:0];
            [accessoryView addConstraints:@[LeftConstraint, TopConstraint, HeightConstraint ,WidthConstraint ]];
            
            UIButton *compButton2=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"D"] tag:1];
            [compButton2.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            [compButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton2 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton2];compButton2.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                 toItem:accessoryView
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
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.129
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint2, TopConstraint2, HeightConstraint2 ,WidthConstraint2 ]];
            
            UIButton *compButton3=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"E"] tag:1];
            [compButton3.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            [compButton3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton3 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton3];compButton3.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                 toItem:accessoryView
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
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.129
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint3, TopConstraint3, HeightConstraint3 ,WidthConstraint3 ]];
            
            UIButton *compButton4=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"F"] tag:1];
            [compButton4.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            [compButton4 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton4 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton4];compButton4.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                 toItem:accessoryView
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
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.129
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint4, TopConstraint4, HeightConstraint4 ,WidthConstraint4 ]];
            
            UIButton *compButton5=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"G"] tag:1];
            [compButton5.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            [compButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton5 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton5];compButton5.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                 toItem:accessoryView
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
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.129
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint5, TopConstraint5, HeightConstraint5 ,WidthConstraint5 ]];
            
            UIButton *compButton6=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"A"] tag:1];
            [compButton6.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            [compButton6 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton6 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton6];compButton6.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                 toItem:accessoryView
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
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.129
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint6, TopConstraint6, HeightConstraint6 ,WidthConstraint6 ]];
            
            UIButton *compButton7=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"B"] tag:1];
            [compButton7.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            [compButton7 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton7 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton7];compButton7.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                 toItem:accessoryView
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
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:-9];
            [accessoryView addConstraints:@[LeftConstraint7, TopConstraint7, HeightConstraint7 ,WidthConstraint7 ]];
            
            UIButton *compButton8=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#"] tag:1];
            [compButton8.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:35]];
            compButton8.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];
            [compButton8 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton8 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton8];compButton8.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:9];
            NSLayoutConstraint *TopConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
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
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.111
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint8, TopConstraint8, HeightConstraint8 ,WidthConstraint8 ]];
            
            UIButton *compButton9=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭"] tag:1];
            [compButton9.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:35]];
            compButton9.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];
            [compButton9 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton9 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton9];compButton9.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                 toItem:accessoryView
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
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.111
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint9, TopConstraint9, HeightConstraint9 ,WidthConstraint9 ]];
            
            UIButton *compButton10=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"maj7"] tag:1];
            [compButton10.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton10.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton10 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton10 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton10];compButton10.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint10, TopConstraint10, HeightConstraint10 ,WidthConstraint10 ]];
            
            UIButton *compButton11=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m"] tag:1];
            [compButton11.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton11.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton11 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton11 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton11];compButton11.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint11, TopConstraint11, HeightConstraint11 ,WidthConstraint11 ]];
            
            UIButton *compButton12=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m7"] tag:1];
            [compButton12.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton12.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton12 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton12 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton12];compButton12.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint12, TopConstraint12, HeightConstraint12 ,WidthConstraint12 ]];
            
            UIButton *compButton13=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"7"] tag:1];
            [compButton13.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton13.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton13 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton13 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton13];compButton13.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.110
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint13, TopConstraint13, HeightConstraint13 ,WidthConstraint13 ]];
            
            UIButton *compButton14=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m7-5"] tag:1];
            [compButton14.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton14.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton14 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton14 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton14];compButton14.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint14, TopConstraint14, HeightConstraint14 ,WidthConstraint14 ]];
            
            UIButton *compButton35=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"mmaj7"] tag:1];
            compButton35.frame=CGRectMake(676, 77, 85, 52);
            [compButton35.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton35.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton35 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton35 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton35];compButton35.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:-9];
            [accessoryView addConstraints:@[LeftConstraint35, TopConstraint35, HeightConstraint35 ,WidthConstraint35 ]];
            
            UIButton *compButton15=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"6"] tag:1];
            [compButton15.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton15.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton15 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton15 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton15];compButton15.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1
                                                                                 constant:9];
            NSLayoutConstraint *TopConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint15, TopConstraint15, HeightConstraint15 ,WidthConstraint15 ]];
            
            UIButton *compButton16=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m6"] tag:1];
            [compButton16.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton16.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton16 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton16 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton16];compButton16.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint16, TopConstraint16, HeightConstraint16 ,WidthConstraint16 ]];
            
            UIButton *compButton17=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"dim"] tag:1];
            [compButton17.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton17.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton17 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton17 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton17];compButton17.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint17, TopConstraint17, HeightConstraint17 ,WidthConstraint17 ]];
            
            UIButton *compButton18=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"aug"] tag:1];
            [compButton18.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton18.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton18 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton18 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton18];compButton18.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint18, TopConstraint18, HeightConstraint18 ,WidthConstraint18 ]];
            
            UIButton *compButton19=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"add9"] tag:1];
            [compButton19.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton19.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton19 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton19 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton19];compButton19.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint19, TopConstraint19, HeightConstraint19 ,WidthConstraint19 ]];
            
            UIButton *compButton20=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"sus4"] tag:1];
            [compButton20.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton20.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton20 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton20 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton20];compButton20.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint20, TopConstraint20, HeightConstraint20 ,WidthConstraint20 ]];
            
            UIButton *compButton21=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"("] tag:1];
            [compButton21.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            compButton21.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton21 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton21 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton21];compButton21.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint21, TopConstraint21, HeightConstraint21 ,WidthConstraint21 ]];
            
            UIButton *compButton36=[self makeButton:CGRectZero text:[NSString stringWithFormat:@")"] tag:1];
            [compButton36.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            compButton36.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton36 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton36 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton36];compButton36.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:-9];
            [accessoryView addConstraints:@[LeftConstraint36, TopConstraint36, HeightConstraint36 ,WidthConstraint36 ]];
            
            UIButton *compButton22=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"9"] tag:1];
            [compButton22.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton22.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton22 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton22 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton22];compButton22.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1
                                                                                 constant:9];
            NSLayoutConstraint *TopConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint22, TopConstraint22, HeightConstraint22 ,WidthConstraint22 ]];
            
            UIButton *compButton23=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#9"] tag:1];
            compButton23.frame=CGRectMake(105, 195, 85, 52);
            [compButton23.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton23.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton23 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton23 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton23];compButton23.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint23, TopConstraint23, HeightConstraint23 ,WidthConstraint23 ]];
            
            UIButton *compButton24=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭9"] tag:1];
            [compButton24.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton24.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton24 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton24 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton24];compButton24.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint24, TopConstraint24, HeightConstraint24 ,WidthConstraint24 ]];
            
            UIButton *compButton25=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"11"] tag:1];
            [compButton25.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton25.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton25 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton25 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton25];compButton25.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint25, TopConstraint25, HeightConstraint25 ,WidthConstraint25 ]];
            
            UIButton *compButton26=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#11"] tag:1];
            [compButton26.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton26.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton26 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton26 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton26];compButton26.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint26, TopConstraint26, HeightConstraint26 ,WidthConstraint26 ]];
            
            UIButton *compButton27=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"13"] tag:1];
            [compButton27.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton27.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton27 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton27 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton27];compButton27.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint27, TopConstraint27, HeightConstraint27 ,WidthConstraint27 ]];
            
            UIButton *compButton28=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭13"] tag:1];
            [compButton28.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton28.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton28 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton28 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton28];compButton28.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.111
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint28, TopConstraint28, HeightConstraint28 ,WidthConstraint28 ]];
            
            UIButton *compButton29=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"←"] tag:1];
            [compButton29.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            compButton29.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
            [compButton29 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton29 addTarget:self action:@selector(back2:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton29];compButton29.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1
                                                                                 constant:9];
            NSLayoutConstraint *TopConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.09
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint29, TopConstraint29, HeightConstraint29 ,WidthConstraint29 ]];
            
            UIButton *compButton30=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"→"] tag:1];
            [compButton30.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            compButton30.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
            [compButton30 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton30 addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton30];compButton30.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.09
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint30, TopConstraint30, HeightConstraint30 ,WidthConstraint30 ]];
            
            UIButton *compButton37=[self makeButton:CGRectZero text:[NSString stringWithFormat:@","] tag:1];
            [compButton37.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            compButton37.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton37 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton37 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton37];compButton37.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.09
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint37, TopConstraint37, HeightConstraint37 ,WidthConstraint37 ]];
            
            UIButton *compButton38=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"/"] tag:1];
            [compButton38.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            compButton38.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton38 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton38 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton38];compButton38.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.09
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint38, TopConstraint38, HeightConstraint38 ,WidthConstraint38 ]];
            
            UIButton *compButton34=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"on"] tag:1];
            [compButton34.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton34.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton34 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton34 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton34];compButton34.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.09
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint34, TopConstraint34, HeightConstraint34 ,WidthConstraint34 ]];
            
            UIButton *compButton31=[self makeButton:CGRectZero text:NSLocalizedString(@"Space", nil) tag:1];
            [compButton31.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton31.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
            [compButton31 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton31 addTarget:self action:@selector(space:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton31];compButton31.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.164
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint31, TopConstraint31, HeightConstraint31 ,WidthConstraint31 ]];
            
            UIButton *compButton32=[self makeButton:CGRectZero text:NSLocalizedString(@"Done", nil) tag:1];
            [compButton32.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:30]];
            compButton32.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
            [compButton32 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton32 addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton32];compButton32.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.164
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint32, TopConstraint32, HeightConstraint32 ,WidthConstraint32 ]];
            
            UIButton *compButton33=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"×"] tag:1];
            [compButton33.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:35]];
            compButton33.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
            [compButton33 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton33 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton33];compButton33.translatesAutoresizingMaskIntoConstraints = NO;
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
                                                                                  toItem:accessoryView
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
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:-9];
            [accessoryView addConstraints:@[LeftConstraint33, TopConstraint33, HeightConstraint33 ,WidthConstraint33 ]];
            
            sender.inputView=accessoryView;
            return YES;
        }
    }
    else{
        //self.navigationController.navigationBarHidden=YES;
        scoreviewController2 *score2=[[scoreviewController2 alloc]init];
        if (value1>=5) {
            CGRect accessFrame=CGRectMake(0, 0, 0, 235);
            accessoryView=[[UIView alloc]initWithFrame:accessFrame];
            accessoryView.backgroundColor=[UIColor whiteColor];
            accessoryscroll2=[[UIScrollView alloc]init];
            accessoryscroll2.delegate=self;
            accessoryscroll2.translatesAutoresizingMaskIntoConstraints = NO;
            [accessoryView addSubview:accessoryscroll2];
            NSLayoutConstraint *blueLeftConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                                  attribute:NSLayoutAttributeLeft
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:accessoryView.safeAreaLayoutGuide
                                                                                  attribute:NSLayoutAttributeLeft
                                                                                 multiplier:1
                                                                                   constant:0];
            NSLayoutConstraint *blueRightConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                                   attribute:NSLayoutAttributeTop
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:accessoryView
                                                                                   attribute:NSLayoutAttributeTop
                                                                                  multiplier:1
                                                                                    constant:60];
            NSLayoutConstraint *blueHeightConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                                    attribute:NSLayoutAttributeHeight
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:nil
                                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                                   multiplier:1
                                                                                     constant:145];
            NSLayoutConstraint *blueTopConstraint = [NSLayoutConstraint constraintWithItem:accessoryscroll2
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView.safeAreaLayoutGuide
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:0];
            [accessoryView addConstraints:@[blueLeftConstraint, blueRightConstraint, blueHeightConstraint ,blueTopConstraint ]];
            
            for (int i=0; i<9; i++) {
                NSString *str7=[chordarray1 objectAtIndex:i];
                chordButton1=[self makeButton:CGRectZero text:str7 tag:i];
                [chordButton1 setTitle:str7 forState:UIControlStateNormal];
                [chordButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
                [chordButton1 addTarget:self action:@selector(Diatonic:) forControlEvents:UIControlEventTouchUpInside];
                [accessoryView addSubview:chordButton1];[chordButtonarray addObject:chordButton1];
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
                                                                                        constant:(score2.view.frame.size.width/9)*i];
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
                                                                                          constant:29.5];
                
                [accessoryView addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
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
                                                                                        constant:(score2.view.frame.size.width/11)*i];
                NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:compButton2
                                                                                      attribute:NSLayoutAttributeTop
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:accessoryView
                                                                                      attribute:NSLayoutAttributeTop
                                                                                     multiplier:1
                                                                                       constant:31];
                NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton2
                                                                                         attribute:NSLayoutAttributeHeight
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:nil
                                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                                        multiplier:1
                                                                                          constant:28];
                [accessoryView addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint ,firstWidthConstraint ]];
            }
            for (int i=0; i<52; i++) {
                compButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                [compButtons addObject:compButton];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i];
                [compButton setTitle:str7 forState:UIControlStateNormal];
                [compButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if (value1==5) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:30]];}
                else if(value1==6){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:30]];}
                else if(value1==7){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:30]];}
                else if(value1==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:30]];}
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
                                                                                        constant:(score2.view.frame.size.width/10)*i];
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
                                                                                          constant:45];
                [accessoryView addConstraints:@[firstWidthConstraint ]];
                [accessoryscroll2 addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint  ]];
            }
            for (int i=0; i<52; i++) {
                compButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                [compButtons addObject:compButton];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i+52];
                [compButton setTitle:str7 forState:UIControlStateNormal];
                [compButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if (value1==5) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:30]];}
                else if(value1==6){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:30]];}
                else if(value1==7){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:30]];}
                else if(value1==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:30]];}
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
                                                                                        constant:(score2.view.frame.size.width/10)*i];
                NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                      attribute:NSLayoutAttributeTop
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:accessoryscroll2
                                                                                      attribute:NSLayoutAttributeTop
                                                                                     multiplier:1
                                                                                       constant:49];
                NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                         attribute:NSLayoutAttributeHeight
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:nil
                                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                                        multiplier:1
                                                                                          constant:45];
                [accessoryView addConstraints:@[firstWidthConstraint ]];
                [accessoryscroll2 addConstraints:@[firstLeftConstraint, firstTopConstraint, firstHeightConstraint  ]];
            }
            for (int i=0; i<52; i++) {
                compButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                [compButtons addObject:compButton];
                NSString *str7=[[chordarrays objectAtIndex:chordarraynumber] objectAtIndex:i+104];
                [compButton setTitle:str7 forState:UIControlStateNormal];
                [compButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if (value1==5) {[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram" size:30]];}
                else if(value1==6){[compButton.titleLabel setFont:[UIFont fontWithName:@"Chord-Diagram2" size:30]];}
                else if(value1==7){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram" size:30]];}
                else if(value1==8){[compButton.titleLabel setFont:[UIFont fontWithName:@"Ukurere-Diagram2" size:30]];}
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
                                                                                        constant:(score2.view.frame.size.width/10)*i];
                NSLayoutConstraint *firstTopConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                      attribute:NSLayoutAttributeTop
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:accessoryscroll2
                                                                                      attribute:NSLayoutAttributeTop
                                                                                     multiplier:1
                                                                                       constant:97];
                NSLayoutConstraint *firstHeightConstraint = [NSLayoutConstraint constraintWithItem:compButton
                                                                                         attribute:NSLayoutAttributeHeight
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:nil
                                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                                        multiplier:1
                                                                                          constant:45];
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
            [compButton29.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
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
                                                                              constant:204];
            NSLayoutConstraint *HeightConstraint = [NSLayoutConstraint constraintWithItem:compButton29
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:31];
            
            [accessoryView addConstraints:@[LeftConstraint, TopConstraint, HeightConstraint ,WidthConstraint ]];
            
            UIButton *compButton30=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"→"] tag:1];
            compButton30.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
            [compButton30.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
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
                                                                                constant:1];
            NSLayoutConstraint *TopConstraint2 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:204];
            NSLayoutConstraint *HeightConstraint2 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:31];
            
            [accessoryView addConstraints:@[LeftConstraint2, TopConstraint2, HeightConstraint2 ,WidthConstraint2 ]];
            
            UIButton *compButton31=[self makeButton:CGRectZero text:NSLocalizedString(@"Space", nil) tag:1];
            compButton31.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton31 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton31.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
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
                                                                                constant:1];
            NSLayoutConstraint *TopConstraint3 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:204];
            NSLayoutConstraint *HeightConstraint3 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:31];
            
            [accessoryView addConstraints:@[LeftConstraint3, TopConstraint3, HeightConstraint3 ,WidthConstraint3 ]];
            
            UIButton *compButton32=[self makeButton:CGRectZero text:NSLocalizedString(@"Done", nil) tag:1];
            compButton32.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton32 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton32.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
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
                                                                                constant:1];
            NSLayoutConstraint *TopConstraint4 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:204];
            NSLayoutConstraint *HeightConstraint4 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:31];
            
            [accessoryView addConstraints:@[LeftConstraint4, TopConstraint4, HeightConstraint4 ,WidthConstraint4 ]];
            
            
            UIButton *compButton33=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"×"] tag:1];
            compButton33.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
            [compButton33 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton33.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
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
                                                                                constant:1];
            NSLayoutConstraint *TopConstraint5 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:204];
            NSLayoutConstraint *HeightConstraint5 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:31];
            
            [accessoryView addConstraints:@[LeftConstraint5, TopConstraint5, HeightConstraint5 ,WidthConstraint5 ]];
            sender.inputView=accessoryView;
            return YES;
        }
        else {
            CGRect accessFrame=CGRectMake(0, 0, 0, 200);
            accessoryView=[[UIView alloc]initWithFrame:accessFrame];
            accessoryView.backgroundColor=[UIColor groupTableViewBackgroundColor];
            
            UIButton *compButton1=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"C"] tag:1];
            [compButton1.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            [compButton1 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton1 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton1];compButton1.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1
                                                                               constant:6];
            NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:accessoryView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1
                                                                              constant:5];
            NSLayoutConstraint *HeightConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1
                                                                                 constant:35];
            NSLayoutConstraint *WidthConstraint = [NSLayoutConstraint constraintWithItem:compButton1
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:.131
                                                                                constant:0];
            [accessoryView addConstraints:@[LeftConstraint, TopConstraint, HeightConstraint ,WidthConstraint ]];
            
            UIButton *compButton2=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"D"] tag:1];
            [compButton2.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            [compButton2 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton2 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton2];compButton2.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint2 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:compButton1
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:6];
            NSLayoutConstraint *TopConstraint2 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:5];
            NSLayoutConstraint *HeightConstraint2 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:35];
            NSLayoutConstraint *WidthConstraint2 = [NSLayoutConstraint constraintWithItem:compButton2
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.131
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint2, TopConstraint2, HeightConstraint2 ,WidthConstraint2 ]];
            
            UIButton *compButton3=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"E"] tag:1];
            [compButton3.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            [compButton3 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton3 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton3];compButton3.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint3 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:compButton2
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:6];
            NSLayoutConstraint *TopConstraint3 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:5];
            NSLayoutConstraint *HeightConstraint3 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:35];
            NSLayoutConstraint *WidthConstraint3 = [NSLayoutConstraint constraintWithItem:compButton3
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.131
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint3, TopConstraint3, HeightConstraint3 ,WidthConstraint3 ]];
            
            UIButton *compButton4=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"F"] tag:1];
            [compButton4.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            [compButton4 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton4 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton4];compButton4.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint4 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:compButton3
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:6];
            NSLayoutConstraint *TopConstraint4 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:5];
            NSLayoutConstraint *HeightConstraint4 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:35];
            NSLayoutConstraint *WidthConstraint4 = [NSLayoutConstraint constraintWithItem:compButton4
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.131
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint4, TopConstraint4, HeightConstraint4 ,WidthConstraint4 ]];
            
            UIButton *compButton5=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"G"] tag:1];
            [compButton5.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            [compButton5 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton5 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton5];compButton5.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint5 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:compButton4
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:6];
            NSLayoutConstraint *TopConstraint5 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:5];
            NSLayoutConstraint *HeightConstraint5 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:35];
            NSLayoutConstraint *WidthConstraint5 = [NSLayoutConstraint constraintWithItem:compButton5
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.131
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint5, TopConstraint5, HeightConstraint5 ,WidthConstraint5 ]];
            
            UIButton *compButton6=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"A"] tag:1];
            [compButton6.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            [compButton6 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton6 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton6];compButton6.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint6 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:compButton5
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:6];
            NSLayoutConstraint *TopConstraint6 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:5];
            NSLayoutConstraint *HeightConstraint6 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:35];
            NSLayoutConstraint *WidthConstraint6 = [NSLayoutConstraint constraintWithItem:compButton6
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.131
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint6, TopConstraint6, HeightConstraint6 ,WidthConstraint6 ]];
            
            UIButton *compButton7=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"B"] tag:1];
            [compButton7.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            [compButton7 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton7 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton7];compButton7.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint7 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:compButton6
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:6];
            NSLayoutConstraint *TopConstraint7 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:5];
            NSLayoutConstraint *HeightConstraint7 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:35];
            NSLayoutConstraint *WidthConstraint7 = [NSLayoutConstraint constraintWithItem:compButton7
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:-6];
            [accessoryView addConstraints:@[LeftConstraint7, TopConstraint7, HeightConstraint7 ,WidthConstraint7 ]];
            
            UIButton *compButton8=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#"] tag:1];
            compButton8.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];
            [compButton8 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton8 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton8];compButton8.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1
                                                                                constant:6];
            NSLayoutConstraint *TopConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:45];
            NSLayoutConstraint *HeightConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:35];
            NSLayoutConstraint *WidthConstraint8 = [NSLayoutConstraint constraintWithItem:compButton8
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.113
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint8, TopConstraint8, HeightConstraint8 ,WidthConstraint8 ]];
            
            UIButton *compButton9=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭"] tag:1];
            compButton9.backgroundColor=[UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1];
            [compButton9 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton9 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton9];compButton9.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint9 = [NSLayoutConstraint constraintWithItem:compButton9
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:compButton8
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1
                                                                                constant:6];
            NSLayoutConstraint *TopConstraint9 = [NSLayoutConstraint constraintWithItem:compButton9
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:accessoryView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:45];
            NSLayoutConstraint *HeightConstraint9 = [NSLayoutConstraint constraintWithItem:compButton9
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1
                                                                                  constant:35];
            NSLayoutConstraint *WidthConstraint9 = [NSLayoutConstraint constraintWithItem:compButton9
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:.113
                                                                                 constant:0];
            [accessoryView addConstraints:@[LeftConstraint9, TopConstraint9, HeightConstraint9 ,WidthConstraint9 ]];
            
            UIButton *compButton10=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"maj7"] tag:1];
            compButton10.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton10 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton10 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton10];compButton10.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint10 = [NSLayoutConstraint constraintWithItem:compButton10
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton9
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint10 = [NSLayoutConstraint constraintWithItem:compButton10
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:45];
            NSLayoutConstraint *HeightConstraint10 = [NSLayoutConstraint constraintWithItem:compButton10
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint10 = [NSLayoutConstraint constraintWithItem:compButton10
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint10, TopConstraint10, HeightConstraint10 ,WidthConstraint10 ]];
            
            UIButton *compButton11=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m"] tag:1];
            compButton11.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton11 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton11 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton11];compButton11.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint11 = [NSLayoutConstraint constraintWithItem:compButton11
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton10
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint11 = [NSLayoutConstraint constraintWithItem:compButton11
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:45];
            NSLayoutConstraint *HeightConstraint11 = [NSLayoutConstraint constraintWithItem:compButton11
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint11 = [NSLayoutConstraint constraintWithItem:compButton11
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint11, TopConstraint11, HeightConstraint11 ,WidthConstraint11 ]];
            
            UIButton *compButton12=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m7"] tag:1];
            compButton12.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton12 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton12 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton12];compButton12.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint12 = [NSLayoutConstraint constraintWithItem:compButton12
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton11
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint12 = [NSLayoutConstraint constraintWithItem:compButton12
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:45];
            NSLayoutConstraint *HeightConstraint12 = [NSLayoutConstraint constraintWithItem:compButton12
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint12 = [NSLayoutConstraint constraintWithItem:compButton12
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint12, TopConstraint12, HeightConstraint12 ,WidthConstraint12 ]];
            
            UIButton *compButton13=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"7"] tag:1];
            compButton13.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton13 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton13 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton13];compButton13.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint13 = [NSLayoutConstraint constraintWithItem:compButton13
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton12
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint13 = [NSLayoutConstraint constraintWithItem:compButton13
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:45];
            NSLayoutConstraint *HeightConstraint13 = [NSLayoutConstraint constraintWithItem:compButton13
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint13 = [NSLayoutConstraint constraintWithItem:compButton13
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint13, TopConstraint13, HeightConstraint13 ,WidthConstraint13 ]];
            
            UIButton *compButton14=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m7-5"] tag:1];
            compButton14.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton14 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton14 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton14];compButton14.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint14 = [NSLayoutConstraint constraintWithItem:compButton14
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton13
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint14 = [NSLayoutConstraint constraintWithItem:compButton14
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:45];
            NSLayoutConstraint *HeightConstraint14 = [NSLayoutConstraint constraintWithItem:compButton14
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint14 = [NSLayoutConstraint constraintWithItem:compButton14
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint14, TopConstraint14, HeightConstraint14 ,WidthConstraint14 ]];
            
            UIButton *compButton35=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"mmaj7"] tag:1];
            [compButton35.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:19]];
            compButton35.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton35 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton35 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton35];compButton35.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint35 = [NSLayoutConstraint constraintWithItem:compButton35
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton14
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint35 = [NSLayoutConstraint constraintWithItem:compButton35
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:45];
            NSLayoutConstraint *HeightConstraint35 = [NSLayoutConstraint constraintWithItem:compButton35
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint35 = [NSLayoutConstraint constraintWithItem:compButton35
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:-6];
            [accessoryView addConstraints:@[LeftConstraint35, TopConstraint35, HeightConstraint35 ,WidthConstraint35 ]];
            
            UIButton *compButton15=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"6"] tag:1];
            compButton15.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton15 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton15 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton15];compButton15.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:85];
            NSLayoutConstraint *HeightConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint15 = [NSLayoutConstraint constraintWithItem:compButton15
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint15, TopConstraint15, HeightConstraint15 ,WidthConstraint15 ]];
            
            UIButton *compButton16=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"m6"] tag:1];
            compButton16.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton16 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton16 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton16];compButton16.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint16 = [NSLayoutConstraint constraintWithItem:compButton16
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton15
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint16 = [NSLayoutConstraint constraintWithItem:compButton16
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:85];
            NSLayoutConstraint *HeightConstraint16 = [NSLayoutConstraint constraintWithItem:compButton16
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint16 = [NSLayoutConstraint constraintWithItem:compButton16
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint16, TopConstraint16, HeightConstraint16 ,WidthConstraint16 ]];
            
            UIButton *compButton17=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"dim"] tag:1];
            compButton17.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton17 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton17 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton17];compButton17.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint17 = [NSLayoutConstraint constraintWithItem:compButton17
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton16
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint17 = [NSLayoutConstraint constraintWithItem:compButton17
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:85];
            NSLayoutConstraint *HeightConstraint17 = [NSLayoutConstraint constraintWithItem:compButton17
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint17 = [NSLayoutConstraint constraintWithItem:compButton17
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint17, TopConstraint17, HeightConstraint17 ,WidthConstraint17 ]];
            
            UIButton *compButton18=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"aug"] tag:1];
            compButton18.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton18 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton18 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton18];compButton18.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint18 = [NSLayoutConstraint constraintWithItem:compButton18
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton17
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint18 = [NSLayoutConstraint constraintWithItem:compButton18
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:85];
            NSLayoutConstraint *HeightConstraint18 = [NSLayoutConstraint constraintWithItem:compButton18
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint18 = [NSLayoutConstraint constraintWithItem:compButton18
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint18, TopConstraint18, HeightConstraint18 ,WidthConstraint18 ]];
            
            UIButton *compButton19=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"add9"] tag:1];
            compButton19.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton19 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton19 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton19];compButton19.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint19 = [NSLayoutConstraint constraintWithItem:compButton19
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton18
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint19 = [NSLayoutConstraint constraintWithItem:compButton19
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:85];
            NSLayoutConstraint *HeightConstraint19 = [NSLayoutConstraint constraintWithItem:compButton19
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint19 = [NSLayoutConstraint constraintWithItem:compButton19
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint19, TopConstraint19, HeightConstraint19 ,WidthConstraint19 ]];
            
            UIButton *compButton20=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"sus4"] tag:1];
            compButton20.backgroundColor=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:83/255.0 alpha:1];
            [compButton20 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton20 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton20];compButton20.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint20 = [NSLayoutConstraint constraintWithItem:compButton20
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton19
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint20 = [NSLayoutConstraint constraintWithItem:compButton20
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:85];
            NSLayoutConstraint *HeightConstraint20 = [NSLayoutConstraint constraintWithItem:compButton20
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint20 = [NSLayoutConstraint constraintWithItem:compButton20
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint20, TopConstraint20, HeightConstraint20 ,WidthConstraint20 ]];
            
            UIButton *compButton21=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"("] tag:1];
            [compButton21.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            compButton21.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton21 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton21 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton21];compButton21.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint21 = [NSLayoutConstraint constraintWithItem:compButton21
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton20
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint21 = [NSLayoutConstraint constraintWithItem:compButton21
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:85];
            NSLayoutConstraint *HeightConstraint21 = [NSLayoutConstraint constraintWithItem:compButton21
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint21 = [NSLayoutConstraint constraintWithItem:compButton21
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint21, TopConstraint21, HeightConstraint21 ,WidthConstraint21 ]];
            
            UIButton *compButton36=[self makeButton:CGRectZero text:[NSString stringWithFormat:@")"] tag:1];
            [compButton36.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            compButton36.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton36 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton36 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton36];compButton36.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint36 = [NSLayoutConstraint constraintWithItem:compButton36
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton21
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint36 = [NSLayoutConstraint constraintWithItem:compButton36
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:85];
            NSLayoutConstraint *HeightConstraint36 = [NSLayoutConstraint constraintWithItem:compButton36
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint36 = [NSLayoutConstraint constraintWithItem:compButton36
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:-6];
            [accessoryView addConstraints:@[LeftConstraint36, TopConstraint36, HeightConstraint36 ,WidthConstraint36 ]];
            
            UIButton *compButton22=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"9"] tag:1];
            compButton22.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton22 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton22 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton22];compButton22.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:125];
            NSLayoutConstraint *HeightConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint22 = [NSLayoutConstraint constraintWithItem:compButton22
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint22, TopConstraint22, HeightConstraint22 ,WidthConstraint22 ]];
            
            UIButton *compButton23=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#9"] tag:1];
            compButton23.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton23 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton23 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton23];compButton23.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint23 = [NSLayoutConstraint constraintWithItem:compButton23
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton22
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint23 = [NSLayoutConstraint constraintWithItem:compButton23
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:125];
            NSLayoutConstraint *HeightConstraint23 = [NSLayoutConstraint constraintWithItem:compButton23
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint23 = [NSLayoutConstraint constraintWithItem:compButton23
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint23, TopConstraint23, HeightConstraint23 ,WidthConstraint23 ]];
            
            UIButton *compButton24=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭9"] tag:1];
            compButton24.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton24 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton24 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton24];compButton24.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint24 = [NSLayoutConstraint constraintWithItem:compButton24
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton23
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint24 = [NSLayoutConstraint constraintWithItem:compButton24
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:125];
            NSLayoutConstraint *HeightConstraint24 = [NSLayoutConstraint constraintWithItem:compButton24
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint24 = [NSLayoutConstraint constraintWithItem:compButton24
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint24, TopConstraint24, HeightConstraint24 ,WidthConstraint24 ]];
            
            UIButton *compButton25=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"11"] tag:1];
            compButton25.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton25 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton25 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton25];compButton25.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint25 = [NSLayoutConstraint constraintWithItem:compButton25
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton24
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint25 = [NSLayoutConstraint constraintWithItem:compButton25
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:125];
            NSLayoutConstraint *HeightConstraint25 = [NSLayoutConstraint constraintWithItem:compButton25
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint25 = [NSLayoutConstraint constraintWithItem:compButton25
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint25, TopConstraint25, HeightConstraint25 ,WidthConstraint25 ]];
            
            UIButton *compButton26=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"#11"] tag:1];
            compButton26.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton26 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton26 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton26];compButton26.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint26 = [NSLayoutConstraint constraintWithItem:compButton26
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton25
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint26 = [NSLayoutConstraint constraintWithItem:compButton26
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:125];
            NSLayoutConstraint *HeightConstraint26 = [NSLayoutConstraint constraintWithItem:compButton26
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint26 = [NSLayoutConstraint constraintWithItem:compButton26
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint26, TopConstraint26, HeightConstraint26 ,WidthConstraint26 ]];
            
            UIButton *compButton27=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"13"] tag:1];
            compButton27.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton27 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton27 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton27];compButton27.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint27 = [NSLayoutConstraint constraintWithItem:compButton27
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton26
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint27 = [NSLayoutConstraint constraintWithItem:compButton27
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:125];
            NSLayoutConstraint *HeightConstraint27 = [NSLayoutConstraint constraintWithItem:compButton27
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint27 = [NSLayoutConstraint constraintWithItem:compButton27
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint27, TopConstraint27, HeightConstraint27 ,WidthConstraint27 ]];
            
            UIButton *compButton28=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"♭13"] tag:1];
            compButton28.backgroundColor=[UIColor colorWithRed:243/255.0 green:163/255.0 blue:56/255.0 alpha:1];
            [compButton28 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton28 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton28];compButton28.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint28 = [NSLayoutConstraint constraintWithItem:compButton28
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton27
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint28 = [NSLayoutConstraint constraintWithItem:compButton28
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:125];
            NSLayoutConstraint *HeightConstraint28 = [NSLayoutConstraint constraintWithItem:compButton28
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint28 = [NSLayoutConstraint constraintWithItem:compButton28
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint28, TopConstraint28, HeightConstraint28 ,WidthConstraint28 ]];
            
            UIButton *compButton29=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"←"] tag:1];
            [compButton29.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            compButton29.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
            [compButton29 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton29 addTarget:self action:@selector(back2:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton29];compButton29.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:accessoryView
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:165];
            NSLayoutConstraint *HeightConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint29 = [NSLayoutConstraint constraintWithItem:compButton29
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint29, TopConstraint29, HeightConstraint29 ,WidthConstraint29 ]];
            
            UIButton *compButton30=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"→"] tag:1];
            [compButton30.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            compButton30.backgroundColor=[UIColor colorWithRed:255/255.0 green:60/255.0 blue:83/255.0 alpha:1];
            [compButton30 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton30 addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton30];compButton30.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint30 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton29
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint30 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:165];
            NSLayoutConstraint *HeightConstraint30 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint30 = [NSLayoutConstraint constraintWithItem:compButton30
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint30, TopConstraint30, HeightConstraint30 ,WidthConstraint30 ]];
            
            UIButton *compButton37=[self makeButton:CGRectZero text:[NSString stringWithFormat:@","] tag:1];
            compButton37.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton37 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton37 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton37];compButton37.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint37 = [NSLayoutConstraint constraintWithItem:compButton37
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton28
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint37 = [NSLayoutConstraint constraintWithItem:compButton37
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:125];
            NSLayoutConstraint *HeightConstraint37 = [NSLayoutConstraint constraintWithItem:compButton37
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint37 = [NSLayoutConstraint constraintWithItem:compButton37
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:-6];
            [accessoryView addConstraints:@[LeftConstraint37, TopConstraint37, HeightConstraint37 ,WidthConstraint37 ]];
            
            UIButton *compButton38=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"/"] tag:1];
            [compButton38.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            compButton38.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton38 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton38 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton38];compButton38.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint38 = [NSLayoutConstraint constraintWithItem:compButton38
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton30
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint38 = [NSLayoutConstraint constraintWithItem:compButton38
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:165];
            NSLayoutConstraint *HeightConstraint38 = [NSLayoutConstraint constraintWithItem:compButton38
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint38 = [NSLayoutConstraint constraintWithItem:compButton38
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint38, TopConstraint38, HeightConstraint38 ,WidthConstraint38 ]];
            
            UIButton *compButton34=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"on"] tag:1];
            compButton34.backgroundColor=[UIColor colorWithRed:0/255.0 green:128/255.0 blue:126/255.0 alpha:1];
            [compButton34 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton34 addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton34];compButton34.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint34 = [NSLayoutConstraint constraintWithItem:compButton34
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton38
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint34 = [NSLayoutConstraint constraintWithItem:compButton34
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:165];
            NSLayoutConstraint *HeightConstraint34 = [NSLayoutConstraint constraintWithItem:compButton34
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint34 = [NSLayoutConstraint constraintWithItem:compButton34
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.113
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint34, TopConstraint34, HeightConstraint34 ,WidthConstraint34 ]];
            
            UIButton *compButton31=[self makeButton:CGRectZero text:NSLocalizedString(@"Space", nil) tag:1];
            compButton31.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
            [compButton31 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton31 addTarget:self action:@selector(space:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton31];compButton31.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint31 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton34
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint31 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:165];
            NSLayoutConstraint *HeightConstraint31 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint31 = [NSLayoutConstraint constraintWithItem:compButton31
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.160
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint31, TopConstraint31, HeightConstraint31 ,WidthConstraint31 ]];
            
            UIButton *compButton32=[self makeButton:CGRectZero text:NSLocalizedString(@"Done", nil) tag:1];
            compButton32.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
            [compButton32 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton32 addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton32];compButton32.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint32 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton31
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint32 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:165];
            NSLayoutConstraint *HeightConstraint32 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint32 = [NSLayoutConstraint constraintWithItem:compButton32
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:.160
                                                                                  constant:0];
            [accessoryView addConstraints:@[LeftConstraint32, TopConstraint32, HeightConstraint32 ,WidthConstraint32 ]];
            
            UIButton *compButton33=[self makeButton:CGRectZero text:[NSString stringWithFormat:@"×"] tag:1];
            [compButton33.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:20]];
            compButton33.backgroundColor=[UIColor colorWithRed:68/255.0 green:83/255.0 blue:95/255.0 alpha:1];
            [compButton33 setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            [compButton33 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:compButton33];compButton33.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *LeftConstraint33 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:compButton32
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1
                                                                                 constant:6];
            NSLayoutConstraint *TopConstraint33 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:accessoryView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:165];
            NSLayoutConstraint *HeightConstraint33 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1
                                                                                   constant:35];
            NSLayoutConstraint *WidthConstraint33 = [NSLayoutConstraint constraintWithItem:compButton33
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:accessoryView
                                                                                 attribute:NSLayoutAttributeRight
                                                                                multiplier:1
                                                                                  constant:-6];
            [accessoryView addConstraints:@[LeftConstraint33, TopConstraint33, HeightConstraint33 ,WidthConstraint33 ]];
            
            sender.inputView=accessoryView;
            return YES;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)sender{
    [sender resignFirstResponder];
    return YES;
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
    //self.navigationController.navigationBarHidden=NO;
    [activeField resignFirstResponder];
}

-(void)back:(id)sender{
    NSUInteger len = [activeField.text length];
    if (activeField.text.length>0) {
        activeField.text = [activeField.text substringToIndex:len-activeField.text.length];
    }
}

-(void)next:(id)sender{
    UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag+1];
    [nextResponder becomeFirstResponder];
    if(activeField.tag==4){
        UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag+0];
        [nextResponder becomeFirstResponder];
    }
}

-(void)back2:(id)sender{
    if (activeField.tag==1) {
    }
    else {
        UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag-1];
        [nextResponder becomeFirstResponder];
    }
    if (activeField.tag<=4) {
        UIResponder* nextResponder = [activeField.superview viewWithTag:activeField.tag-0];
        [nextResponder becomeFirstResponder];
    }
}

-(void)A:(UIButton *)sender {
    [activeField replaceRange: activeField.selectedTextRange withText:sender.titleLabel.text];
}

-(void)Diatonic:(UIButton *)sender{
    BOOL C =[sender.titleLabel.text isEqualToString:@"C"];BOOL D =[sender.titleLabel.text isEqualToString:@"D"];
    BOOL E =[sender.titleLabel.text isEqualToString:@"E"];BOOL F =[sender.titleLabel.text isEqualToString:@"F"];
    BOOL G =[sender.titleLabel.text isEqualToString:@"G"];BOOL A =[sender.titleLabel.text isEqualToString:@"A"];
    BOOL B =[sender.titleLabel.text isEqualToString:@"B"]; BOOL CS =[sender.titleLabel.text isEqualToString:@"#"];
    BOOL DF =[sender.titleLabel.text isEqualToString:@"♭"];
    
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
        chordButton1=[chordButtonarray objectAtIndex:i];
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
}

-(void)M:(UIButton *)sender{
    BOOL C1 =[sender.titleLabel.text isEqualToString:@"M"];BOOL C2 =[sender.titleLabel.text isEqualToString:@"m"];
    BOOL C3 =[sender.titleLabel.text isEqualToString:@"7"];BOOL C4 =[sender.titleLabel.text isEqualToString:@"m7♭5"];
    BOOL C5 =[sender.titleLabel.text isEqualToString:@"6"];BOOL C6 =[sender.titleLabel.text isEqualToString:@"mM7"];
    BOOL C7 =[sender.titleLabel.text isEqualToString:@"dim"];BOOL C8 =[sender.titleLabel.text isEqualToString:@"aug"];
    BOOL C9 =[sender.titleLabel.text isEqualToString:@"sus4"];BOOL C10 =[sender.titleLabel.text isEqualToString:@"add9"];
    BOOL C11 =[sender.titleLabel.text isEqualToString:@"7(2)"];
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
}

-(void)torikeshi:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
