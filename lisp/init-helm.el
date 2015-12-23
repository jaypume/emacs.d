(require-package 'helm)
(require 'helm)
(require 'helm-config)
;(require 'helm-dash)


;;---------------------------------------------------------------------------
;;pujie: helm 自动启动以及解决启动慢的问题
;;---------------------------------------------------------------------------
;;解决启动慢的问题
(setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

(helm-mode 1)
(helm-autoresize-mode 1)
;(setq helm-ff-auto-update-initial-value nil)    ; 禁止自动补全



;;---------------------------------------------------------------------------
;;pujie: helm 按键绑定，以及基础设置
;;---------------------------------------------------------------------------
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-M-x-fuzzy-match                  t   ; 模糊搜索
      helm-buffers-fuzzy-matching           nil
      helm-locate-fuzzy-match               nil
      helm-recentf-fuzzy-match              nil
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)

;;---------------------------------------------------------------------------
;;pujie: 修改helm minibuffer中的回车和backspace功能
;;---------------------------------------------------------------------------
;;http://emacs.stackexchange.com/questions/3798/how-do-i-make-pressing-ret-in-helm-find-files-open-the-directory
;; 回车
(defun fu/helm-find-files-navigate-forward (orig-fun &rest args)
  (if (file-directory-p (helm-get-selection))
      (apply orig-fun args)
    (helm-maybe-exit-minibuffer)))
(advice-add 'helm-execute-persistent-action :around #'fu/helm-find-files-navigate-forward)
(define-key helm-find-files-map (kbd "<return>") 'helm-execute-persistent-action)
;; backspace
(defun fu/helm-find-files-navigate-back (orig-fun &rest args)
  (if (= (length helm-pattern) (length (helm-find-files-initial-input)))
      (helm-find-files-up-one-level 1)
    (apply orig-fun args)))
(advice-add 'helm-ff-delete-char-backward :around #'fu/helm-find-files-navigate-back)
;;TODO:  tab键

;;---------------------------------------------------------------------------
;;pujie: 自动加载helm-bibtex
;;---------------------------------------------------------------------------
;; (autoload 'helm-bibtex "helm-bibtex" "" t)

;; (setq helm-bibtex-bibliography "references.bib")
;; (setq helm-bibtex-library-path "pdfs")

;; ;; open pdf with system pdf viewer (works on mac)
;; (setq helm-bibtex-pdf-open-function
;;   (lambda (fpath)
;;     (start-process "open" "*open*" "open" fpath)))

;; ;; 设置file字段
;; (setq helm-bibtex-pdf-field "file")


;; 单独使用helm bibtex的时候对不同模式设置不同的cite方式
;; (setq helm-bibtex-format-citation-functions
;;   '((org-mode      . helm-bibtex-format-citation-org-link-to-PDF)
;;     (latex-mode    . helm-bibtex-format-citation-cite)
;;     (markdown-mode . helm-bibtex-format-citation-pandoc-citeproc)
;;     (default       . helm-bibtex-format-citation-default)))


;;---------------------------------------------------------------------------
;;pujie: The End
;;---------------------------------------------------------------------------
(provide 'init-helm)
