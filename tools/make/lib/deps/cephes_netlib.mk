
# VARIABLES #

# Define the base download URL:
DEPS_CEPHES_URL ?= http://www.netlib.org/cephes/

# Determine the basename for the download:
deps_cephes_basename := netlib_cephes

# Define the checksum(s) to verify downloaded libraries:
DEPS_CEPHES_CHECKSUM ?= $(foreach file,$(DEPS_CEPHES_LIBS),$(shell cat $(DEPS_CHECKSUMS_DIR)/$(subst .,_,$(deps_cephes_basename)_$(file).tgz)/sha256))

# Define the output directory when downloading:
DEPS_CEPHES_DOWNLOAD_OUT ?= $(DEPS_TMP_DIR)/$(deps_cephes_basename)

# Define the output path(s) when downloading:
deps_cephes_download_out := $(addsuffix .tgz,$(addprefix $(DEPS_CEPHES_DOWNLOAD_OUT)/,$(DEPS_CEPHES_LIBS)))

# Generate an interleaved list of output download paths and checksums:
deps_cephes_checksum := $(join $(deps_cephes_download_out),$(addprefix |,$(DEPS_CEPHES_CHECKSUM)))
deps_cephes_checksum := $(foreach pair,$(deps_cephes_checksum),$(subst |, ,$(pair)))

# Define the output path(s) when building:
deps_cephes_build_out := $(addprefix $(DEPS_CEPHES_BUILD_OUT)/cephes/,$(DEPS_CEPHES_LIBS))

# Define the path to the directory containing tests:
DEPS_CEPHES_TEST_DIR ?= $(DEPS_DIR)/test/netlib_cephes

# Define the output directory path for compiled tests:
DEPS_CEPHES_TEST_OUT ?= $(DEPS_CEPHES_TEST_DIR)/build

# Define the path to a test file for checking an installation:
DEPS_CEPHES_TEST_INSTALL ?= $(DEPS_CEPHES_TEST_DIR)/test_install.cpp

# Define the output path for a test file:
DEPS_CEPHES_TEST_INSTALL_OUT ?= $(DEPS_CEPHES_TEST_OUT)/test_install


# TARGETS #

# Create a download directory.
#
# This target creates a download directory for netlib Cephes.

$(DEPS_CEPHES_DOWNLOAD_OUT):
	$(QUIET) echo 'Creating download directory...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $(DEPS_CEPHES_DOWNLOAD_OUT)


# Download library.
#
# This target downloads the netlib Cephes library for 128-bit reals.

$(DEPS_CEPHES_DOWNLOAD_OUT)/128bit.tgz: | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for Bessel and hypergeometric functions.

$(DEPS_CEPHES_DOWNLOAD_OUT)/bessel.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz $(DEPS_CEPHES_DOWNLOAD_OUT)/cprob.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for complex type as in C9X standard.

$(DEPS_CEPHES_DOWNLOAD_OUT)/c9x-complex.tgz: | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for double-precision elementary functions.

$(DEPS_CEPHES_DOWNLOAD_OUT)/cmath.tgz: | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for probability integrals and their inverses.

$(DEPS_CEPHES_DOWNLOAD_OUT)/cprob.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for elliptic integrals and elliptic filter calculator.

$(DEPS_CEPHES_DOWNLOAD_OUT)/ellf.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library which is a subset of `cmath.tgz` and used by other functions.

$(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz: | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for floating point arithmetic in standard precisions.

$(DEPS_CEPHES_DOWNLOAD_OUT)/ieee.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for IEEE 80-bit extended real elementary functions.

$(DEPS_CEPHES_DOWNLOAD_OUT)/ldouble.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for C translations of `eigens`, `lmdif`.

$(DEPS_CEPHES_DOWNLOAD_OUT)/linalg.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for Fresnel integrals, polylogarithms, Planck radiation formula, Adams-Bashforth-Moulton and Runge-Kutta, solar system integration.

$(DEPS_CEPHES_DOWNLOAD_OUT)/misc.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for Fresnel integrals, polylogarithms, Planck radiation formula, Adams-Bashforth-Moulton and Runge-Kutta, solar system integration.

$(DEPS_CEPHES_DOWNLOAD_OUT)/ode.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for arithmetic on rationals and polynomials.

$(DEPS_CEPHES_DOWNLOAD_OUT)/polyn.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for 144- or 336-bit precision floating point arithmetic and functions.

$(DEPS_CEPHES_DOWNLOAD_OUT)/qfloat.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for minimax rational approximation.

$(DEPS_CEPHES_DOWNLOAD_OUT)/remes.tgz: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Download library.
#
# This target downloads the netlib Cephes library for 32-bit floating point versions of Cephes functions.

$(DEPS_CEPHES_DOWNLOAD_OUT)/single.tgz: | $(DEPS_TMP_DIR) $(DEPS_CEPHES_DOWNLOAD_OUT)
	$(QUIET) echo 'Downloading library...' >&2
	$(QUIET) $(DEPS_DOWNLOAD_BIN) $(DEPS_CEPHES_URL)`basename $@` $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for 128-bit reals.

$(DEPS_CEPHES_BUILD_OUT)/cephes/128bit: $(DEPS_CEPHES_DOWNLOAD_OUT)/128bit.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for Bessel and hypergeometric functions.

$(DEPS_CEPHES_BUILD_OUT)/cephes/bessel: $(DEPS_CEPHES_DOWNLOAD_OUT)/bessel.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for complex type as in C9X standard.

$(DEPS_CEPHES_BUILD_OUT)/cephes/c9x-complex: $(DEPS_CEPHES_DOWNLOAD_OUT)/c9x-complex.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@
	$(QUIET) mv $@/c9x-complex/* $@/
	$(QUIET) rmdir $@/c9x-complex/


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for double-precision elementary functions.

$(DEPS_CEPHES_BUILD_OUT)/cephes/cmath: $(DEPS_CEPHES_DOWNLOAD_OUT)/cmath.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for probability integrals and their inverses.

$(DEPS_CEPHES_BUILD_OUT)/cephes/cprob: $(DEPS_CEPHES_DOWNLOAD_OUT)/cprob.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for elliptic integrals and elliptic filter calculator.

$(DEPS_CEPHES_BUILD_OUT)/cephes/ellf: $(DEPS_CEPHES_DOWNLOAD_OUT)/ellf.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library which is a subset of `cmath.tgz` and used by other functions.

$(DEPS_CEPHES_BUILD_OUT)/cephes/eval: $(DEPS_CEPHES_DOWNLOAD_OUT)/eval.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for floating point arithmetic in standard precisions.

$(DEPS_CEPHES_BUILD_OUT)/cephes/ieee: $(DEPS_CEPHES_DOWNLOAD_OUT)/ieee.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for IEEE 80-bit extended real elementary functions.

$(DEPS_CEPHES_BUILD_OUT)/cephes/ldouble: $(DEPS_CEPHES_DOWNLOAD_OUT)/ldouble.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for C translations of `eigens`, `lmdif`.

$(DEPS_CEPHES_BUILD_OUT)/cephes/linalg: $(DEPS_CEPHES_DOWNLOAD_OUT)/linalg.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for Fresnel integrals, polylogarithms, Planck radiation formula, Adams-Bashforth-Moulton and Runge-Kutta, solar system integration.

$(DEPS_CEPHES_BUILD_OUT)/cephes/misc: $(DEPS_CEPHES_DOWNLOAD_OUT)/misc.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for Fresnel integrals, polylogarithms, Planck radiation formula, Adams-Bashforth-Moulton and Runge-Kutta, solar system integration.

$(DEPS_CEPHES_BUILD_OUT)/cephes/ode: $(DEPS_CEPHES_DOWNLOAD_OUT)/ode.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for arithmetic on rationals and polynomials.

$(DEPS_CEPHES_BUILD_OUT)/cephes/polyn: $(DEPS_CEPHES_DOWNLOAD_OUT)/polyn.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for 144- or 336-bit precision floating point arithmetic and functions.

$(DEPS_CEPHES_BUILD_OUT)/cephes/qfloat: $(DEPS_CEPHES_DOWNLOAD_OUT)/qfloat.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for minimax rational approximation.

$(DEPS_CEPHES_BUILD_OUT)/cephes/remes: $(DEPS_CEPHES_DOWNLOAD_OUT)/remes.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Extract library.
#
# This target extracts a gzipped tar archive of the netlib Cephes library for 32-bit floating point versions of Cephes functions.

$(DEPS_CEPHES_BUILD_OUT)/cephes/single: $(DEPS_CEPHES_DOWNLOAD_OUT)/single.tgz
	$(QUIET) echo 'Extracting library...' >&2
	$(QUIET) $(MKDIR_RECURSIVE) $@
	$(QUIET) $(TAR) -zxf $< -C $@


# Create directory for tests.
#
# This target creates a directory for storing compiled tests.

$(DEPS_CEPHES_TEST_OUT):
	$(QUIET) $(MKDIR_RECURSIVE) $(DEPS_CEPHES_TEST_OUT)


# Compile install test.
#
# This target compiles a test file for testing an installation.

$(DEPS_CEPHES_TEST_INSTALL_OUT): $(deps_cephes_build_out) $(DEPS_CEPHES_TEST_OUT)
	$(QUIET) $(CC) -I $(DEPS_CEPHES_BUILD_OUT) $(DEPS_CEPHES_TEST_INSTALL) -o $(DEPS_CEPHES_TEST_INSTALL_OUT)


# Download Cephes.
#
# This target downloads a Cephes distribution.

deps-download-cephes: $(deps_cephes_download_out)

.PHONY: deps-download-cephes


# Verify download.
#
# This targets verifies a download.

deps-verify-cephes: deps-download-cephes
	$(QUIET) $(DEPS_CHECKSUM_BIN) $(deps_cephes_checksum) >&2

.PHONY: deps-verify-cephes


# Extract Cephes.
#
# This target extracts downloaded Cephes libraries.

deps-extract-cephes: $(deps_cephes_build_out)

.PHONY: deps-extract-cephes


# Test install.
#
# This target tests an installation.

deps-test-cephes: $(DEPS_CEPHES_TEST_INSTALL_OUT)
	$(QUIET) echo 'Running tests...' >&2
	$(QUIET) echo $(DEPS_CEPHES_TEST_INSTALL_OUT)
	$(QUIET) echo '' >&2
	$(QUIET) echo 'Success.' >&2

.PHONY: deps-test-cephes
