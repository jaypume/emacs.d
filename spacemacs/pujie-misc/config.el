;;------------------------------------------------------------------------------
;;pujie: 设置系统默认的一些状态
;;------------------------------------------------------------------------------
;;默认不打开新的frame
(setq ns-pop-up-frames nil)
;;默认开启menu-bar
(menu-bar-mode 1)
;;org mode 美化
(add-hook 'org-mode-hook (lambda() (org-bullets-mode 1)))
(add-hook 'after-init-hook (lambda() (toggle-truncate-lines 1)))
(add-hook 'org-mode-hook (lambda()
                           (global-set-key (kbd "<C-tab>") 'spacemacs/next-useful-buffer)
                           ))


;; (defface org-block-begin-line
;;   '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
;;   "Face used for the line delimiting the begin of source blocks.")

(defface org-block-begin-line
  '((t (:background "#FFFFEA")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "#FFFFEA")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:background "#FFFFEA")))
  "Face used for the line delimiting the begin of source blocks.")

;; (defface org-block-end-line
;;   '((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
;;   "Face used for the line delimiting the end of source blocks.")


;;------------------------------------------------------------------------------
;;pujie: 编辑相关的一些特性
;;------------------------------------------------------------------------------
;; ;; auto-revert
;; (global-auto-revert-mode)
;; (setq global-auto-revert-non-file-buffers t
;;       auto-revert-verbose t)

;; ;; enable auto-pairing
;; (require 'init-autopair)
;; (diminish 'autopair-mode)

;; ;; some personal key bindings
;; (global-set-key (kbd "C-c r") 'replace-string)

;; newline behavior
(global-set-key (kbd "RET") 'newline-and-indent)
(defun sanityinc/newline-at-end-of-line ()
  "Move to end of line, enter a newline, and reindent."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
(global-set-key (kbd "<S-return>") 'sanityinc/newline-at-end-of-line)


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
;;pujie: 设置proxy
;;------------------------------------------------------------------------------





;; (add-to-list 'package-archives '("melpa" . "http://stable.melpa.org") t)

;; (setq configuration-layer--elpa-archives
;;       '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;         ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
;;         ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))




;;------------------------------------------------------------------------------
;;pujie: 设置一些快捷键
;;------------------------------------------------------------------------------
;; (global-set-key "\C-s" 'spacemacs/helm-file-smart-do-search)
;; (global-set-key "\C-s" 'spacemacs/helm-file-smart-do-search)
(global-set-key "\C-s" 'helm-swoop)
(global-set-key "\C-ck" 'yas/expand) 
;; (global-set-key (kbd "C-s") 'helm-swoop-from-isearch)


;;------------------------------------------------------------------------------
;;pujie: 系统独立设置
;;------------------------------------------------------------------------------
;; mac 下的设置
(if (eq system-type 'darwin)
    (progn
      (message "this is darwin")
      ;;------------------------------------------------------------------------------
      ;;pujie: 设置latex的环境变量
      ;;------------------------------------------------------------------------------
      (setenv "PATH" (concat "/Library/TeX/texbin:" (getenv "PATH")))
      (setq exec-path (append '("/Library/TeX/texbin:") exec-path))
      (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
      (setq exec-path (append '("/usr/texbin:") exec-path))

      ;;pujie:  修改默认的字体大小为13
      ;; (set-default-font "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
      ;; (set-default-font "Menlo-13")
      ;; (set-fontset-font "fontset-default" 'han '("STHeitiSC"))
      ;; (set-fontset-font "fontset-default" 'han '("PingFangSC-Ultralight"))
      ;; (set-fontset-font "fontset-default" 'han '("STXihei"))
      ;; (set-fontset-font "fontset-default" 'han '("SourceHanSansSC"))
      (setenv "LC_CTYPE" "en_US.UTF-8")
      ;;------------------------------------------------------------------------------
      ;;pujie: 设置mac下meta key的问题
      ;;------------------------------------------------------------------------------
      ;; I prefer cmd key for meta
      (setq mac-option-key-is-meta nil
            mac-command-key-is-meta t
            mac-command-modifier 'meta
            mac-option-modifier 'none)
      )
  (progn
    (message "this is not darwin")
    )
  )

;; linux 下的设置
(if (eq system-type 'gnu/linux)
    (progn
      (message "this is gnu/linux")
      ;;    (set-default-font "-unknown-Droid Sans Fallback-normal-normal-normal-*-8-*-*-*-*-0-iso10646-1")
      (set-default-font "Droid Sans-10")
      (setenv "LC_CTYPE" "zh_CN.UTF-8")
      )
  (progn
    (message "this is not gnu/linux")
    )
  )
;; windows 下的设置
(if (eq system-type 'windows-nt)
    (progn
      (message "this is windows")
      ;;------------------------------------------------------------------------------
      ;;pujie: windows字体单独设置
      ;;------------------------------------------------------------------------------
      ;; (set-default-font "Yahei Consolas Hybrid:pixelsize=14")
      ;; (set-fontset-font (frame-parameter nil 'font)
      ;;                   'han (font-spec :family "Yahei Consolas Hybrid" :size 14))
      ;; (set-fontset-font (frame-parameter nil 'font)
      ;;                   'symbol (font-spec :family "SimSun" :size 14))
      ;; (set-fontset-font (frame-parameter nil 'font)
      ;;                   'cjk-misc (font-spec :family "SimSun" :size 14))
      ;; (set-fontset-font (frame-parameter nil 'font)
      ;;                   'bopomofo (font-spec :family "SimSun" :size 14))
      ;;------------------------------------------------------------------------------
      ;;pujie:windows 设置默认启动的窗口位置和大小
      ;;------------------------------------------------------------------------------
      ;;设置窗口位置为屏库左上角(0,0)
      (set-frame-position (selected-frame) 0 0)
      ;;设置宽和高，在1080p分辨率的显示器上，默认占左半边
      (set-frame-width (selected-frame) 104)
      (set-frame-height (selected-frame) 54)

      ;;------------------------------------------------------------------------------
      ;;pujie:windows 字体编码设置
      ;;------------------------------------------------------------------------------

      )
  (progn
    (message "this is not windows")
    )
  )



;;------------------------------------------------------------------------------
;;pujie: 2015.12.07 添加xelatex编译
;;------------------------------------------------------------------------------
(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query nil)
            (setq TeX-show-compilation nil)));;这边在hook后执行，所以以这个为准




;;---------------------------------------------------------------------------
;;pujie: org mode 基本设置
;;---------------------------------------------------------------------------
;;解决中文不自动换行的问题
(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines t)
            (setq truncate-lines nil)
            ))

(setq org-directory (cond
                     ((eq system-type 'windows-nt) "~/Notes/0. defaut/")
                     ((eq system-type 'darwin)     "~/Dropbox/Emacs/Notes/org-mode/")
                     ((eq system-type 'gnu/linux)  "~/Dropbox/Emacs/Notes/org-mode/")
                     ))
(setq org-default-notes-file (concat org-directory "capture.org"))
(setq org-return-follows-link nil)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-c)" 'org-remove-file)
(define-key global-map "\C-c(" 'org-agenda-file-to-front)
(define-key global-map "\C-xci" 'helm-semantic-or-imenu)

(setq
 ;; org-log-done t
 ;; org-completion-use-ido t
 ;; org-edit-timestamp-down-means-later t
 ;; org-agenda-start-on-weekday nil
 ;; org-agenda-span 14
 ;; org-agenda-include-diary t
 ;; org-agenda-window-setup 'current-window
 ;; org-fast-tag-selection-single-key 'expert
 ;; org-export-kill-product-buffer-when-displayed t
 ;; org-tags-column 60
 org-startup-indented t;;设置对齐模式
 org-src-fontify-natively t ;;设置orgmode中的src code 语法高亮
 )

;;设置org-todo 关键字
(setq org-todo-keywords
      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

;;自定义orgmode下加粗字体和颜色
(require 'org)
(require 'cl)   ; for delete*
(setq org-emphasis-alist
      (cons '("+" '(:strike-through t :foreground "gray"))
            (delete* "+" org-emphasis-alist :key 'car :test 'equal)))
(setq org-emphasis-alist
      (cons '("*" '(:emphasis t :foreground "blue"))
            (delete* "*" org-emphasis-alist :key 'car :test 'equal)))


;;------------------------------------------------------------------------------
;;pujie: 设置切换buffer时候不显示*开头的buffer
;;------------------------------------------------------------------------------
;;http://emacs.stackexchange.com/questions/5491/setting-ido-ignore-buffers-doesnt-cause-buffers-to-be-ignored-wheres-the-er
(defvar ido-dont-ignore-buffer-names '(
                                       ;; "*grep*"
                                       ;; "*Messages*"
                                       ))
(defun ido-ignore-most-star-buffers (name)
  (and
   (string-match-p "^*" name)
   (not (member name ido-dont-ignore-buffer-names))))
(setq ido-ignore-buffers (list "\\` " #'ido-ignore-most-star-buffers))
;;这是设置helm-buffers-list的 
(global-set-key "\C-xb" 'helm-buffers-list)
(global-set-key (kbd "<C-tab>") 'spacemacs/next-useful-buffer)
(setq helm-boring-buffer-regexp-list
      '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc" "^*"))




;; 下面的方法都是研究如何添加imenu
;;------------------------------------------------------------------------------
;;pujie: 方法1
;;------------------------------------------------------------------------------
;; (defun my-merge-imenu ()
;;   (interactive)
;;   (let ((mode-imenu (imenu-default-create-index-function))
;;         (custom-imenu (imenu--generic-function imenu-generic-expression)))
;;     (append mode-imenu custom-imenu)))
;; (add-to-list
;;  'imenu-generic-expression
;;  '("Sections" "^#### \\[ \\(.*\\) \\]$" 1))
;; ;; (imenu-add-to-menubar "Position")
;; (setq imenu-create-index-function 'my-merge-imenu)
;; (add-hook 'latex-mode-hook
;;           (lambda ()
;;             (add-to-list
;;              'imenu-generic-expression
;;              '("Sections" "^#### \\[ \\(.*\\) \\]$" 1))
;;             ;; (imenu-add-to-menubar "Position")
;;             (setq imenu-create-index-function 'my-merge-imenu)))


;;------------------------------------------------------------------------------
;;pujie: 方法2
;;------------------------------------------------------------------------------
;; (setq test-imenu-generic-expression
;;       '(("Subject"  "^Subject: *\\(.*\\)" 1)
;;         ("Cc"     "^C[Cc]: *\\(.*\\)" 1)
;;         ("To"     "^To: *\\(.*\\)" 1)
;;         ("From"  "^From: *\\(.*\\)" 1)
;; ;;        ("Sections" "^#### \\[ \\(.*\\) \\]$" 1)
;;         ))
;; (add-hook 'latex-mode-hook
;;           (lambda ()
;;             (setq imenu-generic-expression test-imenu-generic-expression)))
;; (add-hook 'latex-mode-hook
;;           (lambda ()
;;             (setq imenu-generic-expression test-imenu-generic-expression)
;;             (setq imenu-create-index-function 'my-merge-imenu)))

;;------------------------------------------------------------------------------
;;pujie: 方案3
;;------------------------------------------------------------------------------
;; https://www.emacswiki.org/emacs/ImenuMode
;; (add-hook 'latex-mode-hook
;;           (lambda ()
;;             (set (make-local-variable imenu-generic-expression)
;;                  '(("Comments" "^\\s-*#" 1)
;;                    ("Sections" "^#### \\[ \\(.*\\) \\]$" 1)
;;                    ))))

;;------------------------------------------------------------------------------
;;pujie: 方案4
;;------------------------------------------------------------------------------
;; 来自我的配置文件
;; (defun my-merge-imenu ()
;;   (interactive)
;;   (let ((mode-imenu (imenu-default-create-index-function))
;; ;;        (custom-imenu (imenu--generic-function imenu-generic-expression)))
;;         (custom-imenu (
;;                        imenu--generic-function
;;                        imenu-generic-expression
;;                        )))
;;     (append mode-imenu custom-imenu)))
;; (add-hook 'LaTeX-mode-hook
;;           (lambda ()
;;             (setq-local
;;              'imenu-generic-expression
;;             (list
;;              (list nil "^\\([a-zA-Z][-a-zA-Z0-9._]*\\)\\s-*[&|]?=" 1)
;;              (list "frame" "^\\begin{frame}{\\(.+\\)}$" 1)
;;              (list "Sections" "^#### \\[ \\(.*\\) \\]$" 1)
;;               ;; "^\\begin{frame}{[a-zA-Z][-a-zA-Z0-9._]*}" 1)
;;              )
;;             )
;;             (setq imenu-create-index-function 'my-merge-imenu)
;;             (imenu-add-menubar-index)
;;             )
;;           )


;;------------------------------------------------------------------------------
;;pujie: 设置projetile index 的方式
;;------------------------------------------------------------------------------
;; (setq projectile-indexing-method 'native)

;;------------------------------------------------------------------------------
;;pujie: 设置鼠标平滑滚动
;;------------------------------------------------------------------------------
;;https://www.reddit.com/r/emacs/comments/3kgv75/why_is_smooth_scrolling_so_slow/
;; (setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
;; (setq mouse-wheel-scroll-amount '(1)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
;; (setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line

;;这一个似乎效果较好 11.21 （OK）
;;https://www.emacswiki.org/emacs/SmoothScrolling
;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;; (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;; (setq scroll-step 1) ;; keyboard scroll one line at a time



;; ;===================配置graphviz环境============================
;; (setenv "PATH" (concat "C:/Program Files/Graphviz2.38/bin;" (getenv "PATH")))
;; (load "graphviz-dot-mode.el" nil t t)

;; (add-hook 'find-file-hook (lambda()
;;                             (if (string= "dot" (file-name-extension
;;                                                 buffer-file-name))
;;                                 (progn
;;                                   (message "Enabling Setings for dot-mode")
;;                                   (setq fill-column 1000)
;;                                         ;(base-auto-pair)
;;                                   (linum-mode)
;;                                   )
;;                               )))

;; ;(setq graphviz-dot-view-command "dotty") ;不起作用，直接在graphviz-dot-mode.el中修改
;; ;===================配置graphviz结束============================


