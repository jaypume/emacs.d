(require-package 'helm)
(require 'helm)
(require 'helm-config)
;(require 'helm-dash)

;;解决启动慢的问题
(setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

(helm-mode 1)
(helm-autoresize-mode 1)
;(setq helm-ff-auto-update-initial-value nil)    ; 禁止自动补全

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

(provide 'init-helm)
