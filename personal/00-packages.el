;; (require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" .
;;                "http://marmalade-repo.org/packages/"))
;; (package-initialize)


;; My packages
(setq prelude-packages (append '(

                                 ;; ide
                                 cmake-ide
                                 rtags
                                 irony
                                 company-irony
                                 company-irony-c-headers

                                 ;; ui
                                 flx-ido
                                 tabbar
                                 tabbar-ruler
                                 neotree
                                 color-theme-sanityinc-tomorrow
                                 ;;drupal-mode
                                 ;;nginx-mode
                                 ) prelude-packages))

;; Install my packages
(prelude-install-packages)
