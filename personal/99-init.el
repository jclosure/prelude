;;; package --- My init
;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with C-x C-f and enter text in its buffer.
(add-to-list 'load-path (expand-file-name "~/.emacs.d/personal"))
(setq personal-themes-dir "~/.emacs.d/personal/themes")
(add-to-list 'load-path personal-themes-dir)


;;; GENERAL TWEAKAGE
;; (setq history-delete-duplicates t)
;; Make URLs clickable
(add-hook 'shell-mode-hook (lambda () (goto-address-mode )))
;; Make file paths clickable
(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)
;; You can highlight some text based on regexp (useful to see "OK" or warnings):
(add-hook 'shell-mode-hook (lambda () (highlight-regexp "\\[OK\\]" "green")))


;;; PRESERVE SHELL HISTORY
(add-hook 'shell-mode-hook 'my-shell-mode-hook)
(defun my-shell-mode-hook ()
  (setq comint-input-ring-file-name "~/.bash_history")  ;; or .zsh_history
  (comint-read-input-ring t))



;; UNDO PRELUDE STUFF I DON'T LIKE
;; remove prelude's reopen as root fn prelude-core:324
(remove-hook 'find-file-hook 'prelude-reopen-as-root)
;;(disable-theme 'zenburn)
(menu-bar-mode 1)
(setq prelude-auto-save nil)
;; which-key
(setq which-key-idle-delay 10.0)
;; full path in title bar
(setq-default frame-title-format "%b (%f)")
;; turn off highlight the current line
(global-hl-line-mode -1)

;; turn on semantic mode
;; (semantic-mode 1)


;; FIX INDENTING AND TABBING
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;;; THEME
;; sanityinc package's theme
;;(load-theme 'sanityinc-tomorrow-bright t)

;; ;; personal custom themes
;; (add-to-list 'custom-theme-load-path personal-themes-dir)
;; ;; load default personal theme
;; (load-theme 'tomorrow-night-bright t)

;; scroll one line at a time (less "jumpy" than defaults)
(setq scroll-step 1) ;; keyboard scroll one line at a time


;; ------------------------------------------------------------


;; ;; C-IDE SETUP
;; (defun cide()
;;   (add-to-list 'load-path
;;                (expand-file-name "~/.emacs.d/personal/emacs-c-ide-demo"))
;;   (load-file "~/.emacs.d/personal/emacs-c-ide-demo/init.el")
;;   ;; PROLLY NOT NEC
;;   (add-to-list 'company-c-headers-path-system "/usr/include/c++/5/")
;; )

;; ;; DISABLE/ENABLE C-IDE
;; (cide)



(defun my-c-mode-config ()

  ;; CMAKE IDE
  (require 'rtags) ;; optional, must have rtags installed
  (cmake-ide-setup)
 ;; (global-set-key [f2]   'compile)

  (local-set-key [f2] 'cmake-ide-compile)
  (local-set-key [f3] 'next-error)

  ;; MY C STUFF

  ;; ;; To specify what M-x make uses for compilation, you specify the compile-command variable.
  ;; ;;(setq compile-command "make -C ../build")
  ;; (setq compile-command "PREV=$(pwd) && mkdir -p ../build && cd ../build && cmake -DCMAKE_BUILD_TYPE=Debug  .. && make && cd $PREV")

  ;; ;; For your GDB stuff, the variable is gud-gdb-command-name, so
  ;; (setq gud-gdb-command-name "gdb --anotate=3 -i=mi -cd ../build")

  ;; (global-set-key [f2]   'compile)
  ;; (global-set-key [f3]   'next-error)


  ;; tricked
  (require 'company-rtags)

  (setq rtags-completions-enabled t)
  (eval-after-load 'company
    '(add-to-list
      'company-backends 'company-rtags))
  (setq rtags-autostart-diagnostics t)
  (rtags-enable-standard-keybindings)


)

;; add to hook
(add-hook 'c++-mode-hook 'my-c-mode-config)







;; -----------------------------------------------------------

;; CONFIGURE HELM
(setq  helm-ff-file-name-history-use-recentf t
       helm-semantic-fuzzy-match t
       helm-imenu-fuzzy-match t
       )

;;; helm scratch space here...

;; (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;; (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; ;; Disable helm in some functions
;; (add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
;; (add-to-list ' helm-completing-read-handlers-alist' (find-file . ido))
;; (add-to-list ' helm-completing-read-handlers-alist' (write-file . nil))
;; (add-to-list 'helm-completing-read-handlers-alist' (find-alternate-file . nil))
;; (add-to-list 'helm-completing-read-handlers-alist' (find-tag . nil))

;; disable file find - doesn t work
;; (add-to-list 'helm-completing-read-handlers-alist '(find-file-read-only . ido))
;; (add-to-list 'helm-completing-read-handlers-alist '(find-file . ido))





;; CONFIGURE COMPANY

;; (setq company-minimum-prefix-length 2)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; disable what is
;; (if (display-graphic-p)
;;     (with-eval-after-load 'company
;;       (define-key company-active-map (kbd "ESC") 'company-abort)))

;; prefer company-mode for completing in shell-mode instead of helm
;; (add-hook 'shell-mode-hook #'company-mode)
;; (define-key shell-mode-map (kbd "TAB") #'company-manual-begin)

;; (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;;       helm-move-to-line-cycle-in-source     nil ; move to end or beginning of source when reaching top or bottom of source.
;;       helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;;      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;;       helm-ff-file-name-history-use-recentf t
;;       helm-echo-input-in-header-line t)



;;; MODIFY HELM DEFAULT FILE NAVIGATION

;; (defun fu/helm-find-files-navigate-forward (orig-fun &rest args)
;;   (if (file-directory-p (helm-get-selection))
;;       (apply orig-fun args)
;;     (helm-maybe-exit-minibuffer)))
;; (advice-add 'helm-execute-persistent-action :around #'fu/helm-find-files-navigate-forward)
;; (define-key helm-find-files-map (kbd "<return>") 'helm-execute-persistent-action)


(defun fu/helm-find-files-navigate-back (orig-fun &rest args)
  (if (= (length helm-pattern) (length (helm-find-files-initial-input)))
      (helm-find-files-up-one-level 1)
    (apply orig-fun args)))
(advice-add 'helm-ff-delete-char-backward :around #'fu/helm-find-files-navigate-back)


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

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )
