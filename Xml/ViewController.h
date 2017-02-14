//
//  ViewController.h
//  Xml
//
//  Created by kvanadev5 on 14/02/17.
//  Copyright © 2017 kvanadev5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>

@property (strong, nonatomic) IBOutlet UITableView *xmltable;

@property (nonatomic, strong) NSMutableDictionary *dictDataD;
@property (nonatomic,strong) NSMutableArray *marrXMLDataA;
@property (nonatomic,strong) NSMutableString *mstrXMLStringS;
@property (nonatomic,strong) NSMutableDictionary *mdictXMLPartD;

@end

