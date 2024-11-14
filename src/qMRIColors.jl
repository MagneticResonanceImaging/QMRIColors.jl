module qMRIColors

export relaxationColorMap, colorLogRemap, read_map_csv
using Colors
using DelimitedFiles
"""
    relaxationColorMap(maptype::AbstractString, x::AbstractArray, loLev=minimum(x), upLev=maximum(x))

Applies a color mapping to a numerical array `x` based on a specified relaxation map type. Reads color data from a CSV file and adjusts values in `x` to provide a color-coded visualization.

This function is commonly used in data visualization, especially for MRI relaxation maps, to display data in a color-coded format for easier interpretation.

# Arguments
- `maptype::AbstractString`: The relaxation map type to use for color mapping. Common values include `"T1"`, `"T2"`, `"R1"`, `"R2"`, etc.
- `x::AbstractArray`: An array of numerical values to be color-mapped.
- `loLev`: Lower bound for color mapping. Defaults to the minimum of `x`.
- `upLev`: Upper bound for color mapping. Defaults to the maximum of `x`.

# Returns
- `rgb_vec`: A vector of RGB colors representing the mapped values.
- `xClip`: A modified version of `x` with values adjusted based on `loLev` and `upLev`.


# Description
1. Calls `read_map_csv(maptype)` to load the colormap.
2. Adjusts `x` based on `loLev` and `upLev` to produce `xClip`.
3. Maps values to colors using `colorLogRemap` and converts to RGB.

"""
function relaxationColorMap(maptype::AbstractString, x::AbstractArray, loLev=minimum(x), upLev=maximum(x))

  colortable = read_map_csv(maptype)

  # modification of the image to be displayed; this is needed because with e.g. a loLev of 100,
  #    the values of 1 ... 99 have to be displayed differently than 0 ("invalid")
  eps = (upLev-loLev)/size(colortable)[1]
  xClip = map(x) do p
      (p < eps) ? loLev-eps : ((p < loLev+eps) ? loLev+1.5*eps : p)  # the 1.5 anticipates a "floor" in the viewing pipeline
  end   
  if (loLev < 0)
      xClip = map(x) do p
          (p < eps) ? loLev-eps : p
      end 
  end        

  lutCmap = colorLogRemap(colortable,loLev,upLev)
  rgb_vec = map(rgb -> Colors.RGB(rgb...), eachrow(lutCmap))
  return rgb_vec, xClip
end

"""
    relaxationColorMap(maptype::AbstractString, loLev=0, upLev=256)

Simplified variant of the above function. Only generates the RGB vector of colors without modifying an array `x`.
"""
function relaxationColorMap(maptype::AbstractString, loLev=0, upLev=256)
  colortable = read_map_csv(maptype)

  lutCmap = colorLogRemap(colortable,loLev,upLev)
  rgb_vec = map(rgb -> Colors.RGB(rgb...), eachrow(lutCmap))
  return rgb_vec
end


function read_map_csv(maptype::AbstractString)
  fn = @__DIR__
  Maptype = uppercasefirst(maptype)
  if (Maptype in ["T1","R1"])
      fn = fn*"/lipari.csv"
  elseif (Maptype in ["T2","T2*","R2","R2*","T1rho","T1ρ","R1rho","R1ρ"])
      fn = fn*"/navia.csv"
  else
      fn = fn*"/"*maptype*".csv"
  end
  colortable = readdlm(fn, ' ', '\n')

  if Maptype[1]=='R'
      colortable = reverse(colortable,dims=1)
  end

  colortable[1,:] .= 0.0;

  return colortable
end

"""
    colorLogRemap(oriCmap, loLev=0.0, upLev=size(cmap)[1])

Applies logarithmic scaling to `oriCmap` based on `loLev` and `upLev`.

# Arguments
- `oriCmap`: Original colormap array.
- `loLev`: Lower bound of the color range.
- `upLev`: Upper bound of the color range.

# Returns
- `logCmap`: Colormap with logarithmic scaling applied.

"""
function colorLogRemap(oriCmap, loLev=0.0, upLev=size(cmap)[1])
  @assert (upLev>0) "upper level must be positive"
  @assert (upLev>loLev) "upper level must be larger than lower level"
  logCmap = similar(oriCmap)
  mapLength = size(oriCmap)[1]
  eInv = exp(-1.0)
  aVal = eInv*upLev
  mVal = max(aVal,loLev)
  bVal = (aVal < loLev) ? (1.0 / mapLength) : (aVal-loLev)/(2*aVal-loLev)+(1.0 / mapLength)
  bVal += 0.0000001   # This is to ensure that after some math, we get a figure that rounds to 1 ("darkest valid color")
                      # rather than to 0 (invalid color). Note that bVal has no units, so 1E-7 is always a small number
  logCmap[1,:] = oriCmap[1,:] # the 'invalid' color
  logPortion = 1.0/(log(mVal)-log(upLev))

  for g in 2:mapLength
      f = 0.0
      x = g*(upLev-loLev)/mapLength+loLev
      if x > mVal
          # logarithmic segment of the curve
          f = mapLength*((log(mVal)-log(x))*logPortion*(1-bVal)+bVal)
      else
          if (loLev < aVal)&&(x>loLev)
              # linear segment of the curve
              f = mapLength*((x-loLev)/(aVal-loLev)*(bVal-(1.0 / mapLength)))+1.0
          end
          if (x<=loLev) 
              # lowest valid color
              f = 1.0
          end
      end
      # lookup from original color map
      logCmap[g,:] = oriCmap[min(mapLength,1+floor(Int64,f)),:]
  end
  return logCmap
end
end
