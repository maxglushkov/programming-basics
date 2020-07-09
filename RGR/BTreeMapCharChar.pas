{����筮� ��ॢ� � ��ࠬ� <����, ���祭��> � ����⢥ ����⮢.
 ����冷祭� �� �����⠭�� ���祩.}
UNIT BTreeMapCharChar;
INTERFACE
  TYPE
    BTMCCTree = ^BTMCCNode;
    BTMCCNode = RECORD
                  Key, Value: CHAR;
                  Left, Right: BTMCCTree
                END;

  {��⠢��� ���祭�� <Key, Value> � ��ॢ� Tree.
   �᫨ � Tree 㦥 ���� ���祭�� � ���箬 Key, ��祣� �� �ந�室��.}
  PROCEDURE BTMCCInsert(VAR Tree: BTMCCTree; Key, Value: CHAR);

  {������� ���祭�� Value, ᮮ⢥�����饥 ����� Key, �� ��ॢ� Tree.
   �����頥� TRUE, �᫨ ���祭�� ��� Key �������, FALSE � ��⨢��� ��砥.}
  FUNCTION BTMCCGetValue(Tree: BTMCCTree; Key: CHAR; VAR Value: CHAR): BOOLEAN;

IMPLEMENTATION
  PROCEDURE BTMCCInsert(VAR Tree: BTMCCTree; Key, Value: CHAR);
  BEGIN {BTMCCInsert}
    IF Tree = NIL
    THEN
      BEGIN
        NEW(Tree);
        Tree^.Key := Key;
        Tree^.Value := Value;
        Tree^.Left := NIL;
        Tree^.Right := NIL
      END
    ELSE
      IF Key <> Tree^.Key
      THEN
        IF Key < Tree^.Key
        THEN
          BTMCCInsert(Tree^.Left, Key, Value)
        ELSE
          BTMCCInsert(Tree^.Right, Key, Value)
  END; {BTMCCInsert}

  FUNCTION BTMCCGetValue(Tree: BTMCCTree; Key: CHAR; VAR Value: CHAR): BOOLEAN;
  BEGIN {BTMCCGetValue}
    IF Tree = NIL
    THEN
      BTMCCGetValue := FALSE
    ELSE
      IF Key = Tree^.Key
      THEN
        BEGIN
          BTMCCGetValue := TRUE;
          Value := Tree^.Value
        END
      ELSE
        IF Key < Tree^.Key
        THEN
          BTMCCGetValue := BTMCCGetValue(Tree^.Left, Key, Value)
        ELSE
          BTMCCGetValue := BTMCCGetValue(Tree^.Right, Key, Value)
  END; {BTMCCGetValue}

BEGIN {BTreeMapCharChar}
END. {BTreeMapCharChar}
