//
//  TCBLoginViewController.m
//  Flukit
//
//  Created by Marin Fischer on 1/11/14.
//  Copyright (c) 2014 TheCodeBoutique. All rights reserved.
//

#import "TCBLoginViewController.h"
#import "TCBCreateAccountViewController.h"
#import "TCBCardViewController.h"
#import "MBProgressHUD.h"
#import "UIAlertView+Blocks.h"
#import "RIButtonItem.h"
@interface TCBLoginViewController ()
{
    CGSize scrollViewContentSize;

}

@end

@implementation TCBLoginViewController
@synthesize scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShown:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasHidden:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES];
    
    [[self scrollView] setContentSize:CGSizeMake([[self scrollView] frame].size.width, [[self scrollView] frame].size.height)];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIKeyboardWillShowNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIKeyboardDidHideNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIKeyboardWillHideNotification
     object:nil];
    
}


-(IBAction)dismissKeyboardTap:(id)sender
{
    [self.view endEditing:YES];
}

-(void)keyboardWillHide:(NSNotification *)aNotification
{
   [[self scrollView] setContentSize:CGSizeMake(scrollViewContentSize.width, scrollViewContentSize.height - 760)];
}

- (void)keyboardWillShown:(NSNotification *)aNotification
{
   // [super keyboardWasShown];
    [[self scrollView] setContentSize:CGSizeMake(scrollViewContentSize.width, scrollViewContentSize.height + 760)];
    [self scrollViewToCenterOfScreen:scrollView];

}

- (void)keyboardWasHidden:(NSNotification *)aNotification
{
   // [super keyboardWasHidden];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //Keyboard becomes visible
    [self scrollViewToCenterOfScreen:textField];
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //keyboard will hide
    [scrollView scrollRectToVisible:[textField frame] animated:YES];
}

-(void)scrollViewToCenterOfScreen:(UIView *)theView
{
    CGFloat viewCenterY = theView.center.y;
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    CGFloat availableHeight = applicationFrame.size.height - 200; // Remove area covered by keyboard
    
    CGFloat y = viewCenterY - availableHeight / 2.0;
    if (y < 0) {
        y = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(0, y) animated:YES];
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

- (IBAction)twitterSignupTapped:(id)sender
{
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

- (IBAction)testAccount:(id)sender
{
    TCBCardViewController *cardApp = [[TCBCardViewController alloc] initWithNibName:@"TCBCardViewController" bundle:nil];
    [[self navigationController] pushViewController:cardApp animated:YES];    
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
