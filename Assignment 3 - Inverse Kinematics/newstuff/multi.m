function q_dot = multi(Jac_q,K_e)
%#codegen
q_dot = zeros(7,1);
q_dot = Jac_q'*K_e;

end