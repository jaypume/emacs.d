;;---------------------------------------------------------------------------
;;pujie: 窗口锁定
;;---------------------------------------------------------------------------
(defun pujie/toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))
(global-set-key "\C-cmw" 'pujie/toggle-window-dedicated)


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


;;---------------------------------------------------------------------------
;;pujie: org-mode 截图函数
;;---------------------------------------------------------------------------
;;另外一个http://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it
;; 生成子文件夹
(defun pujie/org-image-folder()
  "给出存放图片路径的目录"
  ;; 使用子目录
  ;;  (concat (file-name-nondirectory (buffer-file-name)) "image/")
  ;; 不使用子目录
  ;; "_org-screenshot/"
  "_image/"
  )

(defun pujie/org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)
  (setq filename
        (concat
         (make-temp-name
          (concat
           (pujie/org-image-folder)
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
(global-set-key "\C-cmc" 'pujie/org-screenshot)

(defun pujie/org-import-image()
  "拷贝剪贴板中的图片，放入本地文件夹，并在org文件中生成链接和显示图片"
    )
