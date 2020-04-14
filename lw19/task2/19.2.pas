PROGRAM SortDate(INPUT, OUTPUT);
USES DateUnit;
VAR
  GreaterDateFound: BOOLEAN;
  VarDate, NextDate: Date;
  DateFile, TempFile: FileOfDate;
  InputFile: TEXT;
BEGIN {SortDate}
  {Инициализация}
  ASSIGN(DateFile, 'DF.DAT');
  ASSIGN(TempFile, 'TF.DAT');
  ASSIGN(InputFile, 'FI.TXT');
  {Копируем первую дату в DateFile}
  REWRITE(DateFile);
  RESET(InputFile);
  ReadDate(InputFile, VarDate);
  READLN(InputFile);
  WRITE(DateFile, VarDate);
  WHILE NOT EOF(InputFile)
  DO
    {Поместить новую дату в DateFile в соответствующее место}
    BEGIN
      ReadDate(InputFile, NextDate);
      READLN(InputFile);
      IF NextDate.Mo <> NoMonth
      THEN
        BEGIN
          {копируем элементы меньшие, чем NextDate из DateFile в TempFile}
          RESET(DateFile);
          REWRITE(TempFile);
          GreaterDateFound := FALSE;
          WHILE NOT EOF(DateFile) AND NOT GreaterDateFound
          DO
            BEGIN
              READ(DateFile, VarDate);
              IF Less(VarDate, NextDate)
              THEN
                WRITE(TempFile, VarDate)
              ELSE
                GreaterDateFound := TRUE
            END;
          {копируем D в TempFile}
          WRITE(TempFile, NextDate);
          {копируем остаток DateFile в TempFile}
          IF GreaterDateFound
          THEN
            BEGIN
              WRITE(TempFile, VarDate);
              WHILE NOT EOF(DateFile)
              DO
                BEGIN
                  READ(DateFile, VarDate);
                  WRITE(TempFile, VarDate)
                END
            END;
          {копируем TempFile в DateFile}
          REWRITE(DateFile);
          RESET(TempFile);
          WHILE NOT EOF(TempFile)
          DO
            BEGIN
              READ(TempFile, VarDate);
              WRITE(DateFile, VarDate)
            END
        END
    END;
  {Копируем DateFile в OUTPUT}
  RESET(DateFile);
  CopyOut(DateFile)
END. {SortDate}
