(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(autoload 'auto "auto-complete-mode" "Autmatically loads auto-complete-mode" t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/auto-java-complete/")
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

(setq show-paren-delay 0)
(show-paren-mode 1)
(global-set-key (kbd "RET") 'newline-and-indent)

(global-linum-mode t)
(global-hl-line-mode t)

(global-set-key (kbd "C-c C-c") 'kill-ring-save)
(global-set-key (kbd "C-x C-x") 'kill-region)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-y") 'kill-whole-line)
(global-set-key (kbd "M-f") 'find-file)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x C-a") 'mark-whole-buffer)

