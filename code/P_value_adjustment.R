pvals= c(1.57E-16,
         8.06E-05,
         3.81E-03,
         
         2.46E-06,
         0.221382,
         0.00023,
         
         0.00132,
         0.006574,
         0.484927,
         0.043908
)
pvals
plot(pvals)
abline(h = 0.05)


p.adjust(pvals, method = "fdr")
points(p.adjust(pvals, method = "fdr"), col = 'red')


points(p.adjust(pvals, method = "bonferroni"), col = 'blue')
