//
//  HPRViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <Parse/Parse.h>
#import <MMDrawerBarButtonItem.h>
#import "HPRCenterViewController.h"
#import "HPRItemView.h"
#import "HPRLogInViewController.h"
#import "HPRSignUpViewController.h"

@protocol CenterViewController <NSObject>

- (void)openLeftDrawer;
- (void)userStatusButton;

@end

@interface HPRCenterViewController ()
{
    NSMutableArray *cardData;
}
@end

@implementation HPRCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Set up log in view controller
    self.logInViewController = [[HPRLogInViewController alloc] init];
    self.logInViewController.delegate = self;
    [self.logInViewController setFields: PFLogInFieldsUsernameAndPassword
     | PFLogInFieldsLogInButton
     | PFLogInFieldsSignUpButton
     | PFLogInFieldsDismissButton];
    
    // Set up sign up view controller
    HPRSignUpViewController *signUpViewController = [[HPRSignUpViewController alloc] init];
    [signUpViewController setDelegate:self];
    [signUpViewController setFields:PFSignUpFieldsDefault];
    
    // Link the sign up view controller to log in view controller
    [self.logInViewController setSignUpController:signUpViewController];
    
    // Check if user is logged in
    if (![PFUser currentUser]) {
        // Present log in view controllers
        [self presentViewController:self.logInViewController animated:YES completion:nil];
    }
    
    // Modify navigation bar by adding left drawer button, log out button and title
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self
                                                                                     action:@selector(openLeftDrawer)];
    UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Login"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(userStatusButton)];
    [self.navigationItem setRightBarButtonItem:logOutButton];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton];
    [self.navigationItem setTitle:@"Project Raynor"];
    
    
    
    // Set background color of view
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Add label for displaying current user
    self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 470, 160, 40)];
    [self.userLabel setTextColor:self.view.tintColor];
    [self.userLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.userLabel];
    
    // Add button for reloading data
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(reloadCardData:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Reload Data" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 420.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    // Download item objects stored online
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    //    query.limit = 2;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // Load objects into cardSource array and populate cards
            cardData = [objects mutableCopy];
            [self populateCardData:cardData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Methods for handling drawer opening and closing

- (void)openLeftDrawer {
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        NSLog(@"In open left drawer completion");
    }];
}

#pragma mark - Methods for handling user actions

// Handle changing of user status
- (void)userStatusButton {
    if (![PFUser currentUser]) {
        NSLog(@"Display loginviewcontroller");
        [self presentViewController:self.logInViewController animated:YES completion:nil];
    } else {
        [PFUser logOut];
        [self.userLabel setText:@"Not logged in"];
        [[self.navigationItem rightBarButtonItem] setTitle:@"Login"];
    }
    
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    // Dismiss the HPRLogInViewController
    NSString *userLabelString = [NSString stringWithFormat:
                                 @"User: %@",
                                 [user username]];
    [self.userLabel setText:userLabelString];
    [[self.navigationItem rightBarButtonItem] setTitle:@"Logout"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    // Dismiss the HPRSignUpViewController
    NSString *userLabelString = [NSString stringWithFormat:
                                 @"User: %@",
                                 [user username]];
    [self.userLabel setText:userLabelString];
    [[self.navigationItem rightBarButtonItem] setTitle:@"Logout"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Methods for populating card data

- (void)populateCardData:(NSArray *)data {
    
    if([data count] > 0) {
        if ([data count] == 1) {
            HPRItemView *card = [[HPRItemView alloc] initWithFrame:CGRectMake(40,110,240,280)];
            [card setDelegate:self];
            PFObject *curItem = [data objectAtIndex:0];
            PFFile *userImageFile = curItem[@"image"];
            [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                if (!error) {
                    // Image downloaded properly
                    card.imageView.image = [UIImage imageWithData:imageData];
                    card.tag = self.view.tag + 0;
                    card.titleLabel.text = curItem[@"brand"];
                    card.itemIdentifier = curItem.objectId;
                    [card addGestureRecognizer];
                    [self.view addSubview:card];
                }
            }];
        } else {
            for(int i = 1; i >= 0 ;i--){
                //CGRect frame = (i%2 == 0) ?CGRectMake(40,110,240,280):CGRectMake(50,100,240,280);
                //Ignore hard coding
                
                HPRItemView *card = [[HPRItemView alloc] initWithFrame:CGRectMake(40,110,240,280)];
                [card setDelegate:self];
                PFObject *curItem = [data objectAtIndex:i];
                PFFile *userImageFile = curItem[@"image"];
                [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        // Image downloaded properly
                        card.imageView.image = [UIImage imageWithData:imageData];
                        card.tag = self.view.tag + i;
                        card.titleLabel.text = curItem[@"brand"];
                        card.itemIdentifier = curItem.objectId;
                        if (i == 0) [card addGestureRecognizer];
                        [self.view addSubview:card];
                    }
                }];
            }
        }
    }else{
        //Empty datasource - Handle Accordingly
    }
}

- (void)reloadCardData:(UIButton *)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    //    query.limit = 2;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // Load objects into cardSource array and populate cards
            cardData = [objects mutableCopy];
            [self populateCardData:cardData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - Delegate methods for HPRCardView

- (void)processApproval:(BOOL)approval identifier:(NSString *)identifier cardTag:(int)cardTag {
    // Get PFObject corresponding to removed card
    PFObject *curObj;
    for (PFObject *pfo in cardData) {
        if (pfo.objectId == identifier) {
            curObj = pfo;
        }
    }
    
    // Handle approval result
    if (approval == YES) {
        // Increment like count
        NSNumber *curCount = curObj[@"likeCount"];
        NSNumber *incCount = [NSNumber numberWithInt:[curCount intValue] + 1];
        curObj[@"likeCount"] = incCount;
        [curObj saveInBackground];
    } else {
        // Increment dislike count
        NSNumber *curCount = curObj[@"dislikeCount"];
        NSNumber *incCount = [NSNumber numberWithInt:[curCount intValue] + 1];
        curObj[@"dislikeCount"] = incCount;
        [curObj saveInBackground];
    }
    
    // Remove item from source and remove than re-populate subviews
    [cardData removeObject:curObj];
    for (UIView *v in self.view.subviews) {
        if ([v isMemberOfClass:[HPRItemView class]]) {
            [v removeFromSuperview];
        }
    }
    [self populateCardData:cardData];
    
}

@end
