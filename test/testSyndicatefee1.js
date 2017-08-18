var SyndicateFee1 = artifacts.require("./SyndicateFee1.sol");


contract('SyndicateFee1', function (accounts) {

    it("should return undefined when Agent bank share details is not available", function() {
        return SyndicateFee1.deployed().then(function (instance) {
            SF = instance;
            return SF.getAllocation.call()[0];
        }).then(function (fin_count) {
            assert.equal(fin_count,undefined, "test failed: details available")
        });
    });
        it("should return undefined when P1 bank share details is not available", function() {
        return SyndicateFee1.deployed().then(function (instance) {
            SF = instance;
            return SF.getAllocation.call()[1];
        }).then(function (fin_count) {
            assert.equal(fin_count,undefined, "test failed: details available")
        });
    });
        it("should return undefined when P2 bank share details is not available", function() {
        return SyndicateFee1.deployed().then(function (instance) {
            SF = instance;
            return SF.getAllocation.call()[2];
        }).then(function (fin_count) {
            assert.equal(fin_count,undefined, "test failed: details available")
        });
    });
            it("should return undefined when P3 bank share details is not available", function() {
        return SyndicateFee1.deployed().then(function (instance) {
            SF = instance;
            return SF.getAllocation.call()[3];
        }).then(function (fin_count) {
            assert.equal(fin_count,undefined, "test failed: details available")
        });
    });

    it("should return true when amount is passed", function() {
        return SyndicateFee1.deployed().then(function (instance) {
            return instance.allocation.call(10000);
        }).then(function (currentSessionFee) {
            assert.equal(currentSessionFee, true, "test failed: details available");
        });
    });

    it("should return true when details are available", function() {

        return SyndicateFee1.deployed().then(function (instance) {
            var alloc = instance;
            alloc.allocation(10000);
            return alloc.getAllocation();
        }).then(function (count) {
            if (count != 0) {
                return true;
            }
            else {
                return false;
            }
        }).then(function (fin_count) {
            assert.equal(fin_count, true, "test failed: details not available");
        })
    })
})