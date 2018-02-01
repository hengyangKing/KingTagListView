//
//  YQTAssignVocabularyOptionsWord.h
//  YIQITeacher
//
//  Created by J on 2018/2/1.
//  Copyright © 2018年 17zuoye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQTAssignVocabularyOptionsWord : NSObject
@property(nonatomic,copy)NSString *_id;
@property(nonatomic,copy)NSString *entext;


///该word 是否被选中
@property(nonatomic,assign)BOOL selected;
@end
