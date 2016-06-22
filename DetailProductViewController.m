//
//  DetailProductViewController.m
//  MyShopWork
//
//  Created by Liliia Shlikht on 4/5/15.
//  Copyright (c) 2015 Liliia Shlikht. All rights reserved.
//

#import "DetailProductViewController.h"
#import "Shop.h"

@interface DetailProductViewController ()
@property (weak, nonatomic) IBOutlet UIButton *returnToMainList;
- (IBAction)actionReturnToMainList:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *pictureBig;


@end

@implementation DetailProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:(arc4random() %256)/255.0 green:(arc4random() %256)/255.0  blue:(arc4random() %256)/255.0  alpha:1.0]];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.name.text = [self.currentShop objectForKey:@"names"];
    self.pictureBig.image =[UIImage imageNamed:[self.currentShop objectForKey:@"picB"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionReturnToMainList:(id)sender {
    // [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
