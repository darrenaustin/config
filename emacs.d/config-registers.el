;;; config-registers.el --- Set up registers

;; Registers allow you to jump to a file or other location
;; quickly. Use C-x r j followed by the letter of the register (i for
;; init.el, r for this file) to jump to it.

;; You should add registers here for the files you edit most often.

(dolist (r `((?i (file . ,(config-file "init.el")))
             (?b (file . ,(config-file "config-bindings.el")))
             (?r (file . ,(config-file "config-registers.el")))))
  (set-register (car r) (cadr r)))

(provide 'config-registers)
