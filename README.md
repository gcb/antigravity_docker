With the move from gemini_cli to antigravity_cli, google is now closed source. As with most things closed source, better to run in a container.

## Instructions

### Build
1. create `./user-home` directory (it is in gitignore, so nobody commits their dot files by mistake)
1. place all your dotfiles and such in there. It will be copied to your home inside the container (once, during creation)
1. `make build`

Now you have a container with the closed source binary to use as you wish.

### Running

1. edit `Makefile.local`, see example bellow
1. create the dir for holding the settings, e.g. `mkdir settings`
1. `make` or `make run`
1. now you are in the container. Inspect your environment and start the harness with `agy`

```
# sample Makefile.local
export USER=gcb
export PATH_CODE=/home/gcb/work/someproject
export PATH_CONF=/home/gcb/.gemini
```

#### Remember

The **only** way to have your codebase and prompts be private, is to use an Enterprise subscription!

If you are using **any** of the other plans (free, personal, pro, etc) you are agreeing to give all the info to Google.
