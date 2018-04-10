//
//  CMPopTipView.h
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PointDirection) {
    PointDirectionAny = 0,
    PointDirectionUp,
    PointDirectionDown,
};

typedef NS_ENUM(NSInteger, CMPopTipAnimation) {
    CMPopTipAnimationSlide = 0,
    CMPopTipAnimationPop
};


@protocol CMPopTipViewDelegate;


@interface CMPopTipView : UIView{
    CGRect finalFrame;
}

@property (nonatomic, strong)			UIColor					*backgroundColor;
@property (nonatomic, weak)				id<CMPopTipViewDelegate>	delegate;
@property (nonatomic, assign)			BOOL					disableTapToDismiss;
@property (nonatomic, assign)			BOOL					dismissTapAnywhere;
@property (nonatomic, strong)			NSString				*title;
@property (nonatomic, strong)			NSString				*message;
@property (nonatomic, strong)           UIView	                *customView;
@property (nonatomic, strong, readonly)	id						targetObject;
@property (nonatomic, strong)			UIColor					*titleColor;
@property (nonatomic, strong)			UIFont					*titleFont;
@property (nonatomic, strong)			UIColor					*textColor;
@property (nonatomic, strong)			UIFont					*textFont;
@property (nonatomic, assign)			NSTextAlignment			titleAlignment;
@property (nonatomic, assign)			NSTextAlignment			textAlignment;
@property (nonatomic, assign)           BOOL                    has3DStyle;
@property (nonatomic, strong)			UIColor					*borderColor;
@property (nonatomic, assign)           CGFloat                 cornerRadius;
@property (nonatomic, assign)			CGFloat					borderWidth;
@property (nonatomic, assign)           BOOL                    hasShadow;
@property (nonatomic, assign)           CMPopTipAnimation       animation;
@property (nonatomic, assign)           CGFloat                 maxWidth;
@property (nonatomic, assign)           PointDirection          preferredPointDirection;
@property (nonatomic, assign)           BOOL                    hasGradientBackground;
@property (nonatomic, assign)           CGFloat                 sidePadding;
@property (nonatomic, assign)           CGFloat                 topMargin;
@property (nonatomic, assign)           CGFloat                 pointerSize;
@property (nonatomic, assign)           CGFloat                 bubblePaddingX;
@property (nonatomic, assign)           CGFloat                 bubblePaddingY;
@property (nonatomic, assign)           PointDirection          pointDirection;//up,downの数値

/* Contents can be either a message or a UIView */
- (id)initWithTitle:(NSString *)titleToShow message:(NSString *)messageToShow;
- (id)initWithMessage:(NSString *)messageToShow;
- (id)initWithCustomView:(UIView *)aView;

- (void)presentPointingAtView:(UIView *)targetView inView:(UIView *)containerView animated:(BOOL)animated;
- (void)presentPointingAtBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;
- (void)autoDismissAnimated:(BOOL)animated atTimeInterval:(NSTimeInterval)timeInvertal;
- (PointDirection) getPointDirection;

@end


@protocol CMPopTipViewDelegate <NSObject>
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView;

@end
