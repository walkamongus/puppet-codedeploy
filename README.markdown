# AWS CodeDeploy Puppet Module

[![Test](https://github.com/jackdpeterson/puppet-codedeploy/actions/workflows/test.yml/badge.svg)](https://github.com/jackdpeterson/puppet-codedeploy/actions/workflows/test.yml)

## Build Status

- [x] Ubuntu 24.04
- [x] Ubuntu 26.04
- [x] Amazon Linux 2023

## Overview

This module installs and enables the AWS CodeDeploy agent.

## Module Description

The AWS CodeDeploy service allows you to automatically deploy applications to AWS instances from S3 or GitHub. This module downloads and installs the CodeDeploy agent package directly from the regional S3 bucket, configures the agent, and ensures the service is running.

## Setup

### What codedeploy affects

* Packages
    * codedeploy-agent
    * ruby-full (Debian/Ubuntu)
* Services
    * codedeploy-agent daemon

### Dependencies

* [puppetlabs/stdlib](https://forge.puppet.com/modules/puppetlabs/stdlib)
* [puppet/archive](https://forge.puppet.com/modules/puppet/archive)

## Usage

```puppet
include codedeploy
```

To specify a different AWS region:

```puppet
class { 'codedeploy':
  aws_region => 'eu-west-1',
}
```

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `aws_region` | `us-west-1` | AWS region for the CodeDeploy S3 bucket |
| `service_name` | `codedeploy-agent` | Name of the service |
| `package_name` | `codedeploy-agent` | Name of the package |

## Limitations

Supported operating systems:

* Ubuntu 24.04, 26.04
* Debian 12, 13
* Red Hat / Amazon Linux 8, 9, 10

Requires Puppet 8.

### Ruby Compatibility

The `codedeploy-agent` `.deb` package declares dependencies on Ruby <= 3.2.
However, analysis of the agent's Ruby source code confirms it is fully
compatible with Ruby 3.3 (shipped with Ubuntu 26.04). This module uses
`dpkg --force-depends` to bypass the packaging constraint on all
Debian/Ubuntu versions.

## Testing

```bash
make test
```

Runs the module in Docker containers for each supported platform and verifies the package installs successfully.
