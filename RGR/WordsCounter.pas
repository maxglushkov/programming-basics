{������뢠�� ������⢮ ࠧ����� ᫮� � ��⮪� �����.
 ����� � ࠧ��� ॣ���� ������� ����� ᫮���.}
PROGRAM WordsCounter(INPUT, OUTPUT);
USES
  Words, WordsToLower, BTreeMapWordInt;
VAR
  Tree: BTMWITree;
  Key: Word;
BEGIN {WordsCounter}
  WHILE NOT EOF(INPUT)
  DO
    IF WordRead(INPUT, Key) > 0
    THEN
      BEGIN
        WordToLower(Key);
        BTMWIIncrement(Tree, Key)
      END;
  BTMWIPrintListing(OUTPUT, Tree)
END. {WordsCounter}
