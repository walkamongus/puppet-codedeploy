# AWS CodeDeploy Puppet Module

[![Build Status](https://travis-ci.org/walkamongus/puppet-codedeploy.svg?branch=master)](https://travis-ci.org/walkamongus/puppet-codedeploy)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with codedeploy](#setup)
    * [What codedeploy affects](#what-codedeploy-affects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module installs and enables the AWS CodeDeploy agent.

## Module Description

The AWS Codedeploy allows you to automatically deploy applications to AWS instances from S3 or GitHub. This module installs any required packages followed by the CodeDeploy agent. It then enables the codedeploy-agent service and ensures that it is running.

## Setup

### What codedeploy affects

* Packages
    * codedeploy-agent
    * awscli (Debian)
* Services
    * codedeploy-agent daemon

## Usage

The codedeploy-agent package requires a version of Ruby > 2.0.x to be installed under /usr/bin/ruby. This dependency must be satisfied prior to installing the codedeploy-agent package. The recommended way of doing this is via the [puppetlabs/ruby](https://forge.puppetlabs.com/puppetlabs/ruby) module.

Install the AWS CodeDeploy agent and ensure the agent is running

    include '::ruby'
    include '::codedeploy'

