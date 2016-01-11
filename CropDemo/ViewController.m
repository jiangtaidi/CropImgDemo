//
//  ViewController.m
//  CropDemo
//
//  Created by jiangtd on 16/1/11.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import "ViewController.h"
#import "AXCropViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)buttonClicked:(id)sender {
    AXCropViewController *cropVc = [[AXCropViewController alloc] init];
    cropVc.img = [UIImage imageNamed:@"1"];
    cropVc.block = ^(UIImage *img)
    {
        self.imgView.image = img;
    };
    [self.navigationController pushViewController:cropVc animated:YES];
}

@end








