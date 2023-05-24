// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.17;

import "../TestBaseForward.sol";

contract StargateTest is TestBaseForward {
    function setUp() public override {
        // Calldata from https://li.quest/v1/quote
        //               ?fromChain=ETH
        //               &fromAmount=10000000
        //               &fromToken=USDT
        //               &toChain=POL
        //               &toToken=DAI
        //               &slippage=0.03
        //               &allowBridges=stargate
        //               &fromAddress=0xf0ad40Df0AD40DF0Ad40DF0Ad40df0Ad40df0Ad4
        DATA_WITH_NON_NATIVE_ASSET = hex"d7556c1e0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000022000000000000000000000000000000000000000000000000000000000000004c06bab138a6d20bfddd2bfd1ce4cb1c5cf890b3b976fcf110f9a81892119bba7f10000000000000000000000000000000000000000000000000000000000000140000000000000000000000000000000000000000000000000000000000000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006b175474e89094c44da98b954eedeac495271d0f000000000000000000000000f0ad40df0ad40df0ad40df0ad40df0ad40df0ad4000000000000000000000000000000000000000000000000899e8e09ee87263e0000000000000000000000000000000000000000000000000000000000000089000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008737461726761746500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000086c6966692d61706900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000020000000000000000000000000d9e1ce17f2641f24ae83637ab66a2cca9c378b9f000000000000000000000000d9e1ce17f2641f24ae83637ab66a2cca9c378b9f000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec70000000000000000000000006b175474e89094c44da98b954eedeac495271d0f000000000000000000000000000000000000000000000000000000000098968000000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000014438ed17390000000000000000000000000000000000000000000000000000000000989680000000000000000000000000000000000000000000000000899e8e09ee87263e00000000000000000000000000000000000000000000000000000000000000a00000000000000000000000001231deb6f5749ef6ce6943a275a1d3e7486f4eae00000000000000000000000000000000000000000000000000000000646c994a0000000000000000000000000000000000000000000000000000000000000004000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec70000000000000000000000006b3595068778dd592e39a122f4f5a5cf09c90fe2000000000000000000000000c02aaa39b223fe8d0a0e5c4f27ead9083c756cc20000000000000000000000006b175474e89094c44da98b954eedeac495271d0f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000858b85cd18e0cd9300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001d4f4a75308e2000000000000000000000000f0ad40df0ad40df0ad40df0ad40df0ad40df0ad400000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000001200000000000000000000000000000000000000000000000000000000000000014f0ad40df0ad40df0ad40df0ad40df0ad40df0ad40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

        super.setUp();
    }

    function test_forward_success_withNonNativeAsset() public override {
        StargateData memory stargateData = forwardContract.extractStargateData(
            DATA_WITH_NON_NATIVE_ASSET
        );

        _forward(false, stargateData.lzFee);
    }

    function test_forward_fail_withNativeAsset_whenMsgValueIsLow()
        public
        override
    {
        // This bridge doesn't support native asset.
    }

    function test_forward_success_withNativeAsset() public override {
        // This bridge doesn't support native asset.
    }

    function test_extractBridgeData_success_withNonNativeAsset() public {
        BridgeData memory bridgeData = forwardContract.extractBridgeData(
            DATA_WITH_NON_NATIVE_ASSET
        );

        assertEq(bridgeData.bridge, "stargate");
        assertEq(bridgeData.integrator, "lifi-api");
        assertEq(bridgeData.sendingToken, DAI);
        assertEq(bridgeData.receiver, RECEIVER);
        assertEq(bridgeData.destinationChainId, 137);
        assertTrue(bridgeData.hasSourceSwaps);
        assertFalse(bridgeData.hasDestinationCall);
    }

    function test_extractStargateData_success_withNonNativeAsset() public {
        StargateData memory stargateData = forwardContract.extractStargateData(
            DATA_WITH_NON_NATIVE_ASSET
        );

        assertEq(stargateData.dstPoolId, 3);
        assertEq(stargateData.dstGasForCall, 0);
        assertEq(stargateData.refundAddress, RECEIVER);
        assertEq(
            stargateData.callTo,
            hex"f0ad40Df0AD40DF0Ad40DF0Ad40df0Ad40df0Ad4"
        );
        assertEq(stargateData.callData, "");
    }
}
