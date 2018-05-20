
#import "ItemReviewsVC.h"
#import "ReviewCell.h"
#import "Review.h"
#import "AddReviewVC.h"
#import "Reachability.h"

@interface ItemReviewsVC ()

@end

@implementation ItemReviewsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _mRef = [[FIRDatabase database] reference];
    
   _mReviewsList = [NSMutableArray array];
    
    _mReviewsTable.frame = CGRectMake(0, 64, 414, 630);
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    
    if(userId == nil){
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        self.navigationItem.rightBarButtonItem = _mAddBarItem;
    }
    
    NSInteger id = _mSelectedItem.id;
    [self getReviewsForItemByDate: id];
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

-(void)hideTable{
    if(_mReviewsList.count == 0){
        [_mReviewsTable setHidden: true];
    }else{
        [_mReviewsTable setHidden: false];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"itemDetailSegue" sender: _mReviewsList[indexPath.row]];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ReviewCell *cell = (ReviewCell *)[tableView dequeueReusableCellWithIdentifier:@"reviewCell"];
    
    Review *review = _mReviewsList[indexPath.row];

    cell.mDateLabel.font = [UIFont systemFontOfSize: 14];
    cell.mCommentTextView.font = [UIFont systemFontOfSize: 14];
    
    cell.mDateLabel.frame = CGRectMake(297, -1, 85, 21);
    cell.mCommentTextView.frame = CGRectMake(13, 7, 401, 85);
    
    cell.mDateLabel.text = review.date;
    cell.mCommentTextView.text = review.comment;
    
//    cell.mRatingScale.rating = review.rating;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mReviewsList.count;
}

-(void)getReviewsForItemByDate:(NSInteger *)id {
    
    NSString *idString = [NSString stringWithFormat: @"%d", id];

    NSMutableArray *containerList = [NSMutableArray array];
    
    if([self isNetworkAvailable]){
        
        [[[[[_mRef child: @"inventory"] child: idString] child:@"reviews"] queryOrderedByChild: @"date"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            for(snapshot in snapshot.children){
                
                NSDictionary *reviewDict = snapshot.value;
                
                int id = [reviewDict[@"id"]intValue];
                NSString *comment = reviewDict[@"comment"];
                //            NSInteger *rating = reviewDict[@"rating"];
                NSString *date = reviewDict[@"specifics"];
                
                Review *review = [[Review alloc]init];
                
                review.id = id;
                review.comment = comment;
                //            review.rating = rating;
                review.date = date;
                
                [_mReviewsList addObject: review];
                [_mReviewsTable reloadData];
            }
        }];
    }else{
        [self showNoNetworkConnectionAlert];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addReviewSegue"]){
        AddReviewVC *vc = segue.destinationViewController;
        vc.mItemId = _mSelectedItem.id;
    }
}

@end
