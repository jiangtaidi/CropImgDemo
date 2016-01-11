//
//  UIView+addView.m
//  AxProject
//
//  Created by jiangtd on 16/1/4.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import "UIView+addView.h"

@implementation UIView (addView)

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint cr = self.center;
    cr.x = centerX;
    self.center = cr;
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint cr = self.center;
    cr.y = centerY;
    self.center = cr;
}

-(CGFloat)centerY
{
    return self.center.y;
}

@end










