{Группирует формы одного слова из файла статистики WordsCounter.}
PROGRAM GroupWords(INPUT, OUTPUT);
USES
  Words, Stemmer, BTreeMapWordStat;

PROCEDURE InitStemmer();
VAR
  EndingsFile: TEXT;
BEGIN {InitStemmer}
  ASSIGN(EndingsFile, 'StemmerEndings.dat');
  RESET(EndingsFile);
  StemmerLoadEndingsFromFile(EndingsFile);
  CLOSE(EndingsFile)
END; {InitStemmer}

VAR
  Tree: BTMWSTree;
  Original, Stem: Word;
  Count: INTEGER;
BEGIN {GroupWords}
  InitStemmer;
  WHILE NOT EOF(INPUT)
  DO
    IF WordRead(INPUT, Original) > 0
    THEN
      BEGIN
        READLN(INPUT, Count);
        StemmerGetStem(Original, Stem);
        BTMWSAdd(Tree, Stem, Original, Count)
      END;
  BTMWSPrintListing(OUTPUT, Tree)
END. {GroupWords}
