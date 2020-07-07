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

  {Увеличить на 1 значение элемента с ключом Key в дереве Tree.
   Если в Tree нет элемента с ключом Key, создаётся элемент <Key, 1>.}
  PROCEDURE BTMWIIncrement(VAR Tree: BTMWITree; VAR Key: Word);

  {Вывести в OutFile дерево Tree в формате:
    <Key1>: <Value1>
    <Key2>: <Value2>
    ...
    <KeyN>: <ValueN>
    с завершающим переводом строки.}
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
                WRITE(STDERR, 'ПРЕДУПРЕЖДЕНИЕ: Произошло переполнение для ключа ');
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
