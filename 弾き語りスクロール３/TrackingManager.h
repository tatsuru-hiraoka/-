//
//  TrackingManager.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TrackingManager : NSObject

#pragma mark - public method
+ (void)sendScreenTracking:(NSString *)screenName;
+ (void)sendEventTracking:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value screen:(NSString *)screen;
@end
