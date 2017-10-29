;;;----
;;; Basic settings
;;;----
;; elisp path and initialization package system
(package-initialize)
(setq load-path (cons "~/.emacs.d/elisp" load-path))
(load (expand-file-name "~/.roswell/helper.el"))

;; set cording to UTF-8
(prefer-coding-system 'utf-8)

;; don't show startup message
(setq inhibit-startup-message t)

;; show line and column number
(global-linum-mode t)
(setq linum-format "%3d ")
(column-number-mode t)

;; don't sound ring-bell
(setq ring-bell-function 'ignore)

;; highlight parentheses
(show-paren-mode t)

;; indent settings
(setq-default tab-width 2 indent-tabs-mode nil)

;; show file size
(size-indication-mode t)

;; don't show tool and menu bar
(if window-system (tool-bar-mode -1) (tool-bar-mode -1))
(if window-system (menu-bar-mode -1) (menu-bar-mode -1))

;; show path on title bar
(setq frame-title-format "%f")

;; color theme
(load-theme 'wombat t)

;;autosave settings
;;dont make save-list-file
(setq auto-save-list-file-prefix nil)
;;tmpolary file is maked on...
(setq auto-save-file-name-transforms   '((".*" "~/tmp/" t)))
;; save interval
(setq auto-save-timeout 10)
(setq auto-save-interval 100)
;; backup is on "~/.ehist"
(setq backup-directory-alist '((".*" . "~/.ehist")))
;; save some file
(setq version-control     t)
(setq kept-new-versions   4)
(setq kept-old-versions   1)
(setq delete-old-versions t)


;;;----
;;; Keybinds
;;;----
;; set backspace to C-h
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; window resizer
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

(define-key global-map "\C-q" (make-sparse-keymap))
(global-set-key "\C-q\C-q" 'quoted-insert)
(global-set-key "\C-q\C-r" 'window-resizer)
(global-set-key "\C-ql" 'windmove-right)
(global-set-key "\C-qh" 'windmove-left)
(global-set-key "\C-qj" 'windmove-down)
(global-set-key "\C-qk" 'windmove-up)

;;;----
;;; Scheme-mode
;;;----
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'scheme-mode "cmuscheme" "Run an inferior Scheme process." t)
(defun scheme-other-window()
    "Run scheme on other window"
    (interactive)
    (switch-to-buffer-other-window
        (get-buffer-create "*scheme*"))
    (run-scheme scheme-program-name))
(define-key global-map "\C-cs" 'scheme-other-window)
