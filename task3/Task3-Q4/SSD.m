function ssd = SSD(vec1,vec2)
    ssd = sum((vec1 -vec2).^2);    
end