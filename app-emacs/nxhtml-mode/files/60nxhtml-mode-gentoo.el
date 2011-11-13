;;; app-emacs/nxhtml site file initialisation

(add-to-list 'load-path "@SITELISP@")
(add-to-list 'load-path "@SITELISP@/nxhtml")
(add-to-list 'load-path "@SITELISP@/util")
(add-to-list 'load-path "@SITELISP@/related")
(provide 'nxhtml-autostart)
(load "@SITELISP@/autostart" nil t)
(load "@SITELISP@/nxhtml-loaddefs" nil t)

; Set the default directories to the path used to install
; the scripts in Gentoo.
; ftpsync.pl, used by html-upl-dir, is installed by net-misc/ftpsync
(setq html-upl-dir "/usr/bin")
(setq html-chklnk-dir "/usr/libexec/emacs/nxhtml-mode")
(setq html-wtoc-dir "/usr/libexec/emacs/nxhtml-mode")
