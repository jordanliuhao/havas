//
//  PostDetailViewController.h
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

#import <UIKit/UIKit.h>

@interface PostDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *upsLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoHeight;

@end

