# vars for use by utils
colon := $(empty):$(empty)
underscore := $(empty)_$(empty)

# $(call match-word,w1,w2)
# checks if w1 == w2
define match-word
$(strip \
  $(if $(or $(subst $(1),$(empty),$(2)),$(subst $(2),$(empty),$(1))),,true) \
)
endef

# $(call find-word-in-list,w,wlist)
# finds an exact match of word w in word list wlist
define find-word-in-list
$(strip \
  $(eval wl:= $(colon)$(subst $(space),$(colon),$(strip $(2)))$(colon)) \
  $(eval w:= $(colon)$(strip $(1))$(colon)) \
  $(eval m:= $(findstring $(w),$(wl))) \
  $(if $(m),$(1),) \
)
endef

# $(call match-word-in-list,w,wlist)
# does an exact match of word w in word list wlist
define match-word-in-list
$(strip \
  $(if $(strip $(1)), \
    $(call match-word,$(call find-word-in-list,$(1),$(2)),$(strip $(1))), \
  ) \
)
endef

# $(call match-prefix,p,delim,w/wlist)
# matches prefix p in wlist using delimiter delim
define match-prefix
$(strip \
  $(eval w := $(strip $(1)$(strip $(2)))) \
  $(eval text := $(patsubst $(w)%,$(1),$(3))) \
  $(if $(call match-word-in-list,$(1),$(text)),true,) \
)
endef

# Board platform utilities
# $(call is-board-platform,bp)
define is-board-platform
$(call match-word,$(1),$(TARGET_BOARD_PLATFORM))
endef

# $(call is-not-board-platform,bp)
define is-not-board-platform
$(if $(call match-word,$(1),$(TARGET_BOARD_PLATFORM)),,true)
endef

# $(call is-board-platform-in-list,bpl)
define is-board-platform-in-list
$(call match-word-in-list,$(TARGET_BOARD_PLATFORM),$(1))
endef

# SDK and Version Utilities
# $(call is-platform-sdk-version-at-least,version)
# version is a numeric SDK_VERSION
define is-platform-sdk-version-at-least
$(strip \
  $(if $(filter 1,$(shell echo "$$(( $(PLATFORM_SDK_VERSION) >= $(1) ))" )), \
    true, \
  ) \
)
endef

# $(call is-version-greater-or-equal,version_a,version_b)
# version_a >= version_b
define is-version-greater-or-equal
$(strip \
  $(eval a_major := $(word 1,$(subst ., ,$(1)))) \
  $(eval a_minor := $(word 2,$(subst ., ,$(1)))) \
  $(eval b_major := $(word 1,$(subst ., ,$(2)))) \
  $(eval b_minor := $(word 2,$(subst ., ,$(2)))) \
  $(if $(call math_gt,$(a_major),$(b_major)),true, \
    $(if $(call math_gt_or_eq,$(a_major),$(b_major)), \
      $(if $(call math_gt_or_eq,$(a_minor),$(b_minor)),true,false), \
    false)) \
)
endef

# $(call is-version-lower-or-equal,version_a,version_b)
# version_a <= version_b
define is-version-lower-or-equal
$(strip \
  $(eval a_major := $(word 1,$(subst ., ,$(1)))) \
  $(eval a_minor := $(word 2,$(subst ., ,$(1)))) \
  $(eval b_major := $(word 1,$(subst ., ,$(2)))) \
  $(eval b_minor := $(word 2,$(subst ., ,$(2)))) \
  $(if $(call math_lt,$(a_major),$(b_major)),true, \
    $(if $(call math_lt_or_eq,$(a_major),$(b_major)), \
      $(if $(call math_lt_or_eq,$(a_minor),$(b_minor)),true,false), \
    false)) \
)
endef

# Radio file integrity utility
# $(call add-radio-file-sha1-checked,path,sha1)
define add-radio-file-sha1-checked
  $(eval path := $(LOCAL_PATH)/$(1))
  $(eval sha1 := $(shell sha1sum "$(path)" | cut -d" " -f 1))
  $(if $(filter $(sha1),$(2)),
    $(call add-radio-file,$(1)),
    $(error $(path) SHA1 mismatch ($(sha1) != $(2))))
endef
