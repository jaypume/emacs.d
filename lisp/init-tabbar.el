(require-package 'tabbar)
;; (require 'tabbar)
(tabbar-mode 't)
(global-set-key (kbd "<M-up>") 'tabbar-backward-group)
(global-set-key (kbd "<M-down>") 'tabbar-forward-group)
(global-set-key (kbd "<M-left>") 'tabbar-backward)
(global-set-key (kbd "<M-right>") 'tabbar-forward)

;; 把自己打开的文件放入一个group
(setq tabbar-buffer-groups-function
    (lambda () (list "All Buffers")))

;; (setq tabbar-buffer-list-function
;;     (lambda ()
;;         (remove-if
;;           (lambda(buffer)
;;              (find (aref (buffer-name buffer) 0) " *"))
;;           (buffer-list))))

(provide 'init-tabbar)
