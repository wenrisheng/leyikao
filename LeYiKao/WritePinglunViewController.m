//
//  WritePinglunViewController.m
//  LeYiKao
//
//  Created by athudong on 13-11-12.
//  Copyright (c) 2013年 athudong. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "WritePinglunViewController.h"
#import "UIAlertView+customShow.h"
@interface WritePinglunViewController ()

@end

@implementation WritePinglunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        communityDao=[[CommunityDao alloc] init];
        communityDao.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [imageData release];
    [_postId release];
    [_textView release];
    [_imageView release];
    [super dealloc];
}
#pragma mark - CommunityDaoDelegate
-(void)createFaTieWithUPCSuc:(id)value{
    [UIAlertView showWithTitle:nil message:@"评论成功" time:2];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createFaTieWithUPCFail:(NSError *)error{
    [UIAlertView showWithTitle:nil message:@"评论失败" time:2];

}
- (IBAction)fabiaoAction:(id)sender {
    NSString *content=_textView.text;
    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    if (userId==nil) {
         [UIAlertView showWithTitle:nil message:@"请先登陆" time:2];
    }else{
        if (content&&content.length>0) {
            
            if (imageData==nil) {
                NSLog(@"imageData ==nil");
            }
            [communityDao createPinglunWithUserId:userId postId:_postId content:content image:imageData];
        }else{
            [UIAlertView showWithTitle:nil message:@"评论内容不能为空" time:2];
        }
        
    }
   
}

- (IBAction)imageAction:(id)sender {
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate=self;
 //   picker.allowsEditing=YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}
#pragma mark - uiimagepickercontroller
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    _imageView.image=image;
    @try{
        imageData=[UIImagePNGRepresentation(image) retain];
    }
    @catch(NSException *exception){
        @try{
            imageData=UIImageJPEGRepresentation(image, 1.0);
        }@catch(NSException *exception){
            [UIAlertView showWithTitle:nil message:@"图片格式转换错误" time:2];
            
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];

    
  }
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
       UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
        _imageView.image=image;
        @try{
            imageData=[UIImagePNGRepresentation(image) retain];
        }
        @catch(NSException *exception){
            @try{
                imageData=[UIImageJPEGRepresentation(image, 1.0) retain];
            }@catch(NSException *exception){
                [UIAlertView showWithTitle:nil message:@"图片格式转换错误" time:2];
                
            }
        }
        

    }else{
        [UIAlertView showWithTitle:nil message:@"请选择图片" time:2];
    }
 
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
