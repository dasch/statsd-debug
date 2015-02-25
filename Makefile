compile: src/**/*.hs
	cabal build

run: compile
	./dist/build/statsd-server/statsd-server

test: compile
	cabal test
