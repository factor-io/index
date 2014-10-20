[![Build Status](https://travis-ci.org/factor-io/index.svg?branch=master)](https://travis-ci.org/factor-io/index)

Factor.io Connector and Workflow Index
=====
This is project contains a the static files [connectors.yml](https://github.com/factor-io/index/blob/master/connectors.yml), and [workflows.yml](https://github.com/factor-io/index/blob/master/workflows.yml), used by the `factor registry` commands to get a list of available connectors and workflow templates.


## Testing
To run tests just use...

    bundle install
    bundle exec rake

You may have noticed that there is no actual code as this is only a host for static contents; however, the tests validate that the static contents is formatted correctly and that all the links to additional contents are valid as well.
