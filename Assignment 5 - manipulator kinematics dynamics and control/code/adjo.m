function ad = adjo(F_K)
    R = F_K(1:3,1:3);
    p = F_K(1:3,4);
    p_cap = cap(p);
    
    ad = [R p_cap*R;
          zeros(3) R];
end