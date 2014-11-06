//
//  WorkoutlistItem.m
//  WorkOut
//
//  Created by nyalama1 on 10/24/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "WorkoutlistItem.h"

@implementation WorkoutlistItem
@synthesize text = _text ;
@synthesize checked = _checked ;

// given a decoder pull the information out of it
- (id) initWithCoder :( NSCoder *) aDecoder
{
    if (( self = [ super init ]) ) {
        self . text = [ aDecoder decodeObjectForKey : @"Text"];
        self . checked = [ aDecoder decodeBoolForKey :@"Checked"];
    }
    return self ;
}

// if we ’re given an encoder let ’s save the information that we have
- ( void ) encodeWithCoder :( NSCoder *) aCoder
{
    [ aCoder encodeObject : self.text forKey : @"Text"];
    [ aCoder encodeBool : self.checked forKey : @"Checked"];
}

- ( void ) toggleChecked
{
    self . checked = ! self . checked ;
}




@end
