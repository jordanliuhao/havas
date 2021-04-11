//
//  PostDetailViewController.m
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

#import "PostDetailViewController.h"
#import "Havas-Swift.h"

@interface PostDetailViewController () <PostDetailRouter, PostDetailView>

@end

@implementation PostDetailViewController {
    PostDetailPresenter* _presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _presenter = [[PostDetailPresenter alloc] initWithView: self router: self];
    [_presenter bindView];
}

- (void)showPostDetail:(PostDetail *)post {
    _upsLabel.text = post.ups;
    _titleLabel.text = post.title;
    if (post.image != nil) {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: post.image.url]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                self.photoImageView.image = [UIImage imageWithData: data];
                self.photoHeight.constant = (CGFloat)((int)(self.photoImageView.bounds.size.width) * post.image.height / post.image.width);
                
            });
        });
    } else {
        _photoHeight.constant = 0;
    }
    _bodyLabel.text = post.body;
    _commentsLabel.text = post.comments;
}

@end
