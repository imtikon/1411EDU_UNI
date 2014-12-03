//
//  LeaderBoardViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/24/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "LeaderBoardViewController.h"
#import "SWRevealViewController.h"

@interface LeaderBoardViewController ()

@end

@implementation LeaderBoardViewController

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
    self.countries = [[NSMutableArray alloc] init];
	
	NSArray *countriesInEurope = @[@"France",@"Spain",@"Germany",@"Great Britain", @"Italy", @"Portugal",@"Japan", @"China",@"India",@"Indonesia",@"Argentinia", @"Brasil",@"Chile"];
    NSDictionary *europeCountriesDict = @{@"countries" : countriesInEurope};
    //NSArray *countriesinAsia = @[@"Japan", @"China",@"India",@"Indonesia"];
    //NSDictionary *asiaCountriesDict = @{@"countries" : countriesinAsia};
	//NSArray *countriesinSouthAmerica = @[@"Argentinia", @"Brasil",@"Chile"];
	//NSDictionary *southAmericaCountriesDict = @{@"countries" : countriesinSouthAmerica};
	
	[self.countries addObject:europeCountriesDict];
	//[self.countries addObject:asiaCountriesDict];
	//[self.countries addObject:southAmericaCountriesDict];
    
    // Do any additional setup after loading the view.
    self.title = @"Leader Board View";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSDictionary *dictionary = self.countries[section];
	NSArray *array = dictionary[@"countries"];
	return [array count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.countries count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	NSDictionary *dictionary = self.countries[indexPath.section];
	NSArray *array = dictionary[@"countries"];
	NSString *cellvalue = array[indexPath.row];
	
	cell.textLabel.text = cellvalue;
	
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
								 CGRectMake(0, 0, tableView.frame.size.width, 50.0)];
    sectionHeaderView.backgroundColor = [UIColor cyanColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(15, 15, sectionHeaderView.frame.size.width, 25.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:20.0]];
    [sectionHeaderView addSubview:headerLabel];
    
    switch (section) {
        case 0:
            headerLabel.text = @"Ranking \n Total Points 500 pts";
            return sectionHeaderView;
            break;
        /*case 1:
            headerLabel.text = @"Asia";
            return sectionHeaderView;
            break;
        case 2:
            headerLabel.text = @"South America";
            return sectionHeaderView;
            break;*/
        default:
            break;
    }
    
    return sectionHeaderView;
}

/*- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIImage *myImage = [UIImage imageNamed:@"gradient.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
	imageView.frame = CGRectMake(10,10,1,30);
	
	return imageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 30.0f;
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 50.0f;
}

@end
