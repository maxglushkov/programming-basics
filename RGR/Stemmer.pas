{Простой стеммер на основе стеммера Портера.
 Обрабатывает только формы слова, не однокоренные слова.}
UNIT Stemmer;
INTERFACE
  USES
    Words;

  {Загрузить окончания из открытого для чтения файла EndingsFile. Формат:
    <еиначноко1><любой символ><еиначноко2><любой символ> ... <окончаниеN>
   еиначноко - окончание, записанное в обратном порядке.
   Крайне желательно использовать порядок, оптимальный для несбалансированных двоичных деревьев.}
  PROCEDURE StemmerLoadEndingsFromFile(VAR EndingsFile: TEXT);

  {Записать основу слова Original в Stem.}
  PROCEDURE StemmerGetStem(VAR Original, Stem: Word);

IMPLEMENTATION
  USES
    BTreeSetWord;
  VAR
    Endings: BTSWTree;

  PROCEDURE StemmerLoadEndingsFromFile(VAR EndingsFile: TEXT);
  VAR
    Ending: Word;
  BEGIN {StemmerLoadEndingsFromFile}
    WHILE NOT EOF(EndingsFile)
    DO
      IF WordRead(EndingsFile, Ending) > 0
      THEN
        BTSWInsert(Endings, Ending)
  END; {StemmerLoadEndingsFromFile}

  PROCEDURE StemmerGetStem(VAR Original, Stem: Word);
  VAR
    Reversed: Word;
    Ending: BTSWTree;
    Length, Index: INTEGER;
  BEGIN {StemmerGetStem}
    Length := WordReverse(Original, Reversed);
    Ending := BTSWLongestHead(Endings, Reversed);
    IF Ending <> NIL
    THEN
      Length -= WordLength(Ending^.Value);
    FOR Index := 0 TO Length - 1
    DO
      Stem[Index] := Original[Index];
    Stem[Length] := #0
  END; {StemmerGetStem}

BEGIN {Stemmer}
END. {Stemmer}
