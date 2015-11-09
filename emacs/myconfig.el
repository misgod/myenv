;;;(disable-theme 'zenburn)

;;;(prelude-require-package 'solarized-theme)
;;;(load-theme 'solarized-dark t)

(setq x-underline-at-descent-line t)

;;; indent by 2 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)


;; Default font
(set-face-attribute 'default nil :family "Inconsolata" :height 160)


;; disable scrollbar
(toggle-scroll-bar -1)
(scroll-bar-mode -1) 

;; disable whitespace
(setq prelude-whitespace nil)

;; disable flyspell
(setq prelude-flyspell nil)


;;maximized frame
(add-to-list 'default-frame-alist '(fullscreen . maximized))



;;################ Binding ##############3
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;;;
(global-set-key  (kbd "C-x <down>") 'bs-show)
(global-set-key  (kbd "C-x <up>") 'ibuffer)

;;; also diable C-tab in org mode
(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))

;;; Using Mouse to Zoom In/Out
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)



;; disable C-z
(global-unset-key (kbd "C-z"))

;; comment/uncomment
(global-set-key (kbd "M-/") 'comment-or-uncomment-region)

;;; disable ctrl-space for Chinese Input
;;(global-unset-key [\?C- ])

;;; for clojure
(setq cider-show-error-buffer nil)
