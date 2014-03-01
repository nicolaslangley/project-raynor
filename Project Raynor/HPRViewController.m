//
//  HPRViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRViewController.h"
#import "HPRCardView.h"

@interface HPRViewController ()
{
    NSMutableArray *cardSource;
}
@end

@implementation HPRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Populate card source
    cardSource = [@[@"red_shirt",
                    @"black_shirt"]mutableCopy];
    [self populateCardStack:cardSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateCardStack:(NSArray *)data {
    
    if([data count] > 0) {
        if ([data count] == 1) {
            HPRCardView *card = [[HPRCardView alloc] initWithFrame:CGRectMake(62,130,200,240)];
            [card setDelegate:self];
            card.imageView.image = [UIImage imageNamed:[cardSource objectAtIndex:0]];
            card.tag = self.view.tag + 0;
            card.titleLabel.text = [cardSource objectAtIndex:0];
            [card addGestureRecognizer];
            [self.view addSubview:card];
        } else {
            for(int i = 1; i >= 0 ;i--){
                CGRect frame = (i%2 == 0) ?CGRectMake(62,130,200,240):CGRectMake(70,120,200,240);
                //Ignore hard coding
                
                HPRCardView *card = [[HPRCardView alloc] initWithFrame:frame];
                
                [card setDelegate:self];
                card.imageView.image = [UIImage imageNamed:[cardSource objectAtIndex:i]];
                card.tag = self.view.tag + i;
                card.titleLabel.text = [cardSource objectAtIndex:i];
                
                // Add gesture recognizer to top card
                if(i == 0) {
                    [card addGestureRecognizer];
                }
                [self.view addSubview:card];
            }
        }
    }else{
        //Empty datasource - Handle Accordingly
    }
}

#pragma mark - Delegate methods for HPRCardView

- (void)processAction:(BOOL)result title:(NSString *)title cardTag:(int)cardTag {
    // Remove card from array and repopulate stack
    // TODO: Process information based on approval for item with title
    
    // Remove item from source and remove than re-populate subviews
    [cardSource removeObject:title];
    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self populateCardStack:cardSource];
    
}

@end
