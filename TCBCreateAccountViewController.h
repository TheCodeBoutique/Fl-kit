//
//  TCBCreateAccountViewController.h
//  Flukit
//
//  Created by Kyle Carriedo on 1/12/14.
//  Copyright (c) 2014 TheCodeBoutique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface TCBCreateAccountViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@end
