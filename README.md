# jniemela.dk

### Nix & Flakes

If you don't have [nix](https://nixos.org), follow [the nix installation
instructions](https://nixos.org/download.html).

Once you have nix installed, follow the instructions here to get access to
flakes: https://nixos.wiki/wiki/Flakes.  

After installing Nix, you can enter the local development environment by running `nix develop`, this will make the commands below available. Alternatively put `use flakes` into an .envrc file and use direnv.

## Deployment
Running `deploy` will execute the `deployComamnd` in `Main.hs`, in my case, it will rsync the resulting website onto the server.


## Local development
Running `check` will start up the website on localhost:8000, the website will be updated live on changes to files in `src`, changes to `ssg` require a restart of `check`
