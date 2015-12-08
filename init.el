(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
;; (defconst *is-a-mac* (eq system-type 'darwin))


;;----------------------------------------------------------------------------
;; 普杰的配置
;;----------------------------------------------------------------------------
;;2015.12.04  设置打开文件的时候不打开新的窗口
(setq ns-pop-up-frames nil)
;;2015.12.04  添加multi-term支持
(require 'multi-term)
(setq multi-term-program "/bin/zsh")

;;2015.12.08 解决中文终端乱码的问题
(setenv "LANG" "zh_CN.UTF-8")

;;2015.12.08 设置环境变量为git
;;; Set localized PATH for OS X
(defun my-add-path (path-element)
  "Add the specified PATH-ELEMENT to the Emacs PATH."
  (interactive "DEnter directory to be added to path: ")
  (if (file-directory-p path-element)
     (progn
       (setenv "PATH" (concat (expand-file-name path-element) path-separator (getenv "PATH")))
       (add-to-list 'exec-path (expand-file-name path-element)))))

(if (fboundp 'my-add-path)
   (let ((my-paths (list "/opt/local/bin" "/usr/local/bin" "/usr/local/git/bin")))
      (dolist (path-to-add my-paths (getenv "PATH"))
        (my-add-path path-to-add))))

;;2015.12.08 设置注释或者反注释快捷键
(global-set-key (kbd "C-c C-/") 'comment-or-uncomment-region)
(defun my-comment-or-uncomment-region (beg end &optional arg)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end) nil)
                 (list (line-beginning-position)
                       (line-beginning-position 2))))
  (comment-or-uncomment-region beg end arg)
)
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)

;;2015.12.08 设置窗口标记
(require 'window-numbering)
(window-numbering-mode 1)
;; (setq window-numbering-assign-func
      ;; (lambda () (when (equal (buffer-name) "*Calculator*") 9)))

;;----------------------------------------------------------------------------
;; 普杰的配置  the end
;;----------------------------------------------------------------------------






;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
;; (require 'init-compat)
(require 'init-utils)

;; Needed for Emacs version < 24. must come before elpa, as it may provide package.el
;; (require 'init-site-lisp)

;; Machinery for installing required packages.
;; explicitly call 'package-initialize to set up all packages installed via ELPA.
;; should come before all package-related config files
(require 'init-elpa)
;; (require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

;; (require-package 'wgrep)
;; (require-package 'project-local-variables)
;; (require-package 'diminish)
;; (require-package 'scratch)
;; (require-package 'mwe-log-commands)

;; (require 'init-frame-hooks)
;; (require 'init-xterm)
;; (require 'init-osx-keys)
;; (require 'init-gui-frames)
;; (require 'init-proxies)
(require 'init-dired)
;; (require 'init-isearch)
;; (require 'init-uniquify)
;; (require 'init-ibuffer)
;; (require 'init-flycheck)

(require 'init-recentf)
(require 'init-ido)
(require 'init-yasnippet)
(require 'init-hippie-expand)
(require 'init-auto-complete)
;; (require 'init-windows)
;; (require 'init-sessions)
(require 'init-fonts)
;; (require 'init-mmm)
(require 'init-tabbar)
(require 'init-editing-utils)
(require 'init-evil)
(require 'init-matlab)

;; (require 'init-vc)
;; (require 'init-darcs)
(require 'init-git)

;; (require 'init-crontab)
;; (require 'init-textile)
(require 'init-markdown)
(require 'init-auctex)
;; (require 'init-csv)
;; (require 'init-erlang)
;; (require 'init-javascript)
;; (require 'init-php)
(require 'init-org)
;; (require 'init-nxml)
;; (require 'init-html)
;; (require 'init-css)
;; (require 'init-haml)
;; (require 'init-python-mode)
(require 'init-haskell)
;; (require 'init-ruby-mode)
;; (require 'init-rails)
;; (require 'init-sql)

;; (require 'init-paredit)
;; (require 'init-lisp)
;; (require 'init-slime)
;; (require 'init-clojure)
;; (when (>= emacs-major-version 24)
;;   (require 'init-clojure-cider))
;; (require 'init-common-lisp)

;; (when *spell-check-support-enabled*
;;   (require 'init-spelling))

;; (require 'init-marmalade)
;; (require 'init-misc)

;; (require 'init-dash)
;; (require 'init-ledger)
;; ;; Extra packages which don't require any configuration

;; (require-package 'gnuplot)
;; (require-package 'lua-mode)
;; (require-package 'htmlize)
;; (require-package 'dsvn)
;; (when *is-a-mac*
;;   (require-package 'osx-location))
;; (require-package 'regex-tool)

(require 'init-themes)
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


(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("196cc00960232cfc7e74f4e95a94a5977cb16fd28ba7282195338f68c84058ec" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
