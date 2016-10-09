//
//  SimpleCell.h
//  YWOAManagementSystem
//
//  Created by xp on 16/9/2.
//  Copyright © 2016年 yunwangnet.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void) setUpCellByInfo:(NSString *)nameStr;

@end
