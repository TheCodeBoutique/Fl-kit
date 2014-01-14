//
//  TCBCardViewController.m
//  Flukit
//
//  Created by Kyle Carriedo on 1/13/14.
//  Copyright (c) 2014 TheCodeBoutique. All rights reserved.
//

#import "TCBCardViewController.h"

@interface TCBCardViewController ()

@end

@implementation TCBCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSwipeCard:(id)sender {
    CGRect questionFrame = [_questionCard frame];
    CGRect bottomScreenFrame = [_questionCard frame];
    bottomScreenFrame.origin.y = 1200.0f;
    
    //will need to 2 cards one that is hidden 
    
    
    //correct animation
//    [UIView animateWithDuration:1.0 animations:^{
//        [_questionCard setFrame:CGRectMake(CGRectGetMidX(questionFrame), CGRectGetMinY(questionFrame) - 1200, CGRectGetWidth(questionFrame), CGRectGetHeight(questionFrame))];
//    }];

    
    [UIView animateWithDuration:1.0 delay:0.1 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            [_questionCard setFrame:CGRectMake(CGRectGetMidX(questionFrame), CGRectGetMinY(questionFrame) - 1200, CGRectGetWidth(questionFrame), CGRectGetHeight(questionFrame))];
    } completion:^(BOOL finished) {
        [_questionCard setFrame:bottomScreenFrame];
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [UIView animateWithDuration:1.0 animations:^{
                [_questionCard setFrame:questionFrame];
            }];
        });
    }];
}
@end
