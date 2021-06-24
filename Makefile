.PHONY: dev test

dev:
	rackup

test:
	cutest test/*_test.rb

