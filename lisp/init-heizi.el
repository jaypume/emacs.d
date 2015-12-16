
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

;;2015.12.08 设置环境变量 为git
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
;;(setq org-image-actual-width 300)

;; sr-speedbar 安装和设置
(require-package 'sr-speedbar)
(setq sr-speedbar-width 20)
(setq sr-speedbar-auto-refresh t)
(setq sr-speedbar-right-side nil)
;;(setq sr-speedbar-toggle t)

;; window-numbering 安装和设置
(require-package 'window-numbering)

;; deft安装
(require-package 'deft)
(setq deft-extensions '("org"))
(setq deft-directory "~/Dropbox/Notes")
(setq deft-recursive t)
(setq deft-use-filename-as-title t)

;; 设置自动保存的时间  dkfsk
(setq auto-save-timeout 30)

;; (global-set-key (kbd "C-RET") 'set-mark-command)
;; 没有测试成功，这个快捷键
;; (define-key global-map [C-return] 'set-mark-command)

;; php mode
(require-package 'php-mode)

;; 各种elisp跳转
(require-package 'elisp-slime-nav)
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))


;; helm init
(require 'init-helm)

;; 另外一个http://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it

(defun pujie/org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-nondirectory (buffer-file-name))
                  "image/"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (unless (file-exists-p (file-name-directory filename))
    (make-directory (file-name-directory filename)))
  ; take screenshot
  (if (eq system-type 'darwin)
      (call-process "screencapture" nil nil nil "-i" filename))
  (if (eq system-type 'gnu/linux)
      (call-process "import" nil nil nil filename))
  ; insert into file if correctly taken
  (if (file-exists-p filename)
      (insert (concat "[[file:" filename "]]"))
    )
    (org-redisplay-inline-images)
  )


;; Toggle window dedication
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


;; neotree
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
        ))
;; project-explorer
;;(require-package 'project-explorer)
;;(require-package 'tree-mode)
;;(require-package 'dirtree)


;;------------------------------------------------------------------------------
;;2015.12.08 设置初始化之后的加载项
;;------------------------------------------------------------------------------
(mapc (lambda (mode)
      (add-hook 'after-init-hook mode))
      (list 'winner-mode
            'window-numbering-mode
;;            'sr-speedbar-toggle
      ))
;;----------------------------------------------------------------------------
;; 普杰的配置  the end
;;----------------------------------------------------------------------------
(provide 'init-heizi)
