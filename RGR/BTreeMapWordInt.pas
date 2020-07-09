{����筮� ��ॢ� � ��ࠬ� <����, ���祭��> � ����⢥ ����⮢.
 ����冷祭� �� �����⠭�� ���祩.}
UNIT BTreeMapWordInt;
INTERFACE
  USES
    Words;
  TYPE
    BTMWITree = ^BTMWINode;
    BTMWINode = RECORD
                  Key: Word;
                  Value: INTEGER;
                  Left, Right: BTMWITree
                END;

  {�������� �� 1 ���祭�� ����� � ���箬 Key � ��ॢ� Tree � ������ TRUE.
   �᫨ � Tree ��� ����� � ���箬 Key, ᮧ������ ����� <Key, 1> � �����頥��� FALSE.}
  FUNCTION BTMWIIncrement(VAR Tree: BTMWITree; VAR Key: Word): BOOLEAN;

  {����� �� InFile ����� ��ॢ� � �ଠ�:
    <Key><�� �㪢� ��� ����� Words><Value>
    � ��ॢ���� ��ப�.
   ������� �஢�ப �室��� ������ �� �ந��������.}
  FUNCTION BTMWINodeFromFile(VAR InFile: TEXT): BTMWITree;

  {�뢥�� � OutFile ����� ��ॢ� Node � �ଠ�
    <Key> <Value>
    � ��ॢ���� ��ப�.
   ���祭�� Node 㤠�����.}
  PROCEDURE BTMWINodeIntoFile(VAR OutFile: TEXT; VAR Node: BTMWITree);

  {�뢥�� � OutFile ��ॢ� Tree � �ଠ�:
    <Key1> <Value1>
    <Key2> <Value2>
    ...
    <KeyN> <ValueN>
    � �������騬 ��ॢ���� ��ப�.}
  PROCEDURE BTMWIPrintListing(VAR OutFile: TEXT; Tree: BTMWITree);

IMPLEMENTATION
  FUNCTION BTMWIIncrement(VAR Tree: BTMWITree; VAR Key: Word): BOOLEAN;
  VAR
    Cmp: INTEGER;
  BEGIN {BTMWIIncrement}
    IF Tree = NIL
    THEN
      BEGIN
        NEW(Tree);
        Tree^.Key := Key;
        Tree^.Value := 1;
        Tree^.Left := NIL;
        Tree^.Right := NIL;
        BTMWIIncrement := FALSE
      END
    ELSE
      BEGIN
        Cmp := WordExactCompare(Key, Tree^.Key);
        IF Cmp = 0
        THEN
          BEGIN
            IF Tree^.Value = MAXINT
            THEN
              BEGIN
                WRITE(STDERR, '��������������: �ந��諮 ��९������� ��� ���� ');
                WordWrite(STDERR, Key);
                WRITELN(STDERR)
              END;
            Tree^.Value += 1;
            BTMWIIncrement := TRUE
          END
        ELSE
          IF Cmp < 0
          THEN
            BTMWIIncrement := BTMWIIncrement(Tree^.Left, Key)
          ELSE
            BTMWIIncrement := BTMWIIncrement(Tree^.Right, Key)
      END
  END; {BTMWIIncrement}

  FUNCTION BTMWINodeFromFile(VAR InFile: TEXT): BTMWITree;
  BEGIN {BTMWINodeFromFile}
    NEW(BTMWINodeFromFile);
    WordRead(InFile, BTMWINodeFromFile^.Key);
    READLN(InFile, BTMWINodeFromFile^.Value)
  END; {BTMWINodeFromFile}

  PROCEDURE BTMWINodeIntoFile(VAR OutFile: TEXT; VAR Node: BTMWITree);
  BEGIN {BTMWINodeIntoFile}
    WordWrite(OutFile, Node^.Key);
    WRITELN(OutFile, ' ', Node^.Value);
    DISPOSE(Node);
    Node := NIL
  END; {BTMWINodeIntoFile}

  PROCEDURE BTMWIPrintListing(VAR OutFile: TEXT; Tree: BTMWITree);
  BEGIN {BTMWIPrintListing}
    IF Tree <> NIL
    THEN
      BEGIN
        BTMWIPrintListing(OutFile, Tree^.Left);
        WordWrite(OutFile, Tree^.Key);
        WRITELN(OutFile, ' ', Tree^.Value);
        BTMWIPrintListing(OutFile, Tree^.Right)
      END
  END; {BTMWIPrintListing}

BEGIN {BTreeMapWordInt}
END. {BTreeMapWordInt}
