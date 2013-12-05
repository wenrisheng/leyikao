//
//  PeixunbanViewController.h
//  LeYiKao
//
//  Created by athudong on 13-10-15.
//  Copyright (c) 2013年 athudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "PeixunbanDao.h"
enum TableType{
    provinceType,
    cityType,
    professionType,
    listType
};
typedef enum TableType TableType;
@interface PeixunbanViewController : UIViewController<BMKMapViewDelegate,UITableViewDataSource,UITableViewDelegate,PeixunbanDaoDelegate>{
    NSArray *provinceArray;
    NSArray *citiesArray;

    NSArray *filterCitiesArray;
    NSArray *professionArray;
    
    PeixunbanDao *peixunbanDao;
    
    NSString *searchProvinceId;
    NSString *searchCityId;
    NSString *searchProfession;
    
    NSArray *dataArray;
    
    NSArray *listArray;
    BOOL showMap;
}
- (IBAction)switchAction:(id)sender;
- (IBAction)backAction:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UITableView *listTable;

@property (retain, nonatomic) IBOutlet UIView *switchView;
@property (retain, nonatomic) IBOutlet BMKMapView *mapView;

@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)searchButtonAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *provinceLabel;
- (IBAction)provinceButtonAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *cityLabel;
- (IBAction)cityButtonAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *professionLabel;
- (IBAction)professionButtonAction:(id)sender;

@end
