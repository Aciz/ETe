#!/bin/bash

bh="$(dirname "$0")/bin2hex"
cl=/usr/bin/glslangValidator
tmpf="$(dirname "$0")/spirv/data.spv"
outf="+spirv/shader_data.c"

mkdir -p "$(dirname "$0")/spirv"

rm -f "$(dirname "$0")/spirv/shader_data.c"
rm -f "$tmpf"

# Compile individual shaders
for f in *.vert; do
    "$cl" -S vert -V -o "$tmpf" "$f"
    "$bh" "$tmpf" "$outf" "${f%.*}_vert_spv"
    rm -f "$tmpf"
done

for f in *.frag; do
    "$cl" -S frag -V -o "$tmpf" "$f"
    "$bh" "$tmpf" "$outf" "${f%.*}_frag_spv"
    rm -f "$tmpf"
done

# compile lighting shader variations from templates

"$cl" -S vert -V -o "$tmpf" light_vert.tmpl
"$bh" "$tmpf" "$outf" vert_light

"$cl" -S vert -V -o "$tmpf" light_vert.tmpl -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_light_fog

"$cl" -S frag -V -o "$tmpf" light_frag.tmpl
"$bh" "$tmpf" "$outf" frag_light

"$cl" -S frag -V -o "$tmpf" light_frag.tmpl -DUSE_FOG 
"$bh" "$tmpf" "$outf" frag_light_fog

"$cl" -S frag -V -o "$tmpf" light_frag.tmpl -DUSE_LINE
"$bh" "$tmpf" "$outf" frag_light_line

"$cl" -S frag -V -o "$tmpf" light_frag.tmpl -DUSE_LINE -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_light_line_fog

# compile generic shader variations from templates

# single-texture vertex

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl
"$bh" "$tmpf" "$outf" vert_tx0

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx0_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx0_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FOG -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx0_env_fog

# single-texture vertex, identity (1.0) colors 

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CLX_IDENT
"$bh" "$tmpf" "$outf" vert_tx0_ident1

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CLX_IDENT -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx0_ident1_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CLX_IDENT -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx0_ident1_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CLX_IDENT -DUSE_FOG -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx0_ident1_env_fog

# single-texture vertex with fixed (rgb+a) colors

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FIXED_COLOR
"$bh" "$tmpf" "$outf" vert_tx0_fixed

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FIXED_COLOR -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx0_fixed_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FIXED_COLOR -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx0_fixed_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FIXED_COLOR -DUSE_FOG -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx0_fixed_env_fog

# double-texture vertex

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_TX1
"$bh" "$tmpf" "$outf" vert_tx1

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_TX1 -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx1_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_TX1 -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx1_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_TX1 -DUSE_FOG -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx1_env_fog

# double-texture vertex, identity (1.0) colors 

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CLX_IDENT -DUSE_TX1
"$bh" "$tmpf" "$outf" vert_tx1_ident1

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CLX_IDENT -DUSE_TX1 -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx1_ident1_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CLX_IDENT -DUSE_TX1 -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx1_ident1_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CLX_IDENT -DUSE_TX1 -DUSE_FOG -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx1_ident1_env_fog

# double-texture vertex, fixed (rgb+a) colors 

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FIXED_COLOR -DUSE_TX1
"$bh" "$tmpf" "$outf" vert_tx1_fixed

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FIXED_COLOR -DUSE_TX1 -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx1_fixed_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FIXED_COLOR -DUSE_TX1 -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx1_fixed_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_FIXED_COLOR -DUSE_TX1 -DUSE_FOG -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx1_fixed_env_fog

# double-texture vertex, non-identical colors

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CL1 -DUSE_TX1
"$bh" "$tmpf" "$outf" vert_tx1_cl

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CL1 -DUSE_TX1 -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx1_cl_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CL1 -DUSE_TX1 -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx1_cl_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CL1 -DUSE_TX1 -DUSE_ENV -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx1_cl_env_fog

# triple-texture vertex

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_TX2
"$bh" "$tmpf" "$outf" vert_tx2

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_TX2 -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx2_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_TX2 -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx2_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_TX2 -DUSE_ENV -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx2_env_fog

# triple-texture vertex, non-identical colors

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CL2 -DUSE_TX2
"$bh" "$tmpf" "$outf" vert_tx2_cl

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CL2 -DUSE_TX2 -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx2_cl_fog

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CL2 -DUSE_TX2 -DUSE_ENV
"$bh" "$tmpf" "$outf" vert_tx2_cl_env

"$cl" -S vert -V -o "$tmpf" gen_vert.tmpl -DUSE_CL2 -DUSE_TX2 -DUSE_ENV -DUSE_FOG
"$bh" "$tmpf" "$outf" vert_tx2_cl_env_fog

# single-texture fragment, generic

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_ATEST
"$bh" "$tmpf" "$outf" frag_tx0

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_ATEST -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx0_fog

# single-texture fragment, identity (1.0) color

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CLX_IDENT -DUSE_ATEST
"$bh" "$tmpf" "$outf" frag_tx0_ident1

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CLX_IDENT -DUSE_ATEST -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx0_ident1_fog

# single-texture fragment, fixed (rgb+a) color

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_FIXED_COLOR -DUSE_ATEST
"$bh" "$tmpf" "$outf" frag_tx0_fixed

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_FIXED_COLOR -DUSE_ATEST -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx0_fixed_fog

# single-texture fragment, entity color

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_ENT_COLOR -DUSE_ATEST
"$bh" "$tmpf" "$outf" frag_tx0_ent

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_ENT_COLOR -DUSE_ATEST -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx0_ent_fog

# single-texture fragment, depth-fragment

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CLX_IDENT -DUSE_ATEST -DUSE_DF
"$bh" "$tmpf" "$outf" frag_tx0_df

# double-texture fragment

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_TX1
"$bh" "$tmpf" "$outf" frag_tx1

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_TX1 -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx1_fog

# double-texture fragment, identity colors (1.0)

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CLX_IDENT -DUSE_TX1
"$bh" "$tmpf" "$outf" frag_tx1_ident1

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CLX_IDENT -DUSE_TX1 -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx1_ident1_fog

# double-texture fragment, fixed (rgb+a) colors

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_FIXED_COLOR -DUSE_TX1
"$bh" "$tmpf" "$outf" frag_tx1_fixed

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_FIXED_COLOR -DUSE_TX1 -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx1_fixed_fog

# double-texture fragment, entity colors

# "$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_ENT_COLOR -DUSE_TX1
# "$bh" "$tmpf" "$outf" frag_tx1_ent

# "$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_ENT_COLOR -DUSE_TX1 -DUSE_FOG
# "$bh" "$tmpf" "$outf" frag_tx1_ent_fog

# double-texture fragment, non-identical colors

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CL1 -DUSE_TX1
"$bh" "$tmpf" "$outf" frag_tx1_cl

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CL1 -DUSE_TX1 -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx1_cl_fog

# triple-texture fragment

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_TX2
"$bh" "$tmpf" "$outf" frag_tx2

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_TX2 -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx2_fog

# triple-texture fragment, non-identical colors

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CL2 -DUSE_TX2
"$bh" "$tmpf" "$outf" frag_tx2_cl

"$cl" -S frag -V -o "$tmpf" gen_frag.tmpl -DUSE_CL2 -DUSE_TX2 -DUSE_FOG
"$bh" "$tmpf" "$outf" frag_tx2_cl_fog

rm -f "$tmpf"
