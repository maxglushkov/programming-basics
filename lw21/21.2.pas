PROGRAM Encoder(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно CharMap
 и печатает новые символы в OUTPUT}
CONST
  MaxLen = 20;
TYPE
  Index = 1 .. MaxLen;
  Str = ARRAY[Index] OF CHAR;
  CharMap = RECORD
              Map: ARRAY[CHAR] OF CHAR;
              DefinitionDomain: SET OF CHAR;
            END;

PROCEDURE LoadCharMap(VAR Code: CharMap);
{Загрузить в Code шифр замены из файла "Code"}
VAR
  CodeSource: TEXT;
  Ch1, Ch2: CHAR;
BEGIN {LoadCharMap}
  ASSIGN(CodeSource, 'Code');
  RESET(CodeSource);
  WHILE NOT EOF(CodeSource)
  DO
    BEGIN
      IF NOT EOLN(CodeSource)
      THEN
        BEGIN
          READ(CodeSource, Ch1);
          IF NOT EOLN(CodeSource)
          THEN
            BEGIN
              READ(CodeSource, Ch2);
              Code.Map[Ch1] := Ch2;
              Code.DefinitionDomain += [Ch1]
            END
        END;
      READLN(CodeSource)
    END
END;  {LoadCharMap}

PROCEDURE EncodeToOutput(VAR Code: CharMap; VAR S: Str; Count: Index);
{Выводит символы из Code, соответствующие символам из S}
VAR
  I: Index;
BEGIN {EncodeToOutput}
  FOR I := 1 TO Count
  DO
    IF S[I] IN Code.DefinitionDomain
    THEN
      WRITE(OUTPUT, Code.Map[S[I]])
    ELSE
      WRITE(OUTPUT, S[I]);
  WRITELN(OUTPUT)
END;  {EncodeToOutput}

VAR
  Msg: Str;
  Code: CharMap;
  I: INTEGER;
BEGIN {Encoder}
  {Инициализировать Code}
  LoadCharMap(Code);
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      {читать строку в Msg и распечатать ее}
      I := 0;
      WHILE NOT EOLN(INPUT) AND (I < MaxLen)
      DO
        BEGIN
          I += 1;
          READ(INPUT, Msg[I]);
          WRITE(OUTPUT, Msg[I])
        END;
      READLN(INPUT);
      WRITELN(OUTPUT);
      {распечатать кодированное сообщение}
      EncodeToOutput(Code, Msg, I)
    END
END.  {Encoder}
