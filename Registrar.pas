unit Registrar;

interface
uses Encryption, customers;
//  uses CRT;

procedure Registration; 
procedure MainMenuReg; 
function EnteredInSystem: byte;
 
implementation

//---------------------------------------------------------------------------- 
procedure MainMenuReg;
 //Главное меню модуля
 
 Var
  n:integer;
  
 Begin
 Repeat
   Writeln('Модуль регистрации пользователей');
   Writeln;
   Writeln('1-Регистрация');
   Writeln('2-Вход в систему');
   Writeln('3-Выход из меню регистрации');
   Writeln('Выберите пункт меню:');
   Readln(n);
    case n of
     1: Registration;
     2: EnteredInSystem;
     else Writeln('Вы вышли из меню регистрации')
    end; 
 until n>2;
 end;
 //----------------------------------------------------------------------------

 
procedure Registration;
 //Пункт меню 1 - Регистрация в системе
 Var
 UI:TUserInfo;
 Login, Password, passwd,  Name, Group: string;
 
 Begin
 //ClrStr;
 Writeln('Введите логин: ');
 Readln(Login);
 
  If isFoundUser(NameDB_file, Login, Passwd)  then
    Begin 
     Writeln('Пользователь с таким логином уже зарегистрирован')
    end
   else
     begin
 Writeln('Введите пароль: ');
 Readln(Password);
 
 Writeln('Введите ФИО: ');
 Readln(Name);
 
 Writeln('Введите номер учебной группы: ');
 Readln(Group);
  
 UI.Login:=Login;
 UI.Password:=Encrypt(Password, TypeEncr); 
 UI.Name:=Name;
 UI.Group:=Group;  
 AppendUserToFile(NameDB_file, UI);
    end
 
 end;
 //----------------------------------------------------------------------------

 
 //1 - авторизован, 0 - не авторизован
function EnteredInSystem: byte;
 //Пункт меню 2 - Вход в систему
 Var
 Login     :string;
 Password, passwd  :string;
 
 Begin
 //ClrStr;
 Writeln('Введите логин: ');
 Readln(Login);
 
 Writeln('Введите пароль: ');
 Readln(Password);
 Password:=Encrypt(Password, TypeEncr);
 
   If isFoundUser(NameDB_file, Login, passwd)  then
    begin
     if Password=passwd then 
     begin
     EnteredInSystem:= 1;
     LogUser:= Login;
     writeln('Вы вошли в систему');
     end
     else 
     begin
     EnteredInSystem:=0;
     writeln('Неправильно введен пароль')
     end
    end
    else EnteredInSystem:=0;

 end;
 
 
 end.
 //----------------------------------------------------------------------------