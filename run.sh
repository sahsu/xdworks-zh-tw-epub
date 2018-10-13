#!/bin/sh
curl https://github.com/xdworks | grep '<a href="/xdworks/' | sed -e 's;" itemprop="name codeRepository">;;g' | sed -e 's;        <a href="/xdworks/;;g' | while read i; do git clone https://github.com/xdworks/$i; done

cat > startup-school-2017/book.json <<BOOK
{
  "title": "Startup School 2017"
}
BOOK
cat > startup-school-2018/book.json <<BOOK
{
  "title": "Startup School 2018"
}
BOOK
cat > blitzscaling-cs183c/book.json <<BOOK
{
  "title": "BlitzScaling"
}
BOOK
cat > scale-up/book.json <<BOOK
{
  "title": "Scale Up"
}
BOOK
cat > startup-cs183b/book.json <<BOOK
{
  "title": "How to Start a Startup: CS183b"
}
BOOK
cat > speed-reading/book.json <<BOOK
{
  "title": "Speed Reading 激進學習法"
}
BOOK
cat > startup-school-2012/book.json <<BOOK
{
  "title": "Startup School 2012"
}
BOOK
cat > dd/book.json <<BOOK
{
  "title": "得到"
}
BOOK
cat > yc-investor-school/book.json <<BOOK
{
  "title": "YC Startup Investor School"
}
BOOK

find . -name '*.md' | while read i; do 
opencc -i $i -o $i.new 
echo $i.new
test -s $i.new && mv $i.new $i
done

rm EPUB.md
find . -name 'SUMMARY.md' | while read i; do 
DIR=`dirname $i | sed -e 's;\.\/;;g'`
cd $DIR && gitbook epub ./ ../$DIR.epub && echo "* [$DIR](https://github.com/sahsu/xdworks-zh-tw-epub/raw/master/$DIR.epub)" >> ../EPUB.md
cd -

done
wget https://legacy.gitbook.com/download/epub/book/xdite/learn-something -O learn-something.epub
echo "* [學習這回事](https://github.com/sahsu/xdworks-zh-tw-epub/raw/master/learn-something.epub)" >> EPUB.md

cat README-pre.md EPUB.md > README.md

