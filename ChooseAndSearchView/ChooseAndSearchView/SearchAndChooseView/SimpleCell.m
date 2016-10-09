//
//  SimpleCell.m
//  YWOAManagementSystem
//
//  Created by xp on 16/9/2.
//  Copyright © 2016年 yunwangnet.com. All rights reserved.
//

#import "SimpleCell.h"

@implementation SimpleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *CellIdentifier = @"SimpleCell";
    SimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"SimpleCell" bundle:nil];
        cell  = [[nib instantiateWithOwner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setUpCellByInfo:(NSString *)nameStr{
    self.nameLabel.text = [NSString stringWithFormat:@"%@",nameStr.length?nameStr:@"暂无"];
}


@end
