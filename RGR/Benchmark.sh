#!/bin/sh
echo "======================================="
echo "=== WordsCounter Benchmarking Suite ==="
echo "======================================="
WCvariant=""
case $1 in
  "--help" | "-h")
    echo "Usage:"
    echo "      Command                        Description"
    echo "  ./Benchmark.sh                 test ./WordsCounter"
    echo "  ./Benchmark.sh --with-cache    test ./WordsCounterWithCache"
    exit 0
    ;;
  "--with-cache")
    WCvariant="WithCache"
    ;;
esac
printf "\nChecking system requirements\n"
printf "Checking for ./WordsCounter${WCvariant} ... "
if [ -x ./WordsCounter${WCvariant} ]
then
  echo "OK"
else
  if fpc -O3 WordsCounter${WCvariant}.pas >/dev/null 2>&1
  then
    echo "OK"
  else
    echo "Failed"
    exit 1
  fi
fi
printf "Checking for /usr/bin/time ... "
if [ -x /usr/bin/time ]
then
  echo "OK"
else
  echo "Failed"
  exit 1
fi
printf "Checking for Tests/*.txt ... "
if [ -e Tests/1.txt -a -e Tests/2.txt ]
then
  echo "OK"
else
  echo "Failed"
  exit 1
fi
printf "Creating /tmp/WordsCounter${WCvariant}Results directory ... "
if mkdir -p /tmp/WordsCounter${WCvariant}Results >/dev/null 2>&1
then
  echo "OK"
else
  echo "Failed"
  exit 1
fi
printf "Benchmarking requirements are satisfied\n\n"
echo "Running tests ..."
echo "	Big cyrrilic text ..."
cat >Benchmark${WCvariant}.txt <<__BMEOF
=== Mostly cyrrilic big text ===
Bytes: $(wc -c Tests/1.txt | cut -f1 '-d ')
Words: ~$(wc -w Tests/1.txt | cut -f1 '-d ')
WordsCounter${WCvariant} errors and resource usage:
__BMEOF
/usr/bin/time -v ./WordsCounter${WCvariant} <Tests/1.txt >/tmp/WordsCounter${WCvariant}Results/1.txt 2>>Benchmark${WCvariant}.txt
echo "	Tiny cyrrilic text ..."
cat >>Benchmark${WCvariant}.txt <<__BMEOF

=== Cyrrilic tiny text ===
Bytes: $(wc -c Tests/2.txt | cut -f1 '-d ')
Words: ~$(wc -w Tests/2.txt | cut -f1 '-d ')
WordsCounter${WCvariant} errors and resource usage:
__BMEOF
/usr/bin/time -v ./WordsCounter${WCvariant} <Tests/2.txt >/tmp/WordsCounter${WCvariant}Results/2.txt 2>>Benchmark${WCvariant}.txt
echo "	Source code (mixed latin and cyrrilic) ..."
cat >>Benchmark${WCvariant}.txt <<__BMEOF

=== Source code in working directory ===
Bytes: $(cat *.pas | wc -c)
Words: ~$(cat *.pas | wc -w)
WordsCounter${WCvariant} errors and resource usage:
__BMEOF
cat *.pas | /usr/bin/time -v ./WordsCounter${WCvariant} >/tmp/WordsCounter${WCvariant}Results/3.txt 2>>Benchmark${WCvariant}.txt
echo "	Binary file ..."
cat >>Benchmark${WCvariant}.txt <<__BMEOF

=== Executable itself ===
Bytes: $(wc -c WordsCounter${WCvariant} | cut -f1 '-d ')
Words: ~$(wc -w WordsCounter${WCvariant} | cut -f1 '-d ')
WordsCounter${WCvariant} errors and resource usage:
__BMEOF
/usr/bin/time -v ./WordsCounter${WCvariant} <WordsCounter${WCvariant} >/tmp/WordsCounter${WCvariant}Results/4.txt 2>>Benchmark${WCvariant}.txt
printf "Done\n\n"
echo "Benchmarking results are written to Benchmark${WCvariant}.txt"
echo "WordsCounter outputs are written to /tmp/WordsCounter${WCvariant}Results"
