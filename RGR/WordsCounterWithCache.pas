{������뢠�� ������⢮ ࠧ����� ᫮� � ��⮪� �����.
 ����� � ࠧ��� ॣ���� ������� ����� ᫮���.}
PROGRAM WordsCounterWithCache(INPUT, OUTPUT);
USES
  Words, WordsToLower, FSCachedBTreeMapWordInt;
VAR
  Key: Word;
BEGIN {WordsCounterWithCache}
  WHILE NOT EOF(INPUT)
  DO
    IF WordRead(INPUT, Key) > 0
    THEN
      BEGIN
        WordToLower(Key);
        FSCBTMWIIncrement(Key)
      END;
  FSCBTMWIIntoListing(OUTPUT)
END. {WordsCounterWithCache}
