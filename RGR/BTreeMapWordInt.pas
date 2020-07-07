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

  {�������� �� 1 ���祭�� ����� � ���箬 Key � ��ॢ� Tree.
   �᫨ � Tree ��� ����� � ���箬 Key, ᮧ������ ����� <Key, 1>.}
  PROCEDURE BTMWIIncrement(VAR Tree: BTMWITree; VAR Key: Word);

  {�뢥�� � OutFile ��ॢ� Tree � �ଠ�:
    <Key1>: <Value1>
    <Key2>: <Value2>
    ...
    <KeyN>: <ValueN>
    � �������騬 ��ॢ���� ��ப�.}
  PROCEDURE BTMWIPrintListing(VAR OutFile: TEXT; Tree: BTMWITree);

IMPLEMENTATION
  PROCEDURE BTMWIIncrement(VAR Tree: BTMWITree; VAR Key: Word);
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
        Tree^.Right := NIL
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
            Tree^.Value += 1
          END
        ELSE
          IF Cmp < 0
          THEN
            BTMWIIncrement(Tree^.Left, Key)
          ELSE
            BTMWIIncrement(Tree^.Right, Key)
      END
  END; {BTMWIIncrement}

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
