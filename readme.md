# xfel-mode-line

This is a simple but effective way of using echo area as mode-line.
It is implemented as a minor mode, so you could use it as a global one or disable it whenever you don't want it anymore.

## Installing

I included xfel-mode-line into my emacs using [straight](https://github.com/raxod502/straight.el) as follows:
```
(straight-use-package
 '(xfel-mode-line :type git :host github :repo "fernando-jascovich/xfel-mode-line"))
(require 'xfel-mode-line)
(xfel-mode-line-mode 1)
```
