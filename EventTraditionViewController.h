//
//  EventTraditionViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 1/24/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTraditionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) NSString *traditionImageName;
@property (weak, nonatomic) NSString *traditionImageId;
@property (weak, nonatomic) NSString *traditionDescription;
@property (nonatomic, strong) IBOutlet UITableView *myTableView;

@end
