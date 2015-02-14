//
//  DetailProfilePhotoViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 1/16/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#import "DetailProfilePhotoViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface DetailProfilePhotoViewController ()

@property NSString* filepath;
@property (strong, nonatomic) IBOutlet UITextField *captionField;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UIButton *shareobject;

@end

@implementation DetailProfilePhotoViewController

@synthesize traditionImageView;
@synthesize traditionImageName;
@synthesize traditionImageId;
@synthesize traditionName;
@synthesize traditionImageCaption;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Photo";
    
    NSLog(@"traditionImageId = %@",traditionImageId);
    NSLog(@"traditionImageName = %@",traditionImageName);
    //self.traditionImageView.image = [UIImage imageNamed:self.traditionImageName];
    
    // show url image
    //    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.traditionImageName]];
    //    self.traditionImageView.image = [UIImage imageWithData: imageData];
    
    // Load the image with an GCD block executed in another thread
    traditionImageView.image = [UIImage imageNamed:@"iTunesArtwork.png"];
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",traditionImageName]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            //if (image)
            //{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.traditionImageView.image = image;
                });
            //}
        }
    });
    
    // change color : IOS 7 Navigation Bar text and arrow color
    // http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
