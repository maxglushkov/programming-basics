{Двоичное дерево со статистикой в формате <ключ, набор значений, количество значений> в качестве элементов.
 Упорядочено по возрастанию ключей.}
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

  {Добавить Count к Count и Value к Group элемента с ключом Key в дереве Tree.
   Если в Tree нет элемента с ключом Key, создаёт его из значений <Key, [Value], Count>.
   ПРИМЕЧАНИЕ: Key должен передаваться по ссылке. При передаче по значению через некоторое количество итераций
               в WordExactCompare ломается указатель на стек, что приводит к ошибке сегментации.}
  PROCEDURE BTMWSAdd(VAR Tree: BTMWSTree; VAR Key, Value: Word; Count: INTEGER);

  {Вывести в файл OutFile статистику из дерева Tree в формате:
    <Key1_Group1>,<Key1_Group2>, ... ,<Key1_GroupN>: <Key1_Count>
    <Key2_Group1>,<Key2_Group2>, ... ,<Key2_GroupN>: <Key2_Count>
    ...
    <KeyN_Group1>,<KeyN_Group2>, ... ,<KeyN_GroupN>: <KeyN_Count>
    с завершающим переводом строки.}
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
                WRITE(STDERR, 'ПРЕДУПРЕЖДЕНИЕ: Произошло переполнение для ключа ');
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
