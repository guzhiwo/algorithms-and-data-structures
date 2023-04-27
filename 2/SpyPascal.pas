{
  Татьянина Мария пс - 23
  16. У множества шпионов,  собравшихся вместе для наблюдения
секретного     объекта,    имеется    единственный    бинокль.
Сформировалась очередь на этот  бинокль.  Для  каждого  шпиона
задан   период   наблюдения   в  минутах  и  предельное  время
нахождения в очереди. После наблюдения каждый шпион становится
снова  в  конец  очереди.  Как  только  для какого-либо шпиона
истекает предельное время нахождения в очереди, он покидает ее
(даже  если  в  этот момент владеет биноклем) и отправляется к
резиденту. Вывести протокол наблюдения шпионов за объектом(9).
  ABC pascal
}

program queueOfSpies(input, output);

type
  spy = ^spyType;
  spyType = RECORD 
              spyName: STRING;
              period: INTEGER;
              limitTime: INTEGER;
              next: spy
            END;
var
  root: spy;
  person, personName, st: STRING;
  T1: TEXT;
  i, personPeriod, personLimitTime, code : INTEGER;

PROCEDURE Insert(n: STRING; p, l: INTEGER; var s: spy);
begin
  if s = NIL
  then  
    begin
      NEW(s);
      s^.period := p;
      s^.limitTime := l;
      s^.spyName := n;
      s^.next := NIL;
    end
  else
    Insert(personName, personPeriod, personLimitTime, s^.next);  
end; {PrintTree}

PROCEDURE PrintTree(VAR s: spy);
BEGIN {PrintTree}
  IF s <> NIL
  THEN  
    BEGIN
      WRITELN(output, s^.spyName, ' ', s^.period, ' ', s^.limitTime);
      PrintTree(s^.next);
    END  
END; {PrintTree}

PROCEDURE PrintOut(s: spy);
var
  tt, qt, i: INTEGER; 
  endQueue, q: boolean;
  x, dx: spy;
BEGIN
  endQueue := false;
  tt := -1;
  qt := -1;
  
  while (endQueue = false) and (s <> nil) 
  do  
    begin
      tt := tt + 1;
      qt := qt + 1;
      
      if (tt = 0) and (s^.next <> NIL)
      then 
        WRITELN('в момент ', tt:2, ' ', s^.spyName, ' начал наблюдение');

      if (qt - s^.period = 0) and (s^.next <> nil)
      then 
        begin
          if (tt = 0)
          then
            WRITE(' ':12, ' ', s^.spyName, ' закончил наблюдение и ')
          else
            WRITE('в момент ', tt:2, ' ', s^.spyName, ' закончил наблюдение и ');
          if (tt - s^.limitTime) = 0
          then
            begin
              WRITE('отправился к резиденту');
              if(s^.next <> NIL)
              then
                begin
                  x := s;
                  s := s^.next;
                  dispose(x);
                  x:= nil;
                  WRITELN;
                  WRITELN(' ':12, s^.spyName, ' начал наблюдение')
                end              
            end
          else
            begin
              WRITELN('ушёл в конец очереди');
              x := s;
              while x^.next <> nil 
              do
                x := x^.next;
              x^.next := s;
              s := s^.next;
              x^.next^.next := nil; 
              WRITELN(' ':12, s^.spyName, ' начал наблюдение')
            end; 
          qt := 0;
        end;


      q := false;
      dx := nil;
      x := s; 
      i := 0; 


      while (q = false) and (s^.next <> nil)
      do
        begin
          if (x <> nil) and (x^.next <> nil)
          then
            begin
              dx := x;
              x := x^.next  
            end;
          if (x <> nil) and (tt - x^.limitTime = 0)
          then 
            begin
              WRITELN('в момент ', tt, ' ', x^.spyName, ' отправился к резиденту');
              dx^.next := x^.next;
              dispose(x);
              x := dx;
            end;
          
          if (q = false) and ((x = nil) or (x^.next = nil))
          then 
            begin
              q := true;
              x := nil
            end;
        end;

      if (tt - s^.limitTime = 0)  and (s^.next <> nil)
      then
        begin
          WRITELN('в момент ', tt:2, ' ', s^.spyName, ' отправился к резиденту');
          s:= s^.next;
          dispose(x);
          x := s 
        end;
        
      if (s <> nil) and (tt - s^.limitTime = 0) and (s^.next = nil)
      THEN
        begin
          WRITELN('в момент ', tt, ' ', s^.spyName, ' закончил наблюдение и отправился к резиденту последним');
          dispose(s);
          s := nil; 
          endQueue := true
        end;
      x := s
      
    end  
END;





begin 
  ASSIGN(T1, 'inp.txt');  
  {$I-}
  RESET(T1);
  {$I+}
  if IOResult = 0
  then
    begin
      ASSIGN(T1, 'inp.txt'); 
      RESET(T1);
      person:='';
      i := 1;
      root := NIL;
      st := '';
      personPeriod := 0;
      personLimitTime := 0;
      personName := '';
      WHILE not eof(T1)
      DO
        BEGIN
          READLN(T1, person);
          i := 1;
          WHILE person[i] <> ' '
          DO
            begin
              st := st + person[i];
              i := i+1;
            end;
          i := i+1;
          personName := st;
          st := '';

          WHILE person[i] <> ' '
          DO
            begin
              st := st + person[i];
              i := i+1
            end;
          i := i+1;
          val(st, personPeriod, code);
          st := '';

          WHILE i <> Length(person) + 1
          DO
            begin
              st := st + person[i];
              i := i+1
            end;
          val(st, personLimitTime, code);
          st := '';

          Insert(personName, personPeriod, personLimitTime, root);
        END;
      PrintTree(root);
      PrintOut(root);
    end
  else
    begin
      WRITELN('error: file not found');
      EXIT
    end;
end.