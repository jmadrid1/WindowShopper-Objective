
#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mBannerView.backgroundColor = [UIColor blackColor];

    _mBannerLabel.text = @"Great Collections This Spring!";
      
    _mMensPanelImage.image = [UIImage imageNamed: @"ic_mens_panel.png"];
    _mWomensPanelImage.image = [UIImage imageNamed: @"ic_womens_panel.png"];
    
    [_mMensPanelImage setOpaque:false];
    [_mMensPanelImage setAlpha: 0.5];
    
    [_mWomensPanelImage setOpaque:false];
    [_mWomensPanelImage setAlpha: 0.5];
    

    [_mMensButton setTitle: @"MENS" forState: UIControlStateNormal];
    [_mMensButton setBackgroundColor: [UIColor colorWithRed: 0 green: 0.9768045545 blue:0 alpha: 1]];
    _mMensButton.layer.cornerRadius = 15;
    _mMensButton.layer.borderWidth = 0;
    
    [_mWomensButton setTitle: @"WOMENS" forState: UIControlStateNormal];
    [_mWomensButton setBackgroundColor: [UIColor colorWithRed: 0 green: 0.9768045545 blue:0 alpha: 1]];
    _mWomensButton.layer.cornerRadius = 15;
    _mWomensButton.layer.borderWidth = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)mensButtonTap {
    [self performSegueWithIdentifier: @"mensClothingSegue" sender: self];
}

-(IBAction)womensButtonTap {
    [self performSegueWithIdentifier: @"womensClothingSegue" sender: self];
}


@end
