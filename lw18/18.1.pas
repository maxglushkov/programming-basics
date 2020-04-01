PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 4;
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 0 .. NumberOfScores;
  Student: 0 .. ClassSize;
  NextScore: Score;
  Average, TotalScore, ClassTotal: INTEGER;
BEGIN {AverageScore}
  WRITELN('Student averages:');
  ClassTotal := 0;
  Student := 0;
  WHILE Student < ClassSize
  DO
    BEGIN
      TotalScore := 0;
      WhichScore := 0;
      WHILE WhichScore < NumberOfScores
      DO
        BEGIN
          READ(NextScore);
          TotalScore += NextScore;
          WhichScore += 1
        END;
      READLN;
      TotalScore *= 10;
      Average := TotalScore DIV NumberOfScores;
      IF Average MOD 10 >= 5
      THEN
        WRITELN(Average DIV 10 + 1)
      ELSE
        WRITELN(Average DIV 10);
      ClassTotal += TotalScore;
      Student += 1
    END;
  WRITELN;
  WRITELN('Class average:');
  Average := ClassTotal DIV (ClassSize * NumberOfScores);
  WRITELN(Average DIV 10, '.', Average MOD 10:1)
END.  {AverageScore}
