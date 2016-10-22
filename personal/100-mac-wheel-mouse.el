(if  (string-equal system-type "darwin") ; Mac OS X
    (progn
      (message "Mac OS X. Setting up 100-mac-wheel-mouse..")



      (add-hook 'after-init-hook
                (lambda ()

            ;;; Mouse wheel smooth scroll

                  (defcustom mac-mouse-wheel-smooth-scroll t
                    "Non-nil means the mouse wheel should scroll by pixel unit if possible."
                    :group 'mac
                    :type 'boolean)

                  (defvar mac-ignore-momentum-wheel-events)


                  (defun mac-mwheel-scroll (event)
                    "Scroll up or down according to the EVENT.
Mostly like `mwheel-scroll', but try scrolling by pixel unit if
EVENT has no modifier keys, `mac-mouse-wheel-smooth-scroll' is
non-nil, and the input device supports it."
                    (interactive (list last-input-event))
                    (setq mac-ignore-momentum-wheel-events nil)
                    ;; (nth 3 event) is a list of the following form:
                    ;; (isDirectionInvertedFromDevice	; nil (normal) or t (inverted)
                    ;;  (deltaX deltaY deltaZ)		; floats
                    ;;  (scrollingDeltaX scrollingDeltaY) ; nil or floats
                    ;;  (phase momentumPhase)		; nil, nil and an integer, or integers
                    ;;  )
                    ;; The list might end early if the remaining elements are all nil.
                    ;; TODO: horizontal scrolling
                    (if (not (memq (event-basic-type event) '(wheel-up wheel-down)))
                        (when (and (memq (event-basic-type event) '(wheel-left wheel-right))
                                   (eq (nth 1 (nth 3 (nth 3 event))) 1)) ;; NSEventPhaseBegan
                          ;; Post a swipe event when the momentum phase begins for
                          ;; horizontal wheel events.
                          (setq mac-ignore-momentum-wheel-events t)
                          (push (cons
                                 (event-convert-list
                                  (nconc (delq 'click
                                               (delq 'double
                                                     (delq 'triple (event-modifiers event))))
                                         (if (eq (event-basic-type event) 'wheel-left)
                                             '(swipe-left) '(swipe-right))))
                                 (cdr event))
                                unread-command-events))
                      (if (or (not mac-mouse-wheel-smooth-scroll)
                              (delq 'click (delq 'double (delq 'triple (event-modifiers event))))
                              (null (nth 1 (nth 2 (nth 3 event)))))
                          (if (or (null (nth 3 event))
                                  (and (/= (nth 1 (nth 1 (nth 3 event))) 0.0)
                                       (= (or (nth 1 (nth 3 (nth 3 event))) 0) 0)))
                              (mwheel-scroll event))
                        ;; TODO: ignore momentum scroll events after buffer switch.
                        (let* ((window-to-scroll (if mouse-wheel-follow-mouse
                                                     (posn-window (event-start event))))
                               (edges (window-inside-pixel-edges window-to-scroll))
                               (window-inside-pixel-height (- (nth 3 edges) (nth 1 edges)))
                               ;; Do redisplay and measure line heights before selecting
                               ;; the window to scroll.
                               (point-height
                                (or (progn
                                      (redisplay t)
                                      (window-line-height nil window-to-scroll))
                                    ;; The above still sometimes return nil.
                                    (progn
                                      (redisplay t)
                                      (window-line-height nil window-to-scroll))))
                               (header-line-height
                                (window-line-height 'header-line window-to-scroll))
                               (first-height (window-line-height 0 window-to-scroll))
                               (last-height (window-line-height -1 window-to-scroll))
                               ;; Now select the window to scroll.
                               (curwin (if window-to-scroll
                                           (prog1
                                               (selected-window)
                                             (select-window window-to-scroll))))
                               (buffer (window-buffer curwin))
                               (opoint (with-current-buffer buffer
                                         (when (eq (car-safe transient-mark-mode) 'only)
                                           (point))))
                               (first-y (or (car header-line-height) 0))
                               (first-height-sans-hidden-top
                                (cond ((= (car first-height) 0) ; completely invisible.
                                       0)
                                      ((null header-line-height) ; no header line.
                                       (+ (car first-height) (nth 3 first-height)))
                                      (t	  ; might be partly hidden by the header line.
                                       (+ (- (car first-height)
                                             (- (car header-line-height) (nth 2 first-height)))
                                          (nth 3 first-height)))))
                               (scroll-amount (nth 3 event))
                               (delta-y (- (round (nth 1 (nth 2 scroll-amount)))))
                               (scroll-conservatively 0)
                               scroll-preserve-screen-position
                               auto-window-vscroll
                               redisplay-needed)
                          (unwind-protect
                              ;; Check if it is sufficient to adjust window's vscroll
                              ;; value.  Because the vscroll value might be non-zero at
                              ;; this stage, `window-start' might return an invisible
                              ;; position (e.g., "*About GNU Emacs*" buffer.), and thus
                              ;; we cannot rely on `pos-visible-in-window-p' until we
                              ;; reset the vscroll value.  That's why we used
                              ;; `redisplay' followed by `window-line-height' above.
                              (if (cond ((< delta-y 0)	; scroll down
                                         (and
                                          (> first-height-sans-hidden-top 0)
                                          ;; First row has enough room?
                                          (<= (- (nth 2 first-height) first-y)
                                              delta-y)
                                          (or
                                           ;; Cursor is still fully visible if scrolled?
                                           (<= (- (nth 2 point-height) delta-y)
                                               (- (+ first-y window-inside-pixel-height)
                                                  (frame-char-height)))
                                           ;; Window has the only one row?
                                           (= (nth 2 first-height) (nth 2 last-height)))))
                                        ((> delta-y 0) ; scroll up
                                         (and
                                          (> first-height-sans-hidden-top 0)
                                          ;; First row has enough room?
                                          (< delta-y first-height-sans-hidden-top)
                                          (or
                                           (and
                                            ;; Cursor is still fully visible if scrolled?
                                            (< (nth 2 first-height) (nth 2 point-height))
                                            (not (and (eobp) (bolp)
                                                      ;; Cursor is at the second row?
                                                      (= (+ first-y first-height-sans-hidden-top)
                                                         (nth 2 point-height)))))
                                           (and (>= (- first-height-sans-hidden-top delta-y)
                                                    (frame-char-height))
                                                (> (window-vscroll nil t) 0))
                                           ;; Window has the only one row?
                                           (= (nth 2 first-height) (nth 2 last-height)))))
                                        (t
                                         t))
                                  (set-window-vscroll nil (+ (window-vscroll nil t) delta-y) t)
                                (when (> (window-vscroll nil t) 0)
                                  (setq delta-y (- delta-y first-height-sans-hidden-top))
                                  (condition-case nil
                                      ;; XXX: may recenter around the end of buffer.
                                      (scroll-up 1)
                                    (end-of-buffer
                                     (set-window-vscroll nil 0 t)
                                     (condition-case nil
                                         (funcall mwheel-scroll-up-function 1)
                                       (end-of-buffer))
                                     (setq delta-y 0)))
                                  (set-window-vscroll nil 0 t))
                                (condition-case nil
                                    (if (< delta-y 0)
                                        ;; Scroll down
                                        (let (prev-first prev-point prev-first-y)
                                          (while (< delta-y 0)
                                            ;; It might be the case that `point-min' is
                                            ;; visible but `window-start' < `point-min'.
                                            (if (pos-visible-in-window-p (point-min) nil t)
                                                (signal 'beginning-of-buffer nil))
                                            (setq prev-first (window-start))
                                            (setq prev-point (point))
                                            (let ((prev-first-prev-y
                                                   (cadr (pos-visible-in-window-p prev-first
                                                                                  nil t))))
                                              (scroll-down)
                                              (while (null (setq prev-first-y
                                                                 (cadr (pos-visible-in-window-p
                                                                        prev-first nil t))))
                                                ;; If the previous last position gets
                                                ;; invisible after scroll down, scroll
                                                ;; up by line and try again.
                                                (scroll-up 1))
                                              (when (= prev-first-y prev-first-prev-y)
                                                ;; It might be the case that `point-min'
                                                ;; is visible but `window-start' <
                                                ;; `point-min'.
                                                (if (pos-visible-in-window-p (point-min) nil t)
                                                    (signal 'beginning-of-buffer nil))
                                                ;; We came back to the original
                                                ;; position.  We were at a line that is
                                                ;; taller than the window height before
                                                ;; the last scroll up.
                                                (scroll-down 1)
                                                (while (not (pos-visible-in-window-p
                                                             prev-first nil t))
                                                  (set-window-vscroll
                                                   nil (+ (window-vscroll nil t)
                                                          window-inside-pixel-height) t))
                                                (setq prev-first-y
                                                      (+ (window-vscroll nil t)
                                                         (cadr (pos-visible-in-window-p
                                                                prev-first nil t))))
                                                (set-window-vscroll nil 0 t))
                                              (setq delta-y
                                                    (+ delta-y
                                                       (- prev-first-y prev-first-prev-y)))))
                                          (if (>= delta-y window-inside-pixel-height)
                                              (progn
                                                ;; Cancel the last scroll.
                                                (goto-char prev-point)
                                                (set-window-start nil prev-first))
                                            (let* ((target-posn
                                                    (posn-at-x-y 0 (+ first-y delta-y)))
                                                   (target-row
                                                    (cdr (posn-actual-col-row target-posn)))
                                                   (target-y
                                                    (cadr (pos-visible-in-window-p
                                                           (posn-point target-posn) nil t)))
                                                   (scrolled-pixel-height (- target-y first-y))
                                                   (prev-first-row
                                                    (cdr (posn-actual-col-row
                                                          (posn-at-x-y 0 prev-first-y)))))
                                              ;; Cancel the last scroll.
                                              (goto-char prev-point)
                                              (set-window-start nil prev-first)
                                              (scroll-down (- prev-first-row target-row
                                                              (if (= delta-y
                                                                     scrolled-pixel-height)
                                                                  0 1)))
                                              (setq delta-y (- delta-y scrolled-pixel-height)))))
                                      ;; Scroll up
                                      (let (found)
                                        (while (and (not found)
                                                    (>= delta-y window-inside-pixel-height))
                                          (let* ((prev-first-prev-coord
                                                  (pos-visible-in-window-p (window-start) nil t))
                                                 (prev-last-prev-coord
                                                  (pos-visible-in-window-p t nil t))
                                                 (prev-last-prev-posn
                                                  (posn-at-x-y (car prev-last-prev-coord)
                                                               (max (cadr prev-last-prev-coord)
                                                                    first-y)))
                                                 (prev-last
                                                  (posn-point prev-last-prev-posn))
                                                 (prev-last-prev-y
                                                  (cadr prev-last-prev-coord))
                                                 prev-last-y prev-first)
                                            (scroll-up)
                                            (while (null (setq prev-last-y
                                                               (cadr (pos-visible-in-window-p
                                                                      prev-last nil t))))
                                              ;; If the previous last position gets
                                              ;; invisible after scroll up, scroll down
                                              ;; by line and try again.
                                              (setq prev-first (window-start))
                                              (scroll-down 1))
                                            (if (/= prev-last-y prev-last-prev-y)
                                                (setq delta-y
                                                      (- delta-y
                                                         (- prev-last-prev-y prev-last-y)))
                                              ;; We came back to the original position.
                                              ;; We are at a line that is taller than
                                              ;; the window height.
                                              (while (and (>= (- delta-y (window-vscroll nil t))
                                                              window-inside-pixel-height)
                                                          (not (pos-visible-in-window-p
                                                                prev-first nil t)))
                                                (set-window-vscroll
                                                 nil (+ (window-vscroll nil t)
                                                        window-inside-pixel-height)
                                                 t))
                                              (let ((prev-first-y (cadr (pos-visible-in-window-p
                                                                         prev-first nil t))))
                                                (if (not (and prev-first-y
                                                              (>= (- delta-y
                                                                     (window-vscroll nil t))
                                                                  (- prev-first-y first-y))))
                                                    (progn
                                                      (setq found t)
                                                      (set-window-vscroll nil 0 t))
                                                  (setq delta-y
                                                        (- delta-y
                                                           (+ (window-vscroll nil t)
                                                              (- prev-first-y first-y))))
                                                  (set-window-vscroll nil 0 t)
                                                  (scroll-up 1)))))))
                                      (if (< delta-y window-inside-pixel-height)
                                          (let* ((target-posn
                                                  (posn-at-x-y 0 (+ first-y delta-y)))
                                                 (target-row
                                                  (cdr (posn-actual-col-row target-posn)))
                                                 (target-y
                                                  (cadr (pos-visible-in-window-p
                                                         (posn-point target-posn) nil t)))
                                                 (scrolled-pixel-height (- target-y first-y)))
                                            (scroll-up (if (= delta-y scrolled-pixel-height)
                                                           target-row
                                                         (1+ target-row)))
                                            (setq delta-y (- delta-y scrolled-pixel-height)))))
                                  (beginning-of-buffer
                                   (condition-case nil
                                       (funcall mwheel-scroll-down-function 1)
                                     (beginning-of-buffer))
                                   (setq delta-y 0))
                                  (end-of-buffer
                                   (condition-case nil
                                       (funcall mwheel-scroll-up-function 1)
                                     (end-of-buffer))
                                   (setq delta-y 0)))
                                (when (> delta-y 0)
                                  (scroll-down 1)
                                  (set-window-vscroll nil delta-y t)
                                  (setq redisplay-needed t))
                                (if (> (count-screen-lines (window-start) (window-end)) 1)
                                    ;; Make sure that the cursor is fully visible.
                                    (while (and (< (window-start) (point))
                                                (not (pos-visible-in-window-p)))
                                      (vertical-motion -1))))
                            (if curwin (select-window curwin))
                            (if redisplay-needed
                                (let ((mac-redisplay-dont-reset-vscroll t))
                                  (redisplay))))
                          ;; If there is a temporarily active region, deactivate it iff
                          ;; scrolling moves point.
                          (when opoint
                            (with-current-buffer buffer
                              (when (/= opoint (point))
                                (deactivate-mark))))))))

                  (defvar mac-mwheel-installed-bindings nil)

                  (define-minor-mode mac-mouse-wheel-mode
                    "Toggle mouse wheel support with smooth scroll.
With prefix argument ARG, turn on if positive, otherwise off.
Return non-nil if the new state is enabled."
                    :init-value nil
                    :global t
                    :group 'mac
                    ;; Remove previous bindings, if any.
                    (while mac-mwheel-installed-bindings
                      (let ((key (pop mac-mwheel-installed-bindings)))
                        (when (eq (lookup-key (current-global-map) key) 'mac-mwheel-scroll)
                          (global-unset-key key))))
                    ;; Setup bindings as needed.
                    (when mac-mouse-wheel-mode
                      (dolist (event '(wheel-down wheel-up wheel-left wheel-right))
                        (dolist (key (mapcar (lambda (amt) `[(,@(if (consp amt) (car amt)) ,event)])
                                             mouse-wheel-scroll-amount))
                          (global-set-key key 'mac-mwheel-scroll)
                          (push key mac-mwheel-installed-bindings)))))




                  (mouse-wheel-mode 0)
                  (mac-mouse-wheel-mode 1))))
  (message "Not OSX.  Skipping 100-mac-wheel-mouse setup"))
