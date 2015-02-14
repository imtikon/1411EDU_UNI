//
//  LogoutViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "LogoutViewController.h"
#import "SWRevealViewController.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

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
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.title = @"Logout";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //[self refreshMyPlist];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self redirectToLogin];
    
}

-(void)redirectToLogin{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (screenHeight < 568) {
            NSLog(@"--- 4S iPhone ===");
            /*NSString * storyboardName = @"Main_4siPhone";
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
             UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
             [self presentViewController:vc animated:YES completion:nil];*/
        }else {
            NSString * storyboardName = @"Main_iPhone";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }else{
        NSLog(@"==iPad==");
        
        NSString * storyboardName = @"Main_iPad";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    
}

- (void)refreshMyPlist {
    NSError* error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"user.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"user.plist"];
    // set the variables to the values in the text fields
    NSString* userId = @"";
    NSString* userName = @"";
    NSString* userEmail = @"";
    NSString* userPic = @"";
    
    // create dictionary with values in UITextFields
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: userId, userName, userEmail, userPic, nil] forKeys:[NSArray arrayWithObjects: @"UserId", @"UserName", @"UserEmail", @"UserPic", nil]];
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    // check is plistData exists
    if(plistData)
    {
        // write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
    }
    else
    {
        NSLog(@"Error in saveData: %@", error);
    }
    // read now
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSLog(@"savedStock = %@",savedStock);
    
    NSLog(@"Logged out ...");
    UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Logout.." message:@"You need to login again to do browse." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorMessage show];
    
    [self redirectToLogin];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
