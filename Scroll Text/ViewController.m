//
//  ViewController.m
//  Scroll Text
//
//  Created by Isaac Godfried on 2/28/13.
//  Copyright (c) 2013 Isaac Godfried. All rights reserved.
//
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{   _myButton=[[UIButton alloc]init];
    [super viewDidLoad];
    _scrollView.frame = CGRectMake(0, 100, 320, 100);
    // then define how much they can scroll it
    [_scrollView setContentSize:CGSizeMake(960, 100)];
    [self scrollViewDidScroll:_scrollView];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:
                                [NSURL URLWithString:@"http://api.wunderground.com/api/eae1e849db26ed92/conditions/q/ME/Orono.json"]];
    NSURLConnection *theConnection=[[NSURLConnection alloc]
                                    initWithRequest:theRequest delegate:self];
    if(theConnection){
        _weatherInfo = [[NSMutableData alloc] init];
    } else {
        NSLog(@"failed");
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.pageControl.currentPage = page;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_weatherInfo setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_weatherInfo appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *msg = [NSString stringWithFormat:@"Failed: %@", [error description]];
    NSLog(@"%@",msg);
}

//All the data was loaded, let's see what we've got...
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:_weatherInfo options:NSJSONReadingMutableLeaves  error:&myError];
    NSArray *results =  [res objectForKey:@"current_observation"];
    NSString *cur = [results valueForKey:@"weather"];
    NSString *tmp = [results valueForKey:@"temp_f"];
    NSString*imgUrl=[results valueForKey:@"icon_url"];
    NSLog(@"Current conditions: %@, %@º", cur, tmp);
    NSURL*weatherIcon=[NSURL URLWithString:imgUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:weatherIcon];
    UIImage * image = [UIImage imageWithData:imageData];
    _image.image=image;
    _temp.text=cur;
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_image release];
    [_temp release];
    [_scrollView release];
    [_myButton release];
    [_pageControl release];
[super dealloc];
}
@end
