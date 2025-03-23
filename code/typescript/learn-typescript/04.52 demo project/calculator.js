"use strict";
//data:
// initial amount
// annual contribution
// expected return rate
// duration
//                           the inputs for this function | what the function outputs
function calculateInvestment(data) {
    const { initialAmount, annualContribution, expectedReturn, duration } = data;
    if (initialAmount < 0) {
        return "Initial investment amount must be at least zero";
    }
    if (duration <= 0) {
        return "No valid amount of years provided.";
    }
    if (expectedReturn < 0) {
        return "Expected return must be at least zero";
    }
    // define the initial values. we use let because the values will change
    let total = initialAmount;
    let totalContributions = 0;
    let totalInterestEarned = 0;
    // create an array of InvestmentResult objects
    const annualResults = [];
    for (let i = 0; i < duration; i++) {
        total = total * (1 + expectedReturn); // calculate the percentage of the total amount
        totalInterestEarned = total - totalContributions - initialAmount;
        totalContributions = totalContributions + annualContribution;
        total = total + annualContribution;
        annualResults.push({
            year: `Year ${i + 1}`,
            totalAmount: total,
            totalInterestEarned, // or totalInterestEarned: totalInterestEarned, because the variable name is the same as the key
            totalContributions, // or totalContributions: totalContributions, because the variable name is the same as the key
        });
    }
    return annualResults;
}
function printResults(results) {
    if (typeof results === "string") {
        console.log(results);
        return; // return to stop the function because we dont want to print anything else
    }
    for (const yearEndResult of results) {
        console.log(yearEndResult.year);
        console.log(`Total amount: ${yearEndResult.totalAmount.toFixed(0)}`);
        console.log(`Total Contributions: ${yearEndResult.totalContributions.toFixed(0)}`);
        console.log(`Total Interest Earned: ${yearEndResult.totalInterestEarned.toFixed(0)}`);
        console.log("--------------------");
    }
}
// creates an object value data of type InvestmentData
const investmentData = {
    initialAmount: 0,
    annualContribution: 1200,
    expectedReturn: 0.5, // 5% of interest
    duration: 30
};
const results = calculateInvestment(investmentData);
printResults(results);
