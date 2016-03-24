//
//  ViewController.m
//  IGJSONKit
//
//  Created by GavinHe on 16/3/24.
//  Copyright © 2016年 GavinHe. All rights reserved.
//

#import "ViewController.h"

#import "IGJSONKIt.h"

typedef NS_ENUM(NSInteger, Tests) {
    // 解码
    TestsStringToObject = 0,
    TestsStringToMutableObject ,
    TestsDataToObject ,
    TestsDataToMutableObject ,
    // 编码
    TestsArrayToString ,
    TestsArrayToData ,
    TestsDictionaryToString,
    TestsDictionaryToData
};

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tbTests;
    
    NSMutableArray *datas;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self buildUI];
}

#pragma mark - ----> 界面

- (void)buildUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    tbTests            = [[UITableView alloc] initWithFrame:CGRectMake(0, 20,
                                                                       self.view.bounds.size.width,
                                                                       self.view.bounds.size.height)];
    tbTests.delegate   = self;
    tbTests.dataSource = self;
    [self.view addSubview:tbTests];
}

#pragma mark - ----> 数据

- (void)initData{
    datas = [NSMutableArray new];
    
    // 解码
    [datas addObject:@"String To Object"];
    
    [datas addObject:@"String To Mutable Object"];
    
    [datas addObject:@"Data To Object"];

    [datas addObject:@"Data To Mutable Object"];
    
    // 编码
    [datas addObject:@"Array To String"];

    [datas addObject:@"Array To Data"];
    
    [datas addObject:@"Dictionary To String"];

    [datas addObject:@"Dictionary To Data"];
    
}

#pragma mark - ----> TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
static NSString *cellID = @"cellid";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case TestsStringToObject:{
            [self stringToObject];
            break;
        }
        case TestsStringToMutableObject:{
            [self stringToMutableObject];
            break;
        }
        case TestsDataToObject:{
            [self dataToObject];
            break;
        }
        case TestsDataToMutableObject:{
            [self dataToMutableObject];
            break;
        }
        case TestsArrayToString:{
            [self arrayToString];
            break;
        }
        case TestsArrayToData:{
            [self arrayToData];
            break;
        }
        case TestsDictionaryToString:{
            [self dictionaryToString];
            break;
        }
        case TestsDictionaryToData:{
            [self dictionaryToData];
            break;
        }
        default:
            break;
    }
}

#pragma mark - ----> 字符串转成对象

- (void)stringToObject{
    NSString *orgStr = @"{\"key1\":\"value1\",\"key2\":[\"arrElem1\",\"arrElem2\"],\"key3\":3}";
    id obj = [orgStr objectFromJSONString];
    NSLog(@"\n Test String To Object \n String: %@\n Object: \nClass: %@\nDesc:%@",orgStr,[obj class],obj);
}

- (void)stringToMutableObject{
    NSString *orgStr = @"[{\"key1\":\"value1\",\"key2\":[\"arrElem1\",\"arrElem2\"],\"key3\":3},@\"123\"]";
    id obj = [orgStr mutableObjectFromJSONString];
    [obj addObject:@"456"];
    NSLog(@"\n Test String To Object \n String: %@\n Object: \nClass: %@\nDesc:%@",orgStr,[obj class],obj);
}

- (void)dataToObject{
    NSString *orgStr = @"{\"key1\":\"value1\",\"key2\":[\"arrElem1\",\"arrElem2\"],\"key3\":3}";
    
    NSData *data = [orgStr dataUsingEncoding:NSUTF8StringEncoding];
    
    id obj = [data objectFromJSONData];
    NSLog(@"\n Test Data To Object \n String: %@\n Object: \nClass: %@\nDesc:%@",orgStr,[obj class],obj);
}

- (void)dataToMutableObject{
    NSString *orgStr = @"[1,2,3]";
    
    NSData *data = [orgStr dataUsingEncoding:NSUTF8StringEncoding];
    
    id obj = [data mutableObjectFromJSONData];
    
    [obj addObject:@"456"];
    
    NSLog(@"\n Test Data To Object \n String: %@\n Object: \nClass: %@\nDesc:%@",orgStr,[obj class],obj);
}

#pragma mark - ----> 对象转成字符串
- (void)arrayToString{
    NSArray *arr = @[
                     @1,
                     @"2",
                     @{@"k1":@"v1",
                       @"k2":@[@5,@6],
                       @"k2":@{@"kk1":@"vv1"}
                       },
                     @[@3,@4]
                     ];
    
    NSString *str = [arr JSONString];
    NSLog(@"\n Test Array To String \n Array: %@\n String: %@",arr,str);
}
- (void)arrayToData{
    NSArray *arr = @[
                     @1,
                     @"2",
                     @{@"k1":@"v1",
                       @"k2":@[@5,@6],
                       @"k2":@{@"kk1":@"vv1"}
                       },
                     @[@3,@4]
                     ];
    NSData *data = [arr JSONData];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"\n Test Array To Data \n Array: %@\n Data: %@\n Trans To String: %@",arr,data,str);
}

- (void)dictionaryToString{
    NSDictionary *dict =  @{@"k1":@"v1",
                            @"k2":@[@5,@6],
                            @"k2":@{@"kk1":@"vv1"}
                            };
    
    NSString *str = [dict JSONString];
    NSLog(@"\n Test Dictionary To String \n Array: %@\n String: %@",dict,str);
    
}

- (void)dictionaryToData{
    NSDictionary *dict =  @{@"k1":@"v1",
                            @"k2":@[@5,@6],
                            @"k2":@{@"kk1":@"vv1"}
                            };
    
    NSData *data = [dict JSONData];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"\n Test Dictionary To Data \n Dictionary: %@\n Data: %@\n Trans To String: %@",dict,data,str);

}

#pragma mark - ----> 事件



@end
