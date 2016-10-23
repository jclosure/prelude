;; (require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" .
;;                "http://marmalade-repo.org/packages/"))
;; (package-initialize)


;; My packages
(setq prelude-packages (append '(

                                 ;; shell
                                 exec-path-from-shell

                                 ;; ide
                                 cmake-ide
                                 rtags
                                 irony
                                 company-irony
                                 company-irony-c-headers

                                 ;; elixir
                                 elixir-yasnippets
                                 flycheck-credo
                                 ;;flycheck-elixir
                                 ;;flycheck-mix
                                 ob-elixir
                                 alchemist

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
