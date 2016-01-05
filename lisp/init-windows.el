;;---------------------------------------------------------------------------
;;pujie: sr-speedbar 安装和设置
;;---------------------------------------------------------------------------
(require-package 'sr-speedbar)
(setq sr-speedbar-width 20)
(setq sr-speedbar-auto-refresh t)
(setq sr-speedbar-right-side nil)
;;(setq sr-speedbar-toggle t)


;;---------------------------------------------------------------------------
;;pujie: window-numbering 安装和设置
;;---------------------------------------------------------------------------
(require-package 'window-numbering)
(window-numbering-mode 1)
(winner-mode 1)

;;---------------------------------------------------------------------------
;;pujie: deft安装
;;---------------------------------------------------------------------------
;; (require-package 'deft)
;; (setq deft-extensions '("org"))
;; (setq deft-directory "~/Dropbox/Org Notes/")
;; (setq deft-recursive t)
;; (setq deft-use-filename-as-title t)



;;---------------------------------------------------------------------------
;;pujie: 窗口锁定
;;---------------------------------------------------------------------------
(defun pujie/toggle-window-dedicated ()
"Toggle whether the current active window is dedicated or not"
(interactive)
(message
 (if (let (window (get-buffer-window (current-buffer)))
       (set-window-dedicated-p window
        (not (window-dedicated-p window))))
    "Window '%s' is dedicated"
    "Window '%s' is normal")
 (current-buffer)))
(global-set-key "\C-cmw" 'pujie/toggle-window-dedicated)


;;---------------------------------------------------------------------------
;;pujie: neotree
;;---------------------------------------------------------------------------
;; 容易出窗口问题，暂时不用
;; (require-package 'neotree)
;; (setq neo-hidden-regexp-list
;;       '("^\\."
;;         "\\.cs\\.meta$"
;;         "\\.pyc$"
;;         "~$"
;;         "^#.*#$"
;;         "\\.elc$"
;;         "\\.html$"
;;         "\\.*orgimage$"
;;         "ltxpng"
;;         ))

;;----------------------------------------------------------------------------
;;pujie: popwin安装与设置
;;----------------------------------------------------------------------------
(require-package 'popwin)
(require 'popwin)
(popwin-mode 1)
(setq display-buffer-function 'popwin:display-buffer)
;;(push '("^\*helm\*$" :regexp t) popwin:special-display-config)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
(push '("^\*helm-.+\*$" :regexp t) popwin:special-display-config)
(push '("^\*.+help.+\*$" :regexp t) popwin:special-display-config)

;; 貌似没有起效果
;;(push '("^\*.+output\*$" :regexp t) popwin:special-display-config)


;;------------------------------------------------------------------------------
;;pujie: smart mode line
;;------------------------------------------------------------------------------
(require-package 'rich-minority)
(rich-minority-mode 1)
;(require-package 'smart-mode-line)
;(sml/setup t)
;;(setq sml/shorten-directory t)
;;(setq sml/shorten-modes t)
;;(setq sml/name-width `40')
;;(setq sml/mode-width `full')
;;(add-to-list 'rm-whitelist "Org")
(add-to-list 'rm-blacklist " Emacs-Lisp")
(add-to-list 'rm-blacklist " Lisp")
(add-to-list 'rm-blacklist " Helm")
(add-to-list 'rm-blacklist " SliNav")
(add-to-list 'rm-blacklist " AC")
(add-to-list 'rm-blacklist " yas")
(add-to-list 'rm-blacklist " Hi")
(add-to-list 'rm-blacklist " Ind")

(provide 'init-windows)
