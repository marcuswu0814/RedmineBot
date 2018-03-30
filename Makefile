PREFIX?=/usr/local

PROD_NAME=RedmineBot
PROD_NAME_UNDERLINE=redmine-bot

build:
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib

run:
	.build/release/$(PROD_NAME)

test:
	swift test

lint:
	swiftlint

update:
	swift package update

clean:
	swift package clean

xcode:
	swift package generate-xcodeproj

install: build
	mkdir -p "$(PREFIX)/bin"
	cp -f ".build/release/$(PROD_NAME)" "$(PREFIX)/bin/$(PROD_NAME_UNDERLINE)"
