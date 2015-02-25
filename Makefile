compile: src/**/*.hs
	cabal build

run: compile
	./dist/build/statsd/statsd

test: compile
	cabal test
