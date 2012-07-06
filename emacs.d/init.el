;;; darren's emacs setup

;; Load path
(setq config-dir (file-name-directory
                  (or (buffer-file-name) load-file-name)))
(defun config-file (file-name) (concat config-dir file-name))

(add-to-list 'load-path config-dir)
(setq autoload-file (config-file "loaddefs.el"))
(setq custom-file (config-file "custom.el"))

;; Commonly used packages
(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; my configuration for various modes
(require 'config-registers)
(require 'config-misc)
(require 'config-text)
(require 'config-org)
(require 'config-coding)
(require 'config-ruby)
;(require 'config-lisp)
(require 'config-scala)
;(require 'config-theme)
(require 'config-shell)
(require 'config-nav)
(require 'config-magit)

(load custom-file 'noerror)

;; Mac OS config
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
  (global-set-key (kbd "M-H") 'ns-do-hide-others))

(setq config-system-name
      ;; Work around a bug on OS X where system-name is FQDN
      (if (eq system-type 'darwin)
          (car (split-string system-name "\\."))
        system-name))

;; Machine specific configuration
(setq system-specific-config (concat config-dir config-system-name ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))

(if (not (file-exists-p (expand-file-name "~/.emacs.d/elpa/package.el")))
    (let ((buffer (url-retrieve-synchronously
                   "http://tromey.com/elpa/package-install.el")))
      (save-excursion
        (set-buffer buffer)
        (goto-char (point-min))
        (re-search-forward "^$" nil 'move)
        (eval-region (point) (point-max))
        (kill-buffer (current-buffer)))))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
