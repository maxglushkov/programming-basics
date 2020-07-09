{Двоичное дерево.
 Упорядочено по возрастанию.}
UNIT BTreeSetWord;
INTERFACE
  USES
    Words;
  TYPE
    BTSWTree = ^BTSWNode;
    BTSWNode = RECORD
                 Value: Word;
                 Left, Right: BTSWTree;
               END;

  {Вставить значение Value в дерево Tree, если его там ещё нет.}
  PROCEDURE BTSWInsert(VAR Tree: BTSWTree; VAR Value: Word);

  {Найти в дереве Tree самую длинную "голову" для значения Value.}
  FUNCTION BTSWLongestHead(Tree: BTSWTree; VAR Value: Word): BTSWTree;

  {Вывести в OutFile элементы дерева Tree в формате:
    <Value1>,<Value2>, ... ,<ValueN>
   без завершающего перевода строки.}
  PROCEDURE BTSWPrintCommaSeparatedList(VAR OutFile: TEXT; Tree: BTSWTree);

IMPLEMENTATION
  PROCEDURE PrintCommaSeparatedList(VAR OutFile: TEXT; Tree: BTSWTree; VAR PrintComma: BOOLEAN);
  BEGIN {PrintCommaSeparatedList}
    IF Tree^.Left <> NIL
    THEN
      PrintCommaSeparatedList(OutFile, Tree^.Left, PrintComma);
    IF PrintComma
    THEN
      WRITE(OutFile, ',');
    WordWrite(OutFile, Tree^.Value);
    PrintComma := TRUE;
    IF Tree^.Right <> NIL
    THEN
      PrintCommaSeparatedList(OutFile, Tree^.Right, PrintComma)
  END; {PrintCommaSeparatedList}

  PROCEDURE BTSWInsert(VAR Tree: BTSWTree; VAR Value: Word);
  VAR
    Cmp: INTEGER;
  BEGIN {BTSWInsert}
    IF Tree = NIL
    THEN
      BEGIN
        NEW(Tree);
        Tree^.Value := Value;
        Tree^.Left := NIL;
        Tree^.Right := NIL
      END
    ELSE
      BEGIN
        Cmp := WordExactCompare(Value, Tree^.Value);
        IF Cmp <> 0
        THEN
          IF Cmp < 0
          THEN
            BTSWInsert(Tree^.Left, Value)
          ELSE
            BTSWInsert(Tree^.Right, Value)
      END
  END; {BTSWInsert}

  FUNCTION BTSWLongestHead(Tree: BTSWTree; VAR Value: Word): BTSWTree;
  BEGIN {BTSWLongestHead}
    IF Tree = NIL
    THEN
      BTSWLongestHead := NIL
    ELSE
      IF WordStartsWith(Value, Tree^.Value)
      THEN
        BEGIN
          BTSWLongestHead := BTSWLongestHead(Tree^.Right, Value);
          IF BTSWLongestHead = NIL
          THEN
            BTSWLongestHead := Tree
        END
      ELSE
        IF WordExactCompare(Value, Tree^.Value) < 0
        THEN
          BTSWLongestHead := BTSWLongestHead(Tree^.Left, Value)
        ELSE
          BTSWLongestHead := BTSWLongestHead(Tree^.Right, Value)
  END; {BTSWLongestHead}

  PROCEDURE BTSWPrintCommaSeparatedList(VAR OutFile: TEXT; Tree: BTSWTree);
  VAR
    PrintComma: BOOLEAN;
  BEGIN {BTSWPrintCommaSeparatedList}
    IF Tree <> NIL
    THEN
      BEGIN
        PrintComma := FALSE;
        PrintCommaSeparatedList(OutFile, Tree, PrintComma)
      END
  END; {BTSWPrintCommaSeparatedList}

BEGIN {BTreeSetWord}
END. {BTreeSetWord}
