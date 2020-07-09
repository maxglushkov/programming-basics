{����筮� ��ॢ� � ��ࠬ� <����, ���祭��> � ����⢥ ����⮢.
 ����冷祭� �� �����⠭�� ���祩.
 �ᯮ���� 䠩� ��� ���஢���� ��ॢ�. ������� ���ॡ����� ����� ~650MiB.
 �������� �ᯮ�짮����� ⮫쪮 ������ ������� ��ॢ�.}
UNIT FSCachedBTreeMapWordInt;
INTERFACE
  USES
    Words;

  {�������� �� 1 ���祭�� ����� � ���箬 Key � ��ॢ�.
   �᫨ � ��ॢ� ��� ����� � ���箬 Key, ᮧ������ ����� <Key, 1>.}
  PROCEDURE FSCBTMWIIncrement(VAR Key: Word);

  {�뢥�� � OutFile ��ॢ� � �ଠ�:
    <Key1> <Value1>
    <Key2> <Value2>
    ...
    <KeyN> <ValueN>
    � �������騬 ��ॢ���� ��ப�.
   ��ॢ� �� �⮬ ��頥���.}
  PROCEDURE FSCBTMWIIntoListing(VAR OutFile: TEXT);

IMPLEMENTATION
  USES
    BTreeMapWordInt;
  CONST
    MaxSizeInRam = 20000;
  VAR
    Cache, MergeTemp: TEXT;
    SizeInRam: INTEGER;
    Tree: BTMWITree;

  PROCEDURE FlushTreeToCache();
  VAR
    TextVarSwap: TEXT;
  BEGIN {FlushTreeToCache}
    FSCBTMWIIntoListing(MergeTemp);
    RESET(MergeTemp);
    REWRITE(Cache);
    TextVarSwap := Cache;
    Cache := MergeTemp;
    MergeTemp := TextVarSwap;
    SizeInRam := 0
  END; {FlushTreeToCache}

  PROCEDURE MergeRamAndCache(VAR OutFile: TEXT; VAR RamTree, CacheNode: BTMWITree);
  VAR
    Cmp: INTEGER;
    RightTree: BTMWITree;
  BEGIN {MergeRamAndCache}
    IF RamTree <> NIL
    THEN
      BEGIN
        MergeRamAndCache(OutFile, RamTree^.Left, CacheNode);
        Cmp := -1;
        WHILE (CacheNode <> NIL) AND (Cmp < 0)
        DO
          BEGIN
            Cmp := WordExactCompare(CacheNode^.Key, RamTree^.Key);
            IF Cmp <= 0
            THEN
              BEGIN
                IF Cmp < 0
                THEN
                  BTMWINodeIntoFile(OutFile, CacheNode)
                ELSE
                  BEGIN
                    IF MAXINT - RamTree^.Value < CacheNode^.Value
                    THEN
                      BEGIN
                        WRITE(STDERR, '��������������: �ந��諮 ��९������� ��� ���� ');
                        WordWrite(STDERR, RamTree^.Key);
                        WRITELN(STDERR)
                      END;
                    RamTree^.Value += CacheNode^.Value;
                    DISPOSE(CacheNode);
                    CacheNode := NIL
                  END;
                IF NOT EOF(Cache)
                THEN
                  CacheNode := BTMWINodeFromFile(Cache)
              END
          END;
        RightTree := RamTree^.Right;
        BTMWINodeIntoFile(OutFile, RamTree);
        MergeRamAndCache(OutFile, RightTree, CacheNode)
      END
  END; {MergeRamAndCache}

  PROCEDURE AppendRest(VAR InFile, OutFile: TEXT);
  VAR
    Ch: CHAR;
  BEGIN {AppendRest}
    WHILE NOT EOF(InFile)
    DO
      BEGIN
        WHILE NOT EOLN(InFile)
        DO
          BEGIN
            READ(InFile, Ch);
            WRITE(OutFile, Ch)
          END;
        READLN(InFile);
        WRITELN(OutFile)
      END
  END; {AppendRest}

  PROCEDURE FSCBTMWIIncrement(VAR Key: Word);
  BEGIN {FSCBTMWIIncrement}
    IF NOT BTMWIIncrement(Tree, Key)
    THEN
      SizeInRam += 1;
    IF SizeInRam = MaxSizeInRam
    THEN
      FlushTreeToCache
  END; {FSCBTMWIIncrement}

  PROCEDURE FSCBTMWIIntoListing(VAR OutFile: TEXT);
  VAR
    CacheNode: BTMWITree;
  BEGIN {FSCBTMWIIntoListing}
    IF EOF(Cache)
    THEN
      CacheNode := NIL
    ELSE
      CacheNode := BTMWINodeFromFile(Cache);
    MergeRamAndCache(OutFile, Tree, CacheNode);
    IF CacheNode <> NIL
    THEN
      BTMWINodeIntoFile(OutFile, CacheNode);
    AppendRest(Cache, OutFile)
  END; {FSCBTMWIIntoListing}

BEGIN {FSCachedBTreeMapWordInt}
  ASSIGN(Cache, 'FSCBTMWICache0.tmp');
  ASSIGN(MergeTemp, 'FSCBTMWICache1.tmp');
  REWRITE(Cache);
  REWRITE(MergeTemp);
  RESET(Cache)
END. {FSCachedBTreeMapWordInt}
