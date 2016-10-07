;;; package --- My init
;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with C-x C-f and enter text in its buffer.
(add-to-list 'load-path (expand-file-name "~/.emacs.d/personal"))
(setq personal-themes-dir "~/.emacs.d/personal/themes")
(add-to-list 'load-path personal-themes-dir)

;; UNDO PRELUDE STUFF I DON'T LIKE
(disable-theme 'zenburn)
(menu-bar-mode 1)
(setq prelude-auto-save nil)
;; which-key
(setq which-key-idle-delay 10.0)
;; full path in title bar
(setq-default frame-title-format "%b (%f)")
;; turn off highlight the current line
(global-hl-line-mode -1)

;; turn on semantic mode
;;(semantic-mode 1)

;;; THEME
;; sanityinc package's theme
;;(load-theme 'sanityinc-tomorrow-bright t)

;; ;; personal custom themes
;; (add-to-list 'custom-theme-load-path personal-themes-dir)
;; ;; load default personal theme
;; (load-theme 'tomorrow-night-bright t)

;; scroll one line at a time (less "jumpy" than defaults)
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; C-IDE SETUP
(defun cide()
  (add-to-list 'load-path
               (expand-file-name "~/.emacs.d/personal/emacs-c-ide-demo"))
  (load-file "~/.emacs.d/personal/emacs-c-ide-demo/init.el")
  ;; remove prelude's reopen as root fn prelude-core:324
  (remove-hook 'find-file-hook 'prelude-reopen-as-root)
  )
(cide)

;; NEOTREE SETUP
(add-to-list 'load-path "~/projects/")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; TABBAR
(tabbar-mode t)
(load "my-tabbar-style.el")


;; these don't work in osx terminal becaues of need for C-S-kp-next
(global-set-key (kbd "C-S-p") 'tabbar-backward-group)
(global-set-key (kbd "C-S-n") 'tabbar-forward-group)
(global-set-key (kbd "C-<") 'tabbar-backward)
(global-set-key (kbd "C->") 'tabbar-forward) ;; tabbar.el, put all the buffers on the tabs.

;; comment/uncomment keybindings
;; normally:
;; C-/ for undo
;; C-S-/ for redo
(global-set-key (kbd "C-S-c") 'comment-region)
(global-set-key (kbd "C-S-u") 'uncomment-region)


;;;;;;;;;; FLX-IDO (MORE POWERFUL)

;; (require 'flx-ido)
;; (ido-mode 1)
;; (ido-everywhere 1)
;; (flx-ido-mode 1)
;; ;; disable ido faces to see flx highlights.
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-faces nil)

;; If don't want to use the flx's highlights you can turn them off like this:
;;(setq flx-ido-use-faces nil)


;;; C++ SETUP
;; c++11
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11")))
;; c++14
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++14")))
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++14")))



