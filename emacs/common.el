(add-hook 'after-init-hook 'global-company-mode)


;;git-gutter
(prelude-require-package 'git-gutter)
(global-git-gutter-mode +1)

;;w3m
;;(prelude-require-package 'w3m)

(prelude-require-package 'jade-mode)

(prelude-require-package 'livescript-mode)


(prelude-require-package 'rainbow-delimiters)
;;(global-rainbow-delimiters-mode)



;; org-mode heading size
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.1))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.5))))
 )
