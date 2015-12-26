;;---------------------------------------------------------------------------
;;pujie: projectile
;;---------------------------------------------------------------------------
;;projectile
(require-package 'projectile)
(require-package 'helm-projectile)
(projectile-global-mode t)
(helm-projectile-on)
(eval-after-load "projectile"
  '(setq projectile-mode-line
         '(:eval (concat " [项目:"
                       (propertize (projectile-project-name)
                                   ;;'face '(:foreground "#81a2be"))
                                   'face '(:foreground "#0000FF"))
                       "]"))))

;; ibuffer 替代buffer-list
(require-package 'ibuffer-projectile)
(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))
;(global-set-key "\C-xb" 'ibuffer)

;;(require-package 'ibuffer-vc)

(provide 'init-projectile)
