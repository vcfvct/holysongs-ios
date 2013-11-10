//
//  ChineseString.m
//  holysongs
//
//  Created by Li Han on 10/20/13.
//  Copyright (c) 2013 Good Trend LTD. All rights reserved.
//
/*
 this class is a pojo with chinese char string and its pinyin string
 a sort method is also provided here. 
 
 One thing to improve is chinese char with the same pinyin is not well sorted. Need something like google's local collation to fix it.
 */

#import "ChineseString.h"
#import "POAPinyin.h"

@implementation ChineseString

@synthesize string;
@synthesize pinYin;

+(void)pinyinSort:(NSMutableArray *)newArray{
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[newArray count];i++){
        ChineseString *chineseString=[[ChineseString alloc]init];
        chineseString.string=[NSString stringWithString:[newArray objectAtIndex:i] ];
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        if(![chineseString.string isEqualToString:@""]){
            //get pinyin for the Chinese string
            chineseString.pinYin = [POAPinyin quickConvert:chineseString.string];
        }else{
            chineseString.pinYin=@"";
        }
        [chineseStringsArray addObject:chineseString];
    }
   
    //按照拼音字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin"ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    [newArray removeAllObjects];
    for(int i=0;i<[chineseStringsArray count];i++){
        [newArray addObject:((ChineseString*)[chineseStringsArray objectAtIndex:i]).string];
    }
}


@end
