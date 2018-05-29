(autoload 'auto-complete-mode "auto-complete" "AutoComplete mode" t)
(eval-after-load 'auto-complete
  '(progn
     (add-to-list 'ac-dictionary-directories "@SITEETC@/dict")))
