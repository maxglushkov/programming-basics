/* Pseudo-graphic characters compiler                                        *
 * Преобразует текстовые файлы формата                                       *

<ширина-символа> <высота-символа>
<символ>
Обра-
 зец

сим-
 вола
<символ-2>
Обра-
 зец
сим-
 вола
  2

 * в формат                                                                  *

<ширина-символа> <высота-символа>
<символ> <множество-чисел> (1 2 3 4 5 7 8 9 16 17 18 19 22 23 24 25)
<символ-2> <множество-чисел-2> (1 2 3 4 5 7 8 9 11 12 13 14 17 18 19 20 23)

 * Порядок прохода по образцу: слева направо, сверху вниз. Нумерация - с 1.  */
#include <iostream>
using std::istream;
inline bool eof(istream &stream);
inline bool eoln(istream &stream);
int main(){
    using std::cin;
    using std::cout;
    short width, height;
    cin >> width >> height;
    cout << width << ' ' << height << '\n';
    cin.ignore();
    while(!eof(cin)){
        char c = cin.get();
        cout << c << ' ';
        for(char y = 0; y < height; y++){
            cin.ignore();
            for(char x = 1; x <= width; x++){
                if(eoln(cin)) break;
                if(cin.get() != ' ') cout << (x + y * width) << ' ';
            }
        }
        cin.ignore();
        cout << '\n';
    }
    return 0;
}
bool eof(istream &stream){
    return stream.peek() == -1;
}
bool eoln(istream &stream){
    int next = stream.peek();
    if(next == '\n') return true;
    if(next == '\r') return true;
    return next == -1;
}
