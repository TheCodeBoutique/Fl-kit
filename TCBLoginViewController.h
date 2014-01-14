//
//  TCBLoginViewController.h
//  Flukit
//
//  Created by Marin Fischer on 1/11/14.
//  Copyright (c) 2014 TheCodeBoutique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface TCBLoginViewController : UIViewController < UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)signinButton:(id)sender;
- (IBAction)facebookSigninButton:(id)sender;
- (IBAction)createAccountButton:(id)sender;

@end
