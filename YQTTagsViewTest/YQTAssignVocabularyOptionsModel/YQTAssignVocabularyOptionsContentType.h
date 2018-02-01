//
//  YQTAssignVocabularyOptionsContentType.h
//  YIQITeacher
//
//  Created by J on 2018/2/1.
//  Copyright © 2018年 17zuoye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQTAssignVocabularyOptionsContentType : NSObject
/*
 "nid": 2030047,
 "name": "单词跟读",
 "deleted_true": false,
 "id": 2030047,
 "kp_type": 1
 */
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger nid;
@property(nonatomic,assign)NSInteger kp_type;
@property(nonatomic,assign)BOOL deleted_true;
@property(nonatomic,copy)NSString *ID;


///选中状态
@property(nonatomic,assign)BOOL selected;

@end
