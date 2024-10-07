
leader ft and search your stuff

ctrl q (maybe an another in original vim) to send the stuff to the quickfix list.

Then command in command mode:
```shell
cfdo %s/old-name/new-name/gc | update | bd
```
bd if there is a buffer list open.
