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
    
    [self setUpSearchV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)setUpSearchV{
    NSArray *nationalityArr = @[@"中国",@"英国",@"美国",@"法国",@"英格兰",@"意大利",@"伊拉克",@"新加坡",@"泰国"];
    
    SeachAndChooseView *searchV = [SeachAndChooseView initSearchView];
    searchV.frame = CGRectMake(15, 20, self.view.frame.size.width-30, 82);
    searchV.titleLabel.text = @"请选择你的国籍";
    
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i=0; i<nationalityArr.count; i++) {
        SearchInfo *sInfo = [[SearchInfo alloc] init];
        sInfo.sID = [NSString stringWithFormat:@"%d",i+1];
        sInfo.sName = nationalityArr[i];
        [array1 addObject:sInfo];
    }
    
    searchV.allTableArr = array1;
    [self.view addSubview:searchV];
    
}


@end
