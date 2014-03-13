//
//  HPRTableViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 3/2/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRTableViewController.h"

@interface HPRTableViewController ()

@end

@implementation HPRTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // This table displays items in the Item class
        self.parseClassName = @"Item";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 10;
    }
    return self;
}

- (PFQuery *)queryForTable {
    
    NSArray *userLikedItems = [[PFUser currentUser] objectForKey:@"likedItems"];
    NSMutableArray *userLikedItemsIds = [[NSMutableArray alloc] init];
    for (PFObject *obj in userLikedItems) {
        [userLikedItemsIds addObject:[obj objectId]];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"objectId" containedIn:userLikedItemsIds];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    static NSString *identifier = @"Cell";
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = object[@"brand"];
    
    PFFile *thumbnail = object[@"image"];
    cell.imageView.file = thumbnail;
    return cell;
}

@end
