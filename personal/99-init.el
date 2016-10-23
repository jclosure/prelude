;;; package --- My init
;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with C-x C-f and enter text in its buffer.
(add-to-list 'load-path (expand-file-name "~/.emacs.d/personal"))
(setq personal-themes-dir "~/.emacs.d/personal/themes")
(add-to-list 'load-path personal-themes-dir)



;; THEME
(disable-theme 'zenburn)
;;(load-theme 'sanityinc-tomorrow-night-theme)
(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow--define-theme night)

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


;; SCROLLING

(setq mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; scroll one line at a time (less "jumpy" than defaults)
(setq scroll-step 1)

;; globally disable audible bell
;;(setq ring-bell-function (lambda () ()))

;;keep cursor at same position when scrolling
(setq scroll-preserve-screen-position 1)
;;scroll window up/down by one line
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))


;; OS-SPECIFIC SETUP
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (message "You are using Microsoft Windows")
    ;; do windows stuff
    ))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (message "You are using Mac OS X")
    ;; do OSX stuff
    ))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "You are using Linux")
    ;; do Linux stuff
    )))



;; ------------------------------------------------------------

;;; ELIXER SETUP


(add-hook 'elixir-mode-hook 'alchemist-mode)
(setq alchemist-help-ansi-color-docs t)
(setq alchemist-project-compile-when-needed t)

(eval-after-load 'flycheck
  '(flycheck-credo-setup))

;;(eval-after-load 'flycheck
;;  (progn
;;    (require 'flycheck-mix)
;;    '(flycheck-mix-setup)))

(add-hook 'elixir-mode-hook 'flycheck-mode)


;; ------------------------------------------------------------



;;; C++ SETUP
;; c++11
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11")))
;; c++14
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++14")))
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++14")))

;; (add-hook 'c++-mode-hook
;;           (lambda () (setq flycheck-clang-standard-library "libc++")))
;; (add-hook 'c++-mode-hook
;;           (lambda () (setq flycheck-clang-language-standard "c++1y")))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; treat .h files as c++ files
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))



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


;; CMAKE IDE
(require 'rtags) ;; optional, must have rtags installed
(cmake-ide-setup)
;; (global-set-key [f2]   'compile)


(defun my-c-mode-config ()


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

)

;; add to hook
(add-hook 'c++-mode-hook 'my-c-mode-config)
;; (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)


;; gtags

(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))
;; (defun gtags-update ()
;;   "Make GTAGS incremental update"
;;   (call-process "global" nil nil nil "-u"))
;; (defun gtags-update-hook ()
;;   (when (gtags-root-dir)
;;     (gtags-update)))
;; (add-hook 'after-save-hook #'gtags-update-hook)


;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;               (ggtags-mode 1))))

;; (dolist (map (list ggtags-mode-map dired-mode-map))
;;   (define-key map (kbd "C-c g s") 'ggtags-find-other-symbol)
;;   (define-key map (kbd "C-c g h") 'ggtags-view-tag-history)
;;   (define-key map (kbd "C-c g r") 'ggtags-find-reference)
;;   (define-key map (kbd "C-c g f") 'ggtags-find-file)
;;   (define-key map (kbd "C-c g c") 'ggtags-create-tags)
;;   (define-key map (kbd "C-c g u") 'ggtags-update-tags)
;;   (define-key map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;;   (define-key map (kbd "M-.") 'ggtags-find-tag-dwim)
;;   (define-key map (kbd "M-,") 'pop-tag-mark)
;;   (define-key map (kbd "C-c <") 'ggtags-prev-mark)
;;   (define-key map (kbd "C-c >") 'ggtags-next-mark))




;; FROM SCRATCH


;;  (require 'company-rtags)

(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
;;  (push 'company-rtags company-backends)



(progn

  (defun use-rtags (&optional useFileManager)
    (and (rtags-executable-find "rc")
         (cond ((not (gtags-root-dir)) t)
               ((and (not (eq major-mode 'c++-mode))
                     (not (eq major-mode 'c-mode))) (rtags-has-filemanager))
               (useFileManager (rtags-has-filemanager))
               (t (rtags-is-indexed)))))

  (defun tags-find-symbol-at-point (&optional prefix)
    (interactive "P")
    (if (and (not (rtags-find-symbol-at-point prefix)) rtags-last-request-not-indexed)
        (gtags-find-tag)))
  (defun tags-find-references-at-point (&optional prefix)
    (interactive "P")
    (if (and (not (rtags-find-references-at-point prefix)) rtags-last-request-not-indexed)
        (gtags-find-rtag)))
  (defun tags-find-symbol ()
    (interactive)
    (call-interactively (if (use-rtags) 'rtags-find-symbol 'gtags-find-symbol)))
  (defun tags-find-references ()
    (interactive)
    (call-interactively (if (use-rtags) 'rtags-find-references 'gtags-find-rtag)))
  (defun tags-find-file ()
    (interactive)
    (call-interactively (if (use-rtags t) 'rtags-find-file 'gtags-find-file)))
  (defun tags-imenu ()
    (interactive)
    (call-interactively (if (use-rtags t) 'rtags-imenu 'idomenu)))

  ;; NAV REF http://syamajala.github.io/c-ide.html

  (define-key c-mode-base-map (kbd "M-.") (function tags-find-symbol-at-point))
  (define-key c-mode-base-map (kbd "M-,") (function rtags-location-stack-back))
  ;; (define-key c-mode-base-map (kbd "M-,") (function tags-find-references-at-point))

  ;; (define-key c-mode-base-map (kbd "M-;") (function tags-find-file))
  ;; (define-key c-mode-base-map (kbd "C-.") (function tags-find-symbol))
  ;; (define-key c-mode-base-map (kbd "C-,") (function tags-find-references))
  ;; (define-key c-mode-base-map (kbd "C-<") (function rtags-find-virtuals-at-point))
  ;; (define-key c-mode-base-map (kbd "M-i") (function tags-imenu))

  ;; (define-key global-map (kbd "M-.") (function tags-find-symbol-at-point))
  ;; (define-key global-map (kbd "M-,") (function tags-find-references-at-point))
  ;; (define-key global-map (kbd "M-;") (function tags-find-file))
  ;; (define-key global-map (kbd "C-.") (function tags-find-symbol))
  ;; (define-key global-map (kbd "C-,") (function tags-find-references))
  ;; (define-key global-map (kbd "C-<") (function rtags-find-virtuals-at-point))
  ;; (define-key global-map (kbd "M-i") (function tags-imenu))

  (use-rtags))

;;; IRONY

;; needs M-x: irony-install-server

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;(global-company-mode)

(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

;; (define-key c-mode-map [(tab)] 'company-complete)
;; (define-key c++-mode-map [(tab)] 'company-complete)

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
  (setq company-require-match nil)
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


;; company mode tab completion fix


(eval-after-load 'company
  '(progn

     ;;; if active, tab cycle options in active company map
     ;;(define-key company-active-map [tab] 'company-select-next)

     ;;; if active, tab select selected option in active company map
     (let ((map company-active-map))
       (define-key map (kbd "<tab>") 'company-complete-selection)
       (define-key map (kbd "RET") 'nil))

     (setq company-idle-delay 1)
     (define-key company-active-map [tab] 'company-select-next)

     (define-key company-mode-map [remap indent-for-tab-command]
       'company-indent-for-tab-command)

     (setq tab-always-indent 'complete)

     (defvar completion-at-point-functions-saved nil)

     (defun company-indent-for-tab-command (&optional arg)
       (interactive "P")
       (let ((completion-at-point-functions-saved completion-at-point-functions)
             (completion-at-point-functions '(company-complete-common-wrapper)))
         (indent-for-tab-command arg)))

     (defun company-complete-common-wrapper ()
       (let ((completion-at-point-functions completion-at-point-functions-saved))
         (company-complete-common)))))
