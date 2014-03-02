//
//  HPRSignUpViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 3/2/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRSignUpViewController.h"

@interface HPRSignUpViewController ()

@end

@implementation HPRSignUpViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Customize sign up view
    UIColor *color = self.view.tintColor;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Project Raynor";
    label.textColor = color;
    [label sizeToFit];
    [self.signUpView setLogo:label];
    [self.signUpView.usernameField setBackgroundColor:[UIColor whiteColor]];
    [self.signUpView.usernameField setTextColor:color];
    [self.signUpView.passwordField setBackgroundColor:[UIColor whiteColor]];
    [self.signUpView.passwordField setTextColor:color];
    [self.signUpView.signUpButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.signUpView.signUpButton setBackgroundColor:color];
    [self.signUpView.emailField setBackground:nil];
    [self.signUpView.emailField setBackgroundColor:[UIColor whiteColor]];
    [self.signUpView.emailField setTextColor:color];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.signUpView.usernameField setText:@""];
    [self.signUpView.passwordField setText:@""];
    [self.signUpView.emailField setText:@""];
}

@end
