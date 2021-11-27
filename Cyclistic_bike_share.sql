/*-- This is a 12 month data set used to complete the  Google Data Analytics Capstone project Case Study 1: How does a bike-share navigate speedy success?  
This data has been made available by Motivate International Inc.) ---*/

--- I use UNION fuction and merg the 12 month data and create View ---
ALTER view tripdata as

SELECT [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 
DATEPART( dw,[started_at] ) as date_of_week,  [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual] FROM [dbo].['202011$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 

DATEPART( dw,[started_at] ) as date_of_week, [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual] FROM [dbo].['202012$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 
DATEPART( dw,[started_at] ) as date_of_week , [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual]  FROM [dbo].['202101$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at],
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 
DATEPART( dw,[started_at] ) as date_of_week,  [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual] FROM [dbo].['202102$']
UNION
SELECT  [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 
DATEPART( dw,[started_at] ) as date_of_week,  [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual]  FROM [dbo].['202103$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at],
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 
DATEPART( dw,[started_at] ) as date_of_week,  [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual]  FROM [dbo].['202104$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 
DATEPART( dw,[started_at] ) as date_of_week, [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual]  FROM [dbo].['202105$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length , 
DATEPART( dw,[started_at] ) as date_of_week, [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual]  FROM [dbo].['202106$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 
DATEPART( dw,[started_at] ) as date_of_week,  [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual] F FROM [dbo].['202107$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at],
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length,
DATEPART( dw,[started_at] ) as date_of_week,  [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual] FROM [dbo].['202108$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length ,
DATEPART( dw,[started_at] ) as date_of_week,  [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual] FROM [dbo].['202109$']
UNION
SELECT [ride_id], [rideable_type], [started_at], [ended_at], 
datediff(MINUTE ,[started_at] , [ended_at]) as ride_length, 
DATEPART( dw,[started_at] ) as date_of_week, [start_station_name], 
[start_station_id], [end_station_name], [end_station_id], [start_lat], [start_lng], [end_lat], 
[end_lng], [member_casual] FROM [dbo].['202110$'];

--SELECT * FROM [dbo].[tripdata]

--- Total riders avegar ride lenght and maximum ride length per member_casual
SELECT count(DISTINCT [ride_id]) as total_rider, [member_casual],  AVG(ride_length) as avg_ride_leng, MAX([ride_length]) as max_ride_leng
FROM [dbo].[tripdata]
GROUP BY [member_casual]
---Average ride length user per day of week
 SELECT  [member_casual], [date_of_week] , AVG(ride_length) as avg_ride_leng from [dbo].[tripdata]
GROUP BY [date_of_week] ,  [member_casual]
ORDER BY [date_of_week]
 
 ---Users ride start and ride end point
 SELECT  ([ride_id]),[member_casual],
 GEOGRAPHY::Point( [start_lat] , [start_lng] , 4326 ) as ride_start_point,
 GEOGRAPHY::Point([end_lat] , [end_lng] , 4326) as ride_end_poin
 FROM [dbo].[tripdata]
 WHERE [start_lat] IS NOT NULL  AND [start_lng] IS NOT NULL AND  [end_lat] IS NOT NULL AND  [end_lng] IS NOT NULL

 --- Users star and end point by longtude and latitude
 SELECT DISTINCT([ride_id]), [member_casual] , 
 count(DISTINCT[start_station_id]) AS start_station_id, 
 count(DISTINCT[end_station_id]) AS end_station_id, [start_lat] ,[start_lng], [end_lat] , [end_lng]
 FROM [dbo].[tripdata]
 WHERE [start_lat] IS NOT NULL  AND [start_lng] IS NOT NULL AND  [end_lat] IS NOT NULL AND  [end_lng] IS NOT NULL
 GROUP BY [start_lat] , [start_lng], [end_lat] , [end_lng], [member_casual], [ride_id]

 --- user per rideable type
 SELECT COUNT([ride_id]) as num_ride_id, [member_casual] , [rideable_type]
 FROM [dbo].[tripdata]
 GROUP BY [rideable_type], [member_casual]

 --- count of Totla Ride ID for Member_casual
  SELECT COUNT([ride_id]), [member_casual]
  FROM [dbo].[tripdata]
  GROUP BY member_casual

  --- top 20 [start_station_name] and [end_station_name] with location

  SELECT TOP 20 [start_station_name], [end_station_name], [start_lat], [start_lng],[end_lat], [end_lng]
  FROM  [dbo].[tripdata]
  WHERE [start_station_name] IS NOT NULL