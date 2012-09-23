//
//  JakimSolat.h
//
//  Created by Sumardi Shukor <sumardi@wutmedia.com> on 2/26/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//
//  JakimSolatWrapper is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
// 
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
// 
//  You should have received a copy of the GNU General Public License
//  along with JakimSolatWrapper. If not, see <http://www.gnu.org/licenses/>
//

#import <Foundation/Foundation.h>

@interface JakimPrayerTime : NSObject  {
    NSString *location;
    NSString *code;
    NSDate *imsak;
    NSDate *subuh;
    NSDate *syuruk;
    NSDate *zohor;
    NSDate *asar;
    NSDate *maghrib;
    NSDate *isyak;
}

@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSDate *imsak;
@property (nonatomic, retain) NSDate *subuh;
@property (nonatomic, retain) NSDate *syuruk;
@property (nonatomic, retain) NSDate *zohor;
@property (nonatomic, retain) NSDate *asar;
@property (nonatomic, retain) NSDate *maghrib;
@property (nonatomic, retain) NSDate *isyak;

@end
