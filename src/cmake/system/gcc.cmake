SET(compiler_flags_global -pipe;-Wall;-fmessage-length=0;-fno-strict-aliasing;-fvisibility=hidden;-fdiagnostics-color=always)

# debug: explicit -Og -D_DEBUG, implicit -g
SET(compiler_flags_debug ${compiler_flags_global};-Og;-D_DEBUG)
# relwithdebinfo: implicit -O2 -g -DNDEBUG
SET(compiler_flags_relwithdebinfo ${compiler_flags_global})

IF(NOT APPLE)
    IF(ETE_X64)
        SET(compiler_flags_release ${compiler_flags_global};-Winline;-ffast-math;-fomit-frame-pointer;-finline-functions;-fschedule-insns2)
    ELSEIF(ETE_X86)
        SET(compiler_flags_release ${compiler_flags_global};-march=i686;-Winline;-ffast-math;-fomit-frame-pointer;-finline-functions;-fschedule-insns2)
    ELSE()
        SET(compiler_flags_release ${compiler_flags_global})
    ENDIF()
ENDIF()