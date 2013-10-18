/**
 * @class      XMLConverterExample XMLConverterExample.m "XMLConverterExample.m"
 * @brief      XMLConverterExample
 * @details    XMLConverterExample.m in XMLConverter
 * @date       10/16/13
 * @copyright  Copyright (c) 2013 Ruslan Soldatenko. All rights reserved.
 */

#import "XMLConverterExample.h"
#import "XMLConverter.h"

@implementation XMLConverterExample

+ (void)example {
  /// Example 1 and 2: XML Response Convertion
  /*
   212.24.43.44 - IP address of habrahabr.ru
   You can use another IP with restriction of ipgeobase.ru:
   coordinates (needed for next example) will returned only for IP located in Russia or Ukraine.
   */
  NSString *ipAddress = @"212.24.43.44";
  NSString *urlString = [NSString stringWithFormat:@"http://ipgeobase.ru:7020/geo/?ip=%@", ipAddress];
  NSURL *xmlUrl = [NSURL URLWithString:urlString];
  [XMLConverter convertXMLURL:xmlUrl completion:^(BOOL success, NSDictionary *dictionary, NSError *error)
  {
    if (success)
    {
      NSDictionary *ip = dictionary[@"ip-answer"][@"ip"];
      NSLog(@"\n\n***************************Example 1******************************\n\n");
      NSLog(@"%@\nIP Address: %@\nLocated: %@ - %@\nCoordinates: Latitude: %@ Longtitude: %@", dictionary ,ip[@"-value"], ip[@"district"], ip[@"city"], ip[@"lat"], ip[@"lng"]);
      NSLog(@"\n******************************************************************");
      
      //Creating new request with received data
      //langID - Language of response: 1 = EN, 25 = RU
      int langID = 1;
      NSString *anotherUrlString = [NSString stringWithFormat:@"http://levelup.accu-weather.com/widget/levelup/weather-data.asp?slat=%@&slon=%@&metric=1&LangId=%i", ip[@"lat"], ip[@"lng"], langID];
      NSURL *xmlAnotherUrl = [NSURL URLWithString:anotherUrlString];
      [XMLConverter convertXMLURL:xmlAnotherUrl completion:^(BOOL success, NSDictionary *dictionary, NSError *error) {
        NSLog(@"\n\n***************************Example 2******************************\n\n");
        NSLog(@"%@", success ? dictionary : error);
        NSLog(@"\n******************************************************************");
      }];
    }
    else
    {
      NSLog(@"%@", error);
    }
  }];
  /// Example 3: XML File Convertion
  /**
   WARNING!
   This example will work only if file XMLExample.xml include in project.
   In other case example will return error.
   */
  NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"XMLExample" ofType:@"xml"];
  [XMLConverter convertXMLFile:xmlFilePath completion:^(BOOL success, NSDictionary *dictionary, NSError *error)
   {
     NSLog(@"\n\n***************************Example 3******************************\n\n");
     NSLog(@"%@", success ? dictionary : error);
     NSLog(@"\n******************************************************************");
   }];
  ///Examle 4 and 5: XML String Convertion
  NSString *xmlString = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<commands>\n  <command id=\"0\" name=\"GetAPPsProducts\">\n    <command_parameters>\n      <command_parameter id=\"0\" name=\"APPs_Code\">ATAiOS</command_parameter>\n    </command_parameters>\n    <command_result>\n      <apps_products>\n        <apps_products id=\"1\">\n          <apps_code>ATAiOS</apps_code>\n          <apps_product_id>2</apps_product_id>\n          <brand_id>2</brand_id>\n          <brand_desc>Generic</brand_desc>\n          <brand_product_id>2</brand_product_id>\n          <product_id>001-7</product_id>\n          <descrizione>MyTravelApp</descrizione>\n        </apps_products>\n      </apps_products>\n    </command_result>\n  </command>\n</commands>";
  [XMLConverter convertXMLString:xmlString completion:^(BOOL success, NSDictionary *dictionary, NSError *error)
   {
     NSLog(@"\n\n***************************Example 4******************************\n\n");
     NSLog(@"%@", success ? dictionary : error);
     NSLog(@"\n******************************************************************");
   }];
  NSString *xmlAnotherString = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<contacts>\n  <contact id=\"1\">\n    <name>John Smith</name>\n    <phone>123-456-7890</phone>\n    <address>\n      <street>123 Same Street</street>\n      <city>Same Town</city>\n      <state>Same State</state>\n      <zipCode>12345</zipCode>\n    </address>\n  </contact>\n  <contact id=\"2\">\n    <name>Frank Dail</name>\n    <phone>098-765-4321</phone>\n    <address>\n      <street>321 Another Street</street>\n      <city>Another Town</city>\n      <state>Another State</state>\n      <zipCode>54321</zipCode>\n    </address>\n  </contact>\n</contacts>";
  [XMLConverter convertXMLString:xmlAnotherString completion:^(BOOL success, NSDictionary *dictionary, NSError *error)
   {
     NSLog(@"\n\n***************************Example 5******************************\n\n");
     NSLog(@"%@", success ? dictionary : error);
     NSLog(@"\n******************************************************************");
   }];
}

@end
