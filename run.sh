#!/bin/sh
curl https://github.com/xdworks | grep '<a href="/xdworks/' | sed -e 's;" itemprop="name codeRepository">;;g' | sed -e 's;        <a href="/xdworks/;;g' | while read i; do git clone https://github.com/xdworks/$i; done

find . -name '*.md' | while read i; do 
opencc -i $i -o $i.new 
test -s $i.new && mv $i.new $i
done

rm EPUB.md
find . -name 'SUMMARY.md' | while read i; do 
DIR=`dirname $i | sed -e 's;\.\/;;g'`
cd $DIR && gitbook epub ./ ../$DIR.epub && echo "* [$DIR]($DIR.epub)" >> ../EPUB.md
cd -

done

cat README-pre.md EPUB.md > README.md
