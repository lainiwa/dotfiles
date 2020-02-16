(define-module (python-termtosvg)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages check)
  #:use-module (guix build-system python)
  #:use-module (guix download))

(define-public python-termtosvg
  (package
    (name "python-termtosvg")
    (version "1.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "termtosvg" version))
        (sha256
          (base32
            "1vk5kn8w3zf2ymi76l8cpwmvvavkmh3b9lb18xw3x1vzbmhz2f7d"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-lxml" ,python-lxml)
        ("python-pyte" ,python-pyte)
        ("python-wcwidth" ,python-wcwidth)))
    (native-inputs
      `(("python-coverage" ,python-coverage)
        ("python-pylint" ,python-pylint)
        ("python-twine" ,python-twine)
        ("python-wheel" ,python-wheel)))
    (home-page "https://github.com/nbedos/termtosvg")
    (synopsis
      "Record terminal sessions as SVG animations")
    (description
      "Record terminal sessions as SVG animations")
    (license license:bsd-3)))
