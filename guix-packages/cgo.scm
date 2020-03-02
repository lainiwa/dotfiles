(define-module (cgo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download))

(define-public cgo
  (package
    (name "cgo")
    (version "0.6.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                     (url "https://github.com/kieselsteini/cgo")
                     (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "016qslrkk3kk93q9x5mzgd8zdk91fd0h6vxwilzc2x3blamdicrc"))))
    (build-system gnu-build-system)
    (arguments
         '(#:phases (modify-phases %standard-phases (delete 'configure))
          #:tests? #f
          #:make-flags (list "CC=gcc" (string-append "PREFIX=" %output))))
    (home-page "https://github.com/kieselsteini/cgo/")
    (synopsis "Terminal based gopher client")
    (description "cgo is a UNIX/Linux terminal based gopher client.
It has no other dependencies than libc and some syscalls.
It should run on every VT100 compatible terminal.
To show media like images, music or webpages
it relies on external programs you can specify.")
    (license license:isc)))
