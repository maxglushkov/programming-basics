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

PROCEDURE InitializeCharMap(VAR Code: CharMap);
{Присвоить Code шифр замены}
BEGIN {InitializeCharMap}
  Code.Map[' '] := 'W';
  Code.Map['A'] := 'Z';
  Code.Map['B'] := 'Y';
  Code.Map['C'] := 'X';
  Code.Map['D'] := '#';
  Code.Map['E'] := 'V';
  Code.Map['F'] := 'U';
  Code.Map['G'] := 'T';
  Code.Map['H'] := 'S';
  Code.Map['I'] := 'I';
  Code.Map['J'] := 'Q';
  Code.Map['K'] := 'P';
  Code.Map['L'] := '!';
  Code.Map['M'] := 'N';
  Code.Map['N'] := 'M';
  Code.Map['O'] := '2';
  Code.Map['P'] := 'K';
  Code.Map['Q'] := '$';
  Code.Map['R'] := 'D';
  Code.Map['S'] := 'H';
  Code.Map['T'] := '*';
  Code.Map['U'] := 'F';
  Code.Map['V'] := 'E';
  Code.Map['W'] := 'T';
  WRITELN(STDERR, '''G'' и ''W'' будут преобразованы в ''T''. При декодировании могут возникнуть трудности.');
  Code.Map['X'] := 'C';
  Code.Map['Y'] := 'B';
  Code.Map['Z'] := 'A';
  Code.DefinitionDomain := [' ', 'A' .. 'Z']
END;  {InitializeCharMap}

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
  InitializeCharMap(Code);
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
