{Замена регистра требует дополнительной подготовки.
 Использование отдельного модуля позволяет одновременно:
 - снизить потребление памяти при отсутствии необходимости в переводе в нижний регистр;
 - избежать дополнительных функций инициализации и проверок их предварительного вызова.}
UNIT WordsToLower;
INTERFACE
  USES
    Words;
  {Заменить все заглавные буквы в WordToLowercase на строчные.
   Как и Words, использует кодировку CP866.}
  PROCEDURE WordToLower(VAR WordToLowercase: Word);

IMPLEMENTATION
  USES
    BTreeMapCharChar;
  VAR
    LowercaseEquivalent: BTMCCTree;

  PROCEDURE WordToLower(VAR WordToLowercase: Word);
  VAR
    Index: INTEGER;
    LowercaseCh: CHAR;
  BEGIN
    Index := 0;
    WHILE WordToLowercase[Index] <> #0
    DO
      BEGIN
        IF BTMCCGetValue(LowercaseEquivalent, WordToLowercase[Index], LowercaseCh)
        THEN
          WordToLowercase[Index] := LowercaseCh;
        Index += 1
      END
  END;

BEGIN {WordsToLower}
  BTMCCInsert(LowercaseEquivalent, 'Г', 'г');
  BTMCCInsert(LowercaseEquivalent, 'O', 'o');
  BTMCCInsert(LowercaseEquivalent, 'С', 'с');
  BTMCCInsert(LowercaseEquivalent, 'H', 'h');
  BTMCCInsert(LowercaseEquivalent, 'W', 'w');
  BTMCCInsert(LowercaseEquivalent, 'К', 'к');
  BTMCCInsert(LowercaseEquivalent, 'Щ', 'щ');
  BTMCCInsert(LowercaseEquivalent, 'D', 'd');
  BTMCCInsert(LowercaseEquivalent, 'L', 'l');
  BTMCCInsert(LowercaseEquivalent, 'S', 's');
  BTMCCInsert(LowercaseEquivalent, 'А', 'а');
  BTMCCInsert(LowercaseEquivalent, 'Ж', 'ж');
  BTMCCInsert(LowercaseEquivalent, 'О', 'о');
  BTMCCInsert(LowercaseEquivalent, 'Х', 'х');
  BTMCCInsert(LowercaseEquivalent, 'Э', 'э');
  BTMCCInsert(LowercaseEquivalent, 'B', 'b');
  BTMCCInsert(LowercaseEquivalent, 'F', 'f');
  BTMCCInsert(LowercaseEquivalent, 'J', 'j');
  BTMCCInsert(LowercaseEquivalent, 'N', 'n');
  BTMCCInsert(LowercaseEquivalent, 'Q', 'q');
  BTMCCInsert(LowercaseEquivalent, 'U', 'u');
  BTMCCInsert(LowercaseEquivalent, 'Y', 'y');
  BTMCCInsert(LowercaseEquivalent, 'В', 'в');
  BTMCCInsert(LowercaseEquivalent, 'Е', 'е');
  BTMCCInsert(LowercaseEquivalent, 'И', 'и');
  BTMCCInsert(LowercaseEquivalent, 'М', 'м');
  BTMCCInsert(LowercaseEquivalent, 'Р', 'р');
  BTMCCInsert(LowercaseEquivalent, 'У', 'у');
  BTMCCInsert(LowercaseEquivalent, 'Ч', 'ч');
  BTMCCInsert(LowercaseEquivalent, 'Ы', 'ы');
  BTMCCInsert(LowercaseEquivalent, 'Я', 'я');
  BTMCCInsert(LowercaseEquivalent, 'A', 'a');
  BTMCCInsert(LowercaseEquivalent, 'C', 'c');
  BTMCCInsert(LowercaseEquivalent, 'E', 'e');
  BTMCCInsert(LowercaseEquivalent, 'G', 'g');
  BTMCCInsert(LowercaseEquivalent, 'I', 'i');
  BTMCCInsert(LowercaseEquivalent, 'K', 'k');
  BTMCCInsert(LowercaseEquivalent, 'M', 'm');
  BTMCCInsert(LowercaseEquivalent, 'P', 'p');
  BTMCCInsert(LowercaseEquivalent, 'R', 'r');
  BTMCCInsert(LowercaseEquivalent, 'T', 't');
  BTMCCInsert(LowercaseEquivalent, 'V', 'v');
  BTMCCInsert(LowercaseEquivalent, 'X', 'x');
  BTMCCInsert(LowercaseEquivalent, 'Z', 'z');
  BTMCCInsert(LowercaseEquivalent, 'Б', 'б');
  BTMCCInsert(LowercaseEquivalent, 'Д', 'д');
  BTMCCInsert(LowercaseEquivalent, 'Ё', 'ё');
  BTMCCInsert(LowercaseEquivalent, 'З', 'з');
  BTMCCInsert(LowercaseEquivalent, 'Й', 'й');
  BTMCCInsert(LowercaseEquivalent, 'Л', 'л');
  BTMCCInsert(LowercaseEquivalent, 'Н', 'н');
  BTMCCInsert(LowercaseEquivalent, 'П', 'п');
  BTMCCInsert(LowercaseEquivalent, 'Т', 'т');
  BTMCCInsert(LowercaseEquivalent, 'Ф', 'ф');
  BTMCCInsert(LowercaseEquivalent, 'Ц', 'ц');
  BTMCCInsert(LowercaseEquivalent, 'Ш', 'ш');
  BTMCCInsert(LowercaseEquivalent, 'Ъ', 'ъ');
  BTMCCInsert(LowercaseEquivalent, 'Ь', 'ь');
  BTMCCInsert(LowercaseEquivalent, 'Ю', 'ю')
END. {WordsToLower}
