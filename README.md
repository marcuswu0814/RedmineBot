# RedmineBot

[![Build Status](https://travis-ci.org/marcuswu0814/RedmineBot.svg?branch=master)](https://travis-ci.org/marcuswu0814/RedmineBot)
[![codebeat badge](https://codebeat.co/badges/68649015-0c5d-4102-bb00-0ee54faeb7e3)](https://codebeat.co/projects/github-com-marcuswu0814-redminebot-master)
[![codecov](https://codecov.io/gh/marcuswu0814/RedmineBot/branch/master/graph/badge.svg)](https://codecov.io/gh/marcuswu0814/RedmineBot)

`RedmineBot` is a CLI tool help to post commit log to [Redmine](https://www.redmine.org).

## TODO

- Support linux.
- Better unit test.
- User custom template.
- Support much more [Redmine REST API](http://www.redmine.org/projects/redmine/wiki/Rest_api) with CLI.

Any other suggestion? Feel free to create an issue or PR. 🙏

## Installation

### macOS
### Homebrew

```bash
$ brew install marcuswu0814/homebrew-taps/redminebot
```

### Linux

Currently not support yet.

## Setup

```bash
$ redmine-bot setup REDMINE_SERVER_URL API_ACCESS_KEY
```
Get `API_ACCESS_KEY` from `My account` page right hand side.

```bash
$ cd PATH_TO_YOUR_REPO
$ redmine-bot install-hook
```

`Redmine-bot` will install `post-commit` and `post-rewrite` hook in specific repo. after execute `install-hook` command.

## Usage

### Example

***Commit***

```bash
$ cd PATH_TO_YOUR_REPO
$ touch testFile
$ git add --all
$ git commit -m "Commit for #123 and #255"
```
Every time you commited, `post-commit` hook will run. And post commit message to `Redmine` issue number `#123` and `#255`.

***Rebase***

```bash
$ cd PATH_TO_YOUR_REPO
$ git pull --rebase
```
If pull repo. from git server and not fast forward, commit will re-write, and `post-rewrite` hook run.

Just like `post-commit`, `RedmineBot` will post a new note to let you know commit sha is updated.

## Contact

If you find an issue or have questions, feel free to [let me know](https://github.com/marcuswu0814/RedmineBot/issues/new). 👍