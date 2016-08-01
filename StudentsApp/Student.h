//
//  Student.h
//  StudentsApp
//
//  Created by Vinod Lingamsetty on 7/13/16.
//  Copyright © 2016 Vinod Lingamsetty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, assign) int studentId;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *recruiterName;
@property (nonatomic, copy) NSString *entryDate;
@property (nonatomic, copy) NSString *exitDate;

@end
