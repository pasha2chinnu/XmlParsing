//
//  ViewController.m
//  Xml
//
//  Created by kvanadev5 on 14/02/17.
//  Copyright © 2017 kvanadev5. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dictDataD,marrXMLDataA,mstrXMLStringS,mdictXMLPartD;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.xmltable.delegate = self;
    self.xmltable.dataSource = self;
    [self startParsing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startParsing
{
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss#sthash.PmbJ1fKe.dpuf"]];
    xmlparser.delegate = self;
    [xmlparser parse];
    if (marrXMLDataA.count != 0) {
        [self.xmltable reloadData];
    }
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    if ([elementName isEqualToString:@"rss"]) {
        marrXMLDataA = [[NSMutableArray alloc]init];
    }
    
    if ([elementName isEqualToString:@"item"]) {
        mdictXMLPartD = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    if (!mstrXMLStringS) {
        mstrXMLStringS = [[NSMutableString alloc] initWithString:string];
    }else {
        [mstrXMLStringS appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    if ([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"pubDate"]) {
        [mdictXMLPartD setObject:mstrXMLStringS forKey:elementName];
    }
    
    if ([elementName isEqualToString:@"item"]) {
        [marrXMLDataA addObject:mdictXMLPartD];
    }
    
    mstrXMLStringS = nil;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [marrXMLDataA count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[[marrXMLDataA objectAtIndex:indexPath.row] valueForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.detailTextLabel.text = [[[marrXMLDataA objectAtIndex:indexPath.row] valueForKey:@"pubDate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return cell;
}
@end
















