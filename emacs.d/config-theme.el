;;; config-theme.el --- Configure color theme
;;

(require 'color-theme)

(color-theme-initialize)

;(load-file (config-file "vendor/themes/blackboard.el"))
;(color-theme-blackboard)

;(load-file (config-file "vendor/themes/color-theme-tangotango.el"))
;(color-theme-tangotango)

(load-file (config-file "vendor/themes/color-theme-twilight.el"))
(color-theme-twilight)

(provide 'config-theme)
