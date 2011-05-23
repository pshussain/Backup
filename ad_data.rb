package data_wrapper;

message AdData {
  required int64 id = 1;
  required string ua = 2;
  optional string user_agent = 3;
  required string ipaddress =4;
  required string remote_ip = 5;
  required int64 campaign_id = 6;
  required int64 ad_id = 7;
  required string metrics = 8;
  required int32 cost = 9;
  required string ad_type = 10;
  required string ad_client_type = 11;
  required string keywords = 12;
  required string city = 13;
  required int32 client_id = 14;
  required int64 delivery_time =15;
  required string region = 16;
  required string country = 17;
  required string pay_status = 18;
  required string status = 19;
  required int32 zestadz_revenue = 20;
  required int32 publisher_revenue =21;
  required int32 impressions = 22;
  required int64 gross_margin = 23;
  required int64 gross_profit = 24;
  required int32 clicks = 25;
  required int32 publisher_payments_id = 26;
  required string currency_symbol = 27;
  required int32 advertiser_id = 28;
  required string phone_no = 29;
  required string carrier_name = 30;
  required string continent_code = 31;
  required string continent_name = 32;
  required string region_code = 33;
  required string url = 34;
  required string state = 35;
  required string mobile_model = 36;
  required string device_name = 37;
  
  
  
  
}