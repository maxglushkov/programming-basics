#!/bin/sh
echo "======================================="
echo "=== WordsCounter Benchmarking Suite ==="
echo "======================================="
printf "\nChecking system requirements\n"
printf "Checking for ./WordsCounter ... "
if [ -x ./WordsCounter ]
then
  echo "OK"
else
  if fpc -O3 WordsCounter.pas >/dev/null 2>&1
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
printf "Creating /tmp/WordsCounterResults directory ... "
if mkdir /tmp/WordsCounterResults >/dev/null 2>&1
then
  echo "OK"
else
  echo "Failed"
  exit 1
fi
printf "Benchmarking requirements are satisfied\n\n"
echo "Running tests ..."
echo "	Big cyrrilic text ..."
cat >Benchmark.txt <<__BMEOF
=== Mostly cyrrilic big text ===
Bytes: $(wc -c Tests/1.txt | cut -f1 '-d ')
Words: ~$(wc -w Tests/1.txt | cut -f1 '-d ')
WordsCounter errors and resource usage:
__BMEOF
/usr/bin/time -v ./WordsCounter <Tests/1.txt >/tmp/WordsCounterResults/1.txt 2>>Benchmark.txt
echo "	Tiny cyrrilic text ..."
cat >>Benchmark.txt <<__BMEOF

=== Cyrrilic tiny text ===
Bytes: $(wc -c Tests/2.txt | cut -f1 '-d ')
Words: ~$(wc -w Tests/2.txt | cut -f1 '-d ')
WordsCounter errors and resource usage:
__BMEOF
/usr/bin/time -v ./WordsCounter <Tests/2.txt >/tmp/WordsCounterResults/2.txt 2>>Benchmark.txt
echo "	Source code (mixed latin and cyrrilic) ..."
cat >>Benchmark.txt <<__BMEOF

=== Source code in working directory ===
Bytes: $(cat *.pas | wc -c)
Words: ~$(cat *.pas | wc -w)
WordsCounter errors and resource usage:
__BMEOF
cat *.pas | /usr/bin/time -v ./WordsCounter >/tmp/WordsCounterResults/3.txt 2>>Benchmark.txt
echo "	Binary file ..."
cat >>Benchmark.txt <<__BMEOF

=== Executable itself ===
Bytes: $(wc -c WordsCounter | cut -f1 '-d ')
Words: ~$(wc -w WordsCounter | cut -f1 '-d ')
WordsCounter errors and resource usage:
__BMEOF
/usr/bin/time -v ./WordsCounter <WordsCounter >/tmp/WordsCounterResults/4.txt 2>>Benchmark.txt
printf "Done\n\n"
echo "Benchmarking results are written to Benchmark.txt"
echo "WordsCounter outputs are written to /tmp/WordsCounterResults"
