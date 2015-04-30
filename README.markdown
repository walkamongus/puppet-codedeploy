# AWS CodeDeploy Puppet Module

[![Build Status](https://travis-ci.org/walkamongus/puppet-codedeploy.svg?branch=master)](https://travis-ci.org/walkamongus/puppet-codedeploy)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with codedeploy](#setup)
    * [What codedeploy affects](#what-codedeploy-affects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and enables the AWS CodeDeploy agent.

## Module Description

The AWS Codedeploy allows you to automatically deploy applications from S3 or GitHub. This module installs any required package followed by the CodeDeploy agent. It then enables the codedeploy-agent service and ensures it is running.

## Setup

### What codedeploy affects

* Packages
    * codedeploy-agent (RedHat)
    * awscli (Debian)
    * ruby2.0 (Debian)
* Services
    * codedeploy-agent daemon

## Usage

Install the AWS CodeDeploy agent and ensure the agent is running

    class {'::codedeploy': }

## Limitations

This module has been tested on:
* RedHat 6,7
* Debian 6,7
* Ubuntu 14.04

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.
