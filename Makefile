compile: src/**/*.hs
	cabal build

test: compile
	./dist/build/statsd/statsd
