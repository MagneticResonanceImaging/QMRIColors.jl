# qMRI colormaps

```@example 1
using QMRIColors
using CairoMakie
```

## Lipari

This colormap is used for :
- T1

```@example 1
rgb_vec = relaxationColorMap("T1")
cgrad(rgb_vec)
```

## Navia

This colormap is used for :
- T2
- T2*
- T1rho
- T1ρ

```@example 1
rgb_vec = relaxationColorMap("T2")
cgrad(rgb_vec)
```

## Reverse lipari

This colormap is used for :
- R1

```@example 1
rgb_vec = relaxationColorMap("R1")
cgrad(rgb_vec)
```


## Reverse navia

This colormap is used for :
- R2
- R2*
- R1rho
- R1ρ
- 
```@example 1
rgb_vec = relaxationColorMap("R2")
cgrad(rgb_vec)
```