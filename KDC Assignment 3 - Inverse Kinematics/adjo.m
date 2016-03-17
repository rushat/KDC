function ad = adjo(FK)
    R = FK(1:3,1:3);
    p = FK(1:3,4);
    p_cap = cap(p);
    
    ad = [R p_cap*R;
          zeros(3) R];
end