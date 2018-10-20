FILE := Exercism

.PHONY  : default all
default : all
all     : makeinfo tangle

.PHONY : makefile
makefile : jrtangle worldclean weave

.PHONY : jrtangle tangle jrweave weave texi

tangle   : jrtangle
jrtangle :
	jrtangle $(FILE).twjr

weave    : jrweave
jrweave  : texi
texi     : $(FILE).texi
$(FILE).texi : $(FILE).twjr
	jrweave $(FILE).twjr > $(FILE).texi

.PHONY : info html openhtml pdf openpdf makeinfo

info :  texi
	makeinfo $(FILE).texi

html :  texi
	makeinfo --html $(FILE).texi

openhtml : html
	open $(FILE)/index.html

pdf  :  texi
	pdftexi2dvi --quiet --build=tidy --build-dir=build $(FILE).texi

openpdf : pdf
	open $(FILE).pdf

makeinfo : info html pdf clean

.PHONY : clean dirclean distclean worldclean

# remove backup files
clean :
	rm -f *~ .*~ #*#

# remove all directories; leave TexiwebJr, Texinfo files, Makefile
dirclean : clean
	for file in *; do 		       \
	  case $$file in  		       \
	    $(FILE)* | Makefile) ;; \
	    *) rm -vfr $$file		    ;; \
	  esac				       \
	done

# after dirclean, remove HTML and PDF files
distclean : dirclean
	rm -vfr $(FILE) $(FILE).pdf

# after distclean, remove INFO
worldclean : distclean
	rm -rfv $(FILE).info*


