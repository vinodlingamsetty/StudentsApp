//
//  Property.h
//  StudentsApp
//
//  Created by Vinod Lingamsetty on 7/13/16.
//  Copyright © 2016 Vinod Lingamsetty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface Property : NSObject

@property (nonatomic, assign) int propertyId;
@property (nonatomic, copy) NSString *buildingName;
@property (nonatomic, copy) NSString *apartmentNumber;
@property (nonatomic, assign) int noOfSlots;
@property (nonatomic, copy) NSArray *students;

@end
