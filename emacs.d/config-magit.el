;;; config-magit.el --- configuration for project magit panel

(add-to-list 'load-path (config-file "vendor/magit/"))
(require 'magit)

(global-set-key "\C-xg" 'magit-status)

(provide 'config-magit)

