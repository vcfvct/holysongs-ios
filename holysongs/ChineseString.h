//
//  ChineseString.h
//  holysongs
//
//  Created by Li Han on 10/20/13.
//  Copyright (c) 2013 Good Trend LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseString : NSObject

@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;

+(void) pinyinSort:(NSMutableArray *)newArray;

@end
