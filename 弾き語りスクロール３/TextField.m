//
//  TextField.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "TextField.h"

@implementation TextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//テキストボタンの生成
- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    //テキストボタンの生成
    Button* button=[Button buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    [button.titleLabel setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:20]];
    return button;
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
    //[[UIColor lightGrayColor]CGColor];//[[UIColor colorWithRed:2/255.0 green:31/255.0 blue:140/255.0 alpha:0] CGColor];
    
    [self setClipsToBounds:NO];
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    // 直線を描画
    /*CGContextRef context = UIGraphicsGetCurrentContext();  // コンテキストを取得
     CGContextMoveToPoint(context, 5, 70);  // 始点
     CGContextAddLineToPoint(context, 140, 70);  // 終点
     CGContextMoveToPoint(context, 140, 60);  // 始点
     CGContextAddLineToPoint(context, 140, 70);  // 終点
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
