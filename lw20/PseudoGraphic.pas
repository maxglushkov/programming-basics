UNIT PseudoGraphic;
INTERFACE
  {Загрузка стандартных матриц псевдографики. Не требует PGInit.}
  PROCEDURE PGLoadDefaultMatrices();

  {Загрузка матриц псевдографики из файла. Не требует PGInit.}
  PROCEDURE PGLoadFromFile(VAR Source: TEXT);

  {Подготовка к выводу матриц во внутренний буфер.}
  PROCEDURE PGInit();

  {Запись псевдографического представления символа Ch во внутренний буфер.}
  PROCEDURE PGPutChar(Ch: CHAR);

  {Вывод внутренних буферов в Destination}
  PROCEDURE PGFlushTo(VAR Destination: TEXT);

IMPLEMENTATION
  CONST
    Width = 5;
    Height = 5;
    MatrixSize = Width * Height;

  TYPE
    Row = 0 .. Height - 1;
    Column = 1 .. Width;
    Index = 1 .. MatrixSize;

  VAR
    Matrices: ARRAY[CHAR] OF SET OF Index;
    Buffer: ARRAY[INTEGER] OF CHAR;
    Position: INTEGER;

  PROCEDURE PGLoadDefaultMatrices;
  BEGIN {PGLoadDefaultMatrices}
    Matrices['0'] := [2, 3, 4, 6, 9, 10, 11, 13, 15, 16, 17, 20, 22, 23, 24];
    Matrices['1'] := [4, 8, 9, 12, 14, 19, 24];
    Matrices['2'] := [2, 3, 4, 6, 10, 13, 14, 17, 21, 22, 23, 24, 25];
    Matrices['3'] := [2, 3, 4, 6, 10, 13, 14, 16, 20, 22, 23, 24];
    Matrices['4'] := [4, 8, 9, 12, 14, 16, 17, 18, 19, 20, 24];
    Matrices['5'] := [1, 2, 3, 4, 5, 6, 11, 12, 13, 14, 20, 22, 23, 24];
    Matrices['6'] := [2, 3, 4, 6, 11, 12, 13, 14, 16, 20, 22, 23, 24];
    Matrices['7'] := [1, 2, 3, 4, 5, 9, 10, 13, 14, 18, 23];
    Matrices['8'] := [2, 3, 4, 6, 10, 12, 13, 14, 16, 20, 22, 23, 24];
    Matrices['9'] := [2, 3, 4, 6, 10, 12, 13, 14, 15, 20, 22, 23, 24];
    Matrices['A'] := [2, 3, 4, 6, 10, 11, 12, 13, 14, 15, 16, 20, 21, 25];
    Matrices['B'] := [1, 2, 3, 4, 6, 10, 11, 12, 13, 14, 16, 20, 21, 22, 23, 24];
    Matrices['C'] := [2, 3, 4, 6, 11, 16, 22, 23, 24];
    Matrices['D'] := [1, 2, 3, 4, 6, 10, 11, 15, 16, 20, 21, 22, 23, 24];
    Matrices['E'] := [1, 2, 3, 4, 5, 6, 11, 12, 13, 14, 16, 21, 22, 23, 24, 25];
    Matrices['F'] := [1, 2, 3, 4, 5, 6, 11, 12, 13, 14, 16, 21];
    Matrices['G'] := [2, 3, 4, 6, 11, 14, 15, 16, 20, 22, 23, 24];
    Matrices['H'] := [1, 5, 6, 10, 11, 12, 13, 14, 15, 16, 20, 21, 25];
    Matrices['I'] := [2, 3, 4, 8, 13, 18, 22, 23, 24];
    Matrices['J'] := [3, 4, 5, 10, 15, 16, 20, 22, 23, 24];
    Matrices['K'] := [1, 5, 6, 9, 11, 12, 13, 16, 19, 21, 25];
    Matrices['L'] := [1, 6, 11, 16, 21, 22, 23, 24, 25];
    Matrices['M'] := [1, 5, 6, 7, 9, 10, 11, 13, 15, 16, 20, 21, 25];
    Matrices['N'] := [1, 5, 6, 7, 10, 11, 13, 15, 16, 19, 20, 21, 25];
    Matrices['O'] := [2, 3, 4, 6, 10, 11, 15, 16, 20, 22, 23, 24];
    Matrices['P'] := [1, 2, 3, 4, 6, 10, 11, 12, 13, 14, 16, 21];
    Matrices['Q'] := [2, 3, 4, 6, 10, 11, 15, 16, 19, 22, 23, 25];
    Matrices['R'] := [1, 2, 3, 4, 6, 10, 11, 12, 13, 14, 16, 20, 21, 25];
    Matrices['S'] := [2, 3, 4, 6, 12, 13, 14, 20, 22, 23, 24];
    Matrices['T'] := [1, 2, 3, 4, 5, 8, 13, 18, 23];
    Matrices['U'] := [1, 5, 6, 10, 11, 15, 16, 20, 22, 23, 24];
    Matrices['V'] := [1, 5, 6, 10, 11, 15, 17, 19, 23];
    Matrices['W'] := [1, 5, 6, 10, 11, 15, 16, 18, 20, 22, 24];
    Matrices['X'] := [1, 5, 7, 9, 13, 17, 19, 21, 25];
    Matrices['Y'] := [1, 5, 7, 9, 13, 18, 23];
    Matrices['Z'] := [1, 2, 3, 4, 5, 9, 13, 17, 21, 22, 23, 24, 25]
  END; {PGLoadDefaultMatrices}

  PROCEDURE PGLoadFromFile(VAR Source: TEXT);
  VAR
    Ch, Space: CHAR;
    Item: Index;
  BEGIN {PGLoadFromFile}
    {Width and height handling is not implementated}
    IF NOT EOF(Source)
    THEN
      READLN(Source);
    WHILE NOT EOF(Source)
    DO
      BEGIN
        IF NOT EOLN(Source)
        THEN
          BEGIN
            READ(Source, Ch);
            IF NOT EOLN(Source)
            THEN
              READ(Source, Space)
          END;
        WHILE NOT EOLN(Source)
        DO
          BEGIN
            READ(Source, Item);
            Matrices[Ch] += [Item];
            IF NOT EOLN(Source)
            THEN
              READ(Source, Space)
          END;
        READLN(Source)
      END
  END; {PGLoadFromFile}

  PROCEDURE PGInit();
  BEGIN {PGInit}
    Position := 0
  END; {PGInit}

  PROCEDURE PGPutChar(Ch: CHAR);
  BEGIN {PGPutChar}
    Buffer[Position] := Ch;
    Position += 1
  END; {PGPutChar}

  PROCEDURE PGFlushTo(VAR Destination: TEXT);
  VAR
    X: Column;
    Y: Row;
    I: INTEGER;
  BEGIN {PGFlushTo}
    FOR Y := 0 TO Height - 1
    DO
      BEGIN
        FOR I := 0 TO Position - 1
        DO
          BEGIN
            FOR X := 1 TO Width
            DO
              IF X + Y * Width IN Matrices[Buffer[I]]
              THEN
                WRITE(Destination, 'X')
              ELSE
                WRITE(Destination, ' ');
            WRITE(Destination, ' ')
          END;
        WRITELN(Destination)
      END
  END; {PGFlushTo}

BEGIN {PseudoGraphic}
END. {PseudoGraphic}
