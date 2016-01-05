;;------------------------------------------------------------------------------
;;pujie: auctex设置 + latex mode设置
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;pujie: 加载库
;;------------------------------------------------------------------------------
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
(require-package 'auctex)
;; (require 'auctex-autoloads)

;;------------------------------------------------------------------------------
;;pujie: 设置latex的环境变量
;;------------------------------------------------------------------------------
(setenv "PATH" (concat "/Library/TeX/texbin:" (getenv "PATH")))
(setq exec-path (append '("/Library/TeX/texbin:") exec-path))

(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin:") exec-path))

;;------------------------------------------------------------------------------
;;pujie: 添加latexmk编译方式(暂时不用)
;;------------------------------------------------------------------------------
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
;;(require 'auctex-latexmk)
;;(auctex-latexmk-setup)
;;(add-hook 'LaTeX-mode-hook (lambda ()
;;  (push
;;    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
;;      :help "Run latexmk on file")
;;    TeX-command-list)))
;;(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;;------------------------------------------------------------------------------
;;pujie: 2015.12.07 添加xelatex编译
;;------------------------------------------------------------------------------
(add-hook 'LaTeX-mode-hook
          (lambda()
             (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
             (setq TeX-command-default "XeLaTeX")
             (setq TeX-save-query nil)
             (setq TeX-show-compilation t)));;这边在hook后执行，所以以这个为准

;;------------------------------------------------------------------------------
;;pujie: 2015.12.07 使用skim为默认的查看方式，并启动emacs的服务器模式，使得skim可以和emacs交互
;;------------------------------------------------------------------------------
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
;; (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
;; (setq TeX-view-program-list
;;      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
;; (server-start); start emacs in server mode so that skim can talk to it


;;------------------------------------------------------------------------------
;;pujie: Latex模式自动加载的模块
;;------------------------------------------------------------------------------
(mapc (lambda (mode)
      (add-hook 'LaTeX-mode-hook mode))
      (list ;; 'auto-fill-mode
            'LaTeX-math-mode
            'turn-on-reftex
            'TeX-fold-mode
            'linum-mode
            'auto-complete-mode
            'autopair-mode
            'outline-minor-mode))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq ;;TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-engine 'xetex       ; use xelatex default
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
            ))
;;------------------------------------------------------------------------------
;;pujie: tex fold mode 设置
;;------------------------------------------------------------------------------
;; add entries you want to be fold, or comment that needn't to be fold.
(setq TeX-fold-env-spec-list
      (quote (("[figure]" ("figure"))
              ("[table]" ("table"))
              ("[itemize]" ("itemize"))
              ("[description]" ("description"))
              ("[tabular]" ("tabular"))
              ("[frame]" ("frame"))
              ("[array]" ("array"))
              ("[code]" ("lstlisting"))
;;              ("[eqnarray]" ("eqnarray"))
              )))


;;------------------------------------------------------------------------------
;;pujie: reftex设置
;;------------------------------------------------------------------------------
;; make the toc displayed on the left
(setq reftex-toc-split-windows-horizontally t)
;; adjust the fraction
(setq reftex-toc-split-windows-fraction 0.3)


;;------------------------------------------------------------------------------
;;配置到此结束
;;------------------------------------------------------------------------------
(provide 'init-auctex)
