//
//  ViewController.h
//  Scroll Text
//
//  Created by Isaac Godfried on 2/28/13.
//  Copyright (c) 2013 Isaac Godfried. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{UIScrollView *_scrollView;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *temp;
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UIButton *myButton;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,retain) NSMutableData*weatherInfo;
-(IBAction)changePage;
@end
