//
//  ViewController.m
//  MyShopWork
//
//  Created by Liliia Shlikht on 3/14/15.
//  Copyright (c) 2015 Liliia Shlikht. All rights reserved.
//

#import "ViewController.h"
#import "CustomCellTableViewCell.h"
#import "Shop.h"
#import "DetailProductViewController.h"
#import "SaveViewController.h"

@interface ViewController () {
    IBOutlet UITableView *table;
}

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSDictionary *thumbnails;
@property (nonatomic, strong) NSMutableArray *arrayOfUrlStrings;
@property (nonatomic, strong) NSAttributedString * detailTextLabel;
@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) NSMutableArray *resultArray2;
@property (nonatomic, strong) NSDictionary *dictFromSQL;

- (IBAction)saveToSQL:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [table setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    Shop *shop = [[Shop alloc] init];
    NSString *file2 = [[NSBundle mainBundle] pathForResource:@"JSONFile" ofType:@"json"];
    [shop takeDataFromJSONFile:file2];
    shop.dictFromJSON = [shop.dictFromJSON copy];
    
    NSMutableArray *idOfGoods = [[NSMutableArray alloc] initWithArray:[shop.dictFromJSON objectForKey:@"idOfGoods"]];
    NSMutableArray *names = [[NSMutableArray alloc] initWithArray:[shop.dictFromJSON objectForKey:@"nameOfGoods"]];
    NSMutableArray *price = [[NSMutableArray alloc] initWithArray:[shop.dictFromJSON objectForKey:@"price"]];
    
    
    SaveViewController *saveViewController = [[SaveViewController alloc] init];
//    [saveViewController prepareDB];
    [saveViewController takeDataFromSQLite];
//    [saveViewController prepareOperationQueue];
    NSLog(@"It's SQLiteFirst: %@", saveViewController.resultArray);
    self.resultArray2 = saveViewController.resultArray;
    NSLog(@"It's SQLite: %@", self.resultArray2);
    
    
    NSArray *picturesBiggerSize = @[@"ice-cream.jpg", @"chocolate.jpg", @"candy.jpg", @"yogurt.jpg", @"gum.jpg", @"coffee.jpg", @"tea.jpg", @"cake.jpg", @"jelly.jpg", @"cupcake.jpg"];
    
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < names.count; i++) {
        NSDictionary *goods = @{
                                @"names" : names[i],
                                @"picB" : picturesBiggerSize[i],
                                @"prices" : price[i],
                                };
        [data addObject:goods];
    }
    self.tableData = data;
    UINib *nib = [UINib  nibWithNibName:@"CustomCellTableViewCell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cellIdentifier"];
    
    
    for (int i = 0; i < 10; i++) {
        [shop setName:names[i] andPrice:price[i] andIdOfGoods:idOfGoods[i]];
        [shop objectWithData];
        [shop.arrayOfObjects addObject:shop.dict];
    };
    NSMutableArray *copyOfArrayOfObjects = [shop.arrayOfObjects copy];
    NSLog (@"%@", copyOfArrayOfObjects);
    
    self.thumbnails = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"http://www.hotelmargareth.com/uploads/offerte/resize_small/211_anteprima.jpg",
                       @"0",
                       @"http://www.fhits.com.br/media/images/posts/16-chocolate.png",
                       @"1",
                       @"http://a2.l3-images.myspacecdn.com/profile01/144/856489733ef64db6b08abdf8f1970753/t.jpg",
                       @"2",
                       @"http://p14.metroflog.net/pictures/thumbnails/587/71/8/1065871587_VKUDPHEIEIAFULM.jpg",
                       @"3",
                       @"http://mediamall.ge/timthumb.php?src=upload_ge/133926.png&w=150&h=100&mt=1423210311",
                       @"4",
                       @"http://uralnuts.ru/img/icon5.png",
                       @"5",
                       @"http://indianvegetarianrecipes.net/wp-content/uploads/2013/05/Black-Tea-64x64.jpg",
                       @"6",
                       @"http://www.waltsfoods.com/images/CherryCake.png",
                       @"7",
                       @"http://www.fondosytemas.com/wp-content/plugins/WPRPT/resize.php?size=bcZ5qNP&url=e%3BI%3AEex%5E3lyI+!38Y%7B%3C%5E%25Vl0YF*oU%3Db)iK%3C%7CnLUGJ(1LkT%3C%40FAQ(K%3Chyg6d6%2BP%3E%603iL!%2B0R)5iiSgdsn!3%3B~%3DJW",
                       @"8",
                       @"http://media.appypie.com/appicon/usr_1418061077_icon.jpg",
                       @"9",
                       nil
                       ];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.parse.com/1/classes/Goods"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"kcxCuSbMAEAwi1OH0BuSCRALkg2cIfIxDdpcH3PI" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request setValue:@"zS5rkl9quQ9H7P9ljfpX4j2sgdptfB5Tjgnmubvp" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"error: %@", connectionError);
        } else {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
           // NSLog(@"%@", dict);
            self.products = dict[@"results"];
            [table reloadData];
        }
    }];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DetailProductViewController *dpvs = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductViewController"];
//    dpvs.currentShop = [self.tableData objectAtIndex: indexPath.row];
//    [self.navigationController pushViewController:dpvs animated:YES];
//    SaveViewController *dpvs = [self.storyboard instantiateViewControllerWithIdentifier:@"SaveViewController"];
//    dpvs.dictFromSQL = [self.tableData objectAtIndex: indexPath.row];
//    [self.navigationController pushViewController:dpvs animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.tableData.count;
//    return self.products.count;
    return self.resultArray2.count;
}

- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    return [NSString stringWithFormat:@"Title %li", (long) section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    CustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (cell == nil) {
        cell =[[CustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //  NSDictionary *goods = self.tableData[indexPath.row];
    //    cell.leftLabel.text = goods[@"name"];
    //    cell.rightLabel.text = goods[@"price"];
    
//    cell.leftLabel.text = [[self.products objectAtIndex:indexPath.row] objectForKey:@"name"];
//    cell.rightLabel.text = [[self.products objectAtIndex:indexPath.row] objectForKey:@"price"];
    cell.leftLabel.text = [[self.resultArray2 objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.rightLabel.text = [[self.resultArray2 objectAtIndex:indexPath.row] objectForKey:@"price"];
    
    NSMutableString *urlString = [[NSMutableString alloc] init];

    NSString *key = [NSString stringWithFormat:@"%li", (long)indexPath.row];
    urlString = [self.thumbnails objectForKey:key];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *documentsDirectory = [paths objectAtIndex:0];
    // NSLog(@"%@", documentsDirectory);
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", key]];
    
    if ([fileManager fileExistsAtPath:fullPath]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullPath];
            cell.icon.image  = img;
        });
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSMutableData *d = [NSMutableData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            [fileManager createFileAtPath:fullPath contents:d attributes:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *img = [[UIImage alloc] initWithContentsOfFile:fullPath];
                cell.icon.image  = img;
            });
        });
    }
    
    return cell;
}

- (IBAction)saveToSQL:(id)sender {
}
@end
