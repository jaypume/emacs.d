(setq window-system-default-frame-alist
      '((x (font . "文泉驿等宽微米黑 14")) ;; if frame created on x display
        (nil))) ;; if on term

;; 修改默认的字体大小为14
(set-default-font "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
(provide 'init-fonts)
