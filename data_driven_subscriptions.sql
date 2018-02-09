declare @code varchar(25);
declare @prefix int;
declare @team varchar(100)

---------------------------- Enter initial values here ------------

set @code = 'dwam'; -- enter the report code as it appears in the database (rptCode)
set @prefix = 7;  -- Enter the day of the month that the report is being run
set @team = 'All'; -- Enter the name of the recipient/group that will appear at the end of the file name.

-------------------------------------------------------------------

declare @rptdate date;  --- date used for reports requiring a single date (Month Year)
declare @sDate date;  --- start date for reports that use a start and end date
declare @edate date;  --- end date for reports that use a start and end date
declare @LastDay int;  --- Last day of the month
declare @yearmonth int;
declare @monthnum int;
declare @shortmonth char(3);
declare @runDate date = getdate();
set @rptdate = dateadd(month,-1, getdate());
set @sDate = cast(cast(year(@rptdate) as char(4)) + '/' + cast(month(@rptdate) as varchar(2)) + '/1' as date);
set @lastday = day(dateadd(day,-1,cast(cast(year(@rundate) as char(4)) + '/' + cast(month(@rundate) as varchar(2)) + '/1' as date)));
set @edate = dateadd(day,@lastday - 1,@sdate);
set @yearmonth = (year(@rptdate) * 100) + month(@rptdate);
set @shortmonth = substring(datename(month,@runDate),1,3)       
set @monthnum = month(@rptdate);
  select 
  (cast(@prefix as char(1)) + 'th - ' + m.rptname + ' - ' + @team + '_1') as [Filename],
  ('\\bhg\company\Reports\Reporting\' + cast(year(@rptdate) as varchar(10)) + '\' + cast(month(@runDate) as varchar(2)) + '_' + @shortmonth  ) as [Pathname],
  @yearmonth as [rptMonth], @sdate as StartDate, @edate as LastDate 
  from rptSubscriptions m
  where rptcode = @code;
