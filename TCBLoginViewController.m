//
//  TCBLoginViewController.m
//  Flukit
//
//  Created by Marin Fischer on 1/11/14.
//  Copyright (c) 2014 TheCodeBoutique. All rights reserved.
//

#import "TCBLoginViewController.h"
#import "TCBCreateAccountViewController.h"
#import "MBProgressHUD.h"
#import "UIAlertView+Blocks.h"
#import "RIButtonItem.h"
@interface TCBLoginViewController ()

@end

@implementation TCBLoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)signinButton:(id)sender
{
    [[self view] endEditing:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[[UIApplication sharedApplication] keyWindow] rootViewController] view] animated:YES];
    [hud setMode:MBProgressHUDModeIndeterminate];
    [hud show:YES];
    [hud setLabelText:NSLocalizedString(@"Loging in...", @"Loging in...")];
    
    NSString *username = [_usernameTextField text];
    NSString *password = [_passwordTextField text];
    
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [hud hide:YES];
                                            //TODO Remove just testing
                                            [[[UIAlertView alloc] initWithTitle:@"Login Successful"
                                                                        message:@""
                                                               cancelButtonItem:nil
                                                               otherButtonItems:[RIButtonItem itemWithLabel:@"Close" action:^{
                                                
                                            }], nil] show];
                                        } else {
                                            // The login failed. Check error to see why.
                                            [hud hide:YES];
                                            NSString *errorString = [error userInfo][@"error"];
                                            
                                            [[[UIAlertView alloc] initWithTitle:@"Invalid Login"
                                                                        message:errorString
                                                               cancelButtonItem:nil
                                                               otherButtonItems:[RIButtonItem itemWithLabel:@"Close" action:^{

                                            }], nil] show];
                                        }
                                    }];
}
- (IBAction)twitterSignupTapped:(id)sender {
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
        } else {
            NSLog(@"User logged in with Twitter!");
        }     
    }];
}

- (IBAction)facebookSigninButton:(id)sender
{
    [PFFacebookUtils logInWithPermissions:@[] block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
}

- (IBAction)createAccountButton:(id)sender
{
    TCBCreateAccountViewController *createAccountViewController = [[TCBCreateAccountViewController alloc] initWithNibName:@"TCBCreateAccountViewController" bundle:nil];
    [[self navigationController] pushViewController:createAccountViewController animated:YES];
}
@end
