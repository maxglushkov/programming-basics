{����筮� ��ॢ� � ����⨪�� � �ଠ� <����, ����� ���祭��, ������⢮ ���祭��> � ����⢥ ����⮢.
 ����冷祭� �� �����⠭�� ���祩.}
UNIT BTreeMapWordStat;
INTERFACE
  USES
    Words, BTreeSetWord;
  TYPE
    BTMWSTree = ^BTMWSNode;
    BTMWSNode = RECORD
                  Key: Word;
                  Group: BTSWTree;
                  Count: INTEGER;
                  Left, Right: BTMWSTree
                END;

  {�������� Count � Count � Value � Group ����� � ���箬 Key � ��ॢ� Tree.
   �᫨ � Tree ��� ����� � ���箬 Key, ᮧ���� ��� �� ���祭�� <Key, [Value], Count>.
   ����������: Key ������ ��।������� �� ��뫪�. �� ��।�� �� ���祭�� �१ �����஥ ������⢮ ���権
               � WordExactCompare �������� 㪠��⥫� �� �⥪, �� �ਢ���� � �訡�� ᥣ����樨.}
  PROCEDURE BTMWSAdd(VAR Tree: BTMWSTree; VAR Key, Value: Word; Count: INTEGER);

  {�뢥�� � 䠩� OutFile ����⨪� �� ��ॢ� Tree � �ଠ�:
    <Key1_Group1>,<Key1_Group2>, ... ,<Key1_GroupN>: <Key1_Count>
    <Key2_Group1>,<Key2_Group2>, ... ,<Key2_GroupN>: <Key2_Count>
    ...
    <KeyN_Group1>,<KeyN_Group2>, ... ,<KeyN_GroupN>: <KeyN_Count>
    � �������騬 ��ॢ���� ��ப�.}
  PROCEDURE BTMWSPrintListing(VAR OutFile: TEXT; Tree: BTMWSTree);

IMPLEMENTATION
  PROCEDURE BTMWSAdd(VAR Tree: BTMWSTree; VAR Key, Value: Word; Count: INTEGER);
  VAR
    Cmp: INTEGER;
  BEGIN {BTMWSAdd}
    IF Tree = NIL
    THEN
      BEGIN
        NEW(Tree);
        Tree^.Key := Key;
        BTSWInsert(Tree^.Group, Value);
        Tree^.Count := Count;
        Tree^.Left := NIL;
        Tree^.Right := NIL
      END
    ELSE
      BEGIN
        Cmp := WordExactCompare(Key, Tree^.Key);
        IF Cmp = 0
        THEN
          BEGIN
            BTSWInsert(Tree^.Group, Value);
            IF MAXINT - Tree^.Count < Count
            THEN
              BEGIN
                WRITE(STDERR, '��������������: �ந��諮 ��९������� ��� ���� ');
                WordWrite(STDERR, Tree^.Key);
                WRITELN(STDERR)
              END;
            Tree^.Count += Count
          END
        ELSE
          IF Cmp < 0
          THEN
            BTMWSAdd(Tree^.Left, Key, Value, Count)
          ELSE
            BTMWSAdd(Tree^.Right, Key, Value, Count)
      END
  END; {BTMWSAdd}

  PROCEDURE BTMWSPrintListing(VAR OutFile: TEXT; Tree: BTMWSTree);
  BEGIN {BTMWSPrintListing}
    IF Tree <> NIL
    THEN
      BEGIN
        BTMWSPrintListing(OutFile, Tree^.Left);
        BTSWPrintCommaSeparatedList(OutFile, Tree^.Group);
        WRITELN(OutFile, ': ', Tree^.Count);
        BTMWSPrintListing(OutFile, Tree^.Right)
      END
  END; {BTMWSPrintListing}

BEGIN {BTreeMapWordStat}
END. {BTreeMapWordStat}
