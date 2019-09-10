Program Lab3;

Uses crt;

Const
  MaxDiscOnDay = 7;//Максимальное количество пар в день

Type
  
  TDay = record //День
    Name: String; //Наименование дня недели
    DayPair: Integer; //Количество пар в дне недели
    Pair: array [1..MaxDiscOnDay] of String; //Названия пар
    Tpair: Integer; //Всего пар в день
  end;
  
  TTable = record //Общее расписание
    LearnType: String; //Форма обучения
    Faculty: String; //Факультет  
    NumberOfweek: Integer; //Количество недель в семестре 
    NumberOfDay: Integer; //Количество учебных дней в неделе
    DayOfWeek: array[1..7] of TDay; //День недели
    TotalDiscInWeek: Integer; //Количество пар в неделю
    TotalDiscInSemester: Integer; //Количество пар в семестр
  end;


Var
  Table: TTable; //Расписание
  i, j: Integer;


Begin
  
  write('Введите форму обучения (очная, заочная, очно-заочная): ');
  readln(Table.LearnType);
  writeln;
  write('Введите факультет: ');
  readln(Table.Faculty);
  writeln;
  write('Введите количество недель: ');
  readln(Table.NumberOfweek);
  writeln;
  write('Введите количество учебных дней в неделе: ');
  readln(Table.NumberOfDay);
  writeln;
  
  Table.TotalDiscInSemester := 0;
  
  for i := 1 to Table.NumberOfDay do 
  
  begin
    write('Введите ', i, '-й учебный день недели: ');
    readln(Table.DayOfWeek[i].Name);
    writeln;
    write('Введите количество пар в ', Table.DayOfWeek[i].Name, ': ');
    readln(Table.DayOfWeek[i].DayPair);
    writeln;
    
    for j := 1 to Table.DayOfWeek[i].DayPair do
    
    begin
      write('Введите ', j, '-ю пару: ');
      readln(Table.DayOfWeek[i].Pair[j]);
      writeln;
    end;
    
    Table.TotalDiscInWeek := Table.DayOfWeek[i].DayPair + Table.TotalDiscInWeek; //Расчет общего количества пар в неделю
  end;
  
  begin
    clrscr;
    
    writeln('Форма обучения: ', Table.LearnType);
    writeln;
    writeln('Факультет: ', Table.Faculty);
    writeln;
    writeln('Всего недель: ', Table.NumberOfweek);
    writeln;
    writeln('Всего учебных дней в неделе: ', Table.NumberOfDay);
    writeln;
    writeln('Всего пар в неделе: ', Table.TotalDiscInWeek);
    writeln;
    
    Table.TotalDiscInSemester := Table.TotalDiscInWeek * Table.NumberOfweek;//Расчет общего количества пар в семестр
    
    writeln('Всего пар в семестре: ', Table.TotalDiscInSemester);
    writeln;
    
    for i := 1 to Table.NumberOfDay do 
    begin
      writeln('Всего пар в день "', Table.DayOfWeek[i].Name, '": ', Table.DayOfWeek[i].DayPair);
      writeln;
      
      
      for j := 1 to Table.DayOfWeek[i].DayPair do
      
      begin
        writeln(j, '-я пара в день "', Table.DayOfWeek[i].Name, '": ', Table.DayOfWeek[i].Pair[j]);
        writeln;
      end;
    end;
    
  end;
  
End.

