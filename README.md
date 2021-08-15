# Affordable Housing in Davidson County

NSS Group Project | All work shown here addresses Data Question 3 below on short-term rentals in Davidson County, shown on slides 9-15 of the [group presentation](https://docs.google.com/presentation/d/1HXmrIHBnbMyCL53HQRva7tJTM2jBXh1TZq0Ixmpu-50/edit#slide=id.gd7cc4578e4_1_153).

## Data Questions

An introduction to the terminology surrounding the issue of affordable housing can be found at [the website of the Mayor's Office](https://www.nashville.gov/Mayors-Office/Economic-Opportunity/Affordable-Housing-Basics.aspx). For this project, we will use the terms and definitions listed there. You can also see the Housing Nashville report contained in this repository as a pdf for further background information.

Housing is considered **affordable** for a particular family or individual if it costs equal or less than 30% of their income. For example, for a family that has an income of $60,000 annually, housing that costs $18,000 per year ($1500 per month) would be considered affordable.

**Affordable housing** is housing that is affordable (30% or less of total income) for households that earn 60% or less of Davidson County’s median household income.

**Workforce Housing** is housing that is considered affordable (30% or less of total income) for households that earn more than 60% but less than 120% of the median household income.

According to the [Barnes Fund](https://www.nashville.gov/Portals/0/SiteContent/MayorsOffice/docs/AffordableHousing/BarnesFund-AnnualReport-2020.pdf), the 2020 AMI for a family of 4 in the Nashville Metropolitan Statistical area was $82,300, while in 2017 [this AMI was $68,500](https://www.noahtn.org/ah_glossary). 

When considering the cost of home ownership, don't forget to consider property taxes. Per the [Office of the Trustee](https://www.nashville.gov/Trustee/Real-Property-Taxes.aspx), the 2020 tax rate for Urban Services District (USD) is $4.221 (per $100 of assessed value), and the rate for General Services District (GSD) is $3.788 (per $100 of assessed value). Residential property tax is based on the assessed value, which is 25% of the appraised value.

Using the data available to you in the database (download it [here](https://drive.google.com/file/d/1alzdC5UP6UhPJJRFaEs36pAouSaNGp92/view?usp=sharing)) as well as the starter data [here](https://drive.google.com/file/d/1Dck-_JqzwT446PtbcTEXiRE0t49hGXaT/view?usp=sharing), answer the following questions: 

1. Which areas of Davidson County have seen the most rapid increase in home prices? Which ones are losing affordable housing? You can choose different ways to slice the data - by council district or by zipcode, for example.

2. Affordable housing can disappear in a number of ways. It can occur from existing home prices increasing, but can also occur when older, affordable housing is demolished and replaced with more expensive housing. What areas have seen a large number of instances of this?

3. Another factor that can drive up housing costs is houses being used as short-term rental properties. (See [this article](https://harvardlpr.com/wp-content/uploads/sites/20/2016/02/10.1_10_Lee.pdf) published in Harvard Law & Policy Review.) Which areas of town has seen a large number of short-term rental permits? Have these areas also seen an increase in home prices?

4. Consider the text of the `purpose` column of the permit table. Can you find any differences in the types of text that are contained in this field for areas which are rapidly losing affordable housing versus those that are not? 

5. Can you predict when the value of a home will increase based on the text of the permits associated with a house (along with any other factors that you think might be important)? What words tend to be associated with an increase in home price?

Tips for working with the database:
* Join using the `apn` column. This column shows the assessor's parcel number. You can also join using parid/pin/pid.
* The most recent (2021) appraisal values are contained in the `property_updated` table. For most houses, the second most recent (2017) values are contained in the `property` table. All older appraisal values are contained in the `assessment` table.
* The actual sales price of a home is contained in the `saleprice` column of the `property` table. Note though, that there are a number of circumstances that would result in a sale price of zero, such as someone inheriting a house. You can get the full ownership history of a property from the `owner` table.
* The assessment table contains both appraisal and assessment values for each property. The appraisal value represents the market value of a property at the time of the appraisal. This is determined by [the Assessor's Office](https://www.padctn.org/), so does not necessarily match up with the sales price of a home if it were to sell.