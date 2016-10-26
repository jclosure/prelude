;; (require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" .
;;                "http://marmalade-repo.org/packages/"))
;; (package-initialize)

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/" ) t)
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;(add-to-list 'package-archives
;;            '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))


;; My packages
(setq prelude-packages (append '(

                                 ;; general
                                 use-package
                                 auto-compile
                                 yaml-mode

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

                                 ;; org mode
                                 org-plus-contrib
                                 gntp
                                 org-gcal
                                 org2blog ;; wp-blog publishing

                                 ;; http
                                 simple-httpd


                                 ;; elasticsearch
                                 es-mode
                                 logstash-conf



                                 ) prelude-packages))



;; Install my packages
(prelude-install-packages)
