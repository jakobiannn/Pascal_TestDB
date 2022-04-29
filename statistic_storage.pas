
// Модуль описания хранения данных
unit Type89;

Interface

type
  TCode = string[10];
  TDate = string[20];
  TName = string[80];
  
  TUserInfo = record
    Login: TCode;
    UserName: TName;     
  end;
  
  TTestInfo = record
    TestName: TName;  
    TestFile: TName;
  end;
  
  TTestRun = record
    StartDate, EndDate: TDate;
    Score: integer; 
    Mark: TCode;        
  end;
  
  TStatistic = record
    User: TUserInfo;
    Test: TTestInfo;
    TestRun: TTestRun;  
  end;
  
  TStatisticList = array of TStatistic;
  
  TStatisticFile = file of TStatistic;
  
  TUserStatistic = record
    User: TUserInfo;
    AvgUserPerTest:Real;
    BestTest: TTestInfo;
    TestsRun: array of TStatistic;
  end;
  
  TTestStatistic = record
    Test: TTestInfo;
    BestUsers: array of TUserInfo;
    AvgScoreTests:Real;
    AvgPerTest:Real;
    TestsRun: array of TStatistic;  
  end;
  
 implementation
 
 end.