(add-to-list 'load-path "@SITELISP@")

(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
