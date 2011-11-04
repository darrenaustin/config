;;; config-lisp.el --- Configuration for lisp languages
;;
(require 'config-coding)

;; SLIME setup
(add-to-list 'load-path (config-file "vendor/slime/"))
(add-to-list 'load-path (config-file "vendor/slime/contrib/"))
(require 'slime)
(add-hook 'slime-connected-hook
  (lambda () (slime-redirect-inferior-output)))
(slime-setup '(slime-repl))

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "C-c l") "lambda")
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)
(define-key lisp-mode-shared-map (kbd "C-\\") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "C-c v") 'eval-buffer)

(eval-after-load 'paredit
  '(progn
     ;; Not sure why paredit behaves this way with comments; it's annoying
     (define-key paredit-mode-map (kbd ";")   'self-insert-command)
     (add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
     (add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))))

(defun elisp-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

;;; Emacs Lisp
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'run-coding-hook)
(add-hook 'emacs-lisp-mode-hook 'elisp-remove-elc-on-save)

;;; Clojure
(add-to-list 'load-path (config-file "vendor/clojure/"))
(setq swank-clojure-binary (expand-file-name "~/dev/bin/clojure"))
(require 'clojure-mode)
(require 'swank-clojure-autoload)
(add-hook 'clojure-mode-hook 'run-coding-hook)

(defun clojure ()
  "Start a Clojure process with SLIME"
  (interactive)
  (slime 'clojure))

;;; Scheme
(add-hook 'scheme-mode-hook 'run-coding-hook)

;;; Common Lisp
(add-hook 'lisp-mode-hook 'run-coding-hook)

(eval-after-load "slime"
  '(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl"))))

(defun sbcl ()
  "Start a SBCL lisp process with SLIME"
  (interactive)
  (slime 'sbcl))

(provide 'config-lisp)
