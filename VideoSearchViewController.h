//
//  VideoSearchViewController.h
//  holysongs
//
//  Created by Li Han on 11/9/13.
//  Copyright (c) 2013 Good Trend LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoSearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *searchWebView;
@property (nonatomic, strong) NSString *urlString;

@end
