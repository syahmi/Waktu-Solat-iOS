//
//  JakimSolat.m
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

#import "JakimPrayerTime.h"

@implementation JakimPrayerTime

@synthesize location, code, imsak, subuh, syuruk, zohor, asar, maghrib, isyak;

- (void)dealloc
{
    [location release];
    [code release];
    [imsak release];
    [subuh release];
    [syuruk release];
    [zohor release];
    [asar release];
    [maghrib release];
    [isyak release];
    [super dealloc];
}

@end
