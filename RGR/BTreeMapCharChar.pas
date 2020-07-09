{Двоичное дерево с парами <ключ, значение> в качестве элементов.
 Упорядочено по возрастанию ключей.}
UNIT BTreeMapCharChar;
INTERFACE
  TYPE
    BTMCCTree = ^BTMCCNode;
    BTMCCNode = RECORD
                  Key, Value: CHAR;
                  Left, Right: BTMCCTree
                END;

  {Вставить значение <Key, Value> в дерево Tree.
   Если в Tree уже есть значение с ключом Key, ничего не происходит.}
  PROCEDURE BTMCCInsert(VAR Tree: BTMCCTree; Key, Value: CHAR);

  {Получить значение Value, соответствующее ключу Key, из дерева Tree.
   Возвращает TRUE, если значение для Key найдено, FALSE в противном случае.}
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
