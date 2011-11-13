;; js2-mode site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
