INDEX = ./sphinx/_build/html/genindex.html

build:
	@rm -rf xml
	@cd sphinx; make clean; make html; cd ..
	@make install

install:
	@ruby filter.rb
	@cd sphinx; rm -rf ../../docs/*; cp -a _build/html/. ../../docs; cd ..

clean:
	@cd sphinx; make clean; cd ..
