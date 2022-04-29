//Модуль расчета сводной статистики
unit SummaryStat;



interface

uses Type89;


procedure TakingDatas(const FileRead: file of TStatistic; var TotalInfo: TStatisticList; FileName: String);


procedure FullUserStatistic(Login: TCode; const Stat: TStatisticList; 
          var TotalStat: TUserStatistic; var ErrorCode: integer);

procedure SummaryStatUser(Login: String; Stat: TStatisticList; var  SummStat: TUserStatistic);

procedure FullTestStatistic(TestName: TName; const Stat: TStatisticList; 
          var TotalStat: TTestStatistic; var ErrorCode: integer);

procedure SummaryStatTest(const TestName: TName; var SummStat: TTestStatistic; Stat: TStatisticList);

procedure bestAllUser(Stat:TStatisticList; SummStat: TUserStatistic; var bestUser:TUserInfo);

procedure BestTestUser(var TestInfo: TTestStatistic; const  Stat: TStatisticList);


implementation

procedure TakingDatas(const FileRead: file of TStatistic; var TotalInfo: TStatisticList; FileName: String);
var 
i:Integer;
begin
  
  assign(FileRead, Filename);
  
  Reset(FileRead);
  
  i := 0;
  while not (EOF(FileRead)) do
  begin
     Read(FileRead, TotalInfo[i]);
     i := i + 1;
  end;
  
  close(FileRead);
  
  
end;


//Статистика прохождения теста пользователем


procedure UserFindByLogin(Login: TCode; const Stat: TStatisticList; 
  var UserInfo: TUserInfo; var ErrorCode: integer);
var
  i, n: integer;
begin
  i := 0;
  
  n := Length(Stat);
  
  while i <= n - 1 do
  begin
    if Stat[i].User.Login = Login then
    begin
      ErrorCode := 0;
      UserInfo.Login := Stat[i].User.Login;
      UserInfo.UserName := Stat[i].User.UserName; 
      exit;
    end;    
    
    i := i + 1;
  end;
  
  ErrorCode := -1;//not found!
end;

procedure FullUserStatistic(Login: TCode; const Stat: TStatisticList; 
  var TotalStat: TUserStatistic; var ErrorCode: integer);
var
  UserInfo: TUserInfo;
  i, k, n: integer;
begin
  //ищем пльзователя
  UserFindByLogin(Login, Stat, UserInfo, ErrorCode);
  
  if ErrorCode <> 0 then
    exit;
  
  //пользователь найден, рабоаем!
  i := 0; k := -1;
  n := Length(Stat);
  
  TotalStat.User := UserInfo;
  //заполняем статистику пользователя
  while i <= n - 1 do
  begin
    if Stat[i].User.Login = Login then
    begin
      k := k + 1;
      
      SetLength(TotalStat.TestsRun, k + 1);
      TotalStat.TestsRun[k] := Stat[i];
    end;        
    i := i + 1;
  end;
  
  
end;

procedure SummaryStatUser(Login: String; Stat: TStatisticList; var  SummStat: TUserStatistic);
var
  
  j, i, Max, count: Integer;
begin
    //avg score user
  count := 0;
  SummStat.AvgUserPerTest := 0;
  for i := 0 to Length(SummStat.TestsRun) - 1 do
    if SummStat.TestsRun[i].User.Login = Login then 
    begin
      for j := 0 to Length(SummStat.TestsRun) - 1 do
      begin
        SummStat.AvgUserPerTest := SummStat.AvgUserPerTest + SummStat.TestsRun[i].TestRun.Score;
        count := count + 1; 
      end;
    end;
  SummStat.AvgUserPerTest := SummStat.AvgUserPerTest / count;
  
  Max := 0;
  for i := 1 to Length(SummStat.TestsRun)-1 do 
    begin
      if SummStat.TestsRun[i].TestRun.Score >= SummStat.TestsRun[Max].TestRun.Score then
        begin
          Max := i;
          SummStat.BestTest := SummStat.TestsRun[Max].Test
        end;
    end;
  
end;

  //статистика прохождения заданного теста;

procedure TestFind(TestName: TName; const Stat: TStatisticList; 
  var TestInfo: TTestInfo; var ErrorCode: integer);
var
  i, n: integer;
begin
  i := 0;
  
  n := Length(Stat);
  
  while i <= n - 1 do
  begin
    if Stat[i].Test.TestName = TestName then
    begin
      ErrorCode := 0;
      TestInfo.TestName := Stat[i].Test.TestName;
      TestInfo.TestFile := Stat[i].Test.TestFile; 
      exit;
    end;    
    
    i := i + 1;
  end;
  
  ErrorCode := -1;//not found!
end;

procedure FullTestStatistic(TestName: TName; const Stat: TStatisticList; var TotalStat: TTestStatistic; var ErrorCode: integer);
  
var
  TestInfo: TTestInfo;
  //UserInfo: TUserInfo;
  i, k, n: integer;
begin
  //ищем пльзователя
  TestFind(TestName, Stat, TestInfo, ErrorCode);
  
  if ErrorCode <> 0 then
    exit;
  
  
  i := 0; k := -1;
  n := Length(Stat);
  
  TotalStat.Test := TestInfo;
  //заполняем статистику ТЕСТА
  while i <= n - 1 do
  begin
    
    if Stat[i].Test.TestName = TestName then
    begin
      k := k + 1;
      
      SetLength(TotalStat.TestsRun, k + 1);
      TotalStat.TestsRun[k] := Stat[i];
    end;        
    i := i + 1;
  end;
end;

procedure SummaryStatTest(const TestName: TName; var SummStat: TTestStatistic; Stat: TStatisticList);
var
  i, count: Integer;
begin
  
  //avg score per test
  count := 0;
  SummStat.AvgPerTest := 0;
  for i := 0 to length(SummStat.TestsRun) - 1 do 
  begin
    if SummStat.TestsRun[i].Test.TestName = TestName then
      SummStat.AvgPerTest := SummStat.AvgPerTest + SummStat.TestsRun[i].TestRun.Score;
    count := count + 1; 
  end;
  SummStat.AvgPerTest := SummStat.AvgPerTest / count;
  
  
  
  //avg score all tests
  SummStat.AvgScoreTests := 0;
  
  
  for i := 0 to length(stat) - 1 do 
    SummStat.AvgScoreTests := SummStat.AvgScoreTests + Stat[i].TestRun.Score;  
  SummStat.AvgScoreTests := SummStat.AvgScoreTests / (1);
  
  
  
end;

//лучшие пользователи за данный тест

procedure BestTestUser(var TestInfo: TTestStatistic; const  Stat: TStatisticList);

var
  k, i, Max: Integer;
begin
  
  max:=0; k:=-1;
  for i := 0 to length(TestInfo.TestsRun)-1 do 
     begin
      if TestInfo.TestsRun[i].TestRun.Score >= TestInfo.TestsRun[Max].TestRun.Score then
       begin
        max := i;
       end;
         end;
       
  for i := 0 to length(TestInfo.TestsRun)-1 do
    if TestInfo.TestsRun[max].TestRun.Score = TestInfo.TestsRun[i].TestRun.Score then 
      begin
        k:= k+1;
        Setlength(TestInfo.BestUsers,k+1);
        TestInfo.BestUsers[k]:= TestInfo.TestsRun[i].User;
     end;
end;


//procedure SummaryStatUser(Login: String; Stat: TStatisticList; var  SummStat: TUserStatistic);
//Вызовем эту процедуру для вывода среднего 
procedure bestAllUser(Stat:TStatisticList; SummStat: TUserStatistic; var bestUser:TUserInfo);
var
maxNUser,i:Integer;
maxScore:real;
begin
     maxScore := -1;
     maxNUser := 0;
      for i := 1 to length(Stat)-1 do 
        begin
         SummaryStatUser(Stat[i].User.Login,Stat,SummStat);
           if SummStat.AvgUserPerTest > MaxScore then
            MaxScore := SummStat.AvgUserPerTest;
            maxNUser:=i;
        end;
       SummaryStatUser(Stat[maxNUser].User.Login,Stat,SummStat);
       bestUser := SummStat.User;

end;


end.
