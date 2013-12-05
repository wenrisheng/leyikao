//
//  YikaoInfoViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "YikaoInfoViewController.h"
#import "ChineseToPinyin.h"
#import "ProvinceYikaoInfoViewController.h"
@interface YikaoInfoViewController ()

@end

@implementation YikaoInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        NSArray *array=@[@"北京",@"天津",@"上海",@"重庆",@"河北",@"河南",@"云南",@"辽宁",@"黑龙江",@"湖南",@"安徽",@"山东",@"新疆",@"江苏",@"浙江",@"江西",@"湖北",@"广西",@"甘肃",@"山西",@"内蒙古",@"陕西",@"吉林",@"福建",@"贵州",@"广东",@"青海",@"西藏",@"四川",@"宁夏",@"海南"];
       
        originArray=[[NSMutableArray alloc]initWithArray:array];
        dataArray=[self orderedArray:originArray];
        idOrderDid=[[NSMutableDictionary alloc]init];
        
        int i=1;
        for (NSMutableArray *array in dataArray) {
            if (array.count>0) {
                for (NSString *str in array) {
                    [idOrderDid setObject:[NSString stringWithFormat:@"%d",i] forKey:str];
                    i++;
                }
              
            }
        }
        
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    [_table setSectionIndexColor:[UIColor blackColor]];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchTextField resignFirstResponder];
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    idOrderDid=nil;
    originArray=nil;
    dataArray=nil;
    [_searchTextField release];
  
    [_table release];
    [super dealloc];
}
#pragma mark - uitableViewDataSourceDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return dataArray.count;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    
       
    NSArray *array=[NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    NSString *headTitle=[array objectAtIndex:section];
    return headTitle;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[dataArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *identify=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    cell.textLabel.text=[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSArray *array=[NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    return array;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    return index;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str=[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];;
    NSString *provinceId=[idOrderDid objectForKey:str];

    ProvinceYikaoInfoViewController *provinceVC=[[ProvinceYikaoInfoViewController alloc]init];
    provinceVC.provinceId=provinceId;
    [self.navigationController pushViewController:provinceVC animated:YES];
    provinceVC=nil;

}
#pragma mark  汉语转换为拼音(全拼)
-(NSMutableArray *)convertChineseToPinYinForArray:(NSArray *)a
{
    NSMutableArray *b=[[NSMutableArray alloc] init];
    NSInteger k=0;
    for(int i=0;i<a.count;i++)
    {
        NSString *c=[ChineseToPinyin pinyinFromChiniseString:[a objectAtIndex:i]];
        [b insertObject:c atIndex:k];
        k++;
    }
    return [b autorelease];
}

#pragma mark 把数组分组排序
-(NSMutableArray *)orderedArray:(NSArray *)arr
{
    NSMutableArray *orderedArray=[[NSMutableArray alloc] init];
    NSMutableArray *array=[self convertChineseToPinYinForArray:arr];
    NSString *str;
    
    NSMutableArray *a=[[NSMutableArray alloc] init];
    NSMutableArray *b=[[NSMutableArray alloc] init];
    NSMutableArray *c=[[NSMutableArray alloc] init];
    NSMutableArray *d=[[NSMutableArray alloc] init];
    NSMutableArray *e=[[NSMutableArray alloc] init];
    NSMutableArray *f=[[NSMutableArray alloc] init];
    NSMutableArray *g=[[NSMutableArray alloc] init];
    NSMutableArray *h=[[NSMutableArray alloc] init];
    NSMutableArray *i=[[NSMutableArray alloc] init];
    NSMutableArray *j=[[NSMutableArray alloc] init];
    NSMutableArray *k=[[NSMutableArray alloc] init];
    NSMutableArray *l=[[NSMutableArray alloc] init];
    NSMutableArray *m=[[NSMutableArray alloc] init];
    NSMutableArray *n=[[NSMutableArray alloc] init];
    NSMutableArray *o=[[NSMutableArray alloc] init];
    NSMutableArray *p=[[NSMutableArray alloc] init];
    NSMutableArray *q=[[NSMutableArray alloc] init];
    NSMutableArray *r=[[NSMutableArray alloc] init];
    NSMutableArray *s=[[NSMutableArray alloc] init];
    NSMutableArray *t=[[NSMutableArray alloc] init];
    NSMutableArray *u=[[NSMutableArray alloc] init];
    NSMutableArray *v=[[NSMutableArray alloc] init];
    NSMutableArray *w=[[NSMutableArray alloc] init];
    NSMutableArray *x=[[NSMutableArray alloc] init];
    NSMutableArray *y=[[NSMutableArray alloc] init];
    NSMutableArray *z=[[NSMutableArray alloc] init];
    
    for(int mm=0;mm<array.count;mm++)
    {
        str=[array objectAtIndex:mm];
        if([str hasPrefix:@"A"])
        {
            [a addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"B"])
        {
            [b addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"C"])
        {
            [c addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"D"])
        {
            [d addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"E"])
        {
            [e addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"F"])
        {
            [f addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"G"])
        {
            [g addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"H"])
        {
            [h addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"I"])
        {
            [i addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"J"])
        {
            [j addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"K"])
        {
            [k addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"L"])
        {
            [l addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"M"])
        {
            [m addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"N"])
        {
            [n addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"O"])
        {
            [o addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"P"])
        {
            [p addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"Q"])
        {
            [q addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"R"])
        {
            [r addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"S"])
        {
            [s addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"T"])
        {
            [t addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"U"])
        {
            [u addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"V"])
        {
            [v addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"W"])
        {
            [w addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"X"])
        {
            [x addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"Y"])
        {
            [y addObject:[arr objectAtIndex:mm]];
        }
        else if ([str hasPrefix:@"Z"])
        {
            [z addObject:[arr objectAtIndex:mm]];
        }
    }
    orderedArray=[[NSMutableArray alloc] initWithObjects:a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z, nil];
    [a release];
    [b release];
    [c release];
    [d release];
    [e release];
    [f release];
    [g release];
    [h release];
    [i release];
    [j release];
    [k release];
    [l release];
    [m release];
    [n release];
    [o release];
    [p release];
    [q release];
    [r release];
    [s release];
    [t release];
    [u release];
    [v release];
    [w release];
    [x release];
    [y release];
    [z release];
    
    return orderedArray;
}

- (IBAction)searchButtonAction:(id)sender {
    [_searchTextField resignFirstResponder];
    if (_searchTextField.text&&_searchTextField.text.length>0) {
        
  
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF CONTAINS %@",_searchTextField.text];
    NSArray *array=[originArray filteredArrayUsingPredicate:predicate];
    NSLog(@"array:%@",array);
    dataArray=[self orderedArray:array];
    }else{
        dataArray=[self orderedArray:originArray];
    }
    [_table reloadData];
}
@end
