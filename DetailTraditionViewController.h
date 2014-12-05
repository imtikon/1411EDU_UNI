//
//  DetailTraditionViewController.h
//  SliderMenu
//
//  Created by Imtiaz Hossain on 11/23/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTraditionViewController : UIViewController

    @property(strong) UIImage *img;
    @property (weak, nonatomic) IBOutlet UIImageView *traditionImageView;
    @property (weak, nonatomic) NSString *traditionImageName;
    @property (weak, nonatomic) NSString *traditionImageId;

    - (IBAction)closeView:(id)sender;

@end
