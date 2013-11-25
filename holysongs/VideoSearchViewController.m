//
//  VideoSearchViewController.m
//  holysongs
//
//  Created by Li Han on 11/9/13.
//  Copyright (c) 2013 Good Trend LTD. All rights reserved.
//

#import "VideoSearchViewController.h"

@interface VideoSearchViewController ()

@end

@implementation VideoSearchViewController

@synthesize urlString;
@synthesize searchWebView;
@synthesize activityIndicator;

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
    searchWebView.delegate = self;
    
    NSURL *url = [[NSURL alloc] initWithString: [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [searchWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma spinner
- (void)webViewDidStartLoad:(UIWebView *)searchWebView {
    
    [ activityIndicator startAnimating];
}

- (void)webView:(UIWebView *)searchWebView didFailLoadWithError:(NSError *)error {
    
    [activityIndicator stopAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)searchWebView {
    
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
}

@end
