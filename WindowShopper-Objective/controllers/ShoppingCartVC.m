
#import "ShoppingCartVC.h"
#import "CartCell.h"
#import "CartItem.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "Reachability.h"

@interface ShoppingCartVC ()

@end

@implementation ShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mRef = [[FIRDatabase database] reference];
    
    _mCheckoutList = [NSMutableArray array];

    _mTotalItemsLabel.text = @"Total Items: 0";
    _mTotalAmountLabel.text = @"Total Amount: $0.00";
    [_mCheckoutButton setTitle: @"Proceed To Checkout" forState: normal];
    
    _mTotalItemsLabel.font = [UIFont systemFontOfSize: 17];
    _mTotalAmountLabel.font = [UIFont systemFontOfSize: 17];
    _mCheckoutButton.titleLabel.font = [UIFont boldSystemFontOfSize: 18];
    
    _mEmptyView.frame = CGRectMake(0, 121, 414, 404);
    _mEmptyImage.frame = CGRectMake(167.05, 164.56, 78, 76);
    _mCartTable.frame = CGRectMake(0, 121, 414, 404);
    _mTotalItemsLabel.frame = CGRectMake(48, 533, 111, 21);
    _mTotalAmountLabel.frame = CGRectMake(195, 533, 206, 21);
    _mCheckoutView.frame = CGRectMake(20, 598, 374, 41);
    _mCheckoutButton.frame = CGRectMake(0, 3, 374, 36);
    
    _mEmptyView.backgroundColor = [UIColor darkGrayColor];
//    _mCheckoutView.backgroundColor
//    [_mCheckoutButton setTitleColor:<#(nullable UIColor *)#> forState: normal];

    _mEmptyImage.image = [UIImage imageNamed: @"ic_empty_list.png"];
    _mEmptyView.hidden = YES;

    [_mCartTable setRowHeight: 65];
    [_mCartTable reloadData];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    
    if(userId == nil){
        
    }else{
        [self getUsersCart];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)isNetworkAvailable {
    return [[Reachability reachabilityWithHostName:@"www.google.com"] currentReachabilityStatus];
}

-(void)showNoNetworkConnectionAlert{
    if ([self isNetworkAvailable] == NotReachable) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Check Network Connection" message:@"Please check internet connection and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Ok action here
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mCheckoutList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CartCell *cell = (CartCell *)[tableView dequeueReusableCellWithIdentifier:@"cartCell"];
    CartItem *item = _mCheckoutList[indexPath.row];
    
    cell.mItemTitleLabel.text = item.title;
    
    cell.mQuantityStepper.tag = indexPath.row;
    
    [cell.mQuantityStepper addTarget:self action: @selector(quantityStepper:) forControlEvents: UIControlEventValueChanged];
    cell.mQuantityLabel.text = [NSString stringWithFormat: @"Quantity:  %d", item.quantity];
    
    int itemCount = item.quantity;
    NSString *itemCountString = [NSString stringWithFormat: @"%.2d", itemCount];
  
    double quantityDouble = [itemCountString doubleValue];
    cell.mQuantityStepper.value = quantityDouble;
    
    cell.mPriceLabel.text = [NSString stringWithFormat: @"$%.2f", item.price * quantityDouble];
    
    [cell.mItemTitleLabel sizeToFit];
    [cell.mPriceLabel sizeToFit];
    [cell.mQuantityLabel sizeToFit];
    
    return cell;
}

-(void)quantityStepper:(UIStepper *)sender{
    
    CartItem *item = _mCheckoutList[sender.tag];
    
    item.quantity = (int)sender.value;
    
    [_mCartTable reloadData];
    [self totalAmountForItems];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        [tableView setEditing: YES animated:YES];
        
        CartItem *item = _mCheckoutList[indexPath.row];
        int id = item.id;
        NSString *idString = [NSString stringWithFormat: @"%d", id];
        
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
        
        [[[[[_mRef child: @"users"] child: userId] child: @"cart"] child: idString] removeValue];
        
        [_mCheckoutList removeObjectAtIndex: indexPath.row];
        [_mCartTable deleteRowsAtIndexPaths: [NSArray arrayWithObject:indexPath] withRowAnimation: YES];
        [_mCartTable reloadData];
    }
    [self totalAmountForItems];
}


-(void)totalAmountForItems{
    
    _mTotalAmount = 0.00;
    _mTotalItems = 0;
    
    for (CartItem *item in _mCheckoutList){
        int itemCount = item.quantity;
        NSString *itemCountString = [NSString stringWithFormat: @"%.2d", itemCount];
        double itemCountDouble = [itemCountString doubleValue];
        
        _mTotalAmount += item.price * itemCountDouble;
        _mTotalItems += item.quantity;
        
        _mTotalItemsLabel.text = [NSString stringWithFormat: @"Total Items: %d", _mTotalItems];
        _mTotalAmountLabel.text = [NSString stringWithFormat: @"Total Amount: $%.2f", _mTotalAmount];
        [_mTotalAmountLabel sizeToFit];
    }
}

-(void)getUsersCart{

    _mCheckoutList.removeAllObjects;
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    
    if([self isNetworkAvailable]){
        
        [[[[_mRef child: @"users"] child: userId] child: @"cart"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            for(snapshot in snapshot.children){
            
                NSDictionary *cartDict = snapshot.value;
                
                int id = [cartDict[@"id"] intValue];
                NSString *title = cartDict[@"title"];
                NSString *priceString = cartDict[@"price"];
                double price = [priceString doubleValue];
                int quantity = [cartDict[@"quantity"] intValue];
                NSString *size = cartDict[@"size"];
                
                CartItem *item = [[CartItem alloc]init];
                item.id = id;
                item.title = title;
                item.price = price;
                item.quantity = quantity;
                item.size = size;
                
                [_mCheckoutList addObject: item];
                [_mCartTable reloadData];
                [self totalAmountForItems];
            }
        }];
    }else{
        [self showNoNetworkConnectionAlert];
    }    
}

@end
