class TotalCreator
    @products_ids = [] 

    def self.call(cart: )
        PriceList.init()
        @products_ids=ProductIdsGetter.call(cart: cart)
        regular_price=PriceList.count(list: @products_ids)
        total_price=0
        totals=Total.create!(cart: cart)
        #if there is any possible bundle keep stacking 
        while result=self.find_best_bundle(cart: cart) do
            p "return result #{result.inspect}" 
            disc=result[:discount]
            product_ids=result[:product_ids]
            total=result[:total]

            #Get all that data from result and create bundle
            totals.bundles.create!(name: disc.name,kind: disc.kind,product_ids: product_ids,total: total)
            total_price+=total
            ServiceHelper.substract(array_1:@products_ids,array_2:product_ids)
            
        end
        #count others products at regular prices
        total_price+=PriceList.count(list: @products_ids)
        # assign all other items to 
        totals.update!(product_ids: @products_ids, regular_price: regular_price.round(2),total_price: total_price.round(2))
        
        return totals
    end


    def self.find_best_bundle(cart: )
        h_disc=nil
        h_disc_savings=0
        h_common_ids=[]
        h_total_price=0

        cart.discounts.each do |discount|
            case discount.kind 
            when "set"
                common_ids=ServiceHelper.find_commons(array_1:@products_ids ,array_2:discount.product_ids)
                # find those that could be purchased in one bundle
                if(common_ids.length>0)
                    full_price=PriceList.count(list: common_ids)
                    #count full price and compare it to discounted
                    disc_savings=full_price-discount.price

                    #if saving are bigger then stock or previous consider it to be first for bundles
                    #in case of sets add all discount products into the bundle (since we cant buy them separately)
                    if(disc_savings>h_disc_savings)
                        h_disc=discount
                        h_disc_savings=disc_savings
                        h_common_ids=discount.product_ids
                        h_total_price=discount.price
                    end


                    p "Checking"
                    p "Set #{discount.name}"
                    p "Current ids #{@products_ids}"
                    p "Common ids #{common_ids}"
                    p "full price #{full_price}"
                    p "Disc price #{discount.price}"
                    p "Savings #{disc_savings}"
                end

            when "extra"
                common_ids=ServiceHelper.find_commons(array_1:@products_ids ,array_2:discount.product_ids)
                #in case more then one product in the cart can be applied to extra
                common_ids.each do |id|
                    if(@products_ids.count(id)>=discount.count)
                        #create list of same ids so it could be counted
                        current_ids=Array.new(discount.count,id)
                        #count prices before and after adding extra 
                        disc_price=PriceList.count(list: current_ids)
                        current_ids+=[id]
                        full_price=PriceList.count(list: current_ids)
                        disc_savings=full_price-disc_price
                        
                        #in case of we dont need to buy aditional item but we still can since its free
                        #put savings to minimum so it still be considered bundle if no other better options are present
                        if(@products_ids.count(id)==discount.count)
                            disc_savings=0.001
                        end

                        #if its a bettter deal swap for new
                        if(disc_savings>h_disc_savings)
                            h_disc=discount
                            h_disc_savings=disc_savings
                            h_common_ids=current_ids
                            h_total_price=disc_price
                        end

                        p "Checking"
                        p "Extra #{discount.name}"
                        p "Current ids #{@products_ids}"
                        p "Common ids #{current_ids}"
                        p "full price #{full_price}"
                        p "Disc price #{disc_price}"
                        p "Savings #{disc_savings}"
                        
                    end
                end
            end
        end

            
            if h_disc.present?
            best_deal={ discount: h_disc,product_ids: h_common_ids,total: h_total_price}
            else  
            false 
            end
            
    end



end