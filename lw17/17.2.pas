PROGRAM NumberEcho(INPUT, OUTPUT);

PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  D := -1;
  IF EOLN(F)
  THEN
    READLN(F)
  ELSE
    BEGIN
      READ(F, Ch);
      IF (Ch >= '0') AND (Ch <= '9')
      THEN
        D := INTEGER(Ch) - 48
    END
END; {ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);
VAR
  Digit: INTEGER;
BEGIN {ReadNumber}
  N := 0;
  ReadDigit(F, Digit);
  WHILE Digit <> -1
  DO
    BEGIN
      IF (N > MAXINT DIV 10) OR (INTEGER(N * 10 + Digit) < 0)
      THEN
        BEGIN
          N := -1;
          Digit := -1
        END
      ELSE
        BEGIN
          N := N * 10 + Digit;
          ReadDigit(F, Digit)
        END
    END
END; {ReadNumber}

VAR
  Number: INTEGER;
BEGIN {NumberEcho}
  ReadNumber(INPUT, Number);
  IF Number = -1
  THEN
    WRITELN(OUTPUT, 'Переполнение')
  ELSE
    WRITELN(OUTPUT, 'Введено число: ', Number)
END. {NumberEcho}
