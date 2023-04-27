{
  18. В   некотором   институте   информация   об   имеющихся
компьютерах  задана двумя деревьями.  В первом из них сыновьям
корневой вершины соответствуют факультеты,  факультеты в  свою
очередь  делятся  на  кафедры,  кафедры  могут  иметь  в своем
составе лаборатории. Компьютеры могут быть установлены в общих
факультетских   классах,   на   кафедрах,   в  лабораториях  и
идентифицируются  уникальными  номерами.  Во   втором   дереве
сыновьям корня соответствуют учебные корпуса, корпуса включают
списки  аудиторий,  а  для  каждой  аудитории  заданы   номера
находящихся  в  них  компьютеров.  Некоторые  аудитории  могут
принадлежать  нескольким  факультетам.  Выдать  список   таких
аудиторий (12).
Татьянина Марияб пс-23
Free Pascal
}

Program TreeION;

Type
  ukaz = ^uzel;
  uzel = record
         location: string;
         name: string;     
         left, right: ukaz; 
         fath: ukaz;       
         urov: integer;    
       end;
       
Var
  root1, root2: ukaz;
  TreeNum, faculty: string;
  Fin1, Fin2, Fout: text;

Procedure PechPr1(var r1, r2: ukaz; s: string; var faculty: string; var isNotEnd: boolean);
Var
  St: string;

Begin
  if r2 <> nil 
  then
    Begin
      St := r2^.name;
      if (St = s) and (r2^.location <> '') 
      then
        Begin
          isNotEnd := false;
          if (faculty <> '') and (faculty <> r2^.location)
          then
            begin
              writeln(Fout, r1^.location);
              faculty := '';
            end
          else
            faculty := r2^.location;
        end;
        if isNotEnd
        then
          PechPr1(r1, r2^.left, s, faculty, isNotEnd);
        if isNotEnd
        then
          PechPr1(r1, r2^.right, s, faculty, isNotEnd);
    end;
End;

Procedure PechPr2(var r1, r2: ukaz; var faculty: string);  
Var
  St: string;
  isNotEnd: boolean; 
Begin
  isNotEnd := true;
  if r1 <> nil 
  then
    Begin
      St := r1^.name;
      if r1^.location <> ''
      then
        PechPr1(r1, r2 , St, faculty, isNotEnd);
      PechPr2(r1^.left, r2, faculty);
      PechPr2(r1^.right, r2, faculty)
    end;
End;

Procedure FromFile(var F: text; var ro: ukaz; TN: string);
Var
  i, m, k, Len: integer;
  R, S, position: string;  
  p, t, kon: ukaz;
Begin
  position := '';
  While not Eof(F) 
  do
    begin
      ReadLn(F, S);
      k := 0;
      Len := Length(S);
      While S[k+1] = '.' do k := k+1;  
      R := Copy(S, k+1, Len-k);  
      if (k = 1) and (TN = 'first') 
      then 
        position := R;
      if (k = 2) and (TN = 'second') 
      then 
        position := R;  
      New(kon);
      kon^.name := R;
      kon^.left := nil;
      kon^.right := nil;
      kon^.urov := k;
      kon^.location := '';
      if (position <> '')
      then
        kon^.location := position;
      if k = 0 
      then    
        begin
          ro := kon;     
          kon^.fath := nil;
          m := 0;            
          t := kon;       
          continue;
        end;
      if k > m 
      then      
        begin
          t^.left := kon;
          kon^.fath := t;
        end
      else                    
        if k = m 
        then     
          begin
            t^.right := kon;
            kon^.fath := t^.fath;       
          end
        else                 
          begin
            p := t;
            For i := 1 to m-k do
               p := p^.fath;
            kon^.fath := p^.fath; 
            p^.right := kon;
          end;
      m := k;
      t := kon;       
    end; 
End;

Begin
  Assign(Fin1, 'input1.txt');
  Assign(Fin2, 'input2.txt'); 
  Assign(Fout, 'output.txt'); 
  {$I-}
  Reset(Fin1);
  Reset(Fin2);
  {$I+}
  if IOResult = 0
  THEN
    begin
      New(root1);
      New(root2);         
      
      TreeNum := 'first';
      FromFile(Fin1, root1, TreeNum);
      TreeNum := 'second';  
      FromFile(Fin2, root2, TreeNum);           
      Close(Fin1);
      Close(Fin2);
      Rewrite(Fout); 
      faculty := '';
      PechPr2(root2, root1, faculty);
      Close(Fout)
    end
  ELSE
    BEGIN
      WRITELN('error');
      EXIT
    END;
End.
