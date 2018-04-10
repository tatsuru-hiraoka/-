//
//  Entity.h
//  弾き語りスクロール
//
//  Created by 平岡 建 on 13/01/03.
//  Copyright (c) 2013年 平岡 建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * composer;
@property (nonatomic, retain) NSNumber * slider;
@property (nonatomic, retain) NSNumber * tempo;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSString *memo;
@property (nonatomic, retain) NSData *colordata;
@property (nonatomic, retain) NSData *diagram;
@property (nonatomic, retain) NSData *store;
@property (nonatomic, retain) NSData *metronome;
@end
