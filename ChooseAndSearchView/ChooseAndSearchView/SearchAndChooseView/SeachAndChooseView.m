//
//  SeachAndChooseView.m
//  ChooseAndSearchView
//
//  Created by xp on 16/9/6.
//  Copyright © 2016年 yunwangnet.com. All rights reserved.
//

#import "SeachAndChooseView.h"
#import "SearchInfo.h"
#import "SimpleCell.h"

@interface SeachAndChooseView()<UITableViewDelegate,UITableViewDataSource>{
    BOOL isOpenList;/**< 已经打开了表单 */
}

@property (nonatomic,strong) NSMutableArray *tbArr;
@property (nonatomic,strong) NSMutableArray *searchArr;
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation SeachAndChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)initSearchView{
    SeachAndChooseView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"SeachAndChooseView" owner:self options:nil] lastObject];
    return searchView;
}

-(void)setAllTableArr:(NSMutableArray *)allTableArr{
    _allTableArr = allTableArr;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFChangeAction:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)textFChangeAction:(NSNotification *)noti{
    UITextField *textF = noti.object;
    
    if (textF == self.textF) {
        if (textF.text.length ==0) {
            [self hiddnTableView];
        }else{
            //显示列表，且搜索列表 adsTextF
            [self showTableViewByView:self.textF andCount:5];
            
            NSMutableArray *arr = [NSMutableArray array];
            
            for (int i=0; i<self.allTableArr.count; i++) {
                id object = self.allTableArr[i];
                
                if ([object isKindOfClass:[SearchInfo class]]) {
                    SearchInfo *info = (SearchInfo *)object;
                    if([info.sName rangeOfString:textF.text].location !=NSNotFound) {
                        [arr addObject:info];
                    }
                }
                
            }
            self.tbArr = arr;
        }
        
        [self.tableView reloadData];
    }
}

#pragma mark - 按钮响应函数
- (IBAction)chooseBtnAction:(UIButton *)sender {
    
//    int index = btn.tag - 100;
//    UITextField *textF = self.allTableArr[index-1];
//    selectTextF = textF;
    
    self.tbArr = self.allTableArr.mutableCopy;
    if (isOpenList == YES) {
        [self hiddnTableView];
    }else{
//        if (ScreenHeight == 568) {
            [self showTableViewByView:self.textF andCount:5];
//        }else{
//            [self showTableViewByView:self.textF andCount:5];
//        }
    }
    [self.tableView reloadData];
    
}

#pragma mark - 网络请求

#pragma mark - 协议函数
#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tbArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SimpleCell *cell = [SimpleCell cellWithTableView:tableView];
    
    id object = self.tbArr[indexPath.row];
    
    if ([object isKindOfClass:[NSString class]]) {
        [cell setUpCellByInfo:object];
    }
    
    if ([object isKindOfClass:[SearchInfo class]]) {
        SearchInfo *info = (SearchInfo *)object;
        [cell setUpCellByInfo:info.sName];
    }
    
//    //负责人
//    if ([object isKindOfClass:[MailListInfo class]]) {
//        MailListInfo *info = (MailListInfo *)object;
//        cell.textLabel.text = info.Name;
//    }
//    
//    //区域
//    if ([object isKindOfClass:[AddressInfo class]]) {
//        AddressInfo *info = (AddressInfo *)object;
//        cell.textLabel.text = info.Name;
//    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id object = self.tbArr[indexPath.row];
    
    if ([object isKindOfClass:[SearchInfo class]]) {
        SearchInfo *info = (SearchInfo *)object;
        self.textF.text = info.sName;
    }
    
//    //负责人
//    if ([object isKindOfClass:[MailListInfo class]]) {
//        MailListInfo *info = (MailListInfo *)object;
//        selectPeopleinfo = info;
//        selectTextF.text = info.Name;
//    }
//    
//    //区域
//    if ([object isKindOfClass:[AddressInfo class]]) {
//        AddressInfo *info = (AddressInfo *)object;
//        selectAddress = info;
//        selectTextF.text = info.Name;
//    }
    
    
    [self hiddnTableView];
    
}

//然后根据具体的业务场景去写逻辑就可以了,比如
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [touch.view isKindOfClass:[UIButton class]]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}

#pragma mark - 组装数据、创建视图、自定义方法

-(NSMutableArray *)tbArr{
    if (_tbArr == nil) {
        _tbArr = [NSMutableArray array];
    }
    return _tbArr;
}

-(NSMutableArray *)searchArr{
    if (_searchArr == nil) {
        _searchArr = [NSMutableArray array];
    }
    return _searchArr;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.textF.frame.origin.x, self.textF.frame.origin.y, 0, 0) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.borderWidth = 1.0;
        _tableView.layer.borderColor = [UIColor colorWithRed:0.7264 green:0.7264 blue:0.7264 alpha:1.0].CGColor;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //开启自动估算高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        [self addSubview:_tableView];
        //        [self.bgView bringSubviewToFront:_tableView];
    }
    return _tableView;
}

-(void)showTableViewByView:(UIView *)view andCount:(int)count {
    isOpenList = YES;
    self.tableView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, view.frame.origin.y+view.frame.size.height+2, view.frame.size.width, 44*count);
    }];
}

-(void)hiddnTableView{
    isOpenList = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        if (finished == YES) {
            self.tableView.hidden = YES;
        }
    }];
}

-(NSMutableArray *)getSearchArrayByArr:(NSMutableArray *)array andClassName:(NSString *)classN{
//    NSClassFromString(classN) *info = array[0];
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i=0; i<array.count; i++) {
        SearchInfo *sInfo = [[SearchInfo alloc] init];
        sInfo.sID = @"12";
        sInfo.sName = @"Name";
        
        [arr addObject:sInfo];
    }
    
    
    
    return arr;
}

//如果点击无法响应，即无法传递点击，判断点击的坐标是否是tableView所包含的区域,如果是则让tableView响应点击
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        //将坐标由当前视图发送到 指定视图 fromView是无法响应的范围小父视图
        
        CGPoint stationPoint = [self.tableView convertPoint:point fromView:self];
        
        if (CGRectContainsPoint(self.tableView.bounds, stationPoint))
        {
            view = self.tableView;
        }
        
    }
    return view;
}


@end
