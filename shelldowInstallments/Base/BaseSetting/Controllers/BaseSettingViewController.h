//
//  BaseSettingViewController.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BYTableViewController.h"
#import "ZXXGroupItem.h"
#import "ZXXBaseSetting.h"
#import "ZXXSettingCell.h"
typedef NS_ENUM(NSUInteger,CellPostNoteType){
    CellPostNoteTypeNULL = 1,
    CellPostNoteTypeWithkeyBoardHiden = 2
};
@interface BaseSettingViewController : BYTableViewController
/**
 *描述控制器有多少组
 */
@property (nonatomic, strong,nullable)NSMutableArray *groups;


/**
 描述点击cell时是否发送结束编辑
 @return 默认为CellPostNoteTypeNULL
 注意：如果右侧带有TextField时必须使用CellPostNoteTypeWithkeyBoardHiden
 */
- (CellPostNoteType)type;

@end
