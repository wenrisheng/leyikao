//
//  WritePostViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-21.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "WritePostViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIAlertView+customShow.h"
@interface WritePostViewController ()

@end

@implementation WritePostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        communityDao=[[CommunityDao alloc]init];
        communityDao.delegate=self;
        imageArray=[[NSMutableArray alloc]init];
        
      
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CALayer *layer=_textView.layer;
    layer.cornerRadius=2;
    layer.borderColor=[[UIColor grayColor] CGColor];
    layer.borderWidth=1;
      _imageScrollView.contentSize=CGSizeMake(_imageScrollView.frame.size.width*3, _imageScrollView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)createAction:(id)sender {
     [_textView resignFirstResponder];
    NSString *title=_textField.text;
    if (title&&title.length>0) {
        NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        [communityDao createPostWithUserId:userId title:title content:_textView.text image:imageArray];
    }else{
        UIAlertView *aiView=[[UIAlertView alloc] initWithTitle:nil message:@"标题不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        [aiView show];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideAlert:) userInfo:aiView repeats:NO];
        [aiView release];
    }
    
}
-(void)hideAlert:(NSTimer *)timer{
    UIAlertView *aiView=timer.userInfo;
    [aiView dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)dealloc {
    [imageArray release];
    [_textView release];
    [_textField release];

    [_imageScrollView release];
    [super dealloc];
}
#pragma mark - communityDaoDelegate
-(void)createPostSuc:(id)value{
    UIAlertView *aiView=[[UIAlertView alloc] initWithTitle:nil message:@"发帖成功" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [aiView show];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideAlert:) userInfo:aiView repeats:NO];
    [aiView release];
}
-(void)createPostFail:(NSError *)error{
    UIAlertView *aiView=[[UIAlertView alloc] initWithTitle:nil message:@"发帖失败" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [aiView show];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideAlert:) userInfo:aiView repeats:NO];
    [aiView release];
}
- (IBAction)addImageAction:(id)sender {
    //图片库
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate=self;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
   // picker.allowsEditing=YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    [picker release];

}
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
       
        @try{
             int count=imageArray.count;
            if (count>5) {
                [UIAlertView showWithTitle:nil message:@"最多添加5张图片" time:2];
            }else{
                NSData  *imageData=UIImagePNGRepresentation(image);
                [imageArray addObject:imageData];
                
                UIImageView *imageView=[[UIImageView alloc]init];
                imageView.frame=CGRectMake(count*_imageScrollView.frame.size.width*0.5,0, _imageScrollView.frame.size.width*0.5, _imageScrollView.frame.size.height);
                imageView.image=image;
                [_imageScrollView addSubview:imageView];
                [imageView release];
            }
         
         
        }
        @catch(NSException *exception){
            @try{
                int count=imageArray.count;
                if (count>5) {
                    [UIAlertView showWithTitle:nil message:@"最多添加5张图片" time:2];
                }else{
                    NSData  *imageData=UIImageJPEGRepresentation(image, 1.0);
                    [imageArray addObject:imageData];
                    
                    UIImageView *imageView=[[UIImageView alloc]init];
                    imageView.frame=CGRectMake(count*_imageScrollView.frame.size.width*0.5,0, _imageScrollView.frame.size.width*0.5, _imageScrollView.frame.size.height);
                    imageView.image=image;
                    [_imageScrollView addSubview:imageView];
                    [imageView release];
                }

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
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
