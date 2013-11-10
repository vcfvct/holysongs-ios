//
//  ViewController.m
//  holysongs
//
//  Created by Li Han on 10/12/13.
//  Copyright (c) 2013 Good Trend LTD. All rights reserved.
//

#import "ViewController.h"
#import "LyricViewController.h"
#import "GDataXMLNode.h"
#import "pinyin.h"
#import "POAPinyin.h"
#import "ChineseString.h"

@interface ViewController ()
@end

@implementation ViewController{
    NSMutableArray *songTitles;
    NSMutableDictionary *sectionDic;
    NSMutableDictionary *lyricDic;
}


@synthesize myTableView;

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    songTitles = [[NSMutableArray alloc] init];
    lyricDic = [[NSMutableDictionary alloc] init];
    sectionDic = [[NSMutableDictionary alloc] init];
   
    //set up the section chars
    for (int i = 0; i < 26; i++){
        [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
    }
    [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
    
    //获取工程目录的xml文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"songs" ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //使用NSData对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    
    //获取根节点（songs）
    GDataXMLElement *rootElement = [doc rootElement];
    
    //获取根节点下的节点（User）
    NSArray *songs = [rootElement elementsForName:@"song"];
    
    for (GDataXMLElement *song in songs) {
        //获取歌名和歌词
        GDataXMLElement *nameElement= [[song elementsForName:@"name"] objectAtIndex:0];
        NSString *name = [nameElement stringValue];
        GDataXMLElement *lyricElement= [[song elementsForName:@"lyric"] objectAtIndex:0];
        NSString *lyric = [lyricElement stringValue];
        [songTitles addObject:name];
        [lyricDic setObject:lyric forKey:name];
        
        char first = pinyinFirstLetter([name characterAtIndex:0]);
        NSString *sectionName;
        if ((first>='a'&&first<='z')||(first>='A'&&first<='Z')) {
            sectionName = [[NSString stringWithFormat:@"%c",first] uppercaseString];
        }
        else {
            sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
        }
        [[sectionDic objectForKey:sectionName] addObject:name];
    }
    
    for (id key in sectionDic) {
        NSMutableArray *songNames = [sectionDic objectForKey:key];
        [ChineseString pinyinSort:songNames];
    }
    
}

//NSInteger pinyinSort(NSString *s1, NSString *s2, void *context){
//    return [s2 localizedCompare:s1];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - table view
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
    for (int i = 0; i < 27; i++)
        [indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
    return indices;
    
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return  [ALPHA rangeOfString:title].location;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 27;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:section]];
    return  [[sectionDic objectForKey:key] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:section]];
    return key;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SongItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:indexPath.section]];
    NSMutableArray *songNames=[sectionDic objectForKey:key];
    NSString *name =[songNames objectAtIndex:indexPath.row];
    cell.textLabel.text =  name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        LyricViewController *destViewController = segue.destinationViewController;
        NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:indexPath.section]];
        NSMutableArray *songNames=[sectionDic objectForKey:key];
        NSString *name =[songNames objectAtIndex:indexPath.row];
        destViewController.lyric = [lyricDic objectForKey:name];
        destViewController.songName = name;
    }
}

@end
