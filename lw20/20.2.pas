PROGRAM PseudoGraphicPrintWithCustomMatrices(INPUT, OUTPUT);
USES PseudoGraphic;
VAR
  Matrices: TEXT;
  Ch: CHAR;
BEGIN {PseudoGraphicPrintWithCustomMatrices}
  ASSIGN(Matrices, 'PGFont.cch');
  RESET(Matrices);
  PGLoadFromFile(Matrices);
  PGInit;
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      READ(Input, Ch);
      PGPutChar(Ch)
    END;
  PGFlushTo(OUTPUT)
END. {PseudoGraphicPrintWithCustomMatrices}
