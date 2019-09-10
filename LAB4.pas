program LAB4;

{Дана целочисленная прямоугольная матрица. Определить 
1)кол-во строк, не содержащих ни одного нулевого элемента; 
2)Максимальное из чисел, встречающихся в заданной матрице более одного раза.} 

Uses crt;

const
  SIZE = 5;

type
  
  TIndex = 1..SIZE;//Максимальное количество элементов в матрице
  TElem = integer;//Тип элеменетов
  mtr = array [TIndex, TIndex] of TElem;//Прямоугольная матрица
  Tline = array [1..SIZE * SIZE] Of TElem;
  //Одномерный массив из элементов матрицы


function LinesWithZero(a: mtr; x, y: integer): integer;
//Функция, которая возвращает количество строк с нулевыми элементами

var
  i, j: integer; 
  k: integer;//Переменная,обозначающая количество искомых строк 

begin
  k := 0;
  for i := 1 to x do
    for j := 1 to y do
      if a[i, j] = 0 then
      begin
        k := k + 1;//подсчет нулевых строк
        break;//Переход на следующую строку 
      end;
  k := x - k; 
  LinesWithZero := k
end;


procedure MaxRep(const a: mtr; const x, y: integer; var max: Integer; 
var RepExists: boolean);
//находим повторяющиеся элементы

var
  i, j, b, k, n: integer;
  line: Tline;
  flag: boolean;

begin
  n := 1;
  for i := 1 to x do
    for j := 1 to y do
    begin
      line[n] := a[i, j];
      inc(n);
    end;
  
  for i := 1 to x * y - 1 do 
    for j := 1 to x * y - i do 
      if line[j] > line[j + 1] then 
      begin
        k := line[j];
        line[j] := line[j + 1];
        line[j + 1] := k;
      end;
  
  flag := false;
  
  for i := x * y downto 2 do
    if line[i] = line[i - 1] then
    begin
      max := line[i];
      flag := true;
    end;
    
  RepExists := flag;
  
end;




var
  a: mtr;
  x, y, i, j, mx, max: integer;
  RepExists: boolean;

begin
  clrscr;
  
  write('Количество строк', ' x=');
  readln(x);
  
  write('Количество столбцов', ' y=');
  readln(y);
  
  for i := 1 to x do
    for j := 1 to y do
      a[i, j] := random(20) - 10;//каждому элементу массива присваиваем случайное число 
  
  for i := 1 to x do
  begin
    for j := 1 to y do
    begin
      write(a[i, j]:3); //вывод элементов массива 
    end;
    writeln;
  end;
  
  writeln;
  
  writeln('Количество строк без нулевых элементов=', LinesWithZero(a, x, y));
  writeln;
  
  MaxRep(a, x, y, max, RepExists);
  
  if RepExists then 
     writeln('Наибольший, встреченный более 1 раза=', max)
   else writeln('В заданной матрице нет чисел, встречающихся более одного раза');
  
end.