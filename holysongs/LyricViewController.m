//
//  LyricViewController.m
//  holysongs
//
//  Created by Li Han on 10/17/13.
//  Copyright (c) 2013 Good Trend LTD. All rights reserved.
//
#import "LyricViewController.h"
#import "VideoSearchViewController.h"
#import "Reachability.h"

#define TABLEVIEW_COLOR 102/255.0

@interface LyricViewController (){
    BOOL isOpen;
}


@property (strong, nonatomic) NSArray *menuList;
@property (strong, nonatomic) NSArray *urlList;

@end
@implementation LyricViewController

@synthesize lyric;
@synthesize textView;
@synthesize songName;
@synthesize songNameLabel;
@synthesize searchView;
@synthesize searchTableView;

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
	// Set the Label text with the selected recipe
    textView.text = lyric;
    [textView flashScrollIndicators];
    songNameLabel.text = songName;
    
    self.menuList = @[@"youtube搜索", @"优酷搜索", @"土豆搜索"];
    self.urlList = @[@"http://m.youtube.com/results?q=", @"http://www.soku.com/m/y/video?q=", @"http://www.soku.com/m/t/video?q="];
    [searchTableView reloadData];

    
    UISwipeGestureRecognizer *swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openDrawer)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGestureRecognizer];
    UISwipeGestureRecognizer *swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeDrawer)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGestureRecognizer];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)menuBtn:(id)sender {
    if(isOpen){
        [self closeDrawer];
    }else{
        [self openDrawer];
    }
}

- (void)openDrawer {

    [UIView animateWithDuration:.5f animations:^{searchView.center = CGPointMake(240, 315);}];
    [self setBackgroundAlpha];
    isOpen = true;
}

- (void)closeDrawer {
    [UIView animateWithDuration:.5f animations:^{searchView.center = CGPointMake(500, 315);}];
    [self clearBackgroundAlpha];
    isOpen = false;
}

-(void)setBackgroundAlpha{
    textView.alpha = .2f;
    songNameLabel.alpha = .2f;
}

-(void)clearBackgroundAlpha{
    textView.alpha = 1.0f;
    songNameLabel.alpha = 1.0f;
}


#pragma tableview Delegtesss

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.backgroundColor = [UIColor colorWithRed:TABLEVIEW_COLOR green:TABLEVIEW_COLOR blue:TABLEVIEW_COLOR alpha:1.0];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [self.menuList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeDrawer];
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    switch (status) {
        case NotReachable:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有网络连接"
                                                            message:@"必须有wifi或者3g网络才能观看视频！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            break;
        }
        case ReachableViaWWAN:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有连接WIFI"
                                                            message:@"观看视频比较耗费流量，确定用3G继续吗？"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"继续", nil];
            [alert show];
            break;
        }
        case ReachableViaWiFi:
        {
            [self performSegueWithIdentifier:@"showVideoSearch" sender:self];
            break;
        }

    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex != alertView.cancelButtonIndex){
        [self performSegueWithIdentifier:@"showVideoSearch" sender:self];
    }
}

#pragma segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showVideoSearch"]) {
        NSIndexPath *indexPath = [self.searchTableView indexPathForSelectedRow];
        VideoSearchViewController *destViewController = segue.destinationViewController;
        NSString *url= [NSString stringWithFormat:@"%@%@", [self.urlList objectAtIndex:indexPath.row], songName];
        destViewController.urlString = url;
    }
}


//-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if(something){
//        return YES;
//    }else{
//        return NO;
//    }
//}


@end
