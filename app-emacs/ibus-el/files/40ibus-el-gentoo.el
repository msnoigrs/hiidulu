(require 'ibus)
(add-hook 'after-init-hook 'ibus-mode-on)
(ibus-define-common-key ?\C-\s nil)
(ibus-define-common-key ?\C-/ nil)
