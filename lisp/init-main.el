;;----------------------------------------------------------------------------
;;pujie: 启动配置（别人的）
;;----------------------------------------------------------------------------
(require 'init-utils)

;; Needed for Emacs version < 24. must come before elpa, as it may provide package.el
;; (require 'init-site-lisp)

;; Machinery for installing required packages.
;; explicitly call 'package-initialize to set up all packages installed via ELPA.
;; should come before all package-related config files
(require 'init-elpa)


;;----------------------------------------------------------------------------
;;pujie: 启动相关
;;----------------------------------------------------------------------------
;;设置打开文件的时候不打开新的窗口
(setq ns-pop-up-frames nil)

;;默认初始窗口为scratch 和 它的内容
(setq inhibit-startup-screen t)
(setq initial-scratch-message ";;For your dream, PUJIE!!")

;;解决中文终端乱码的问题
(setenv "LANG" "zh_CN.UTF-8")

;;设置自动保存的时间
(setq auto-save-timeout 30)


;;----------------------------------------------------------------------------
;;pujie: 加载各种大型模块
;;----------------------------------------------------------------------------
(require 'init-recentf);;最近文件
(require 'init-yasnippet);;代码模板/片段
(require 'init-auto-complete);;自动补全
(require 'init-editing-utils);;编辑相关的特性
(require 'init-git);;magit设置
(require 'init-helm);;功能强大的界面
(require 'init-projectile);;以项目为单位管理文件，提高效率
(require 'init-faces);;外观设置
(require 'init-windows);;窗口管理，文件目录等
(require 'init-auctex)
(require 'init-org)
(require 'init-tools);;一些工具，词典终端之类的,以及待归类的代码


;;------------------------------------------------------------------------------
;;pujie: 通过界面配置的选项在这里定义
;;------------------------------------------------------------------------------
(setq custom-file (expand-file-name "lisp/init-preferences.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;------------------------------------------------------------------------------
;;pujie: 一些有用的tips
;;------------------------------------------------------------------------------

;; (require-package 'gnuplot)
;; (require-package 'lua-mode)
;; (require-package 'htmlize)
;; (require-package 'dsvn)
;; (when *is-a-mac*
;;   (require-package 'osx-location))
;; (require-package 'regex-tool)

;; ;;----------------------------------------------------------------------------
;; ;; Allow access from emacsclient
;; ;;----------------------------------------------------------------------------
;; (require 'server)
;; (unless (server-running-p)
;;   (server-start))

;; ;;----------------------------------------------------------------------------
;; ;; Variables configured via the interactive 'customize' interface
;; ;;----------------------------------------------------------------------------
;; (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (when (file-exists-p custom-file)
;;   (load custom-file))

;; ;;----------------------------------------------------------------------------
;; ;; Allow users to provide an optional "init-local" containing personal settings
;; ;;----------------------------------------------------------------------------
;; (when (file-exists-p (expand-file-name "init-local.el" user-emacs-directory))
;;   (error "Please move init-local.el to ~/.emacs.d/lisp"))
;; (require 'init-local nil t)


;; ;;----------------------------------------------------------------------------
;; ;; Locales (setting them earlier in this file doesn't work in X)
;; ;;----------------------------------------------------------------------------
;; (require 'init-locales)

;; (add-hook 'after-init-hook
;;            (lambda ()
;;              (message "init completed in %.2fms"
;;                       (sanityinc/time-subtract-millis after-init-time before-init-time))))



;;----------------------------------------------------------------------------
;;普杰的配置  the end
;;----------------------------------------------------------------------------
(provide 'init-main)
