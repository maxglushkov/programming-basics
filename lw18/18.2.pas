PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 4;
VAR
  WhichScore: 0 .. NumberOfScores;
  Student: 0 .. ClassSize;
  Ch: CHAR;
  NextScore, Average, TotalScore, ClassTotal: INTEGER;
BEGIN {AverageScore}
  WRITELN('Student averages:');
  ClassTotal := 0;
  Student := 0;
  WHILE Student < ClassSize
  DO
    BEGIN
      Ch := '#';
      WHILE (NOT EOLN) AND (Ch <> ' ')
      DO
        BEGIN
          READ(Ch);
          WRITE(Ch)
        END;
      TotalScore := 0;
      WhichScore := 0;
      WHILE WhichScore < NumberOfScores
      DO
        BEGIN
          READ(NextScore);
          IF (NextScore < 0) OR (NextScore > 100)
          THEN
            WRITELN('Число ', NextScore:0, ' не лежит в отрезке [0; 100]')
          ELSE
            BEGIN
              TotalScore += NextScore;
              WhichScore += 1
            END
        END;
      READLN;
      TotalScore *= 10;
      Average := TotalScore DIV NumberOfScores;
      IF Average MOD 10 >= 5
      THEN
        WRITELN(Average DIV 10 + 1:0)
      ELSE
        WRITELN(Average DIV 10:0);
      ClassTotal += TotalScore;
      Student += 1
    END;
  WRITELN;
  WRITELN('Class average:');
  Average := ClassTotal DIV (ClassSize * NumberOfScores);
  WRITELN(Average DIV 10, '.', Average MOD 10:1)
END.  {AverageScore}
