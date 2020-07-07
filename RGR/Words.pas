{Слово - набор символов латиницы или кириллицы в кодировке CP866.
 Признак конца слова - нулевой символ (#0).}
UNIT Words;
INTERFACE
  TYPE
    Word = ARRAY[INTEGER] OF CHAR;

  {Считать слово с InFile в OutWord.
   Возвращает количество считанных символов.}
  FUNCTION WordRead(VAR InFile: TEXT; VAR OutWord: Word): INTEGER;

  {Вывести в OutFile слово из InWord.}
  PROCEDURE WordWrite(VAR OutFile: TEXT; VAR InWord: Word);

  {Сравнить слова Left и Right.
   ВАЖНО! Это функция точного сравнения. Она не учитывает лексикографический порядок символов.
          К примеру, в CP866 'я' < 'ё' и 'Ё' > 'ё'
   Возвращает:
    -1, если Left < Right
     0, если Left = Right
     1, если Left > Right}
  FUNCTION WordExactCompare(VAR Left, Right: Word): INTEGER;

  {Вернуть TRUE, если слово Wrd начинается с Head, FALSE - в противном случае.}
  FUNCTION WordStartsWith(VAR Wrd, Head: Word): BOOLEAN;

  {Сосчитать и вернуть количество символов в Wrd, не включая #0.}
  FUNCTION WordLength(VAR Wrd: Word): INTEGER;

  {Записать в Reversed слово из Original в обратном порядке.}
  FUNCTION WordReverse(VAR Original, Reversed: Word): INTEGER;

IMPLEMENTATION
  FUNCTION IsLetterCP866(Ch: CHAR): BOOLEAN;
  BEGIN {IsLetterCP866}
    IsLetterCP866 := ((Ch >= 'A') AND (Ch <= 'Z')) OR ((Ch >= 'a') AND (Ch <= 'z')) OR ((Ch >= 'А') AND (Ch <= 'п')) OR ((Ch >= 'р') AND (Ch <= 'ё'))
  END; {IsLetterCP866}

  FUNCTION WordRead(VAR InFile: TEXT; VAR OutWord: Word): INTEGER;
  VAR
    IsLetter: BOOLEAN;
    Ch: CHAR;
  BEGIN
    WordRead := 0;
    IsLetter := TRUE;
    WHILE NOT EOF(InFile) AND IsLetter
    DO
      BEGIN
        READ(InFile, Ch);
        IsLetter := IsLetterCP866(Ch);
        IF IsLetter
        THEN
          BEGIN
            OutWord[WordRead] := Ch;
            WordRead += 1
          END
      END;
    OutWord[WordRead] := #0
  END;

  PROCEDURE WordWrite(VAR OutFile: TEXT; VAR InWord: Word);
  VAR
    Index: INTEGER;
  BEGIN
    Index := 0;
    WHILE InWord[Index] <> #0
    DO
      BEGIN
        WRITE(OutFile, InWord[Index]);
        Index += 1
      END
  END;

  FUNCTION WordExactCompare(VAR Left, Right: Word): INTEGER;
  VAR
    Index: INTEGER;
    EndOfWord: BOOLEAN;
  BEGIN
    WordExactCompare := 0;
    Index := 0;
    EndOfWord := FALSE;
    WHILE (NOT EndOfWord) AND (WordExactCompare = 0)
    DO
      BEGIN
        EndOfWord := (Left[Index] = #0) OR (Right[Index] = #0);
        IF Left[Index] < Right[Index]
        THEN
          WordExactCompare := -1;
        IF Left[Index] > Right[Index]
        THEN
          WordExactCompare := 1;
        Index += 1
      END
  END;

  FUNCTION WordStartsWith(VAR Wrd, Head: Word): BOOLEAN;
  VAR
    Index: INTEGER;
  BEGIN {WordStartsWith}
    WordStartsWith := TRUE;
    Index := 0;
    WHILE (Head[Index] <> #0) AND WordStartsWith
    DO
      BEGIN
        WordStartsWith := Wrd[Index] = Head[Index];
        Index += 1
      END
  END; {WordStartsWith}

  FUNCTION WordLength(VAR Wrd: Word): INTEGER;
  BEGIN {WordLength}
    WordLength := 0;
    WHILE Wrd[WordLength] <> #0
    DO
      WordLength += 1
  END; {WordLength}

  FUNCTION WordReverse(VAR Original, Reversed: Word): INTEGER;
  VAR
    Index: INTEGER;
  BEGIN {WordReverse}
    Index := WordLength(Original);
    WordReverse := 0;
    WHILE Index > 0
    DO
      BEGIN
        Index -= 1;
        Reversed[WordReverse] := Original[Index];
        WordReverse += 1
      END;
    Reversed[WordReverse] := #0
  END; {WordReverse}

BEGIN {Words}
END. {Words}
