{������ ॣ���� �ॡ�� �������⥫쭮� �����⮢��.
 �ᯮ�짮����� �⤥�쭮�� ����� �������� �����६����:
 - ᭨���� ���ॡ����� ����� �� ������⢨� ����室����� � ��ॢ��� � ������ ॣ����;
 - �������� �������⥫��� �㭪権 ���樠����樨 � �஢�ப �� �।���⥫쭮�� �맮��.}
UNIT WordsToLower;
INTERFACE
  USES
    Words;
  {�������� �� �������� �㪢� � WordToLowercase �� �����.
   ��� � Words, �ᯮ���� ����஢�� CP866.}
  PROCEDURE WordToLower(VAR WordToLowercase: Word);

IMPLEMENTATION
  USES
    BTreeMapCharChar;
  VAR
    LowercaseEquivalent: BTMCCTree;

  PROCEDURE WordToLower(VAR WordToLowercase: Word);
  VAR
    Index: INTEGER;
    LowercaseCh: CHAR;
  BEGIN
    Index := 0;
    WHILE WordToLowercase[Index] <> #0
    DO
      BEGIN
        IF BTMCCGetValue(LowercaseEquivalent, WordToLowercase[Index], LowercaseCh)
        THEN
          WordToLowercase[Index] := LowercaseCh;
        Index += 1
      END
  END;

BEGIN {WordsToLower}
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, 'O', 'o');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, 'H', 'h');
  BTMCCInsert(LowercaseEquivalent, 'W', 'w');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, 'D', 'd');
  BTMCCInsert(LowercaseEquivalent, 'L', 'l');
  BTMCCInsert(LowercaseEquivalent, 'S', 's');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, 'B', 'b');
  BTMCCInsert(LowercaseEquivalent, 'F', 'f');
  BTMCCInsert(LowercaseEquivalent, 'J', 'j');
  BTMCCInsert(LowercaseEquivalent, 'N', 'n');
  BTMCCInsert(LowercaseEquivalent, 'Q', 'q');
  BTMCCInsert(LowercaseEquivalent, 'U', 'u');
  BTMCCInsert(LowercaseEquivalent, 'Y', 'y');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, 'A', 'a');
  BTMCCInsert(LowercaseEquivalent, 'C', 'c');
  BTMCCInsert(LowercaseEquivalent, 'E', 'e');
  BTMCCInsert(LowercaseEquivalent, 'G', 'g');
  BTMCCInsert(LowercaseEquivalent, 'I', 'i');
  BTMCCInsert(LowercaseEquivalent, 'K', 'k');
  BTMCCInsert(LowercaseEquivalent, 'M', 'm');
  BTMCCInsert(LowercaseEquivalent, 'P', 'p');
  BTMCCInsert(LowercaseEquivalent, 'R', 'r');
  BTMCCInsert(LowercaseEquivalent, 'T', 't');
  BTMCCInsert(LowercaseEquivalent, 'V', 'v');
  BTMCCInsert(LowercaseEquivalent, 'X', 'x');
  BTMCCInsert(LowercaseEquivalent, 'Z', 'z');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�');
  BTMCCInsert(LowercaseEquivalent, '�', '�')
END. {WordsToLower}
