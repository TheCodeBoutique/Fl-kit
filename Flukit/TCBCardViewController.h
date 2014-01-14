//
//  TCBCardViewController.h
//  Flukit
//
//  Created by Kyle Carriedo on 1/13/14.
//  Copyright (c) 2014 TheCodeBoutique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCBCardViewController : UIViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIView *questionCard;
- (IBAction)didSwipeCard:(id)sender;
@end
