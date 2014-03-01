//
//  HPRViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <Parse/Parse.h>
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import "HPRViewController.h"
#import "HPRItemView.h"

@interface HPRViewController ()
{
    NSMutableArray *cardData;
}
@end

@implementation HPRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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


#pragma mark - Methods for creating drawer views

- (void)openLeftDrawer
{
    
}


#pragma mark - Methods for populating card data

- (void)populateCardData:(NSArray *)data {
    
    if([data count] > 0) {
        if ([data count] == 1) {
            HPRItemView *card = [[HPRItemView alloc] initWithFrame:CGRectMake(62,130,200,240)];
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
                CGRect frame = (i%2 == 0) ?CGRectMake(62,130,200,240):CGRectMake(70,120,200,240);
                //Ignore hard coding
                
                HPRItemView *card = [[HPRItemView alloc] initWithFrame:frame];
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
