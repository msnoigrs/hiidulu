(add-to-list 'load-path "@SITELISP@")
(autoload 'vbnet-mode "vbnet-mode"
  "A mode for editing VB.NET code" t)
(add-to-list 'auto-mode-alist
	     '("\\.\\(frm\\|bas?\\|cls\\.vb\\)\\'" . vbnet-mode))
