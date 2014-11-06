//
//  WorkoutlistItem.h
//  WorkOut
//
//  Created by nyalama1 on 10/24/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkoutlistItem : NSObject <NSCoding>

@property ( nonatomic , copy ) NSString * text ;
@property ( nonatomic , assign ) BOOL checked ;

- ( void ) toggleChecked ;

@end
