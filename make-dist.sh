#!/bin/sh

die () {
    echo "$*" >&2
    exit 1
}
doit () {
    echo "\$ $*" >&2
    $* || die "[ERROR:$?]"
}

rdf=t/example/index.rdf
doit wget -O $rdf~ http://www.kawa.net/rss/index-e.rdf
diff $rdf $rdf~ > /dev/null || doit /bin/mv -f $rdf~ $rdf
/bin/rm -f $rdf~

egrep -v '^t/.*\.t$' MANIFEST > MANIFEST~
ls t/*.t >> MANIFEST~
diff MANIFEST MANIFEST~ > /dev/null || doit /bin/mv -f MANIFEST~ MANIFEST
/bin/rm -f MANIFEST~

[ -f Makefile ] && doit make clean
doit perl Makefile.PL

[ -f META.yml ] || doit touch META.yml
doit make metafile
newmeta=`ls -t */META.yml | head -1`
diff META.yml $newmeta > /dev/null || doit /bin/cp -f $newmeta META.yml

doit make disttest

main=`grep 'lib/.*pm$' < MANIFEST | head -1`
[ "$main" == "" ] && die "main module is not found in MANIFEST"
doit pod2text $main > README~
diff README README~ > /dev/null || doit /bin/mv -f README~ README
/bin/rm -f README~

doit make dist
[ -d blib ] && doit /bin/rm -fr blib
[ -f pm_to_blib ] && doit /bin/rm -f pm_to_blib
[ -f Makefile ] && doit /bin/rm -f Makefile
[ -f Makefile.old ] && doit /bin/rm -f Makefile.old

ls -lt *.tar.gz | head -1
