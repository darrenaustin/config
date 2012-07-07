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

;; Mac OS sane keyboard config
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
  (global-set-key (kbd "M-H") 'ns-do-hide-others))

;; Init package system and make sure my standard packages are installed
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/")
;;	     '("marmalade" . "http://marmalade-repo.org/packages/")
	     )
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
    twilight-theme
    magit
    clojure-mode
    slime
    markdown-mode
    starter-kit-lisp
    org
    )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; configuration for various modes
(require 'config-registers)
(require 'config-misc)
(require 'config-text)
(require 'config-org)
(require 'config-coding)
(require 'config-ruby)
(require 'config-theme)
(require 'config-shell)
(require 'config-magit)


(setq config-system-name
      ;; Work around a bug on OS X where system-name is FQDN
      (if (eq system-type 'darwin)
          (car (split-string system-name "\\."))
        system-name))

;; Machine specific configuration
(setq system-specific-config (concat config-dir config-system-name ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))

(load custom-file 'noerror)
