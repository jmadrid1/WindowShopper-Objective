
#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mBannerView.backgroundColor = [UIColor darkGrayColor];

    _mBannerLabel.text = @"Great Collections This Spring!";
      
    _mMensPanelImage.image = [UIImage imageNamed: @"mens_panel.png"];
    _mWomensPanelImage.image = [UIImage imageNamed: @"womens_panel.png"];
    
    _mMensPanelImage.frame = CGRectMake(12, 174, 191, 427);
    _mWomensPanelImage.frame = CGRectMake(211, 174, 190, 427);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segueToMens:)];
    [_mMensPanelImage setUserInteractionEnabled: true];
    [_mMensPanelImage addGestureRecognizer:tap];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segueToWomens:)];
    [_mWomensPanelImage setUserInteractionEnabled: true];
    [_mWomensPanelImage addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)segueToMens:(UITapGestureRecognizer*)tap {
    [self performSegueWithIdentifier: @"mensClothingSegue" sender: self];
}

-(void)segueToWomens:(UITapGestureRecognizer*)tap {
    [self performSegueWithIdentifier: @"womensClothingSegue" sender: self];
}

@end
