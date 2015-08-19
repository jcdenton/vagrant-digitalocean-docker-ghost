Requires the following Vagrant plugins:

    vagrant plugin install vagrant-digitalocean
    vagrant plugin install vagrant-env

All required environment variables are located in `.env` file.

How to run:

    vagrant up

It would create a new 512M DO box called `$VAGRANT_MACHINE_NAME`
and run two Docker containers there: `nginx-proxy` and `$GHOST_BLOG_NAME`.

And do not forget to set up DigitalOcean DNS servers for your `$GHOST_BLOG_HOST`.
