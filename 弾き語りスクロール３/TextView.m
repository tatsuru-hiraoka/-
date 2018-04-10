//
//  TextView.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "TextView.h"

@implementation TextView

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
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    CALayer *layer = self.layer;
    layer.backgroundColor = [[UIColor whiteColor] CGColor];
    layer.cornerRadius = 1.0;//枠線の角度
    layer.masksToBounds = YES;
    layer.borderWidth = 1.0;//枠線の太さ
    layer.borderColor =[[UIColor lightGrayColor]CGColor];
    
    [self setClipsToBounds:NO];
    
    // 直線を描画
    /*CGContextRef context = UIGraphicsGetCurrentContext();  // コンテキストを取得
     CGContextMoveToPoint(context, 5, 53);  // 始点
     CGContextAddLineToPoint(context, 140, 53);  // 終点
     CGContextMoveToPoint(context, 140, 45);  // 始点
     CGContextAddLineToPoint(context, 140, 53);  // 終点
     CGContextStrokePath(context);  // 描画！*/
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 20, bounds.origin.y + 8,
                      bounds.size.width - 40, bounds.size.height - 16);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
