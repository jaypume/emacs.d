(add-to-list 'load-path (expand-file-name "lisp/editing-utils" user-emacs-directory))

;; dimish minor mode name to save mode line space
(require-package 'diminish)

;; some default value
(setq-default
 blink-cursor-delay 0.5
 blink-cursor-interval 0.4
 buffers-menu-max-size 20
 case-fold-search t
 column-number-mode t
 compilation-scroll-output t
 delete-selection-mode t
 grep-scroll-output t
 indent-tabs-mode nil
 line-spacing 0.2
 make-backup-files nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 scroll-step 1
 scroll-margin 3
 scroll-conservatively 10000
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t)
(set-scroll-bar-mode nil)
(tool-bar-mode 0)


;; auto-revert
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose t)

;; enable auto-pairing
(require 'init-autopair)
(diminish 'autopair-mode)

;; some personal key bindings
(global-set-key (kbd "C-c r") 'replace-string)

;; newline behavior
(global-set-key (kbd "RET") 'newline-and-indent)
(defun sanityinc/newline-at-end-of-line ()
  "Move to end of line, enter a newline, and reindent."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))

(global-set-key (kbd "<S-return>") 'sanityinc/newline-at-end-of-line)

;; change yes-or-no to y-or-n
;; (fset 'yes-or-no-p 'y-or-n-p)

;; display time
(display-time-mode t)
(setq display-time-24hr-format t)


;;------------------------------------------------------------------------------
;;pujie: 旁边显示行号
;;------------------------------------------------------------------------------
;; display line number
;; (require 'linum)
(require-package 'hlinum)
;; (require 'hlinum)
;;(hlinum-activate)
;;(global-linum-mode nil)

;; visual line
(global-visual-line-mode t)
;; (diminish 'global-visual-line-mode)
(diminish 'visual-line-mode)

;; expand-region
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; enable uppercase and lowercase transform for region
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; whole-line-or-region-mode
(require-package 'whole-line-or-region)
(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)

;; enable cua mode without prefix key
(cua-selection-mode t)

;; use page-break-line to handle the ^L page-breaking symbol
(require-package 'page-break-lines)
(global-page-break-lines-mode)
(diminish 'page-break-lines-mode)

;; enable subword-mode
;; (global-subword-mode t)

;; multiple-cursors-mode
;; (require-package 'multiple-cursors)
;; multiple-cursors
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-+") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
;; (global-set-key (kbd "C-c c r") 'set-rectangular-region-anchor)
;; (global-set-key (kbd "C-c c c") 'mc/edit-lines)
;; (global-set-key (kbd "C-c c e") 'mc/edit-ends-of-lines)
;; (global-set-key (kbd "C-c c a") 'mc/edit-beginnings-of-lines)

;; switch-window
(require 'init-switch-window)
;; Set "C-x p" to select the previous window
(defun other-window-backward (&optional n)
  "Select the Nth previous window"
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))
(global-set-key "\C-xp" 'other-window-backward)


;; undo-tree
(require 'init-undo-tree)
(diminish 'undo-tree-mode)

;; outline-minor-mode
(require 'init-outl-minor)

;; use C-u C-u C-s/r to trigger the flexible search action
(require 'init-flex-isearch)

;; set some compilation shortcuts
(require 'init-compile)


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

;;----------------------------------------------------------------------------
;;pujie: avy跳转
;;----------------------------------------------------------------------------
(require-package 'avy)
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)

;;------------------------------------------------------------------------------
;;pujie: 滚动半屏
;;------------------------------------------------------------------------------
(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 6)))
(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))
(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))
(global-set-key "\C-v" 'scroll-up-half)
(global-set-key "\C-d" 'scroll-down-half)

;;------------------------------------------------------------------------------
;;pujie: 关闭提醒
;;------------------------------------------------------------------------------
(setq ring-bell-function 'ignore)
;; quiet, please! No dinging!
;; (setq visible-bell nil)
;; (setq ring-bell-function (lambda ()
;;                            (set-face-background 'default "DodgerBlue")
;;                            (set-face-foreground 'default "black")))


;;------------------------------------------------------------------------------
;;pujie: 解决中文自动换行分词的问题
;;------------------------------------------------------------------------------
;;http://www.douban.com/group/topic/31132282/
(add-hook 'org-mode-hook '(lambda ()
                            (setq visual-line-fringe-indicators t)
                            (visual-line-mode)
                            (if visual-line-mode
                                (setq word-wrap nil))))

;;------------------------------------------------------------------------------
;;pujie: 设置mac下meta key的问题
;;------------------------------------------------------------------------------
;;; I prefer cmd key for meta
(if (eq system-type 'darwin)
    (setq mac-option-key-is-meta nil
          mac-command-key-is-meta t
          mac-command-modifier 'meta
          mac-option-modifier 'none)
  )

;;------------------------------------------------------------------------------
;;pujie: 设置自动保存到文件,以及自动保存的时间间隔
;;------------------------------------------------------------------------------
(defun save-buffer-if-visiting-file (&optional args)
  "Save the current buffer only if it is visiting a file"
  (interactive)
  (if (and (buffer-file-name) (buffer-modified-p))
      (save-buffer args)))
(add-hook 'auto-save-hook 'save-buffer-if-visiting-file)

;;设置自动保存的时间
;;这个是自动保存的字符间隔，如果小于20则默认20，来自官方文档：
;;http://www.gnu.org/software/emacs/manual/html_node/emacs/Auto-Save-Control.html
(setq auto-save-interval 1
      ;;这个是默认的自动保存间隔时间
      auto-save-timeout 60)


;;------------------------------------------------------------------------------
;;配置到这里结束
;;------------------------------------------------------------------------------
(provide 'init-editing-utils)
