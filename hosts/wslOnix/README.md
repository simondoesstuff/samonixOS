## Vscode jupyter notebook tips

Running a jupyer from within wsl has been historically troublesome but there are some debugging steps to be done. First, access **openvscode-server** from the windows host by running `sudo systemctl status openvscode-server` and visiting the link in a browser.
- Commonly, python packages depend on `gcc`. My jupyter setup has failed in the past because my flake didn't have `gcc` included in it and modules were silently failing.
- Also, including the `stenv.cc.cc.lib` package is vital for getting ld libraries in the path.
- First check if `jupyter notebook` itself runs without error. If all else fails, you can use the notebook server this command provides from within vscode when selecting a jupyter kernel.
