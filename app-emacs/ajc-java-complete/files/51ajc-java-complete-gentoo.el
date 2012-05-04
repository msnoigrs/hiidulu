(add-to-list 'load-path "@SITELISP@")
(require 'ajc-java-complete-config)
;(setq ajc-tag-file "~/.java_base.tag")
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
