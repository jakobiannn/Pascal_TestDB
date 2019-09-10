program Lab2;

 //Вывести буквы,входящие в текст только один раз

type
  TBukvu = set of 'A'..'я';

var
  s: string; //Начальный текст
  i: Integer; 
  first: TBukvu; //Множество букв, которые встретились в первый раз
  following: TBukvu; //Множество букв, которые встретились в последующие разы
  answer: TBukvu;//Буквы, входящие в текст только один раз

begin
  write('Введите текст: '); 
  readln(s);
  
  for i := 1 to Length(s) do 
    if not (s[i] in first) then
      include(first, s[i])
    else include(following, s[i]);
  
  answer := first - following;
  
  Write('Буквы, входящие в текст один раз:', answer);
  
end. 