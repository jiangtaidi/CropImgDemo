//
//  AXCropViewController.h
//  AxProject
//
//  Created by jiangtd on 16/1/10.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AXBaseViewController.h"

typedef void(^AXCropViewControllerBlock)(UIImage *img);

@interface AXCropViewController : UIViewController

@property(nonatomic,strong)UIImage *img;
@property(nonatomic,copy)AXCropViewControllerBlock block;

@end
