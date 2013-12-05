//
//  WritePinglunViewController.h
//  LeYiKao
//
//  Created by athudong on 13-11-12.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDao.h"
@interface WritePinglunViewController : UIViewController<CommunityDaoDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CommunityDao *communityDao;
    NSData *imageData;
}
- (IBAction)backAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UITextView *textView;
- (IBAction)fabiaoAction:(id)sender;
- (IBAction)imageAction:(id)sender;
@property(retain,nonatomic)NSString *postId;
@end
