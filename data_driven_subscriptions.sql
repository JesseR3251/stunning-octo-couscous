-- exec usp_SpecialRpts @code='dwam', @prefix=7, @team='All'
declare @code varchar(25);
declare @prefix int;
declare @team varchar(100)

---------------------------- Enter initial values here ------------

set @code = 'dwam'; -- enter the report code as it appears in the database (rptCode)
set @prefix = 7;  -- Enter the day of the month that the report is being run
set @team = 'All'; -- Enter the name of the recipient/group that will appear at the end of the file name.

-------------------------------------------------------------------

declare @rptdate date;
declare @yearmonth int;
declare @monthnum int;
declare @shortmonth char(3)
set @rptdate = dateadd(month,-1, getdate());
set @yearmonth = (year(@rptdate) * 100) + month(@rptdate);
set @shortmonth = substring(datename(month,@rptdate),1,3)       
set @monthnum = month(@rptdate);
  select 
  (cast(@prefix as char(1)) + 'th - ' + m.rptname + ' - ' + @team + '_1') as [Filename],
  ('\\bhg\company\Reports\Reporting\' + cast(year(@rptdate) as varchar(10)) + '\' + cast(month(@rptdate) as varchar(2)) + '_' + @shortmonth  ) as [Pathname],
  @yearmonth as [rptMonth] 
  from rptSubscriptions m
  where rptcode = @code;