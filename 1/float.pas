{ Татьянина Мария -23 
  Составить программу перевода вещественного числа в форму константы 
  с плавающей точкой в строковом формате.
  Целая часть мантиссы должна состоять из одной цифры. (8)
  GNUPascal
}
PROGRAM realNum(INPUT, OUTPUT);
VAR
  M: REAL;
  St: STRING;
  E: INTEGER;
  T1: TEXT;
  NegativeNumber: BOOLEAN;

PROCEDURE Print(St: STRING; E: INTEGER);
VAR 
  Mantissa, Fraction, Zero, S: STRING;
  I, F: INTEGER;
BEGIN
  I := 1;
  Zero := '0';
  F := 0;
  S := St + '!'; 
  Mantissa := '';
  Fraction := '';
  IF S[I] = '-'
      THEN 
        I := I + 1;
  WHILE S[I] <> '!'
  DO
    BEGIN
      IF (S[I] <> '.') AND (S[I] <> '0') AND (Mantissa = '')
      THEN
        BEGIN
          IF NegativeNumber
          THEN
            Mantissa := Mantissa + '-';
          Mantissa := Mantissa + S[I] + '.';
          I := I + 1
        END;    
      IF (F <> 5) AND (S[I] <> '.') AND (Mantissa <> '') 
      THEN
        BEGIN
          Fraction := Fraction + S[I];
          F := F + 1
        END; 
      I := I + 1
    END;

  WHILE (F < 5) AND (E <> 0)
  DO 
    BEGIN
      Fraction := Fraction + Zero;
      F := F + 1
    END;

  WRITE(Mantissa, Fraction);
  IF (E <> 0)
  THEN
    WRITELN('E', E)
END;

BEGIN
  St := '';
  E := 0;
  NegativeNumber := FALSE;
  
  ASSIGN(T1, 'input.txt');  
  {$I-}
  RESET(T1);
  {$I+}
  if IOResult = 0
  THEN
    WRITELN('open')
  ELSE
    BEGIN
      WRITELN('close');
      EXIT
    END;
  
  READ(T1, M);
  RESET(T1);
  READ(T1, St);
   
  IF M < 0
  THEN
    BEGIN
      NegativeNumber := TRUE;
      M := -M
    END;
    
  WHILE (M > 10.0)
  DO
    BEGIN
      M := M / 10;
      E := E + 1
    END;
  WHILE (M < 1) AND (M <> 0)
  DO
    BEGIN
      M := M * 10;
      E := E - 1
    END; 

  Print(St, E);
END. 
