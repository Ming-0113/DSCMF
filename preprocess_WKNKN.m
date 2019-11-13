function Y=preprocess_WKNKN(Y,Sd,St,K,eta)

   
    eta = eta .^ (0:K-1);

    y2_new1 = zeros(size(Y));
    y2_new2 = zeros(size(Y));

    empty_rows = find(any(Y,2) == 0);   % get indices of empty rows
    empty_cols = find(any(Y)   == 0);   % get indices of empty columns

   
    for i=1:length(Sd)
        drug_sim = Sd(i,:); 
        drug_sim(i) = 0;    
        indices  = 1:length(Sd);    
        drug_sim(empty_rows) = []; 
        indices(empty_rows) = [];  

        [~,indx] = sort(drug_sim,'descend');    % sort descendingly
        indx = indx(1:K);       % keep only similarities of K nearest neighbors
        indx = indices(indx);   % and their indices

        drug_sim = Sd(i,:);
        y2_new1(i,:) = (eta .* drug_sim(indx)) * Y(indx,:) ./ sum(drug_sim(indx));
    end

    for j=1:length(St)
        target_sim = St(j,:); 
        target_sim(j) = 0;    

        indices  = 1:length(St);       
        target_sim(empty_cols) = [];    
        indices(empty_cols) = [];      

        [~,indx] = sort(target_sim,'descend');  % sort descendingly
        indx = indx(1:K);       % keep only similarities of K nearest neighbors
        indx = indices(indx);   % and their indices

        target_sim = St(j,:);
        y2_new2(:,j) = Y(:,indx) * (eta .* target_sim(indx))' ./ sum(target_sim(indx));
    end

    Y = max(Y,(y2_new1 + y2_new2)/2);

end