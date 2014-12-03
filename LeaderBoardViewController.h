//
//  LeaderBoardViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 11/24/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardViewController : UIViewController

@property (nonatomic,strong) NSMutableArray *countries;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
