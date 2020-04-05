#!/usr/bin/env bash

function getPercent() {
    echo $((100 * ${1} / ${2}))
}
