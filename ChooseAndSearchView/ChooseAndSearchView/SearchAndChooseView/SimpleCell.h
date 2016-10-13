//
//  SimpleCell.h
//  YWOAManagementSystem
//
//  Created by xp on 16/9/2.
//  Copyright © 2016年 yunwangnet.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 该Cell是为了使用自动布局的 高度自动估算
 */

@interface SimpleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void) setUpCellByInfo:(NSString *)nameStr;

@end
