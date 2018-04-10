//
//  Button.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "Button.h"

@implementation Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CALayer *layer = self.layer;
    layer.backgroundColor =[[UIColor colorWithRed:0/255.0 green:143/255.0 blue:88/255.0 alpha:1]CGColor]; //[[UIColor clearColor] CGColor];
    layer.cornerRadius = 1.0;//枠線の角度
    layer.masksToBounds = YES;
    layer.borderWidth = 0.0;//枠線の太さ
    layer.borderColor = [[UIColor lightGrayColor]CGColor];//[[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:0] CGColor];
    
    [self setClipsToBounds:NO];
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 20, bounds.origin.y + 8,
                      bounds.size.width - 40, bounds.size.height - 16);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
