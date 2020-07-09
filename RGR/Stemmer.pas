{���⮩ �⥬��� �� �᭮�� �⥬��� �����.
 ��ࠡ��뢠�� ⮫쪮 ��� ᫮��, �� ������७�� ᫮��.}
UNIT Stemmer;
INTERFACE
  USES
    Words;

  {����㧨�� ����砭�� �� ����⮣� ��� �⥭�� 䠩�� EndingsFile. ��ଠ�:
    <����筮��1><�� ᨬ���><����筮��2><�� ᨬ���> ... <����砭��N>
   ����筮�� - ����砭��, ����ᠭ��� � ���⭮� ���浪�.
   �ࠩ�� ����⥫쭮 �ᯮ�짮���� ���冷�, ��⨬���� ��� ��ᡠ����஢����� ������� ��ॢ쥢.}
  PROCEDURE StemmerLoadEndingsFromFile(VAR EndingsFile: TEXT);

  {������� �᭮�� ᫮�� Original � Stem.}
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
