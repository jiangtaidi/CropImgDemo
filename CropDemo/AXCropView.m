//
//  AXCropView.m
//  AxProject
//
//  Created by jiangtd on 16/1/10.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import "AXCropView.h"
#import "UIView+addView.h"

#define MinWidth 60
#define MinHeight 60

@interface AXCropView ()

@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,strong)NSMutableArray *viewArr;

@property(nonatomic,assign)CGPoint preCenter;
@property(nonatomic,weak)UIView *contentView;
@property(nonatomic,assign)CGRect preFrame;

@end

@implementation AXCropView

-(id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
        [self addpanGesture];
    }
    return self;
}

-(void)setupUI
{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
    _contentView = contentView;
    
    NSArray *arr = @[@"ScanTranslation1",@"ScanTranslation2",@"ScanTranslation3",@"ScanTranslation4"];
    
    int i = 1;
    for (NSString *imgName in arr) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        btn.tag = i;
        i++;
        [self.btnArr addObject:btn];
        [self addSubview:btn];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(btnPanGesture:)];
        [btn addGestureRecognizer:panGesture];
    }
    
    for (int i = 0; i<4; i++) {
        UIView *vw = [[UIView alloc] init];
        [self addSubview:vw];
        UIPanGestureRecognizer *pGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPanGesture:)];
        vw.tag = i+1;
        [vw addGestureRecognizer:pGesture];
        [self.viewArr addObject:vw];
    }
    
}

-(void)addpanGesture
{
    UIPanGestureRecognizer *cPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cPanGestureAction:)];
    cPanGesture.maximumNumberOfTouches = 2;
    cPanGesture.minimumNumberOfTouches = 1;
    [self.contentView addGestureRecognizer:cPanGesture];
}

-(void)btnPanGesture:(UIPanGestureRecognizer*)panGesture
{
    UIView *vw = panGesture.view;
    CGRect oldFrame = self.frame;
    CGRect oldIntersectRect  = CGRectIntersection(self.frame, self.superview.bounds);
    
    CGPoint transport = [panGesture translationInView:vw];
    if (vw.tag == 4) {
        self.width = self.preFrame.size.width + transport.x;
        self.height = self.preFrame.size.height + transport.y;
    }
    else if(vw.tag == 3)
    {
        self.x = self.preFrame.origin.x + transport.x;
        self.width = self.preFrame.size.width - transport.x;
        self.height = self.preFrame.size.height + transport.y;
    }
    else if(vw.tag == 2)
    {
        self.width = self.preFrame.size.width + transport.x;
        self.y = self.preFrame.origin.y + transport.y;
        self.height = self.preFrame.size.height - transport.y;
    }
    else if(vw.tag == 1)
    {
        self.x = self.preFrame.origin.x + transport.x;
        self.width = self.preFrame.size.width - transport.x;
        self.y = self.preFrame.origin.y + transport.y;
        self.height = self.preFrame.size.height - transport.y;
    }
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        self.preFrame = self.frame;
    }
    if (self.width < MinWidth || self.height < MinHeight) {
        self.frame = oldFrame;
    }
    CGRect newFrame = self.frame;
    if (newFrame.size.width * newFrame.size.height > oldFrame.size.height * oldFrame.size.width) {
        
        CGRect newIntersectRect  = CGRectIntersection(self.frame, self.superview.bounds);
        if (newFrame.size.width * newFrame.size.height > newIntersectRect.size.width * newIntersectRect.size.height) {
            self.frame = oldFrame;
        }
        
    }
    self.preCenter = self.center;

}

-(void)viewPanGesture:(UIPanGestureRecognizer*)panGesture
{
    UIView *vw = panGesture.view;
    CGRect oldFrame = self.frame;
    CGRect oldIntersectRect  = CGRectIntersection(self.frame, self.superview.bounds);
    
    CGPoint transport = [panGesture translationInView:vw];
    if (vw.tag == 1) {
        self.y = self.preFrame.origin.y + transport.y;
        self.height = self.preFrame.size.height - transport.y;
    }
    else if(vw.tag == 2)
    {
        self.x = self.preFrame.origin.x + transport.x;
        self.width = self.preFrame.size.width - transport.x;
    }
    else if(vw.tag == 3)
    {
        self.height = self.preFrame.size.height + transport.y;
    }
    else if(vw.tag == 4)
    {
        self.width = self.preFrame.size.width + transport.x;
    }
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        self.preFrame = self.frame;
    }
    if (self.width < MinWidth || self.height < MinHeight) {
        self.frame = oldFrame;

    }
    self.preCenter = self.center;
    CGRect newFrame = self.frame;
    if (newFrame.size.width * newFrame.size.height > oldFrame.size.height * oldFrame.size.width) {
        
        CGRect newIntersectRect  = CGRectIntersection(self.frame, self.superview.bounds);
        if (oldIntersectRect.size.width * oldIntersectRect.size.height >= newIntersectRect.size.width * newIntersectRect.size.height) {
            self.frame = oldFrame;
            self.preCenter = self.preCenter;
        }
        
    }

}

-(void)cPanGestureAction:(UIPanGestureRecognizer*)panGesture
{
    CGPoint transport = [panGesture translationInView:self];
    CGRect oldFrame = self.frame;
    CGRect oldIntersectRect  = CGRectIntersection(self.frame, self.superview.bounds);
    CGFloat oldMj = oldIntersectRect.size.width * oldIntersectRect.size.height;
    
    self.center = CGPointMake(self.preCenter.x + transport.x, self.preCenter.y + transport.y);
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        
        self.preCenter = self.center;
    }
    CGRect newIntersectRect  = CGRectIntersection(self.frame, self.superview.bounds);
    CGFloat newMj = newIntersectRect.size.width * newIntersectRect.size.height;
    
    if (newMj < oldMj) {
        self.frame = oldFrame;
        self.preCenter = self.center;
    }
}

-(void)layoutSubviews
{
    CGFloat space = 3;
    self.contentView.frame = CGRectMake(space,space, self.bounds.size.width - space * 2, self.bounds.size.height - space * 2);
    
    ((UIView*)self.btnArr[0]).frame = CGRectMake(0, 0, 15, 15);
    ((UIView*)self.btnArr[1]).frame = CGRectMake(self.bounds.size.width - 15, 0, 15, 15);
    ((UIView*)self.btnArr[2]).frame = CGRectMake(0, self.bounds.size.height - 15, 15, 15);
    ((UIView*)self.btnArr[3]).frame = CGRectMake(self.bounds.size.width - 15, self.bounds.size.height - 15, 15, 15);
    
    ((UIView*)self.viewArr[0]).frame = CGRectMake(15, 0, self.bounds.size.width - 30, 3);
    ((UIView*)self.viewArr[0]).backgroundColor = [UIColor blackColor];

    ((UIView*)self.viewArr[1]).frame = CGRectMake(0, 15, 3, self.bounds.size.height - 30);
    ((UIView*)self.viewArr[1]).backgroundColor = [UIColor blackColor];
    
    ((UIView*)self.viewArr[2]).frame = CGRectMake(15, self.bounds.size.height - 3, self.bounds.size.width - 30, 3);
    ((UIView*)self.viewArr[2]).backgroundColor = [UIColor blackColor];
    
    ((UIView*)self.viewArr[3]).frame = CGRectMake(self.bounds.size.width - 3, 15, 3, self.bounds.size.height - 30);
    ((UIView*)self.viewArr[3]).backgroundColor = [UIColor blackColor];
    
}

- (void)drawRect:(CGRect)rect
{
    self.preCenter = self.center;
    self.preFrame = rect;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setStroke];

    CGContextSetLineWidth(context,.5);

    CGContextStrokeRect(context, CGRectMake(3, 3, self.bounds.size.width - 6, self.bounds.size.height - 6));
    
    [[UIColor whiteColor] setStroke];
    
    CGContextMoveToPoint(context, 3, self.contentView.bounds.size.height / 3);
    CGContextAddLineToPoint(context,self.contentView.bounds.size.width + 3, self.contentView.bounds.size.height / 3);
    
    CGContextMoveToPoint(context, 3, self.bounds.size.height / 3 * 2);
    CGContextAddLineToPoint(context,self.contentView.bounds.size.width + 3, self.bounds.size.height / 3 * 2);
    
    CGContextMoveToPoint(context, self.bounds.size.width / 3, 3);
    CGContextAddLineToPoint(context,self.bounds.size.width / 3, self.contentView.bounds.size.height + 3);

    CGContextMoveToPoint(context, self.bounds.size.width / 3 * 2,3);
    CGContextAddLineToPoint(context,self.bounds.size.width / 3 * 2, self.contentView.bounds.size.height + 3);
    
    CGContextStrokePath(context);
}

#pragma mark =============GetMethod============

-(NSMutableArray*)btnArr
{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

-(NSMutableArray*)viewArr
{
    if (!_viewArr) {
        _viewArr = [NSMutableArray array];
    }
    return _viewArr;
}

@end









