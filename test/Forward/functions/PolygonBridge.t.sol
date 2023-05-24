// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.17;

import "../TestBaseForward.sol";

contract PolygonBridgeTest is TestBaseForward {
    function setUp() public override {
        // Calldata from https://li.quest/v1/quote
        //               ?fromChain=ETH
        //               &fromAmount=10000000
        //               &fromToken=USDT
        //               &toChain=POL
        //               &toToken=DAI
        //               &slippage=0.03
        //               &allowBridges=polygon
        //               &fromAddress=0xf0ad40Df0AD40DF0Ad40DF0Ad40df0Ad40df0Ad4
        DATA_WITH_NON_NATIVE_ASSET = hex"b4f37581000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000002003a0e1e40c42f6e82278b3e86b1cfe4de51a39172521976a8043db8b604a1e5240000000000000000000000000000000000000000000000000000000000000140000000000000000000000000000000000000000000000000000000000000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006b175474e89094c44da98b954eedeac495271d0f000000000000000000000000f0ad40df0ad40df0ad40df0ad40df0ad40df0ad4000000000000000000000000000000000000000000000000871861fad9c2a8c00000000000000000000000000000000000000000000000000000000000000089000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007706f6c79676f6e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000086c6966692d61706900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000020000000000000000000000000d9e1ce17f2641f24ae83637ab66a2cca9c378b9f000000000000000000000000d9e1ce17f2641f24ae83637ab66a2cca9c378b9f000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec70000000000000000000000006b175474e89094c44da98b954eedeac495271d0f000000000000000000000000000000000000000000000000000000000098968000000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000014438ed17390000000000000000000000000000000000000000000000000000000000989680000000000000000000000000000000000000000000000000871861fad9c2a8c000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000001231deb6f5749ef6ce6943a275a1d3e7486f4eae00000000000000000000000000000000000000000000000000000000646445b40000000000000000000000000000000000000000000000000000000000000004000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec70000000000000000000000006b3595068778dd592e39a122f4f5a5cf09c90fe2000000000000000000000000c02aaa39b223fe8d0a0e5c4f27ead9083c756cc20000000000000000000000006b175474e89094c44da98b954eedeac495271d0f00000000000000000000000000000000000000000000000000000000";
        // Calldata from https://li.quest/v1/quote
        //               ?fromChain=ETH
        //               &fromAmount=1000000000000000000
        //               &fromToken=ETH
        //               &toChain=POL
        //               &toToken=DAI
        //               &slippage=0.03
        //               &allowBridges=polygon
        //               &fromAddress=0xf0ad40Df0AD40DF0Ad40DF0Ad40df0Ad40df0Ad4
        DATA_WITH_NATIVE_ASSET = hex"b4f37581000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000002005f73a5aaa0b1c1fa339114963e33e3ae365f3ceb5d26d2457990023b1c55d17d0000000000000000000000000000000000000000000000000000000000000140000000000000000000000000000000000000000000000000000000000000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006b175474e89094c44da98b954eedeac495271d0f000000000000000000000000f0ad40df0ad40df0ad40df0ad40df0ad40df0ad400000000000000000000000000000000000000000000006021174b2d390a6c300000000000000000000000000000000000000000000000000000000000000089000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007706f6c79676f6e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000086c6966692d61706900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000020000000000000000000000000def1c0ded9bec7f1a1670819833240f027b25eff000000000000000000000000def1c0ded9bec7f1a1670819833240f027b25eff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000006b175474e89094c44da98b954eedeac495271d0f0000000000000000000000000000000000000000000000000de0b6b3a764000000000000000000000000000000000000000000000000000000000000000000e0000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000001283598d8ab000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000006021174b2d390a6c3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000042c02aaa39b223fe8d0a0e5c4f27ead9083c756cc20001f4dac17f958d2ee523a2206206994597c13d831ec70000646b175474e89094c44da98b954eedeac495271d0f000000000000000000000000000000000000000000000000000000000000869584cd00000000000000000000000026c16b6926637cf5eb62c42991b4166add66ff9e00000000000000000000000000000000000000000000006b6695494964643b50000000000000000000000000000000000000000000000000";

        super.setUp();
    }

    function test_forward_fail_withNonNativeAsset_whenNoEnoughFee()
        public
        override
    {
        // This bridge doesn't require native fee.
    }

    function test_extractBridgeData_success_withNonNativeAsset() public {
        BridgeData memory bridgeData = forwardContract.extractBridgeData(
            DATA_WITH_NON_NATIVE_ASSET
        );

        assertEq(bridgeData.bridge, "polygon");
        assertEq(bridgeData.integrator, "lifi-api");
        assertEq(bridgeData.sendingToken, DAI);
        assertEq(bridgeData.receiver, RECEIVER);
        assertEq(bridgeData.destinationChainId, 137);
        assertTrue(bridgeData.hasSourceSwaps);
        assertFalse(bridgeData.hasDestinationCall);
    }

    function test_extractBridgeData_success_withNativeAsset() public {
        BridgeData memory bridgeData = forwardContract.extractBridgeData(
            DATA_WITH_NATIVE_ASSET
        );

        assertEq(bridgeData.bridge, "polygon");
        assertEq(bridgeData.integrator, "lifi-api");
        assertEq(bridgeData.sendingToken, DAI);
        assertEq(bridgeData.receiver, RECEIVER);
        assertEq(bridgeData.destinationChainId, 137);
        assertTrue(bridgeData.hasSourceSwaps);
        assertFalse(bridgeData.hasDestinationCall);
    }
}
