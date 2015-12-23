(require-package 'color-theme)
;;(require-package 'color-theme-sanityinc-solarized)
;;(require-package 'color-theme-sanityinc-tomorrow)
(require-package 'monokai-theme)

;; custom theme packages
;; can be removed
;; (add-to-list 'load-path
;;              (expand-file-name "lisp/custom-themes" user-emacs-directory))
;; (setq custom-theme-directory
;;       (expand-file-name "lisp/custom-themes" user-emacs-directory))
;; (require 'color-theme-blackboard)

;;(require-package 'atom-dark-theme)

;;2015.12.08 加载默认的主题monokai
(load-theme 'monokai t)

;; if you don't customize it, this is the theme you get
;;(setq-default custom-enabled-themes '(monokai))

;; Ensure that themes will be applied even if they have not been customized
;; (defun reapply-themes ()
;;   "Forcibly load the themes listed in `custom-enabled-themes'."
;;   (dolist (theme custom-enabled-themes)
;;     (unless (custom-theme-p theme)
;;       (load-theme theme)))
;;   (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

;;(add-hook 'after-init-hook 'reapply-themes)



;;---------------------------------------------------------------------------------
;;pujie: 设置 mode line的颜色
;;-------------------------------------------------------------------------
;;http://stackoverflow.com/questions/9446673/asking-emacs-to-highlight-more-clearly-which-window-pane-has-the-focus-cursor
(set-face-attribute  'mode-line
                     nil
                     :foreground "yellow"
                     :background "red"
                     :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
                     nil
                     :foreground "grey60"
                     :background "red"
                     :box '(:line-width 1 :style released-button))
;;-------------------------------------------------------------------------



(provide 'init-themes)
