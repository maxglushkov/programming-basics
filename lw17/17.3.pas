PROGRAM Stat(INPUT, OUTPUT);

FUNCTION WillOverflow(Mul1, Mul2, Add: INTEGER): BOOLEAN;
BEGIN {WillOverflow}
  WillOverflow := (Mul1 > MAXINT DIV Mul2) OR (INTEGER(Mul1 * Mul2 + Add) < 0);
END; {WillOverflow}

PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  D := -1;
  IF NOT EOLN(F)
  THEN
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
      IF WillOverflow(N, 10, Digit)
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
  Number, Min, Max, Sum, Count: INTEGER;
  Overflow: BOOLEAN;
BEGIN {Stat}
  Min := MAXINT;
  Max := 0;
  Sum := 0;
  Count := 0;
  Overflow := FALSE;
  WHILE (NOT EOF(INPUT)) AND (NOT Overflow)
  DO
    BEGIN
      ReadNumber(INPUT, Number);
      IF Number = -1
      THEN
        Overflow := TRUE
      ELSE
        BEGIN
          IF Number < Min
          THEN
            Min := Number;
          IF Number > Max
          THEN
            Max := Number;
          IF INTEGER(Sum + Number) < 0
          THEN
            Overflow := TRUE
          ELSE
            Sum += Number;
          IF Count = MAXINT
          THEN
            Overflow := TRUE
          ELSE
            Count += 1
        END;
      IF NOT Overflow
      THEN
        READLN(INPUT)
    END;
  IF Overflow
  THEN
    WRITE(OUTPUT, 'Переполнение')
  ELSE
    IF Count = 0
    THEN
      WRITE(OUTPUT, 'Не введено ни одного числа')
    ELSE
      BEGIN
        WRITELN(OUTPUT, 'Минимальное:            ', Min:0);
        WRITELN(OUTPUT, 'Максимальное:           ', Max:0);
        WRITE(OUTPUT, 'Среднее арифметическое: ', Sum DIV Count:0);
        IF Sum MOD Count <> 0
        THEN
          IF WillOverflow(Sum MOD Count, 200, Count) OR (INTEGER(Count * 2) < 0)
          THEN
            BEGIN
              WRITELN(OUTPUT);
              WRITE(OUTPUT, 'Переполнение');
            END
          ELSE
            WRITE(OUTPUT, ',', (Sum MOD Count * 200 + Count) DIV (Count * 2):0)
      END;
  WRITELN(OUTPUT)
END. {Stat}
