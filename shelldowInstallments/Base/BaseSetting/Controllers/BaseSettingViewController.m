//
//  BaseSettingViewController.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseSettingViewController.h"


@interface BaseSettingViewController ()

@end

@implementation BaseSettingViewController

- (CellPostNoteType)type{
    return CellPostNoteTypeNULL;
}

- (NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
- (instancetype)init{
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)initTableView{
    [super initTableView];
    /// 在这个方法里面加载数据源
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZXXGroupItem *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXXSettingCell *cell;
    // 给cell传递模型
    ZXXGroupItem *group = self.groups[indexPath.section];
    ZXXSetItem *item = group.items[indexPath.row];
    if (self.type==CellPostNoteTypeNULL) {
        cell = [ZXXSettingCell cellTableView:tableView reuseIdentifier:CELLCOMMON];
    }else if (self.type==CellPostNoteTypeWithkeyBoardHiden){
        if (item.class == [ZXXTextFieldItem class]) {
            ///这里因为cell里面的textField的get方法中添加了观察中心。所以为了区别其他cell独立出一个reuseIdentifier
            NSString *reuseIdentifier = [NSString stringWithFormat:@"%@_TextField",CELLCOMMON_EDIT];
            cell = [ZXXSettingCell cellTableView:tableView reuseIdentifier:reuseIdentifier];
        }else{
            cell = [ZXXSettingCell cellTableView:tableView reuseIdentifier:CELLCOMMON_EDIT];
        }
    }
    if((indexPath.section==self.groups.count-1)&&(indexPath.row==group.items.count-1)){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH);
    }else{
        cell.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    }
    cell.item = item;
    
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZXXGroupItem *group = self.groups[indexPath.section];
    
    ZXXSetItem *item = group.items[indexPath.row];
    
    if (item.option&&([item isKindOfClass:[ZXXArrowItem class]]||[item isKindOfClass:[ZXXImageArrowItem class]]||[item isKindOfClass:[ZXXLabelArrowItem class]]||[item isKindOfClass:[ZXXCheakItem class]])) {
        item.option(item);
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXXGroupItem *group = self.groups[indexPath.section];
    ZXXSetItem *item = group.items[indexPath.row];
    if (item.height>0) {
        return item.height;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    ZXXGroupItem *group = self.groups[section];
    return group.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    ZXXGroupItem *group = self.groups[section];
    return group.footerTitle;
}

@end
