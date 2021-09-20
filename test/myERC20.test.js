const { expect } = require("chai");
const { assert } = require("console");

const MyERC20 = artifacts.require('MyERC20');

describe('test myERC20', ()=>{
    it('shoud deploy smart contract properly', async ()=>{
        const smartContract = await MyERC20.deployed();
        console.log("sc",smartContract.address);
        assert(smartContract.address !== undefined);
        expect(smartContract.address).not.equal("");
        

    })
})