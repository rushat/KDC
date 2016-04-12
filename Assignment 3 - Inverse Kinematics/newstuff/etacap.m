function et_c = etacap(eta)
    om_cap = cap(eta(4:6));
    v = eta(1:3);
    et_c = [om_cap v;
            0 0 0 0];
end