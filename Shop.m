//
//  Shop.m
//  MyShopWork
//
//  Created by Liliia Shlikht on 3/15/15.
//  Copyright (c) 2015 Liliia Shlikht. All rights reserved.
//

#import "Shop.h"
@interface Shop ()
@end

@implementation Shop


-(id)copyWithZone:(NSZone *)zone
{
    Shop *copy = [[ Shop allocWithZone:zone] init];
    copy.dictFromJSON = [self.dictFromJSON copy];
    copy.arrayOfObjects = [[NSMutableArray alloc] initWithArray:self.arrayOfObjects copyItems:YES];
    return copy;
}

- (id) init {
    self = [super init];
    if (self) {
        self.dictFromJSON = [NSMutableDictionary dictionary];
        self.arrayOfNames = [NSMutableArray array];
        self.arrayOfPrices = [NSMutableArray array];
        self.dict = [NSMutableDictionary dictionary];
        self.arrayOfObjects = [NSMutableArray array];
        
        self.name = [NSString string];
        self.price = [NSString string];;
        self.idOfGoods = [NSString string];;
    }
    return self;
}



- (void) takeDataFromJSONFile:(id)JSON {
    
    NSLog(@"Step into takeDataFromJSONFile");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"JSONFile.json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    NSData *data;
    if ([fileManager fileExistsAtPath:fullPath]) {
        data = [NSData dataWithContentsOfFile:fullPath];
        if(NSClassFromString(@"NSJSONSerialization")) {
            id object = [NSJSONSerialization JSONObjectWithData: data options:0 error:&error];
            if(error) {
                NSLog(@"error: %@", error.localizedDescription);
                return;
            }
            if([object isKindOfClass:[NSDictionary class]])
            {
                self.dictFromJSON = object;
            }
            NSLog(@"file exist");
            return;
        }
    } else {
        data =[NSData dataWithContentsOfFile:JSON];
        if ([fileManager createFileAtPath:fullPath contents:data attributes:nil]) {
            NSLog(@"File created");
            [self takeDataFromJSONFile:JSON];
        }
    }
    
}

- (void) setName:(NSString *)name andPrice: (NSString *) price andIdOfGoods: (NSString *) idOfGoods {
    _name = name;
    _price = price;
    _idOfGoods = idOfGoods;
}


- (NSMutableDictionary *)objectWithData {
    NSMutableDictionary *allData = [NSMutableDictionary dictionaryWithObjectsAndKeys: self.name, @"nameOfGoods", self.price, @"price", self.idOfGoods, @"idOfGoods", nil];
    self.dict = allData;
    return self.dict;
}
@end
