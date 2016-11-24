# ChooseAndSearchView
模仿安卓中自带的选择框（Spinner）。
使用时必须将该View置于父视图的最顶层，才不会被其他控件挡住。<br> <br>
![image](https://github.com/LongJiangSB/ChooseAndSearchView/blob/master/Images/selectImg.gif) <br>
Installation with CocoaPods
----
``` c
    pod 'ChooseAndSearchView'
```
Usage
----
``` c
    #import "SeachAndChooseView.h"
```
vc.m
``` c
    NSArray *nationalityArr = @[@"中国",@"英国",@"美国",@"法国",@"英格兰",@"意大利",@"伊拉克",@"新加坡",@"泰国",@"德国"];
    
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
```
