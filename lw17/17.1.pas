PROGRAM SumDigits(INPUT, OUTPUT);

PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  D := -1;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      IF Ch = '0' THEN D := 0 ELSE
      IF Ch = '1' THEN D := 1 ELSE
      IF Ch = '2' THEN D := 2 ELSE
      IF Ch = '3' THEN D := 3 ELSE
      IF Ch = '4' THEN D := 4 ELSE
      IF Ch = '5' THEN D := 5 ELSE
      IF Ch = '6' THEN D := 6 ELSE
      IF Ch = '7' THEN D := 7 ELSE
      IF Ch = '8' THEN D := 8 ELSE
      IF Ch = '9' THEN D := 9
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
      IF Sum > MAXINT - Digit
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
