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
    
    NSURL *url = [[NSURL alloc] initWithString: [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [searchWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
