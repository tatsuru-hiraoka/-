//
//  AppDelegate.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize scoreviewcontroller2;
@synthesize scoreviewcontroller3;
@synthesize splitviewController;
@synthesize bannerIsVisible3;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //起動画面の表示時間の調整。
    //sleep(2);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        splitviewController=[[UISplitViewController alloc]init];
        _tableviewController=[[tableviewController alloc]init];
        scoreviewcontroller2=[[scoreviewController2 alloc]init];
        scoreviewcontroller2.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
        scoreviewcontroller2.navigationItem.leftBarButtonItem =self.splitviewController.displayModeButtonItem;
        
        _navigationController2=[[UINavigationController alloc]initWithRootViewController:scoreviewcontroller2];
        _navigationController2.navigationBar.tintColor=[UIColor colorWithRed:150/255.0 green:81/255.0 blue:24/255.0 alpha:1];
        _navigationController2.toolbarHidden=NO;
        
        _navigationController=[[UINavigationController alloc]initWithRootViewController:_tableviewController];
        //score2=(scoreviewController2 *)[[_splitviewController.viewControllers lastObject]topViewController];不必要
        splitviewController.viewControllers=[NSArray arrayWithObjects:_navigationController,_navigationController2,nil];
        self.splitviewController.delegate=scoreviewcontroller2;//必要
        splitviewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
        [_window setRootViewController:splitviewController];
        [_window addSubview:splitviewController.view];
        [_window makeKeyAndVisible];
    }
    else{
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableviewController=[[tableviewController alloc]init];
        
        _navigationController=[[UINavigationController alloc]initWithRootViewController:_tableviewController];
        _window.rootViewController=_navigationController;
        [_window addSubview:_tableviewController.view];
        [_window bringSubviewToFront:_tableviewController.view];
        [_window makeKeyAndVisible];
    }
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else{
        return (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    //scoreviewcontroller2.bannerIsVisible3=NO;scoreviewcontroller3.bannerIsVisible3=NO;
}

//バックグラウンドから戻ってきたとき
- (void)applicationWillEnterForeground:(UIApplication *)application{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];//重要
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;//initWithConcurrencyType
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error = nil;
    NSDictionary *options=[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption,nil];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
    
}

- (void)mergeChangesFrom_iCloud:(NSNotification *)notification {
    [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
