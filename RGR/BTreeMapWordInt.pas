{Двоичное дерево с парами <ключ, значение> в качестве элементов.
 Упорядочено по возрастанию ключей.}
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

  {Увеличить на 1 значение элемента с ключом Key в дереве Tree и вернуть TRUE.
   Если в Tree нет элемента с ключом Key, создаётся элемент <Key, 1> и возвращается FALSE.}
  FUNCTION BTMWIIncrement(VAR Tree: BTMWITree; VAR Key: Word): BOOLEAN;

  {Считать из InFile элемент дерева в формате:
    <Key><не буква для модуля Words><Value>
    с переводом строки.
   Никаких проверок входных данных не производится.}
  FUNCTION BTMWINodeFromFile(VAR InFile: TEXT): BTMWITree;

  {Вывести в OutFile элемент дерева Node в формате
    <Key> <Value>
    с переводом строки.
   Значение Node удаляется.}
  PROCEDURE BTMWINodeIntoFile(VAR OutFile: TEXT; VAR Node: BTMWITree);

  {Вывести в OutFile дерево Tree в формате:
    <Key1> <Value1>
    <Key2> <Value2>
    ...
    <KeyN> <ValueN>
    с завершающим переводом строки.}
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
                WRITE(STDERR, 'ПРЕДУПРЕЖДЕНИЕ: Произошло переполнение для ключа ');
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
