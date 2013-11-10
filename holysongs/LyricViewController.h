//
//  LyricViewController.h
//  holysongs
//
//  Created by Li Han on 10/17/13.
//  Copyright (c) 2013 Good Trend LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LyricViewController : UIViewController <UITableViewDataSource, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSString *lyric;
@property (nonatomic, strong) NSString *songName;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

- (IBAction)menuBtn:(id)sender;

@end
