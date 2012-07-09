;;; config-misc.el --- General global settings that don't fit elsewhere

(when window-system
  (setq frame-title-format '("%b"))
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode)
  (blink-cursor-mode)
  (mouse-wheel-mode))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq default-frame-alist '((width . 100) (height . 60)))

(setq visible-bell nil
      font-lock-maximum-decoration t
      inhibit-startup-message t
      transient-mark-mode t
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      make-backup-files nil
      completion-ignore-case t
      save-place-file (concat config-dir "saved-places"))
(put 'narrow-to-region 'disabled nil)
(transient-mark-mode t)

;; Assign some common key mappings
(global-set-key "\C-]" 'replace-regexp)
(global-set-key "\M-g"  'goto-line)
(global-set-key "\C-x\C-m" 'execute-extended-command)

;; Transparently open compressed files
(auto-compression-mode t)

;; Save a list of recent files visited.
(recentf-mode 1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

;; ido-mode
(when (> emacs-major-version 21)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-max-prospects 10))

;; Seed the random-number generator
(random t)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)
(delete 'try-expand-line hippie-expand-try-functions-list)

;; Default to unified diffs
(setq diff-switches "-u")

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace))
(global-set-key (kbd "C-c n") 'cleanup-buffer)
;; TODO: can we hook this one up just for source files?
;(add-hook 'before-save-hook 'cleanup-buffer)

(defun recompile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  (byte-recompile-directory config-dir 0))

;; Start a shell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'shell)

;; Ensure shell scripts are saved executable
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(provide 'config-misc)
