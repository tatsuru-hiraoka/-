//
//  TrackingManager.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "TrackingManager.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@implementation TrackingManager

// スクリーン名を GoogleAnalyticsに送信する
+ (void)sendScreenTracking:(NSString *)screenName
{
    /*id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-57821300-1"];
    [[GAI sharedInstance] setDefaultTracker:tracker];
    // スクリーン名を設定
    [tracker set:kGAIScreenName value:screenName];
    // トラッキング情報を送信する
    
    [tracker send:[[GAIDictionaryBuilder createScreenView]build]];
    
    // 送信が終わったらtrackerに設定されているスクリーン名を初期化する
    [tracker set:kGAIScreenName value:nil];*/
    
    
}

// イベントを GoogleAnalyticsに送信する
+ (void)sendEventTracking:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value screen:(NSString *)screen
{
    /*id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    // スクリーン名を設定
    [tracker set:kGAIScreenName value:screen];
    
    // イベントのトラッキング情報を送信する
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category action:action label:label value:value] build]];*/
}

@end
