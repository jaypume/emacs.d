(require-package 'color-theme)
(require-package 'color-theme-sanityinc-solarized)
(require-package 'color-theme-sanityinc-tomorrow)
(require-package 'monokai-theme)
(require-package 'molokai-theme)
(require-package 'zenburn-theme)
(require-package 'base16-theme)
(require-package 'color-theme-modern)
(require-package 'atom-dark-theme)

;;-------------------------------------------------------------------------------
;;pujie: 自定义的主题目录
;;-------------------------------------------------------------------------------
;; can be removed
;; (add-to-list 'load-path
;;              (expand-file-name "lisp/custom-themes" user-emacs-directory))
;; (setq custom-theme-directory
;;       (expand-file-name "lisp/custom-themes" user-emacs-directory))
;; (require 'color-theme-blackboard)

;;-------------------------------------------------------------------------------
;;pujie: 默认加载的主题
;;-------------------------------------------------------------------------------
;;(load-theme 'bharadwaj t t)
;; (enable-theme 'bharadwaj)
;; (load-theme 'monokai t)
;; (load-theme 'base16-summerfruit-light t)
;; (load-theme 'sanityinc-tomorrow-night t)
 (load-theme 'sanityinc-tomorrow-day t)
;;(load-theme 'molokai t)
;; (load-theme 'sanityinc-solarized-light t)
;; (load-theme 'sanityinc-solarized-dark t)
;; (load-theme 'base16-solarized-dark t)
;; (load-theme 'base16-monokai-light t)
;; (load-theme 'zenburn)
;; (load-theme 'wombat)


;;-------------------------------------------------------------------------------
;;pujie: 确保主题能够被使用（x）
;;-------------------------------------------------------------------------------
;; Ensure that themes will be applied even if they have not been customized
;; (defun reapply-themes ()
;;   "Forcibly load the themes listed in `custom-enabled-themes'."
;;   (dolist (theme custom-enabled-themes)
;;     (unless (custom-theme-p theme)
;;       (load-theme theme)))
;;   (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

;;(add-hook 'after-init-hook 'reapply-themes)



;;-------------------------------------------------------------------------------
;;pujie: 设置 mode line的颜色
;;-------------------------------------------------------------------------
;;http://stackoverflow.com/questions/9446673/asking-emacs-to-highlight-more-clearly-which-window-pane-has-the-focus-cursor
;; (set-face-attribute  'mode-line
;;                      nil
;;                      :foreground "yellow"
;;                      :background "black"
;;                      :box '(:line-width 1 :style released-button))
;; (set-face-attribute  'mode-line-inactive
;;                      nil
;; ;                     :foreground "black"
;;                      :background "black"
;;                      :box '(:line-width 1 :style released-button))
;;(set-background-color "white")
;;-------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;pujie: 字体设置
;;------------------------------------------------------------------------------
;; (require-package 'chinese-fonts-setup)
;; (require 'chinese-fonts-setup)

;; mac 下的设置
(if (eq system-type 'darwin)
    ;; 修改默认的字体大小为14
    ;; (set-default-font "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
     (set-default-font "Menlo-14")
     (set-fontset-font "fontset-default" 'han '("STHeiti"))
    )


;; linux 下的设置
(if (eq system-type 'gnu/linux)
;;    (set-default-font "-unknown-Droid Sans Fallback-normal-normal-normal-*-8-*-*-*-*-0-iso10646-1")
    (set-default-font "Droid Sans-10")
  (setenv "LC_CTYPE" "zh_CN.UTF-8")
        )

;; windows 下的设置
(if (eq system-type 'windows-nt)
    ()
    )


(provide 'init-faces)
