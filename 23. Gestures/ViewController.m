//
//  ViewController.m
//  23. Gestures
//
//  Created by Admin on 02.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak,nonatomic) UIImageView *imageView;
@property (assign,nonatomic) CGFloat scale;
@property (assign,nonatomic) CGFloat angle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UIImage *image=[UIImage imageNamed:@"Images/ball"];
    //UIView *view=[[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    
    //Uchenik
    UIImage *image2=[[UIImage alloc] initWithContentsOfFile:@"/Users/admin/Desktop/XCodeProjects/23. Gestures/23. Gestures/Images/ball.jpg"];
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    imageView.image=image2;
    imageView.autoresizingMask=
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin;
    self.imageView=imageView;
    self.scale=1.f;
    [self.view addSubview:imageView];
    //---------
    //end of Uchenik
    
    //Student
    UITapGestureRecognizer *tapRec=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapRec];
    
    //---------
    //end of Student
    
    //Master
    UISwipeGestureRecognizer *swipeRecLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    swipeRecLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    //separatly right and left
    [self.view addGestureRecognizer:swipeRecLeft];
    
    UISwipeGestureRecognizer *swipeRecRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    swipeRecRight.direction=UISwipeGestureRecognizerDirectionRight;
    //separatly right and left
    [self.view addGestureRecognizer:swipeRecRight];
    
    UITapGestureRecognizer *doubleTapDoubleTouchRec=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handle2Taps2Touches:)];
    doubleTapDoubleTouchRec.numberOfTapsRequired=2;
    doubleTapDoubleTouchRec.numberOfTouchesRequired=2;
    [self.view addGestureRecognizer:doubleTapDoubleTouchRec];
    
    //---------
    //end of Master
    
    //Superman
    
    UIPinchGestureRecognizer *pinchRec=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    pinchRec.delegate=self;
    [self.view addGestureRecognizer:pinchRec];
    
    UIRotationGestureRecognizer *rotRec=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotation:)];
    rotRec.delegate=self;
    [self.view addGestureRecognizer:rotRec];
    //---------
    //end of Superman
}
#pragma mark - handles
- (void) handleTap:(UITapGestureRecognizer*) tapRecognizer {
    [UIView animateWithDuration:2.f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.imageView.center=[tapRecognizer locationInView:self.view];
    } completion:^(BOOL finished) {
        
    }];
}
- (void) handleSwipe:(UISwipeGestureRecognizer*) swipeRec {
    //NSLog(@"direction %ld",swipeRec.direction);
    if (swipeRec.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
        [UIView animateWithDuration:1.f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            CGAffineTransform trasformRotate=CGAffineTransformRotate(self.imageView.transform, M_PI);
            self.imageView.transform=trasformRotate;
        } completion:nil];
    } else if (swipeRec.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"left");
        [UIView animateWithDuration:1.f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            CGAffineTransform trasformRotate=CGAffineTransformRotate(self.imageView.transform, -3.141);
            self.imageView.transform=trasformRotate;
        } completion:nil];
    }
}
- (void) handle2Taps2Touches:(UITapGestureRecognizer*) tapRec{
    [self.imageView.layer removeAllAnimations];
}

-(void) handlePinch:(UIPinchGestureRecognizer*) pinchRec{
    NSLog(@"pinch scale %1.3f",pinchRec.scale);
    if (pinchRec.state==UIGestureRecognizerStateBegan) {
        self.scale=1;
    }
    CGFloat correctedScale=1.f+pinchRec.scale-self.scale;
    CGAffineTransform currentTransform=self.imageView.transform;
    currentTransform=CGAffineTransformScale(currentTransform, correctedScale, correctedScale);

    self.imageView.transform=currentTransform;
    self.scale=pinchRec.scale;
}
- (void) handleRotation:(UIRotationGestureRecognizer*) rotRec{
    if (rotRec.state==UIGestureRecognizerStateBegan) {
        self.angle=0;
    }
    CGFloat correctedAngel=rotRec.rotation-self.angle;
    CGAffineTransform currentTransform=self.imageView.transform;
    currentTransform=CGAffineTransformRotate(currentTransform, correctedAngel);
    
    self.imageView.transform=currentTransform;
    self.angle=rotRec.rotation;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
