//
//  PeixunbanViewController.m
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import "PeixunbanViewController.h"
#import "DetailPeixunbanViewController.h"
@interface PeixunbanViewController ()

@end

@implementation PeixunbanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        peixunbanDao=[[PeixunbanDao alloc]init];
        peixunbanDao.delegate=self;
        showMap=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _mapView.delegate=self;
    _listTable.tag=listType;
    self.navigationController.navigationBarHidden=YES;
    [peixunbanDao findProvinces];
    [peixunbanDao findCities];
    [peixunbanDao findSpecialties];
  //////////////////////////////////////////////////
//[_mapView setShowsUserLocation:YES];
//      _mapView.userTrackingMode = BMKUserTrackingModeNone;
    
    BMKCoordinateRegion viewRegion= BMKCoordinateRegionMake(CLLocationCoordinate2DMake(23.12, 113.26), BMKCoordinateSpanMake(0.05, 0.05));
    
     [_mapView setRegion:viewRegion];
    


}
#pragma mark - baiduView
// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    NSString *AnnotationViewID = @"renameMark";
    
    BMKAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];

    // 设置颜色
    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorRed;
    // 从天上掉下效果
    ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;

    
    return newAnnotation;
    
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    BMKPointAnnotation *annotation=(BMKPointAnnotation *)view.annotation;
    NSString *title=annotation.title;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name==%@",title];
    NSArray *array=[listArray filteredArrayUsingPredicate:predicate];
    NSDictionary *dic=[array objectAtIndex:0];
    NSString *ID=[dic objectForKey:@"id"];
    
    DetailPeixunbanViewController *peixunbanVC=[[DetailPeixunbanViewController alloc] init];
    peixunbanVC.peixunbanId=ID;
    NSLog(@"id:%@",ID);
    [self.navigationController pushViewController:peixunbanVC animated:YES];
    peixunbanVC=nil;
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchTextField resignFirstResponder];
     _table.frame=CGRectMake(-200, 120, 58, 149);
}
- (void)dealloc {
    listArray=nil;
    filterCitiesArray=Nil;
    peixunbanDao=nil;
        if (_mapView) {
            [_mapView release];
            _mapView = nil;
        }
    [_searchTextField release];
    [_provinceLabel release];
    [_cityLabel release];
    [_professionLabel release];
    [_table release];
    [_switchView release];
    [_table release];
    [_listTable release];
    [super dealloc];
}
- (IBAction)searchButtonAction:(id)sender {
    
    [_searchTextField resignFirstResponder];
    [peixunbanDao searchPeixunbanByProvince:searchProvinceId city:searchCityId specialty:searchProfession keyword:_searchTextField.text];
}
- (IBAction)provinceButtonAction:(id)sender {
    _table.frame=CGRectMake(17, 120, 58, 149);

    _table.tag=provinceType;
    [_table reloadData];
}
- (IBAction)cityButtonAction:(id)sender {

    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"province==%@",[NSString stringWithFormat:@"%@",searchProvinceId]];
   
    filterCitiesArray=[[citiesArray filteredArrayUsingPredicate:predicate] retain];

    

    _table.frame=CGRectMake(130, 120, 58, 149);
    _table.tag=cityType;
    [_table reloadData];
}
- (IBAction)professionButtonAction:(id)sender {
    _table.frame=CGRectMake(245, 120, 58, 149);
    _table.tag=professionType;
    [_table reloadData];
}
#pragma mark - bmkMapViewDelegate

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - uitableViewdataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int type=tableView.tag;
    switch (type) {
        case provinceType:
        {
            return provinceArray.count;
        }
            break;
        case cityType:
        {
            return filterCitiesArray.count;
        }
            break;
        case professionType:
        {
            return professionArray.count;
        }
            break;
            case listType:
        {
            NSLog(@"listArray count:%d",listArray.count);
            return listArray.count;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    [[cell textLabel] setFont:[UIFont fontWithName:@"Arial" size:8]];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    int type=tableView.tag;
    switch (type) {
        case provinceType:
        {
            NSDictionary *dic=[provinceArray objectAtIndex:indexPath.row];

            cell.textLabel.text=[dic objectForKey:@"name"];
        }
            break;
        case cityType:
        {
            NSDictionary *dic=[filterCitiesArray objectAtIndex:indexPath.row];
            cell.textLabel.text=[dic objectForKey:@"name"];        }
            break;
        case professionType:
        {
            NSDictionary *dic=[professionArray objectAtIndex:indexPath.row];
            cell.textLabel.text=[dic objectForKey:@"name"];
        }
            break;
        case listType:{
            NSDictionary *dic=[listArray objectAtIndex:indexPath.row];
            cell.textLabel.text=[dic objectForKey:@"name"];
        }
            break;
        default:
           
            break;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int type=tableView.tag;
    switch (type) {
        case provinceType:
        {
            NSDictionary *dic=[provinceArray objectAtIndex:indexPath.row];
            searchProvinceId=[dic objectForKey:@"id"];
            _provinceLabel.text=[dic objectForKey:@"name"];
            _table.frame=CGRectMake(-320, 0, _table.frame.size.width, _table.frame.size.height);
        }
            break;
        case cityType:
        {
            
            NSLog(@"filterARray:%@",filterCitiesArray);
            NSDictionary *dic=[filterCitiesArray objectAtIndex:indexPath.row];
            searchCityId=[dic objectForKey:@"id"];
            _cityLabel.text=[dic objectForKey:@"name"];
          _table.frame=CGRectMake(-320, 0, _table.frame.size.width, _table.frame.size.height);
        }
            break;
        case professionType:
        {
             NSDictionary *dic=[professionArray objectAtIndex:indexPath.row];
            _professionLabel.text=[dic objectForKey:@"name"];
            searchProfession=[dic objectForKey:@"id"];
            _table.frame=CGRectMake(-320, 0, _table.frame.size.width, _table.frame.size.height);
        }
            break;
        case listType:{
             NSDictionary *dic=[listArray objectAtIndex:indexPath.row];
            DetailPeixunbanViewController *peixunbanVC=[[DetailPeixunbanViewController alloc] init];
            peixunbanVC.peixunbanId=[dic objectForKey:@"id"];
            [self.navigationController pushViewController:peixunbanVC animated:YES];
            peixunbanVC=nil;
        }
            break;
        default:
        break;
    }

}
#pragma mark - peixunbanDaoDelegate
-(void)findProvincesSuc:(id)value{
    provinceArray=[value retain];

}
-(void)findProvincesFail:(NSError *)error{
    UIAlertView *aiView=[[UIAlertView alloc]initWithTitle:nil message:@"获取省份出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aiView show];
    [aiView release];
    NSLog(@"findProvincesFail");
}

-(void)findCitySuc:(id)value{
    citiesArray=[value retain];

}
-(void)findCityFail:(NSError *)error{
    UIAlertView *aiView=[[UIAlertView alloc]initWithTitle:nil message:@"获取市区出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aiView show];
    [aiView release];
      NSLog(@"findCityFail");
}

-(void)findSpecialtySuc:(id)value{
    professionArray=[value retain];
}
-(void)findSpecialtyFail:(NSError *)error{
    UIAlertView *aiView=[[UIAlertView alloc]initWithTitle:nil message:@"获取专业出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aiView show];
    [aiView release];
}

-(void)searchPeisunbanByPCSSuc:(id)value{
    listArray=[value retain];
    
    NSLog(@"searchResult:%@",listArray);
    [_listTable reloadData];
    NSDictionary *d=[listArray objectAtIndex:0];
    double lat=[[d objectForKey:@"lat"] doubleValue];
    double lon=[[d objectForKey:@"lng"] doubleValue];
    
  BMKCoordinateRegion viewRegion= BMKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lon), BMKCoordinateSpanMake(0.05, 0.05));
   
                                                            
    [_mapView setRegion:viewRegion];
    for (NSDictionary *dic in listArray) {
        double latitude=[[dic objectForKey:@"lat"] doubleValue];
        double longitude=[[dic objectForKey:@"lng"] doubleValue];
        NSLog(@"lat:%f  lon:%f",latitude,longitude);
        NSString *title=[dic objectForKey:@"name"];
        
        BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
      
        coor.latitude = latitude;
        coor.longitude = longitude;
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = title;
    //pointAnnotation.subtitle = @"此Annotation可拖拽!";
        [_mapView addAnnotation:pointAnnotation];
        [pointAnnotation release];

        
        
      
    }
    
}
-(void)searchPeisunbanByPCSFail:(id)value{
    UIAlertView *aiView=[[UIAlertView alloc]initWithTitle:nil message:@"搜索失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aiView show];
    [aiView release];
    NSLog(@"searchPeisunbanByPCSFail");
}

- (IBAction)switchAction:(id)sender {
    if (showMap) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1];
        [_mapView setAlpha:0];
        [_listTable setAlpha:1];
        showMap=NO;
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1];
        [_mapView setAlpha:1];
        [_listTable setAlpha:0];
        showMap=YES;
         [UIView commitAnimations];
    }
}


@end
