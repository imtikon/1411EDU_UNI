//
//  ViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/21/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Welcome";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    //UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 22)];
    //statusBarView.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:14.0/255.0 blue:63.0/255.0 alpha:1.0];
    //statusBarView.textInputContextIdentifier = [UIColor whiteColor];
    //[self.navigationController.navigationBar addSubview:statusBarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
