//
//  Diagram.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2017/05/19.
//  Copyright © 2017年 平岡 建. All rights reserved.
//

#import "Diagram.h"

@implementation Diagram

//コンテキストの指定
-(void)setContext:(CGContextRef)context{
    if(_context!=nil){
        CGContextRelease(_context);
        _context=NULL;
    }
    _context=context;
}

//色の指定
-(void)setColor_r:(int)r g:(int)g b:(int)b{
    CGContextSetRGBFillColor(_context,r/255.0f,g/255.0f,b/255.0f,1.0f);
    
    CGContextSetRGBStrokeColor(_context,r/255.0f,g/255.0f,b/255.0f,1.0f);
}

//ライン幅の指定
-(void)setLineWidth:(float)width{
    CGContextSetLineWidth(_context,width);
}

//ラインの描画
-(void)drawLine_x0:(float)x0 y0:(float)y0 x1:(float)x1 y1:(float)y1{
    CGContextSetLineCap(_context,kCGLineCapRound);
    CGContextMoveToPoint(_context,x0,y0);
    CGContextAddLineToPoint(_context,x1,y1);
    CGContextStrokePath(_context);
}

//ポリラインの描画
-(void)drawPolyline_x:(float[])x y:(float[])y length:(int)length{
    CGContextSetLineCap(_context,kCGLineCapRound);
    CGContextSetLineJoin(_context,kCGLineJoinRound);
    CGContextMoveToPoint(_context,x[0],y[0]);
    for(int i=1;i<length;i++){
        CGContextAddLineToPoint(_context,x[i],y[i]);
    }
    CGContextStrokePath(_context);
}

//円の描画
-(void)drawCircle_x:(float)x y:(float)y w:(float)w h:(float)h{
    CGContextAddEllipseInRect(_context,CGRectMake(x,y,w,h));
    CGContextStrokePath(_context);
}

//円の塗りつぶし
-(void)fillCircle_x:(float)x y:(float)y w:(float)w h:(float)h{
    CGContextFillEllipseInRect(_context,CGRectMake(x,y,w,h));
}

//初期化
-(id)initWidthFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        _context=NULL;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //グラフィックコンテキストの取得
    [self setContext:UIGraphicsGetCurrentContext()];
    
    //色の指定
    [self setColor_r:255 g:255 b:255];
    
    //背景のクリア
    //[self fillRect_x:0 y:0 w:self.frame.size.width h:self.frame.size.height];
    
    //ラインの描画
    [self setColor_r:255 g:0 b:0];
    [self setLineWidth:2];
    [self drawLine_x0:25 y0:5 x1:25 y1:5+40];
    
    //ポリラインの描画
    float dx[]={55+0,55+30,55+10,55+40,55+0};
    float dy[]={5+0,5+5,5+20,5+25,5+40};
    [self setLineWidth:3];
    [self drawPolyline_x:dx y:dy length:5];
    
    //円の描画
    [self setColor_r:0 g:0 b:255];
    [self drawCircle_x:5 y:100 w:40 h:40];
    
    //円の塗りつぶし
    [self setColor_r:0 g:0 b:255];
    [self fillCircle_x:55 y:100 w:40 h:40];
}

@end
