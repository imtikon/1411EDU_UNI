//
//  DetailTraditionViewController.m
//  SliderMenu
//
//  Created by Imtiaz Hossain on 11/23/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "DetailTraditionViewController.h"

@implementation DetailTraditionViewController

@synthesize traditionImageView;
@synthesize traditionImageName;
@synthesize traditionImageId;
@synthesize traditionName;
@synthesize traditionImageCaption;

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
    self.traditionImageView.image = [UIImage imageNamed:self.traditionImageName];//traditionImageName;
    NSLog(@"traditionImageId = %@",traditionImageId);
    NSLog(@"traditionImageName = %@",traditionImageName);
    self.traditionName.text = traditionImageName;
    
    // Do any additional setup after loading the view.
    self.traditionImageCaption.delegate = self;
    self.traditionImageCaption.tag = 31;
    self.traditionImageCaption.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 31:
            self.traditionImageCaption.backgroundColor = [UIColor clearColor];
        default:
            break;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch (textField.tag) {
        case 31:
            [textField resignFirstResponder];
            break;
        default:
            break;
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 31:
            break;
        default:
            break;
    }
}

@end
