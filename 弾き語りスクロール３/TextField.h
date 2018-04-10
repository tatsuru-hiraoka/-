//
//  TextField.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreviewController2.h"

@interface TextField : UITextField<UIScrollViewDelegate>{
    CGContextRef _context;
    //UIView *accessoryView;
}

- (void)drawRect:(CGRect)rect;
@end
