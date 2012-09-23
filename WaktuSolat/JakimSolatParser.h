//
//  JakimSolatParser.h
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

@class JakimPrayerTime, JakimSolatParser;

@protocol JakimSolatDelegate <NSObject>

@optional
- (void)jakimSolatParser:(JakimSolatParser *)parser didParsePrayerTime:(JakimPrayerTime *)prayerTime;
- (void)jakimSolatParser:(JakimSolatParser *)parser didFailWithError:(NSError *)error;

@end


@interface JakimSolatParser : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    id<JakimSolatDelegate> delegate;
    
    NSURL *url;
    NSURLConnection *urlConnection;

    JakimPrayerTime *prayerTime;
    NSMutableData *prayerTimeData;
}

@property (nonatomic, retain) id<JakimSolatDelegate> delegate;
@property (nonatomic, retain) JakimPrayerTime *prayerTime;

- (id)initWithURL:(NSURL *)urlJakim;
- (id)initWithCode:(NSString *)code;
- (BOOL)parse;

@end
