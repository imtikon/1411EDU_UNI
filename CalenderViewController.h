//
//  CalenderViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalenderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic,strong) NSMutableArray *countries;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(void)closePhotoWindow;
@end
