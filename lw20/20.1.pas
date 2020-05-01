PROGRAM PseudoGraphicPrint(INPUT, OUTPUT);
USES PseudoGraphic;
VAR
  Ch: CHAR;
BEGIN {PseudoGraphicPrint}
  PGLoadDefaultMatrices;
  PGInit;
  WHILE NOT EOF
  DO
    BEGIN
      READ(Ch);
      PGPutChar(Ch)
    END;
  PGFlushTo(OUTPUT)
END. {PseudoGraphicPrint}
