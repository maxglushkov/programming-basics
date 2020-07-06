{����� - ����� ᨬ����� ��⨭��� ��� ��ਫ���� � ����஢�� CP866.
 �ਧ��� ���� ᫮�� - �㫥��� ᨬ��� (#0).}
UNIT Words;
INTERFACE
  TYPE
    Word = ARRAY[INTEGER] OF CHAR;
  {������� ����� ���⮥ ᫮�� Wrd.}
  PROCEDURE WordNew(VAR Wrd: Word);
  {����� ᫮�� � InFile � OutWord.
   �����頥� ������⢮ ��⠭��� ᨬ�����.}
  FUNCTION WordRead(VAR InFile: TEXT; VAR OutWord: Word): INTEGER;
  {�뢥�� � OutFile ᫮�� �� InWord.}
  PROCEDURE WordWrite(VAR OutFile: TEXT; InWord: Word);
  {�ࠢ���� ᫮�� Left � Right.
   �����! �� �㭪�� �筮�� �ࠢ�����. ��� �� ���뢠�� ���ᨪ�����᪨� ���冷� ᨬ�����.
          � �ਬ���, � CP866 '�' < '�' � '�' > '�'
   �����頥�:
    -1, �᫨ Left < Right
     0, �᫨ Left = Right
     1, �᫨ Left > Right}
  FUNCTION WordExactCompare(Left, Right: Word): INTEGER;
  {������� � ������ ������⢮ ᨬ����� � Wrd, �� ������ #0.}
  FUNCTION WordLength(Wrd: Word): INTEGER;
  {������� � Reversed ᫮�� �� Original � ���⭮� ���浪�.}
  FUNCTION WordReverse(Original: Word; VAR Reversed: Word): INTEGER;

IMPLEMENTATION
  FUNCTION IsLetterCP866(Ch: CHAR): BOOLEAN;
  BEGIN {IsLetterCP866}
    IsLetterCP866 := ((Ch >= 'A') AND (Ch <= 'Z')) OR ((Ch >= 'a') AND (Ch <= 'z')) OR ((Ch >= '�') AND (Ch <= '�')) OR ((Ch >= '�') AND (Ch <= '�'))
  END; {IsLetterCP866}

  PROCEDURE WordNew(VAR Wrd: Word);
  BEGIN {WordNew}
    Wrd[0] := #0
  END; {WordNew}

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

  PROCEDURE WordWrite(VAR OutFile: TEXT; InWord: Word);
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

  FUNCTION WordExactCompare(Left, Right: Word): INTEGER;
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

  FUNCTION WordLength(Wrd: Word): INTEGER;
  BEGIN {WordLength}
    WordLength := 0;
    WHILE Wrd[WordLength] <> #0
    DO
      WordLength += 1
  END; {WordLength}

  FUNCTION WordReverse(Original: Word; VAR Reversed: Word): INTEGER;
  VAR
    SrcIndex, DstIndex: INTEGER;
  BEGIN {WordReverse}
    SrcIndex := WordLength(Original);
    DstIndex := 0;
    WHILE SrcIndex > 0
    DO
      BEGIN
        SrcIndex -= 1;
        Reversed[DstIndex] := Original[SrcIndex];
        DstIndex += 1
      END;
    Reversed[DstIndex] := #0;
    WordReverse := DstIndex
  END; {WordReverse}

BEGIN {Words}
END. {Words}
