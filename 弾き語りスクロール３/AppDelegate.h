//
//  AppDelegate.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "tableviewController.h"
#import "scoreviewController2.h"
#import "scoreviewController3.h"
#import "infomationViewController2.h"
//#import "MediaPlayerViewController.h"
#import "StoreViewController.h"
#import "BeetViewController.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIWindow* _window;
    UINavigationController* _navigationController;
    UINavigationController* _navigationController2;
    UITableViewController* _tableviewController;
}
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) scoreviewController2 *scoreviewcontroller2;//bannerIsVisible3を使いたいのでプロパティを使う。
@property (nonatomic, retain) scoreviewController3 *scoreviewcontroller3;
@property (nonatomic, retain) UISplitViewController *splitviewController;
@property (nonatomic, retain) NSData *colordata;
@property (nonatomic, retain) NSURL *tlogPath;
@property (nonatomic, retain) NSURL *cloudPath;
@property (nonatomic, assign) BOOL bannerIsVisible3;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

