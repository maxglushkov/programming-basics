PROGRAM SumDigits(INPUT, OUTPUT);

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

VAR
  Sum, Digit: INTEGER;
BEGIN {SumDigits}
  Sum := 0;
  ReadDigit(INPUT, Digit);
  WHILE Digit <> -1
  DO
    BEGIN
      IF INTEGER(Sum + Digit) < 0
      THEN
        BEGIN
          Sum := -1;
          Digit := -1
        END
      ELSE
        BEGIN
          Sum += Digit;
          ReadDigit(INPUT, Digit)
        END
    END;
  IF Sum = -1
  THEN
    WRITELN(OUTPUT, 'Переполнение')
  ELSE
    WRITELN(OUTPUT, 'Сумма цифр: ', Sum)
END. {SumDigits}
