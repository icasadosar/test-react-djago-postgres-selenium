#!/bin/bash

USER_GITHUB="icasadosar@gmail.com"

ssh-keygen -t ed25519 -f "~/.ssh/id-key-github" -C "${USER_GITHUB}" -q -P ""