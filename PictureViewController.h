//
//  PictureViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PictureViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *myPhoto;
@property (strong, nonatomic) IBOutlet UILabel *myName;
@property (strong, nonatomic) IBOutlet UILabel *myBio;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end
