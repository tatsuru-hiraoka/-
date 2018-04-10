//
//  tableviewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "AppDelegate.h"
#import "tableviewController.h"
#import "infomationViewController.h"
#import "infomationViewController2.h"
#import "BeetViewController.h"
#import <CoreData/CoreData.h>

@interface tableviewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
//-(void)dismiss;
//-(void)makeCMPopTipView;
@end

@implementation tableviewController
@synthesize managedObjectContext;
@synthesize fetchedResultsController;
//@synthesize popOver;

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.toolbarHidden=NO;
    //self.title=NSLocalizedString(@"Appname", nil);
    //左側に編集ボタンを表示する。
    self.navigationItem.leftBarButtonItem =self.editButtonItem;
    //右側にプラスボタンを表示する。（作る）
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRow:)];
    [self.navigationItem setRightBarButtonItem:addButton animated:YES];
    //色の設定。
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:150/255.0 green:81/255.0 blue:24/255.0 alpha:1];
    [[UIBarButtonItem appearance]setTintColor:[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1]];
    self.navigationController.toolbar.tintColor=[UIColor groupTableViewBackgroundColor];
    self.tableView.allowsSelection=YES;
    self.tableView.separatorColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    
    /*if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        // ２回目以降の起動時
        //[self dismiss];
    }
    else
    {
        NSLog(@"%@", @"初回起動時");
        // 初回起動時
        Infomation=YES;
    }*/
    
    imageview.alpha=0;
    //新しくできたセルに移動する。
    [self.tableView scrollToRowAtIndexPath:newIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    screenName = NSStringFromClass([self class]);
    [TrackingManager sendScreenTracking:screenName];
    
    if (self.managedObjectContext==nil) {
        managedObjectContext=[(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];
    }//必要
    self.view.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    UIImage *image=[UIImage imageNamed:@"Load2.jpg"];
    imageview=[[UIImageView alloc]initWithImage:image];
    imageview.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+20);
    [self.view addSubview:imageview];
    
    Bluetootharray=[[NSMutableArray alloc]init];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 45, 140, 30)];
    label1.text=@"NOW LOADING..";
    label1.backgroundColor=[UIColor clearColor];
    [imageview addSubview:label1];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIButton *i1=[UIButton buttonWithType:UIButtonTypeInfoDark];
        [i1 addTarget:self action:@selector(Info:) forControlEvents:UIControlEventTouchUpInside];
        i1.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
        Info=[[UIBarButtonItem alloc]initWithCustomView:i1];
        
        BluetoothButton=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"Bluetooth"] style:UIBarButtonItemStylePlain target:self action:@selector(Bluetooth:)];
        BluetoothButton.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
        
        Send=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Send", nil)] style:UIBarButtonItemStylePlain target:self action:@selector(Send:)];
        Send.tintColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
        
        Cancel=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(torikeshi:)];
        Cancel.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
        
        Store=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Store", nil)] style:UIBarButtonItemStylePlain target:self action:@selector(Store:)];
        Store.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
        
        Spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        toolbararray1=[NSArray arrayWithObjects:BluetoothButton,Spacer,Store,Info,nil];
        self.toolbarItems=toolbararray1;
    }
    else{
        BluetoothButton=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"Bluetooth"] style:UIBarButtonItemStylePlain target:self action:@selector(Bluetooth:)];
        BluetoothButton.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
        
        Send=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Send", nil)] style:UIBarButtonItemStylePlain target:self action:@selector(Send:)];
        Send.tintColor=[UIColor colorWithRed:170/255.0 green:12/255.0 blue:10/255.0 alpha:1];
        
        Cancel=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(torikeshi:)];
        Cancel.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
        
        UIButton *i1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        i1.frame = CGRectMake(0, 0, 50, 30);//UIPopoverPresentationControllerで必要
        i1.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
        [i1 setTitle:NSLocalizedString(@"Store", nil) forState:UIControlStateNormal];
        [i1 addTarget:self action:@selector(Store:) forControlEvents:UIControlEventTouchUpInside];
        Store=[[UIBarButtonItem alloc]initWithCustomView:i1];
        Store.tintColor=[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
        
        Spacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        toolbararray1=[NSArray arrayWithObjects:BluetoothButton,Spacer,Store,nil];
        self.toolbarItems=toolbararray1;
        
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CMPopTipView:)name:@"CMPopTipView"object:nil];
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismiss:)name:@"CMPopTipView dismiss"object:nil];
    }
    myPeerID = [[MCPeerID alloc] initWithDisplayName:@"Chord Scroll"];
    
    serviceType = @"Chord-Scroll";
    
    Session = [[MCSession alloc] initWithPeer:myPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
    Session.delegate = self;
    
    // MCAdvertiserAssistant の生成
    advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:serviceType
                                                               discoveryInfo:nil
                                                                     session:Session];
    
    BrowserViewController = [[MCBrowserViewController alloc] initWithServiceType:serviceType
                                                                         session:Session];
    BrowserViewController.delegate = self;
    
    Bluetooth=NO;
    //Infomation=NO;
    dataarray1=[[NSMutableArray alloc]init];
    dataarray2=[[NSMutableArray alloc]init];
    Tempoarray=[[NSMutableArray alloc]init];
}

/*-(void)makeCMPopTipView{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    //if (self.navigationItem.rightBarButtonItem!=nil) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", nil)
                                                                             message:NSLocalizedString(@"Incorrect Item ID", nil) preferredStyle:UIAlertControllerStyleAlert];
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}*/

- (void)reloadFetchedResults:(NSNotification*)notification {
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"reloadFetchedResults");
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];//1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;//セクションの高さを設定。
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] init];
    id<NSFetchedResultsSectionInfo>sectioninfo=[[self.fetchedResultsController sections]objectAtIndex:section];
    sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,0,self.view.frame.size.width,20)];
    sectionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,20)];
    sectionLabel.backgroundColor = [UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    sectionLabel2.backgroundColor = [UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:1];
    sectionLabel.textColor = [UIColor whiteColor];
    sectionLabel.text = [sectioninfo name];
    //sectionLabel.adjustsFontSizeToFitWidth=YES;
    [sectionView addSubview:sectionLabel2];
    [sectionView addSubview:sectionLabel];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.編集モード
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            scoreviewController2 *score2=[[scoreviewController2 alloc]init];
            score2=(scoreviewController2 *)[[self.splitViewController.viewControllers lastObject]topViewController];//tableviewで下の階層を使うときはここに書かないとscore2に渡せない
            Entity *entity= [[self fetchedResultsController] objectAtIndexPath:indexPath];//選択された行の特定
            if (entity.title==score2.detailItem.title) {
                [score2.navigationItem setRightBarButtonItem:nil];
                score2.toolbarItems=nil;
            }
        }
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
//行の並び替えを可にする。
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Entity *entity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text =entity.title;
}

#pragma mark - Table view delegate
//セルが選択されたら
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (Bluetooth) {
        //セルの選択状態の解除
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        self.tableView.allowsMultipleSelection=YES;
        Entity *entity= [[self fetchedResultsController] objectAtIndexPath:indexPath];
        self.detailItem=entity;
        if (self.detailItem.data) {
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            if (self.detailItem) {
                if (self.detailItem.diagram!=nil) {
                    //diagramがないときはdataを入れてdataarray2に値が入るようにする
                    GuitarDiagramarray=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.diagram];
                }
                else {
                    GuitarDiagramarray=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.data];
                }
                dataarray1=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.data];
                
                dataarray2=[NSArray arrayWithObjects:dataarray1,GuitarDiagramarray,nil];
            }
            title=self.detailItem.title;
            if (self.detailItem.artist!=nil) {
                artist=self.detailItem.artist;
            }
            else{
                NSString *str9=[NSString stringWithFormat:@""];
                artist=str9;
            }
            if (self.detailItem.composer!=nil) {
                composer=self.detailItem.composer;
            }
            else{
                NSString *str10=[NSString stringWithFormat:@""];
                composer=str10;
            }
            if (self.detailItem.memo!=nil) {
                memo=self.detailItem.memo;
            }
            else{
                NSString *str11=[NSString stringWithFormat:@""];
                memo=str11;
            }
            if (self.detailItem.colordata!=nil) {
                colorarray2=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.colordata];
                NSNumber *num1=[colorarray2 objectAtIndex:0];colorvalue5=[num1 intValue];
                NSNumber *num2=[colorarray2 objectAtIndex:1];colorvalue6=[num2 intValue];
                NSNumber *num3=[colorarray2 objectAtIndex:2];colorvalue7=[num3 intValue];
                NSNumber *num4=[colorarray2 objectAtIndex:3];colorvalue8=[num4 intValue];
                
                number1=[NSNumber numberWithInt:colorvalue5];
                number2=[NSNumber numberWithInt:colorvalue6];
                number3=[NSNumber numberWithInt:colorvalue7];
                number4=[NSNumber numberWithInt:colorvalue8];
                colorarray=[NSMutableArray arrayWithObjects:num1,num2,num3,num4,nil];
            }
            else{
                colorvalue5=0;
                colorvalue6=0;
                colorvalue7=0;
                colorvalue8=0;
                
                number1=[NSNumber numberWithInt:colorvalue5];
                number2=[NSNumber numberWithInt:colorvalue6];
                number3=[NSNumber numberWithInt:colorvalue7];
                number4=[NSNumber numberWithInt:colorvalue8];
                colorarray=[NSMutableArray arrayWithObjects:number1,number2,number3,number4,nil];
            }
            NSNumber *number11=[colorarray objectAtIndex:1];
            int value=[number11 intValue];
            if (value>=7) {
                dataarray=[dataarray2 objectAtIndex:1];
            }
            else{
                dataarray=[dataarray2 objectAtIndex:0];
            }
            number9=self.detailItem.slider;
            number10=self.detailItem.tempo;
            if (self.detailItem.metronome!=nil) {
                Tempoarray=[NSKeyedUnarchiver unarchiveObjectWithData:self.detailItem.metronome];
            }
            else{
                for (int i=0; i<200; i++) {
                    [Tempoarray addObject:number10];
                }
            }
            [dataarray addObject:number1];
            [dataarray addObject:number2];
            [dataarray addObject:number3];
            [dataarray addObject:number4];
            [dataarray addObject:number9];
            [dataarray addObject:number10];
            [dataarray addObject:title];
            [dataarray addObject:artist];
            [dataarray addObject:composer];
            [dataarray addObject:memo];
            for (int i=0; i<200; i++) {
                [dataarray addObject:[Tempoarray objectAtIndex:i]];
            }
            [Bluetootharray addObject:dataarray];
            toolbararray1=[NSArray arrayWithObjects:BluetoothButton,Spacer,Send,Spacer,Cancel,Spacer,Store,Info,nil];
            self.toolbarItems=toolbararray1;
        }
    }
    else{
        //self.tableView.allowsSelection=YES;
        //セルの選択状態の解除
        //[self dismiss];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            scoreviewController2 *score2=[[scoreviewController2 alloc]init];
            score2=(scoreviewController2 *)[[self.splitViewController.viewControllers lastObject]topViewController];//tableviewで下の階層を使うときはここに書かないとscore2に渡せない
            Entity *entity= [[self fetchedResultsController] objectAtIndexPath:indexPath];//選択された行の特定
            score2.detailItem =entity;
            infomationViewController2 *info2=[[infomationViewController2 alloc]init];
            info2.detailItem=entity;
            [self.navigationController pushViewController:info2 animated:YES];
        }
        else{
            self.navigationController.navigationBarHidden=YES;
            self.navigationController.toolbarHidden=YES;
            tableView.allowsSelection=NO;
            [self.view bringSubviewToFront:imageview];//subviewのインデックスの一番前に移動する.
            
            CGPoint scrollPoint = CGPointMake(0,0);
            [tableView setContentOffset:scrollPoint animated:NO];//アニメーションするとセルが見えてしまう。
            imageview.alpha=1;
            [self performSelector:@selector(Delay:)withObject:nil afterDelay:0.1];
            score=[[scoreviewController3 alloc]init];
            Entity *entity= [[self fetchedResultsController] objectAtIndexPath:indexPath];
            score.detailItem =entity;
        }
    }
}
//セルの選択がはずれたときに呼ばれる
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryNone;
}

-(void)Delay:(id)sender{
    [self.navigationController pushViewController:score animated:YES];
}

//プラスボタンが押された。
-(void)addRow:(id)sender{
    //[self dismiss];
    infomationViewController2 *info=[[infomationViewController2 alloc]init];
    [self.navigationController pushViewController:info animated:YES];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"artist" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"artist" cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    if (type==NSFetchedResultsChangeInsert) {
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(type==NSFetchedResultsChangeDelete){
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    newIndexpath=newIndexPath;
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*-(void)dismiss{
    [navBarLeftButtonPopTipView6 dismissAnimated:YES];
    navBarLeftButtonPopTipView6 = nil;
    //[navBarLeftButtonPopTipView7 dismissAnimated:YES];
    //navBarLeftButtonPopTipView7 = nil;
    Infomation=NO;
}*/

-(void)Info:(id)sender{
    //[self dismiss];
    DescriptionTableViewController *Description=[[DescriptionTableViewController alloc]init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController pushViewController:Description animated:YES];
    }
}

-(void)Bluetooth:(id)sender{
    //[self dismiss];
    //[popOver dismissPopoverAnimated:YES];
    [advertiserAssistant start];
    [self presentViewController:BrowserViewController animated:YES completion:nil];
}

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler
{
    //招待を受けるかどうかと自身のセッションを返す
    invitationHandler(YES,Session);
    [advertiserAssistant stop];
}

// 発見したピアを MCBrowserViewController が提供する UI 上に表示するか判断するデリゲートメソッド
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController
      shouldPresentNearbyPeer:(MCPeerID *)peerID
            withDiscoveryInfo:(NSDictionary *)info
{
    return YES;
}

// Done ボタン押下時のデリゲートメソッド
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
    [advertiserAssistant stop];
    Bluetooth=YES;
}

// Cancel ボタン押下時のデリゲートメソッド
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
    [advertiserAssistant stop];
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error
{
    if(error){
        NSLog(@"[error localizedDescription] %@", [error localizedDescription]);
    }
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    //send.alpha=0;
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    // NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    BOOL needToNotify = NO;
    // 他のピアの接続状態を管理
    if (state == MCSessionStateConnected) {
        if (![connectedPeerIDs containsObject:peerID]) {
            [connectedPeerIDs addObject:peerID];
            [advertiserAssistant stop];
        }
    } else {
        if ([connectedPeerIDs containsObject:peerID]) {
            [connectedPeerIDs removeObject:peerID];
            [advertiserAssistant stop];
            needToNotify = YES;
        }
    }
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    //メインスレッドで実行する。
    dispatch_async(dispatch_get_main_queue(), ^{
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Entity"inManagedObjectContext:self.managedObjectContext];
        NSMutableArray *dataArray2=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        dataarray3=[[NSMutableArray alloc]init];
        dataarray4=[[NSMutableArray alloc]init];
        dataarray5=[[NSMutableArray alloc]init];
        
        for (int i=0; i<400; i++) {
            NSString *str=[dataArray2 objectAtIndex:i];
            [dataarray3 addObject:str];
        }
        for (int i=410; i<610; i++) {
            NSValue *metrovalue=[dataArray2 objectAtIndex:i];
            [dataarray5 addObject:metrovalue];
        }
        NSData *textdata=[NSKeyedArchiver archivedDataWithRootObject:dataarray3];
        [newManagedObject setValue:textdata forKey:@"data"];
        [dataarray4 addObject:[dataArray2 objectAtIndex:400]];
        [dataarray4 addObject:[dataArray2 objectAtIndex:401]];
        [dataarray4 addObject:[dataArray2 objectAtIndex:402]];
        [dataarray4 addObject:[dataArray2 objectAtIndex:403]];
        NSData *colordata=[NSKeyedArchiver archivedDataWithRootObject:dataarray4];
        [newManagedObject setValue:colordata forKey:@"colordata"];
        [newManagedObject setValue:[dataArray2 objectAtIndex:404] forKey:@"slider"];
        [newManagedObject setValue:[dataArray2 objectAtIndex:405] forKey:@"tempo"];
        [newManagedObject setValue:[dataArray2 objectAtIndex:406] forKey:@"title"];
        [newManagedObject setValue:[dataArray2 objectAtIndex:407] forKey:@"artist"];
        [newManagedObject setValue:[dataArray2 objectAtIndex:408] forKey:@"composer"];
        [newManagedObject setValue:[dataArray2 objectAtIndex:409] forKey:@"memo"];
        NSData *metronome=[NSKeyedArchiver archivedDataWithRootObject:dataarray5];
        [newManagedObject setValue:metronome forKey:@"metronome"];
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        //新しくできたセルに移動する。
        [self.tableView scrollToRowAtIndexPath:newIndexpath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        toolbararray1=[NSArray arrayWithObjects:BluetoothButton,Spacer,Store,Info,nil];
        self.toolbarItems=toolbararray1;
        Bluetooth=NO;
        [TrackingManager sendEventTracking:@"Bluetooth" action:@"Bluetooth Receive"
                                     label:@"Bluetooth Receive" value:nil screen:screenName];
    });
}

//
/*(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info{
 //発見した Peer へ招待を送る デフォルトで３０秒
 [browser invitePeer:peerID toSession:session withContext:nil timeout:30];
 }*/

//データの送信
-(void)Send:(id)sender{
    for (int i=0; i<[Bluetootharray count]; i++) {
        NSData *data2=[NSKeyedArchiver archivedDataWithRootObject:[Bluetootharray objectAtIndex:i]];
        NSError *error;
        NSArray *peerIDs = Session.connectedPeers;
        
        [Session sendData:data2
                  toPeers:peerIDs
                 withMode:MCSessionSendDataReliable
                    error:&error];
        if (error) {
            NSLog(@"Failed %@", error);
        }
    }
    toolbararray1=[NSArray arrayWithObjects:BluetoothButton,Spacer,Store,Info,nil];
    self.toolbarItems=toolbararray1;
    Bluetooth=NO;
    [self.tableView reloadData];
    [Bluetootharray removeAllObjects];
    [TrackingManager sendEventTracking:@"Bluetooth" action:@"Bluetooth Send"
                                 label:@"Bluetooth Send" value:nil screen:screenName];
}

-(void)torikeshi:(id)sender{
    toolbararray1=[NSArray arrayWithObjects:BluetoothButton,Spacer,Store,Info,nil];
    self.toolbarItems=toolbararray1;
    [self.tableView reloadData];
    [Bluetootharray removeAllObjects];
}

-(void)Store:(id)sender{
    //[self dismiss];
    StoreViewController *store=[[StoreViewController alloc]init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController pushViewController:store animated:YES];
    }
    else{
        UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:store];
        
        navigationController.modalPresentationStyle = UIModalPresentationPopover;
        navigationController.preferredContentSize = CGSizeMake(600,320);
        
        UIPopoverPresentationController *presentationController = navigationController.popoverPresentationController;
        presentationController.delegate = self;
        presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
        presentationController.sourceView = sender;
        
        [self presentViewController:navigationController animated:YES completion:NULL];
    }
}

/*-(void)dismiss:(NSNotification *)notification{
    [self dismiss];
}

-(void)CMPopTipView:(NSNotification *)notification{
    [self makeCMPopTipView];
}*/

@end
