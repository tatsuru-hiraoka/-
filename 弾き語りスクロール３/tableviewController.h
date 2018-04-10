//
//  tableviewController.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "Entity.h"
#import "StoreViewController.h"
#import "DescriptionTableViewController.h"
#import "CMPopTipView.h"
#import "TrackingManager.h"

@class scoreviewController3;

@interface tableviewController:UITableViewController<UIAlertViewDelegate,NSFetchedResultsControllerDelegate,UISplitViewControllerDelegate,UITextFieldDelegate,UIPopoverPresentationControllerDelegate,MCNearbyServiceAdvertiserDelegate,MCSessionDelegate,MCBrowserViewControllerDelegate>{
    NSString *screenName;
    NSMutableArray *array1;
    NSMutableArray *Bluetootharray;
    NSMutableArray *GuitarDiagramarray;
    NSMutableArray *colorarray;
    NSMutableArray *colorarray2;
    NSMutableArray *dataarray;
    NSMutableArray *dataarray1;
    NSMutableArray *connectedPeerIDs;
    NSMutableArray *dataarray3;
    NSMutableArray *dataarray4;
    NSMutableArray *dataarray5;
    NSMutableArray *Tempoarray;
    NSArray *dataarray2;
    NSArray *toolbararray1;
    UITextField *textField;
    UIBarButtonItem *Store;
    UIBarButtonItem *BluetoothButton;
    UIBarButtonItem *Spacer;
    UIBarButtonItem *Cancel;
    UIBarButtonItem *Send;
    UIBarButtonItem *Info;
    //UIBarButtonItem *addButton;
    UIImageView *imageview;
    scoreviewController3 *score;
    UILabel *sectionLabel;
    UILabel *sectionLabel2;
    MCSession *Session;
    NSString *serviceType;
    MCPeerID *myPeerID;
    MCAdvertiserAssistant *advertiserAssistant;
    MCBrowserViewController *BrowserViewController;
    NSIndexPath *newIndexpath;
    NSString *title;
    NSString *artist;
    NSString *composer;
    NSString *memo;
    NSNumber *number1;
    NSNumber *number2;
    NSNumber *number3;
    NSNumber *number4;
    NSNumber *number9;
    NSNumber *number10;
    NSInteger colorvalue1;
    NSInteger colorvalue2;
    NSInteger colorvalue3;
    NSInteger colorvalue4;
    CMPopTipView *navBarLeftButtonPopTipView6;
    //CMPopTipView *navBarLeftButtonPopTipView7;
    int colorvalue5;
    int colorvalue6;
    int colorvalue7;
    int colorvalue8;
    BOOL Bluetooth;
    //BOOL Infomation;
}
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic)NSEntityDescription *entity;
@property(strong,nonatomic)Entity *detailItem;
@end
