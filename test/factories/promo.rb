Factory.define(:promo) do |p|
  p.code '123ABC'
  p.fixed_discount 5.00
  p.expires_on 1.year.from_now
end
