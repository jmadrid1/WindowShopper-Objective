
#import "WomensClothingVC.h"
#import "Clothes.h"
#import "ClothesCell.h"
#import "ItemDetailVC.h"
#import "CollectionHeader.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Reachability.h"

@interface WomensClothingVC ()

@end

@implementation WomensClothingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mRef = [[FIRDatabase database] reference];
    
    _mDressesList = [NSMutableArray array];
    _mShirtsList = [NSMutableArray array];
    _mPantsList = [NSMutableArray array];
    
    _mEmptyView.frame = CGRectMake(0, 59, 414, 628);
    _mEmptyImage.frame = CGRectMake(167.95, 59, 414, 628);
    _mClothesCollection.frame = CGRectMake(0, 70, 414, 617);
    
    _mEmptyView.backgroundColor = [UIColor darkGrayColor];
    
    _mEmptyImage.image = [UIImage imageNamed: @"ic_empty_list.png"];
    _mEmptyView.hidden = YES;
    
    [self getInventory];
    [self hideTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [self hideTable];
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

-(void)hideTable{
    int itemCount = _mDressesList.count + _mShirtsList.count + _mPantsList.count;
    
    if(itemCount == 0){
        [_mClothesCollection setHidden: true];
        [_mEmptyView setHidden: false];
    }else{
        [_mClothesCollection setHidden: false];
        [_mEmptyView setHidden: true];
    }
}

-(void)filterClothes:(NSMutableArray *)clothes{
    
    for(Clothes *item in clothes){
        
        NSString *category = item.category;
        NSString *specifics = item.specifics;

        NSArray *categoryOptions = [[NSArray alloc]initWithObjects: @"dresses", @"shirts", @"pants", nil];
        
        int index = [categoryOptions indexOfObject: category];
        
        switch (index) {
                
            case 0:
                if([specifics isEqual: @"womens"]){
                    [_mDressesList addObject: item];
                }
                break;
            case 1:
                if([specifics isEqual: @"womens"]){
                    [_mShirtsList addObject: item];
                }
                break;
            case 2:
                if([specifics isEqual: @"womens"]){
                    [_mPantsList addObject: item];
                }
                break;
                
            default:
                break;
        }
    }
}

-(void)getInventory{
    
    if([self isNetworkAvailable]){
        
        NSMutableArray *containerList = [NSMutableArray array];
        
        _mDressesList.removeAllObjects;
        _mShirtsList.removeAllObjects;
        _mPantsList.removeAllObjects;
        
        [[_mRef child: @"inventory"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            for(snapshot in snapshot.children){
                
                NSDictionary *clothesDict = snapshot.value;
   
                int id = [clothesDict[@"id"] intValue];
                NSString *title = clothesDict[@"title"];
                NSString *category = clothesDict[@"category"];
                NSString *specifics = clothesDict[@"specifics"];
                NSString *summary = clothesDict[@"summary"];
                NSString *image = clothesDict[@"image"];
                NSString *price = clothesDict[@"price"];
                NSDictionary *size = clothesDict[@"sizes"];
                
                double priceDouble = [price doubleValue];
                
                Clothes *item = [[Clothes alloc]init];
                item.id = id;
                item.title = title;
                item.summary = summary;
                item.category = category;
                item.specifics = specifics;
                item.image = image;
                item.price = priceDouble;
                item.sizes = size;
                
                [containerList addObject: item];
                
                [self filterClothes: containerList];
                
                containerList.removeAllObjects;
                
                [_mClothesCollection reloadData];
            }
        }];
    }else{
        [self showNoNetworkConnectionAlert];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier: @"collectionHeader" forIndexPath: indexPath];
    
    switch (indexPath.section) {
        case 0:
            header.mTitle.text = @"Dresses";
            [header.mTitle sizeToFit];
            break;
        case 1:
            header.mTitle.text = @"Shirts";
            break;
        case 2:
            header.mTitle.text = @"Pants";
            break;
            
        default:
            break;
    }
    return header;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ClothesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"clothesCell" forIndexPath: indexPath];
    
    Clothes *item = [[Clothes alloc]init];
    
    switch (indexPath.section) {
        case 0:
            item = _mDressesList[indexPath.row];
            break;
        case 1:
            item = _mShirtsList[indexPath.row];
            break;
        case 2:
            item = _mPantsList[indexPath.row];
            break;
            
        default:
            break;
    }
    
    NSString *url = item.image;
    [cell.mClothesImage sd_setImageWithURL:[NSURL URLWithString: url] placeholderImage: [UIImage imageNamed: @"placeholder.png"]];
    
    cell.mTitleLabel.text = item.title;
    [cell.mTitleLabel sizeToFit];
    cell.mTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    double price = item.price;
    cell.mPriceLabel.text = [NSString stringWithFormat: @"%.2f", price];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return _mDressesList.count;
        case 1:
            return _mShirtsList.count;
        case 2:
            return _mPantsList.count;
            
        default:
            break;
    }
    return _mDressesList.count + _mShirtsList.count + _mPantsList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Clothes *item = [[Clothes alloc]init];
    
    switch (indexPath.section) {
        case 0:
            item = _mDressesList[indexPath.row];
            break;
        case 1:
            item = _mShirtsList[indexPath.row];
            break;
        case 2:
            item = _mPantsList[indexPath.row];
            break;
            
        default:
            break;
    }
    [self performSegueWithIdentifier:@"itemDetailSegue" sender: item];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"itemDetailSegue"]){
        ItemDetailVC *vc = segue.destinationViewController;
        vc.mSelectedItem = (Clothes *) sender;
    }
}
@end
