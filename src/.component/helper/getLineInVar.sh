#!/usr/bin/env bash

function getLineInVar() {
    echo -n "${1}" | grep -c '^'
}
