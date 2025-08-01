#!/usr/bin/env bash
set -e

# Global default validation
core_validate() {
  require_env_var "_REMOTE_USER"
  require_env_var "_REMOTE_USER_HOME"
  require_env_var "_CONTAINER_USER"
  require_env_var "_CONTAINER_USER_HOME"
}
