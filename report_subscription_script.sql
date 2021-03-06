SELECT USR.UserName AS SubscriptionOwner 
      ,SUB.ModifiedDate 
      ,SUB.[Description] 
      ,SUB.EventType 
      ,SUB.DeliveryExtension 
      ,SUB.LastStatus 
      ,SUB.LastRunTime 
      ,SCH.NextRunTime 
      ,SCH.Name AS ScheduleName       
      ,CAT.[Path] AS ReportPath 
      ,CAT.[Description] AS ReportDescription 
FROM dbo.Subscriptions AS SUB 
     INNER JOIN dbo.Users AS USR 
         ON SUB.OwnerID = USR.UserID 
     INNER JOIN dbo.[Catalog] AS CAT 
         ON SUB.Report_OID = CAT.ItemID 
     left JOIN dbo.ReportSchedule AS RS 
         ON SUB.Report_OID = RS.ReportID 
            AND SUB.SubscriptionID = RS.SubscriptionID 
     left JOIN dbo.Schedule AS SCH 
         ON RS.ScheduleID = SCH.ScheduleID 
WHERE sub.eventtype = 'TimedSubscription'
	AND SUB.LastStatus <> 'Disabled'
	AND SUB.LastRunTime BETWEEN '1/18/18' AND '1/19/18'
ORDER BY USR.UserName 
        ,CAT.[Path];