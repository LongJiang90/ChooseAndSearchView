//
//  SeachAndChooseView.m
//  ChooseAndSearchView
//
//  Created by xp on 16/9/6.
//  Copyright © 2016年 yunwangnet.com. All rights reserved.
//

#import "SeachAndChooseView.h"
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
    
    self.tbArr = self.allTableArr.mutableCopy;
    if (isOpenList == YES) {
        [self hiddnTableView];
    }else{
        [self showTableViewByView:self.textF andCount:5];
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
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id object = self.tbArr[indexPath.row];
    
    if ([object isKindOfClass:[SearchInfo class]]) {
        SearchInfo *info = (SearchInfo *)object;
        self.textF.text = info.sName;
        self.selectedInfo = info;
    }
    
    [self hiddnTableView];
    
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.textF.frame.origin.y, 0, 0) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.borderWidth = 1.0;
        _tableView.layer.borderColor = [UIColor colorWithRed:0.7264 green:0.7264 blue:0.7264 alpha:1.0].CGColor;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //开启自动估算高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        [self addSubview:_tableView];
        [self.superview bringSubviewToFront:_tableView];
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
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        id dataInfo = array[i];
        if ([dataInfo isKindOfClass:NSClassFromString(classN)]) {
            SearchInfo *sInfo = [[SearchInfo alloc] init];
            sInfo.sID = @"12";
            sInfo.sName = @"Name";
            
            [arr addObject:sInfo];
        }
    }
    return arr;
}

//@TODO:该函数用于解决：tableView展开时 超出self时，无法选中Cell
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        //将坐标由当前视图发送到 指定视图 fromView是无法响应的范围小父视图
        CGPoint stationPoint = [self.tableView convertPoint:point fromView:self];
        
        if (CGRectContainsPoint(self.tableView.bounds, stationPoint))
        {
            //如果点击无法响应，即无法传递点击，判断点击的坐标是否是tableView所包含的区域,如果是则让tableView响应点击
            view = self.tableView;
        }
        
    }
    return view;
}


@end
