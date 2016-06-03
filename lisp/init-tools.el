;;----------------------------------------------------------------------------
;;pujie: 词典模块 - 有道词典
;;----------------------------------------------------------------------------
;;(require 'sdcv-mode)
;;(global-set-key (kbd "C-c d") 'sdcv-search)
(require-package 'youdao-dictionary)
;; Enable Cache
(setq url-automatic-caching t)

;; Example Key binding
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)

;; Integrate with popwin-el (https://github.com/m2ym/popwin-el)
 (push "*Youdao Dictionary*" popwin:special-display-config)

;; Set file path for saving search history
;; (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")

;; Enable Chinese word segmentation support (支持中文分词)
;; (setq youdao-dictionary-use-chinese-word-segmentation t)



;;------------------------------------------------------------------------------
;;pujie: multi-term 设置
;;------------------------------------------------------------------------------
;;2015.12.04  添加multi-term支持
(require-package 'multi-term)
;;(setq multi-term-program "/bin/zsh")


;;------------------------------------------------------------------------------
;;pujie: hippie-expand
;;------------------------------------------------------------------------------
(global-set-key (kbd "M-/") 'hippie-expand)
(provide 'init-hippie-expand)



;;---------------------------------------------------------------------------
;;pujie: php + elisp + ...
;;---------------------------------------------------------------------------
;; php mode
(require-package 'php-mode)

;; 各种elisp跳转
;;(require-package 'elisp-slime-nav)
;;(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
;;  (add-hook hook 'elisp-slime-nav-mode))


;;---------------------------------------------------------------------------
;;pujie: 设置url代理
;;---------------------------------------------------------------------------
;; (setq url-using-proxy t)
;; (setq url-proxy-services '(("http" . "mi.jaypu.com:9102")))

;;------------------------------------------------------------------------------
;;pujie: 用外部程序打开
;;------------------------------------------------------------------------------
(require-package 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "open" (file))))


;;------------------------------------------------------------------------------
;;pujie: 顺滑滚动
;;------------------------------------------------------------------------------
;; 感觉没什么卵用
;; (require-package 'smooth-scrolling)
;; (smooth-scrolling-mode 1)

;;------------------------------------------------------------------------------
;;pujie: 保存session 和 desktop
;;------------------------------------------------------------------------------
(require-package 'session)
(add-hook 'after-init-hook 'session-initialize) 
(load "desktop")
(desktop-load-default)
(desktop-read);

;;------------------------------------------------------------------------------
;;pujie:  minimap
;;------------------------------------------------------------------------------
(require-package 'minimap)


(provide 'init-tools)
