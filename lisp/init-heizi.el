
;;----------------------------------------------------------------------------
;;pujie: 普杰的配置大杂烩
;;----------------------------------------------------------------------------
;;2015.12.04  设置打开文件的时候不打开新的窗口
(setq ns-pop-up-frames nil)
;;2015.12.04  添加multi-term支持
(require 'multi-term)
(setq multi-term-program "/bin/zsh")

;;2015.12.08 解决中文终端乱码的问题
(setenv "LANG" "zh_CN.UTF-8")


;;---------------------------------------------------------------------------
;;pujie: 为git设置环境变量
;;---------------------------------------------------------------------------
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


;;---------------------------------------------------------------------------
;;pujie: 设置注释或者反注释快捷键
;;---------------------------------------------------------------------------
(global-set-key (kbd "C-c C-/") 'comment-or-uncomment-region)
(defun my-comment-or-uncomment-region (beg end &optional arg)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end) nil)
                 (list (line-beginning-position)
                       (line-beginning-position 2))))
  (comment-or-uncomment-region beg end arg)
)
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)


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

;;pujie: 设置自动保存的时间
(setq auto-save-timeout 30)



;;---------------------------------------------------------------------------
;;pujie: php + elisp + ...
;;---------------------------------------------------------------------------
;; php mode
(require-package 'php-mode)

;; 各种elisp跳转
(require-package 'elisp-slime-nav)
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))




;;---------------------------------------------------------------------------
;;pujie: Toggle window dedication
;;---------------------------------------------------------------------------
(defun toggle-window-dedicated ()
"Toggle whether the current active window is dedicated or not"
(interactive)
(message
 (if (let (window (get-buffer-window (current-buffer)))
       (set-window-dedicated-p window
        (not (window-dedicated-p window))))
    "Window '%s' is dedicated"
    "Window '%s' is normal")
 (current-buffer)))

;;---------------------------------------------------------------------------
;;pujie: neotree
;;---------------------------------------------------------------------------
(require-package 'neotree)
(setq neo-hidden-regexp-list
      '("^\\."
        "\\.cs\\.meta$"
        "\\.pyc$"
        "~$"
        "^#.*#$"
        "\\.elc$"
        "\\.html$"
        "\\.*orgimage$"
        "ltxpng"
        ))

;;---------------------------------------------------------------------------
;;pujie: projectile
;;---------------------------------------------------------------------------
;;projectile
(require-package 'projectile)
(require-package 'helm-projectile)
(helm-projectile-on)
;; ibuffer 替代buffer-list
(require-package 'ibuffer-projectile)
(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))
;(global-set-key "\C-xb" 'ibuffer)

;;(require-package 'ibuffer-vc)


;;---------------------------------------------------------------------------
;;pujie: 设置url代理
;;---------------------------------------------------------------------------
;; (setq url-using-proxy t)
;; (setq url-proxy-services '(("http" . "mi.jaypu.com:9102")))


;;----------------------------------------------------------------------------
;;普杰的配置  the end
;;----------------------------------------------------------------------------
(provide 'init-heizi)
