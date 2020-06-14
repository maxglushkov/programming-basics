PROGRAM Prime(INPUT, OUTPUT);
CONST
  First = 2;
  Last = 100;
VAR
  Item, Multiple: INTEGER;
  Sieve: SET OF First .. Last;
BEGIN {Prime}
  {Initializing sieve}
  Sieve := [First .. Last];
  {Excluding composite numbers from sieve}
  Item := First;
  WHILE Item * Item <= Last
  DO
    BEGIN
      IF Item IN Sieve
      THEN
        BEGIN
          Multiple := 2 * Item;
          WHILE Multiple <= Last
          DO
            BEGIN
              Sieve -= [Multiple];
              Multiple += Item
            END
        END;
      Item += 1
    END;
  {Printing sieve}
  FOR Item := First TO Last
  DO
    IF Item IN Sieve
    THEN
      WRITELN(Item)
END. {Prime}
