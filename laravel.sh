#!/bin/sh
composer require --dev vimeo/psalm psalm/plugin-laravel larastan/larastan barryvdh/laravel-ide-helper
echo "
includes:
    - vendor/larastan/larastan/extension.neon

parameters:

    paths:
        - app/

    # Level 9 is the highest level
    level: 5

#    ignoreErrors:
#        - '#PHPDoc tag @var#'
#
#    excludePaths:
#        - ./*/*/FileToBeExcluded.php
#
#    checkMissingIterableValueType: false
" >> phpstan.neon
