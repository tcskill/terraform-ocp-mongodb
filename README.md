#  MAS terraform module

Deploys .... (module currently being built)

### Supported Component Selector Probe Types 


## Supported platforms

- OCP 4.6+

## Module dependencies

The module uses the following elements

### Terraform providers

- helm - used to configure the scc for OpenShift
- null - used to run the shell scripts

### Environment

- kubectl - used to apply the yaml to create the route

## Suggested companion modules

The module itself requires some information from the cluster and needs a
namespace to be created. The following companion
modules can help provide the required information:


## Example usage



