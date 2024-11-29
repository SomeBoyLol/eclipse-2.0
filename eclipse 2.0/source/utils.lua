function math.round(num, multiple)
    multiple = multiple or 1
    return math.floor((num / multiple) + 0.5) * multiple
end