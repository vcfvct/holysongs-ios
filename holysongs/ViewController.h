//
//  ViewController.h
//  holysongs
//
//  Created by Li Han on 10/12/13.
//  Copyright (c) 2013 Good Trend LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *myTableView;

@end
