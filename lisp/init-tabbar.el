(require-package 'tabbar)
;; (require 'tabbar)
(tabbar-mode 't)
(global-set-key (kbd "C-c n") 'tabbar-forward)
(global-set-key (kbd "C-c p") 'tabbar-backward)
(global-set-key (kbd "C-c f") 'tabbar-forward-tab)
(global-set-key (kbd "C-c b") 'tabbar-backward-tab)

(provide 'init-tabbar)
