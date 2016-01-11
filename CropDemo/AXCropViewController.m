//
//  AXCropViewController.m
//  AxProject
//
//  Created by jiangtd on 16/1/10.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import "AXCropViewController.h"
#import "AXMyScretTopView.h"
#import "AXCropView.h"
#import "ALAssetsLibrary+addALAsset.h"

@interface AXCropViewController ()

@property(nonatomic,weak)UIImageView *imgView;
@property(nonatomic,weak)AXCropView *cropView;

@end

@implementation AXCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI
{
    [self setupTopView];
    [self setContentView];
}

-(void)setupTopView
{
    AXMyScretTopView * topView = [AXMyScretTopView myScretTopView];
    topView.frame = CGRectMake(0, 0, ScreenWidth, 44);
    topView.backgroundColor = JGCOLOR(233, 108, 143);
    topView.titleLabel.text = @"截图";
    topView.sureBtn.hidden = NO;
    [self.view addSubview:topView];
    __weak typeof(self) sf = self;
    topView.block = ^(NSInteger index)
    {
        [sf topViewActionWithIndex:index];
    };
}

-(void)setContentView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHight - 44)];
    contentView.backgroundColor = [UIColor blackColor];
    contentView.layer.masksToBounds = YES;
    [self.view addSubview:contentView];
    
    CGFloat width = self.img.size.width > ScreenWidth ? ScreenWidth : self.img.size.width;
    CGFloat height = (width / self.img.size.width) * self.img.size.height;
    UIImageView *imgView =[[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, 0, width, height);
    imgView.center = CGPointMake(contentView.bounds.size.width / 2, contentView.bounds.size.height / 2);
    imgView.image = self.img;
    imgView.userInteractionEnabled = YES;
    [contentView addSubview:imgView];
    
    _imgView = imgView;
    
    AXCropView *cropView = [[AXCropView alloc] initWithFrame:CGRectMake(20, 20, 80, 150)];
    _cropView = cropView;
    [imgView addSubview:_cropView];
}

#pragma mark ===============Action==============

-(void)topViewActionWithIndex:(NSInteger)index
{
    if(index == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(index == 2)
    {
        [self cropImg];
    }
}

-(void)cropImg
{
    CGRect cropFrame = self.cropView.frame;
    CGFloat orgX = cropFrame.origin.x * (self.img.size.width / self.imgView.frame.size.width);
    CGFloat orgY = cropFrame.origin.y * (self.img.size.height / self.imgView.frame.size.height);
    CGFloat width = cropFrame.size.width * (self.img.size.width / self.imgView.frame.size.width);
    CGFloat height = cropFrame.size.height * (self.img.size.height / self.imgView.frame.size.height);
    CGRect cropRect = CGRectMake(orgX, orgY, width, height);
    CGImageRef imgRef = CGImageCreateWithImageInRect(self.img.CGImage, cropRect);
    
    CGFloat deviceScale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(cropFrame.size, 0, deviceScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, cropFrame.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, cropFrame.size.width, cropFrame.size.height), imgRef);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imgRef);
    UIGraphicsEndImageContext();
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library toolWriteImageToSavedPhotosAlbum:newImg.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if(error)
        {
            JGLog(@"截图写入出错");
        }
    } groupName:@"爱秀"];
}

@end
























