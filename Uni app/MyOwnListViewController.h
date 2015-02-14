//
//  MyOwnListViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 1/29/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOwnListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) NSString *traditionImageName;
@property (weak, nonatomic) NSString *traditionImageId;
@property (nonatomic, strong) IBOutlet UITableView *myTableView;
-(void)closePhotoWindow;
@end
