;; mac 下的设置
(if (eq system-type 'darwin)
    ;; 修改默认的字体大小为14
    (set-default-font "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
    (set-fontset-font "fontset-default" 'han '("STHeiti"))
    )

;; linux 下的设置
(if (eq system-type 'gun/linux)
    ()
    )

;; windows 下的设置
(if (eq system-type 'windows-nt)
    ()
    )

;; 提供插件
(provide 'init-fonts)
