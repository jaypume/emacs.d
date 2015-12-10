
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

;;2015.12.09 org mode 相关设置
(setq org-image-actual-width 300)

;; sr-speedbar 安装和设置
(require-package 'sr-speedbar)
(setq sr-speedbar-width 30)
(setq sr-speedbar-auto-refresh nil)
(setq sr-speedbar-right-side nil)
;;(setq sr-speedbar-toggle t)

;; window-numbering 安装和设置
(require-package 'window-numbering)


;; (global-set-key (kbd "C-RET") 'set-mark-command)
;; 没有测试成功，这个快捷键
;; (define-key global-map [C-return] 'set-mark-command)

;;------------------------------------------------------------------------------
;;2015.12.08 设置初始化之后的加载项
;;------------------------------------------------------------------------------
(mapc (lambda (mode)
      (add-hook 'after-init-hook mode))
      (list 'winner-mode
            'window-numbering-mode
            'sr-speedbar-toggle
      ))
;;----------------------------------------------------------------------------
;; 普杰的配置  the end
;;----------------------------------------------------------------------------
(provide 'init-heizi)
