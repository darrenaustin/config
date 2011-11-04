;;; config-scala.el --- Configuration for the Scala Programming Language

(require 'config-coding)

(add-to-list 'load-path (config-file "vendor/scala/"))
(require 'scala-mode-auto)
(add-hook 'scala-mode-hook 'run-coding-hook)

(provide 'config-scala)
