;; DISFUNCTIONAL

(define-module (abook)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages m4)
  #:use-module (guix git-download))

(define-public abook
  (package
    (name "abook")
    (version "0.6.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                     (url "https://git.code.sf.net/p/abook/git")
                     (commit "ver_0_6_1")))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1q4viizf7247hcwlrv08lxj2iwk3rmgiiivp9dp0g75kbm7ixmr5"))
              (modules '((guix build utils)))))
    (build-system gnu-build-system)
    (native-inputs
      `(("autoconf" ,autoconf)
        ("m4" ,m4)
        ("libtool" ,libtool)
        ("automake" ,automake)))
    (inputs
      `(("ncurses" ,ncurses)
        ("readline" ,readline)))
    ; (arguments
    ;      '(#:phases (modify-phases %standard-phases (delete 'configure))
    ;       ; #:tests? #f
    ;       ; #:make-flags (list "CC=gcc" (string-append "PREFIX=" %output))
    ;       ))
    (home-page "http://abook.sourceforge.net/")
    (synopsis "Addressbook program")
    (description "Addressbook program with mutt mail client support.")
    (license license:gpl2+)))
