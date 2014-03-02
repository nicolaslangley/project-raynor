//
//  HPRLogInViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 3/2/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRLogInViewController.h"

@interface HPRLogInViewController ()

@end

@implementation HPRLogInViewController

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
	// Do any additional setup after loading the view.
    // Set view background color
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Customize attributes for log in view
    UIColor *color = self.view.tintColor;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Project Raynor";
    label.textColor = color;
    [label sizeToFit];
    [self.logInView setLogo:label];
    [self.logInView.usernameField setBackgroundColor:[UIColor whiteColor]];
    [self.logInView.usernameField setTextColor:color];
    [self.logInView.passwordField setBackgroundColor:[UIColor whiteColor]];
    [self.logInView.passwordField setTextColor:color];
    [self.logInView.passwordForgottenButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.logInView.passwordForgottenButton setBackgroundColor:color];
    [self.logInView.logInButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.logInView.logInButton setBackgroundColor:color];
    [self.logInView.signUpButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundColor:color];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.logInView.usernameField setText:@""];
    [self.logInView.passwordField setText:@""];
}

@end
