;;; config-org.el --- Org mode configuration

(add-to-list 'load-path (config-file "vendor/org/lisp"))
(require 'org-install)

(setq org-directory "~/Dropbox/Notes/")
(setq org-default-notes-file (concat org-directory "refile.org"))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-return-follows-link t)
(setq org-insert-mode-line-in-empty-file t)
(setq org-cycle-separator-lines 1)
(setq org-special-ctrl-a/e t)
(setq org-tags-column -79)
(setq org-agenda-align-tags-to-colun 70)
(setq org-startup-folded 'fold)
(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-fontify-done-headline t)
(setq org-M-RET-may-split-line nil)

(setq org-todo-keywords '("TASK(t)" "NEXT(n)" "WAITING(w)" "CANCELLED(c)" "DONE(d)"))
(setq org-todo-interpretation 'type)
(setq org-archive-location "::* Archived")
(defun org-next-actions () (interactive) (org-todo-list "NEXT"))
(defun org-mark-as-next () (interactive) (org-todo 2))
(defun org-mark-as-waiting () (interactive) (org-todo 3))
(defun org-mark-as-cancelled () (interactive) (org-todo 4))
(defun org-mark-as-done () (interactive) (org-todo 5))
(global-set-key "\C-xt" 'org-next-actions)
(global-set-key "\C-cc" 'org-capture)

(add-hook 'org-mode-hook
          '(lambda ()
             (auto-fill-mode 1)
             (define-key org-mode-map "\C-cn" 'org-mark-as-next)
             (define-key org-mode-map "\C-cw" 'org-mark-as-waiting)
             (define-key org-mode-map "\C-cc" 'org-mark-as-cancelled)
             (define-key org-mode-map "\C-cd" 'org-mark-as-done)
             (define-key org-mode-map "\C-ca" 'org-archive-subtree-default)))

(provide 'config-org)
