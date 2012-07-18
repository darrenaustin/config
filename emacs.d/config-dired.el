;;; config-dired.el --- Configure dired mode

(eval-after-load "dired"
  '(require 'dired-x))

(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            ;; Omit . files
            (setq dired-omit-files
                  (concat dired-omit-files "\\|^\\..+$"))))

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))

(provide 'config-dired)
