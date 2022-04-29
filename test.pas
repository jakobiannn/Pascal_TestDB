//Программа тестирования модуля
program Test;

uses SummaryStat, Type89, TestFileCreate,crt;

var
  TestFile1, TestFile2, TestFile3, TestFile4: TStatisticFile;
  AStat: TStatisticList;
  ErrorCode: integer;
  TotalStat: TUserStatistic;
  TestStat: TTestStatistic;
  bestUser:TUserInfo;
  m, n, p, q: String;

begin
  write('Имя файла: ');
  readln(m);
  readln(p);
  readln(n);
  readln(q);
  
  SetLength(AStat, 4);
  
  AStat[0].User.Login := 'smg';
  AStat[0].User.UserName := 'Олег';
  AStat[0].TestRun.Score := 5;
  AStat[0].Test.TestName := 'ОКН';
  
  AStat[1].User.Login := 'tinkoff';
  AStat[1].User.UserName := 'Алексей';
  AStat[1].TestRun.Score := 4;
  AStat[1].Test.TestName := 'Геометрия_и_топология';
  
  AStat[2].User.Login := 'tinkoff';
  AStat[2].User.UserName := 'Алексей';
  AStat[2].TestRun.Score := 3;
  AStat[2].Test.TestName := 'Алгебра';
  
  AStat[3].User.Login := 'tinkoff';
  AStat[3].User.UserName := 'Алексей';
  AStat[3].TestRun.Score := 5;
  AStat[3].Test.TestName := 'Геометрия_и_топология';
  
  
  Assign(TestFile1, m); 
    Assign(TestFile2, p);
       Assign(TestFile3, n);
         Assign(TestFile4, q);
     
  rewrite(TestFile1);
    rewrite(TestFile2);
      rewrite(TestFile3);
        rewrite(TestFile4);
  
  
  write(TestFile1, AStat[0]);
     write(TestFile1, AStat[1]);
        write(TestFile1, AStat[2]);
          write(TestFile1, AStat[3]);
  

  
  TakingDatas(TestFile1, AStat, m);
     TakingDatas(TestFile2, AStat, p);
       TakingDatas(TestFile3, AStat, n);
         TakingDatas(TestFile4, AStat, q);
   

  FullUserStatistic('tinkoff', AStat, TotalStat, ErrorCode);
  
  
  
  SummaryStatUser('tinkoff', AStat, TotalStat );
  
  
  FullTestStatistic( 'Геометрия_и_топология', AStat, TestStat, ErrorCode);
  
  SummaryStatTest('Геометрия_и_топология', TestStat, AStat);
  
  BestTestUser(TestStat, AStat);
  
  bestAllUser(AStat, TotalStat,bestUser);
  
 ClrScr;
  
  Writeln('Логин: ', TotalStat.User.Login);
  Writeln('Имя: ', TotalStat.User.UserName);
  Writeln('Средний балл пользователя за все тесты: ',TotalStat.AvgUserPerTest);
  Writeln('Лучший тест: ', TotalStat.BestTest.TestName);
  Writeln;
  
  Writeln('Имя теста: ', TestStat.Test.TestName);
  Writeln('Средний балл за тест: ', TestStat.AvgPerTest);
  Write('Лучшие пользватели за тест: ');
  
  for var i:Integer := 0 to length(TestStat.BestUsers)-1 do
  Writeln(TestStat.BestUsers[i].Login);
  
  writeln('Лучший пользователь за все тесты: ',bestUser.login);
  
end.
