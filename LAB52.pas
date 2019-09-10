program LAB52;
//Определить, является ли последовательность чисел, записанных в файл, монотонной 

Uses TestCtreate;

var
  LabFile:  Tfile;
  name:     string;
  mass:     Tarray;
  m:        Tarray;
  s:        integer;
  i, j:     integer;
  size:     integer;
  p:        integer;
  flag:     boolean;

begin
  Writeln('Выберите пункт меню(1-5)');
  Writeln('1-Создать убывающую последовательность');
  Writeln('2-Создать возрастающую последовательность');
  Writeln('3-Создать немонотонную последовательность');
  Writeln('4-Создать фаил с одним элементом');
  Writeln('5-Создать пустой файл');
  
  Readln(s);
  
  case s of
    1:  DecSequence(LabFile);
    2:  IncSequence(LabFile);
    3:  NotMonotoneSequence(LabFile);
    4:  SingleElementSequence(LabFile);
    5:  SequenceIsEmpty(LabFile);
  end;
  writeln;
  reset(LabFile);
  i := 0;
  while not EOF(labFile) do
  begin
    inc(i);
    read(labFile, mass[i]);
  end;
  
  size := i;//Размер последовательности
  
  if size = 1 then
  begin
    writeln('Последовательность состоит из одного элемента');
    exit;
  end;
  
  for i := 1 to size do
    m[i] := mass[i];
  
  for i := 1 to size - 1 do
    for j := 1 to size - i do
      if m[j] > m[j + 1] then
      begin
        p := m[j];
        m[j] := m[j + 1];
        m[j + 1] := p;
      end;
  
  for i := 1 to size do
    if m[i] <> mass[i] then
      break
      else
    if i = size then
    begin
      writeln('Последовательность возрастающая');
      exit;
    end;
  
  for i := size downto 2 do
    for j := size downto  (size - i + 2) do
      if m[j] > m[j - 1] then
      begin
        p := m[j];
        m[j] := m[j - 1];
        m[j - 1] := p;
      end;
  
  for i := 1 to size do
    if m[i] <> mass[i] then
      break
      else
    if i = size then
    begin
      writeln('Последовательность убывающая'); 
      exit;
    end;
  
  
  if Filesize(LabFile) = 0 then
  begin
    writeln('Файл пустой');
    exit;
  end;
  
  writeln('Последовательность немонотонная');
  
  
end.



