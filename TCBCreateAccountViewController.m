//
//  TCBCreateAccountViewController.m
//  Flukit
//
//  Created by Kyle Carriedo on 1/12/14.
//  Copyright (c) 2014 TheCodeBoutique. All rights reserved.
//

#import "TCBCreateAccountViewController.h"
#import "MBProgressHUD.h"

@interface TCBCreateAccountViewController ()

@end

@implementation TCBCreateAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createUserTapped:(id)sender {
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:[[[[UIApplication sharedApplication] keyWindow] rootViewController] view] animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"Creating Account...";
    
    PFUser *user = [PFUser user];
    user.username = [_username text];
    user.password = [_password text];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [hud hide:YES];
            [[self navigationController] popToRootViewControllerAnimated:YES]; //TODO Remove once game is created
    
        } else {
            [hud hide:YES];
            NSString *errorString = [error userInfo][@"error"];
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end