//
//  SeachAndChooseView.h
//  ChooseAndSearchView
//
//  Created by xp on 16/9/6.
//  Copyright © 2016年 yunwangnet.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchInfo.h"

@interface SeachAndChooseView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
- (IBAction)chooseBtnAction:(UIButton *)sender;

@property (nonatomic,strong) NSMutableArray *allTableArr;/**< 所有的数据 */
@property (nonatomic,strong) SearchInfo *selectedInfo;/**< 选中的信息 */

+(instancetype)initSearchView;


/**
 *  将数组转换为相应类型的SearchInfo
 *
 *  @param array  原来的数组
 *  @param classN 对象类型名称
 *
 *  @return 返回全部包含SearchInfo的数组
 */
-(NSMutableArray *)getSearchArrayByArr:(NSMutableArray *)array andClassName:(NSString *)classN;

/**
 *  显示选择表单
 *
 *  @param view  显示在那个View的下面
 *  @param count 默认高度
 */
-(void)showTableViewByView:(UIView *)view andCount:(int)count;

/**
 *  隐藏选择表单
 */
-(void)hiddnTableView;

@end
