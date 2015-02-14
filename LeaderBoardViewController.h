//
//  LeaderBoardViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 11/24/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *countries;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UILabel *rankingPosition;
@property (weak, nonatomic) IBOutlet UILabel *totalPoints;
@property (weak, nonatomic) IBOutlet UIImageView *myOwnImageView;

@end
