//
//  WritePostViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-21.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDao.h"
@interface WritePostViewController : UIViewController<CommunityDaoDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    CommunityDao *communityDao;
    NSMutableArray *imageArray;
}
- (IBAction)backAction:(id)sender;

- (IBAction)createAction:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *textField;
@property (retain, nonatomic) IBOutlet UITextView *textView;

- (IBAction)addImageAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *imageScrollView;

@end
