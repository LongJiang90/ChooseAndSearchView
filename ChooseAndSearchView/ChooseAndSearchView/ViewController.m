//
//  ViewController.m
//  ChooseAndSearchView
//
//  Created by xp on 16/9/6.
//  Copyright © 2016年 yunwangnet.com. All rights reserved.
//

#import "ViewController.h"
#import "SeachAndChooseView.h"
#import "SearchInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpTwoSearchV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTwoSearchV{
    SeachAndChooseView *searchV1 = [SeachAndChooseView initSearchView];
    searchV1.frame = CGRectMake(15, 20, self.view.frame.size.width/2-40, 82);
    searchV1.backgroundColor = [UIColor lightGrayColor];
    searchV1.titleLabel.text = @"选择类型";
    
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        SearchInfo *sInfo = [[SearchInfo alloc] init];
        sInfo.sID = @"12";
        sInfo.sName = [NSString stringWithFormat:@"第一个表单的Name%d",i];
        [array1 addObject:sInfo];
    }
    
    searchV1.allTableArr = array1;
    [self.view addSubview:searchV1];
    
    
    SeachAndChooseView *searchV2 = [SeachAndChooseView initSearchView];
    searchV2.frame = CGRectMake(searchV1.frame.origin.x+searchV1.frame.size.width+10, 20, self.view.frame.size.width/2-40, 82);
    NSMutableArray *array2 = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        SearchInfo *sInfo = [[SearchInfo alloc] init];
        sInfo.sID = @"12";
        sInfo.sName = [NSString stringWithFormat:@"第二个表单的Name%d",i];
        [array2 addObject:sInfo];
    }
    
    searchV2.allTableArr = array2;
    [self.view addSubview:searchV2];
    
}


@end
