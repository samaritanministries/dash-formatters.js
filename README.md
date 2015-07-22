# Dash Formatters

[![Build Status](https://travis-ci.org/samaritanministries/dash-formatters.js.svg)](https://travis-ci.org/samaritanministries/dash-formatters.js)

#### This is a collection of text formatters for the Dash platform.

# Releasing a New Version

Steps to release a new version:

1. Update the [change log](/CHANGELOG.md).
2. Run `./bower_deploy.sh`

# Setup

* install node/npm
* npm install
* bower install
* npm install testem -g

# Tests

Run ```testem```

# Usage

```coffee
dateString = "2013-04-25T15:30:35.050+00:00"
new DashFormatters.Date().format(dateString)
# "4/25/2013"
```

# License

MIT License
