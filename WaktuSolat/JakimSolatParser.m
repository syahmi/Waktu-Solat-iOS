//
//  JakimSolatParser.m
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

#import "JakimSolatParser.h"
#import "JakimPrayerTime.h"
#import "XPathQuery.h"

@implementation JakimSolatParser

@synthesize prayerTime, delegate;

- (id)init
{
    if (self = [super init]) {
        prayerTimeData = [[NSMutableData alloc] init];
        prayerTime = [[JakimPrayerTime alloc] init];
        
        [self initWithCode:@"sgr03"];
    }
    
    return self;
}

- (id)initWithURL:(NSURL *)urlJakim
{
    if (self = [super init]) {
        prayerTimeData = [[NSMutableData alloc] init];
        prayerTime = [[JakimPrayerTime alloc] init];
        
        if([urlJakim isKindOfClass:[NSString class]]) {
            urlJakim = [NSURL URLWithString:(NSString *)urlJakim];
        }
        
        url = urlJakim;
        
        NSArray *pairs = [[url query] componentsSeparatedByString:@"&"];
        NSMutableDictionary *kvPairs = [NSMutableDictionary dictionary];
        for (NSString *pair in pairs) {
            NSArray *bits = [pair componentsSeparatedByString:@"="];
            NSString *key = [[bits objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            NSString *value = [[bits objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            [kvPairs setObject:value forKey:key];
        }
        
        prayerTime.code = [kvPairs objectForKey:@"kod"];
    }
    
    return self;
}

- (id)initWithCode:(NSString *)code
{
    if (self = [super init]) {
        prayerTimeData = [[NSMutableData alloc] init];
        prayerTime = [[JakimPrayerTime alloc] init];
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.e-solat.gov.my/solat.php?kod=%@&lang=EN&url=http://www.wutlab.com&frameborder=0", code]];
        prayerTime.code = code;
    }
    
    return self;
}

- (BOOL)parse
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
    [request setValue:@"JakimSolatParser" forHTTPHeaderField:@"User-Agent"];
    urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

    return YES;
}

- (void)dispatchSolatToDelegate
{
    if (prayerTime) {
        if([[self delegate] respondsToSelector:@selector(jakimSolatParser:didParsePrayerTime:)]) {
            [[self delegate] jakimSolatParser:self didParsePrayerTime:prayerTime];
        }
    }
}

- (void)performXPathQuery
{
    NSArray *node = [[NSArray alloc] init];
    
    node = PerformHTMLXPathQuery([NSData dataWithData:prayerTimeData], @"//b");
    prayerTime.location = [[node objectAtIndex:0] objectForKey:@"nodeContent"];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    NSDate *currentDate = [[NSDate alloc] init];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd"];
    [dateComponents setDay:[[format stringFromDate:currentDate] intValue]];
    [format setDateFormat:@"MM"];
    [dateComponents setMonth:[[format stringFromDate:currentDate] intValue]];
    [format setDateFormat:@"yyyy"];
    [dateComponents setYear:[[format stringFromDate:currentDate] intValue]];
    [dateComponents setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+8"]];
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    node = PerformHTMLXPathQuery([NSData dataWithData:prayerTimeData], @"//table/tr[6]/td/font[6]");
    NSArray *imsakTime = [[[node objectAtIndex:0] objectForKey:@"nodeContent"] componentsSeparatedByString:@":"];
    [dateComponents setHour:[[imsakTime objectAtIndex:0] intValue]];
    [dateComponents setMinute:[[imsakTime objectAtIndex:1] intValue]];
    prayerTime.imsak = [cal dateFromComponents:dateComponents];
    
    node = PerformHTMLXPathQuery([NSData dataWithData:prayerTimeData], @"//table/tr[7]/td/font[6]");
    NSArray *subuhTime = [[[node objectAtIndex:0] objectForKey:@"nodeContent"] componentsSeparatedByString:@":"];
    [dateComponents setHour:[[subuhTime objectAtIndex:0] intValue]];
    [dateComponents setMinute:[[subuhTime objectAtIndex:1] intValue]];
    prayerTime.subuh = [cal dateFromComponents:dateComponents];
    
    node = PerformHTMLXPathQuery([NSData dataWithData:prayerTimeData], @"//table/tr[8]/td/font[6]");
    NSArray *syurukTime = [[[node objectAtIndex:0] objectForKey:@"nodeContent"] componentsSeparatedByString:@":"];
    [dateComponents setHour:[[syurukTime objectAtIndex:0] intValue]];
    [dateComponents setMinute:[[syurukTime objectAtIndex:1] intValue]];
    prayerTime.syuruk = [cal dateFromComponents:dateComponents];
    
    node = PerformHTMLXPathQuery([NSData dataWithData:prayerTimeData], @"//table/tr[9]/td/font[6]");
    NSArray *zohorTime = [[[node objectAtIndex:0] objectForKey:@"nodeContent"] componentsSeparatedByString:@":"];
    [dateComponents setHour:[[zohorTime objectAtIndex:0] intValue]];
    [dateComponents setMinute:[[zohorTime objectAtIndex:1] intValue]];
    prayerTime.zohor = [cal dateFromComponents:dateComponents];
    
    node = PerformHTMLXPathQuery([NSData dataWithData:prayerTimeData], @"//table/tr[10]/td/font[6]");
    NSArray *asarTime = [[[node objectAtIndex:0] objectForKey:@"nodeContent"] componentsSeparatedByString:@":"];
    [dateComponents setHour:[[asarTime objectAtIndex:0] intValue]];
    [dateComponents setMinute:[[asarTime objectAtIndex:1] intValue]];
    prayerTime.asar = [cal dateFromComponents:dateComponents];
    
    node = PerformHTMLXPathQuery([NSData dataWithData:prayerTimeData], @"//table/tr[11]/td/font[6]");
    NSArray *maghribTime = [[[node objectAtIndex:0] objectForKey:@"nodeContent"] componentsSeparatedByString:@":"];
    [dateComponents setHour:[[maghribTime objectAtIndex:0] intValue]];
    [dateComponents setMinute:[[maghribTime objectAtIndex:1] intValue]];
    prayerTime.maghrib = [cal dateFromComponents:dateComponents];
    
    node = PerformHTMLXPathQuery([NSData dataWithData:prayerTimeData], @"//table/tr[12]/td/font[6]");
    NSArray *isyakTime = [[[node objectAtIndex:0] objectForKey:@"nodeContent"] componentsSeparatedByString:@":"];
    [dateComponents setHour:[[isyakTime objectAtIndex:0] intValue]];
    [dateComponents setMinute:[[isyakTime objectAtIndex:1] intValue]];
    prayerTime.isyak = [cal dateFromComponents:dateComponents];
    
    [self dispatchSolatToDelegate];
}

- (void)dealloc
{
    [prayerTimeData release];
    [urlConnection release];
    [prayerTime release];
    [delegate release];
    [url release];
    [super dealloc];
}

#pragma mark - Connection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [prayerTimeData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [prayerTimeData appendData:data];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([[self delegate] respondsToSelector:@selector(jakimSolatParser:didFailWithError:)]) {
        [[self delegate] jakimSolatParser:self didFailWithError:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self performXPathQuery];
}

@end
