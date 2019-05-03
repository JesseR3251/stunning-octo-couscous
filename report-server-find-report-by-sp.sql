SELECT Name,
CAST(CAST(Content AS VARBINARY(MAX)) AS VARCHAR(MAX)) AS ReportXML
FROM ReportServer.dbo.Catalog
where Type = 2
	AND CAST(CAST(Content AS VARBINARY(MAX)) AS VARCHAR(MAX)) LIKE '%DW_sRptReferralAgentDetail%'
order by Name