PROGRAM Prime(INPUT, OUTPUT);
CONST
  First = 2;
  Last = 100;
VAR
  Item, Multiple: INTEGER;
  Sieve: SET OF First .. Last;
BEGIN {Prime}
  Sieve := [First .. Last];
  Item := First;
  WHILE Item <= Last
  DO
    BEGIN
      IF Item IN Sieve
      THEN
        BEGIN
          WRITELN(Item);
          Multiple := Item;
          WHILE Multiple <= Last
          DO
            BEGIN
              Sieve -= [Multiple];
              Multiple += Item
            END
        END;
      Item += 1
    END
END. {Prime}
