Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493604E6BF8
	for <lists+linux-edac@lfdr.de>; Fri, 25 Mar 2022 02:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351790AbiCYB3p (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Mar 2022 21:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiCYB3o (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Mar 2022 21:29:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F37647;
        Thu, 24 Mar 2022 18:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6ZCL1jPXx6633ALulSBkGVeNUX9LwCaMvbdi8G/fjF0v0O9mSUJmZ8X3qFl22MvDhInotnEmrntyJH+Gclc7bakYHpjCeCol6UJQOc2mFdQkfPXQs0LPSD3Wg+OQHPGrcrnbLWpqAivgy0ioP1rQRRpxE4fNx/TdR8JpZEKNzkX31S4QzPneHKz/aDNFpbM0wXVfpjTn35KteJ4VCvi+0qJmatTA6+NTju954+WoUKTfm/5ITED8vcchpL/OvS2RzYrmnwBA82+YxamGHwhkmmQZ6l931PRFMzh4/nEReCCdEMs/LPHlN/N1wmNTa6VmYWw/WnL7NGODjq2niIhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HsHat4Zv6Z3zYYWR+e8XgrXp4k54VSovR7a1aHb8/o=;
 b=jH8mTSdwjslvZ80laf8/T0aEKI3hBAl+NQkuuF+vcx/LegKNfANGi4uXLleCXeQ6w6GpTfuyHRAXsqAuDuPiXGN8tAw0IYu1GPLZnsmTCaNcdNKmvJtqx3b3n4WNZNAC5actD7LcY2gaDfuvXiztGMrCRRusDMLypDdGvt6lpu6ewUspxNpTQgoDX8CjzkjFxgc5WiD1Irmpu9a13ZZ7UA6OAB347HA5vF6WgoDOFPolN6MKjVhCb8XMLZZpmC2hhpCfc2IDLip0F0DaOJeeEHevWjskYBYYVKb1xZm7W6D/FXF3272dlvTkO5W8xc3oe3z0KvKYsIWkVoGtxFKtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HsHat4Zv6Z3zYYWR+e8XgrXp4k54VSovR7a1aHb8/o=;
 b=pTKuiGrVuhiwexEIjQ7opx5BiBUKpCeNvG4+5UA0N077I8Js/fX17pzL5KH1mpdfZDdyzre2sTLEcbJrH523J0nvLv1lv/Obh1MR3vUsAD/eWLPnYEjAgI5mz2rAbjwkTfa8mxPGeLUv23VL9AIItbvPVmOiErk8Y66QvFghJLQ=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR0402MB3794.eurprd04.prod.outlook.com (2603:10a6:208:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 01:28:06 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 01:28:06 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver 
Thread-Topic: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver 
Thread-Index: AQHYOrogKpzqNHgd/0yorlVfqzVePKzPWaZg
Date:   Fri, 25 Mar 2022 01:28:06 +0000
Message-ID: <AS8PR04MB8404C4B5BF4E405308942AA8921A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
In-Reply-To: <20220318111742.15730-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c01ea77-b8e8-48cf-14e6-08da0dfeb6d8
x-ms-traffictypediagnostic: AM0PR0402MB3794:EE_
x-microsoft-antispam-prvs: <AM0PR0402MB3794B986522A38E8F92ECD11921A9@AM0PR0402MB3794.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uooPUPrQPE5axXNHrkYybpjor1W8Qi6+RiXn9MDvJnVtuK/wUZT0Eks4fQ+f5zuoev+PEEggXADo6hBf2l9zlwuLEU0Xid+bHde++bOkIga1+02HWuO8DrsKabpBQixtBZrUy8YKkwRbj7EUM3HOuza/Y+L1zmp2sRxzgO+52NehuuiCnWcUrF36jaJ/7ReduOihqIsQW2+PO51eD8QYskpX0CIPfVAhd1C5Fp+6SbqmnCYu4ClArHAOoC20XV6GdOsws4lwg3CAd+ojBHdjRWJy2juivpBKkIBAkGZaedyoEaG/VQn9B0yklwx9CVR1KzhfC0ympB24D1tJzbf3z6tEMgVI+7AKkNM0NpO7V2eUa7Mx7KoADcRmo+Njypz1L5KQRJPlW/kwQXVFaYzMxpwNvOReAPUrhSvb5HzxZiWX91TxyVN9CEWw47gDb90uLOK2KxwUQDjutaB89vmTDg3uBsSwgNC8D8GScrv3Izny0vLEBYv8FT1MAq84CYLrpcKn/4VvGTthPteF4QwvZwVmqTqv7NxWZFCNA4FFoqlcUL7WpMU3xg0RpPYdwidxlojI1lrqu0+bfQgY2CbYHImrL76su6ma9etkKJnDwGz6y+3shqL+xIZIyTzUWscP/Pva87M80q2xV2PV4/v3QbeT+qDblLXcEBQDskSBcArxAvHN2nQdvmdS/kfMO6jT9IgKObghz91AuxDF4AgAEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(38100700002)(122000001)(4744005)(8936002)(33656002)(53546011)(44832011)(71200400001)(508600001)(5660300002)(54906003)(110136005)(86362001)(83380400001)(4743002)(55016003)(9686003)(186003)(38070700005)(26005)(66556008)(64756008)(66446008)(7696005)(6506007)(2906002)(76116006)(66946007)(66476007)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aUtuSDRYcEZmUE5GaFAyL3FuQ1I2dDRTUkVKQld3TkRhZ2IvQ1FIT0dlRzMx?=
 =?gb2312?B?MDJuY3ZMSEZoaGFTRzh2RFdsTEtPbVBwbVN1MmJUS1BkOG1CY2toR2docnZO?=
 =?gb2312?B?Zks5SDl2Rk12bHJkT1ZpdmhONkM1cmUvQlF0a0ZtRnVobnJqQldnQS9Ud2Vw?=
 =?gb2312?B?UFVQS29XY2hRQ0UxNjIzMFRNbUt5bXhMcFBuZ0RjK2JTTkp2VHhQd3FvY3dV?=
 =?gb2312?B?V1lCdmxsZFpEb2VteFNuWmdVZXdGVEdxK2xjNEY0SldtclhrUDlZTnFRNUNE?=
 =?gb2312?B?QlVYUi9vaTZqbTVYZTdIdWw1cGlJb1RpMHZELyt1VlBqcHlhSXN2clMvRWVq?=
 =?gb2312?B?SGUrdGE5ZUtRTU9TaDdtbXQ4eDdMVzF0QWxaOTF3RHlCOE9VR3NnZHZzMHUz?=
 =?gb2312?B?NUFpaGhnTmRmUS9hd21nTitmSlRjeGZoZ3dlQXhUbGoyMmhJVVlMYUg3Zm05?=
 =?gb2312?B?L2FVMkhwdFBJdUNTZE5naWo0ajIrOVg3dVZhNFdqblZ6WjByOU1jK05tTm1q?=
 =?gb2312?B?a2tUcXl2UlBuME5Pa1o2NDlidFZxOHZCcWdQVTIyT3ZNWTRza2RYR2t5ZkMv?=
 =?gb2312?B?Qm9iNnFoRUpaL3VWZXNTMFhudEllT0NuRnBtVnFIL25YNG44cWQrYkJOS1h3?=
 =?gb2312?B?VUViVzlEUFZhdmFITVY5bGFKSnU3aHM3ZzdqalJ0R00rYi90d2N3ZWxHZi9u?=
 =?gb2312?B?bG5PVlA1VVh0Vno0Tjg2UEMzd2JKcm5taVlWNzBscEF0eXd2RnBTMjdieDF5?=
 =?gb2312?B?NWRRK0gzaThpT3pYRlVxU3I1Z1oxL2RpbGFoSjdWVEFEVEZWNElrL3ZFOG50?=
 =?gb2312?B?akdTT0d1QjFNZmsrei96WTUzZFhVb1hZRHo3VkpuY3ErSHY3R1owQk5QdktK?=
 =?gb2312?B?eUdaaXJvRE0rWlVQOTdoay90TnNMcUgrbDJjK3dFVHpYYWpwQU11WWV3ZjFv?=
 =?gb2312?B?bmZiL3R3amtLUmtUUTJJWDBHaVh5K3dtVWRSNGpqZXFpc2h0M2drbHNoTVRN?=
 =?gb2312?B?UlJETXZXUlVoRjlqRm5qL01HQ25yejJtM0tteW42MzNvd1dETUZrS3FkOHJE?=
 =?gb2312?B?Z0R2YVU5ZkV2dUZ0Vkl3Y1FwdnVFM3Q3NTY5S2hUS2FJazBkMVlPY3JXYWla?=
 =?gb2312?B?aWhUUzNVaVc0RkMvSmRqQTc1V1hEQmJzNnJBeFk0a2F4UWplOW14QjZkbFp2?=
 =?gb2312?B?ekdmYlR3MjE4RkhYOXhaeW9hM3JmVWFxMnZDV1hKTkxUU2ZJWXRSemN6dTZD?=
 =?gb2312?B?S24xdjZJM2ZMYzFRNzdLaUgxYUVBMW1yZnZKMVFDekVjSGp5TGR5RkovWWU1?=
 =?gb2312?B?YmhJKzdhYndmNHpvanBoVVNaWmxoeVhaa1YwejdUZUpEZmVUSTg1T2wxR29h?=
 =?gb2312?B?dDByQ21CazZGS3ZSRE9wZm9sYlgvb1kzVjNuUllBYXBPK2RNdDl0VXBFSFdq?=
 =?gb2312?B?eDhRRzNtZjZYS1N5Tlpac2dDejNaWm91MnpUaXdEc1AxdjVkaHRxb01XK0x1?=
 =?gb2312?B?L0pIVnA0Q2pManJOb2Y0UWVvNTVhU200YkVPQ2l3dXNSQlhzMHZiN0V2TmtW?=
 =?gb2312?B?UVBTY3diblJOSmlQN05tSGNETVlmMlNxREx2THJSQ3BMMnNOaWRHWi9WWHh5?=
 =?gb2312?B?TURQcGpnamp6d3liYXFmelhuM21HWDI2anM0Z0hwV1JJQVYrcW1sWUVoeC9m?=
 =?gb2312?B?Tk9DYVFPbnRyWGJyTVlGTjVtL0plMmcvZTdYTzE0Tk05dEQ0SUdyRlhENzgy?=
 =?gb2312?B?TGhwTkc2WXRQaHlIU1lVaS9xZHB1ZlZvRGpSNkF6eDNBWkhCN2JjZXVOQ0hx?=
 =?gb2312?B?enNPRzZlSldqS2o0QzNyK3FoNEdDd09vZXhFbGY3ZGQrYkpZNDZxSjVCN0ls?=
 =?gb2312?B?MVl6YURvd3B1S2ovTHl1WS8yc1hKb0ZRNi9keGxmOUMzanFUY2ZwLzY0Q2RP?=
 =?gb2312?Q?gGXzmZf3G4u0XeTByQgaDnJvAvL6p/OX?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c01ea77-b8e8-48cf-14e6-08da0dfeb6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 01:28:06.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sJdOuEtcOjmtxOESKIsLVyBIXhUE+N6ZDFhTGuWBOeeGlnfR6Ro6eSq9QZA7KupOzJxx2VDuM37Co2u3zNjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
aGVycnkgU3VuDQo+IFNlbnQ6IDIwMjLE6jPUwjE4yNUgMTk6MjANCj4gVG86IGJwQGFsaWVuOC5k
ZTsgbWNoZWhhYkBrZXJuZWwub3JnOyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsNCj4gdG9ueS5s
dWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsgcnJpY0BrZXJuZWwub3JnDQo+IENj
OiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDAvMl0gZml4IHNvbWUgYnVn
cyBpbiBWMy5YIFN5bm9wc3lzIEVEQUMgRERSIGRyaXZlcg0KPiANCj4gVGhlIHR3byBwYXRjaGVz
IGZpeCBzb21lIGlzc3VlcyBmb3IgVjMuWCBTeW5vcHN5cyBFREFDIEREUiBpbg0KPiBzeW5vcHN5
c19lZGFjLmMuDQo+IEZvciB0aGUgZGV0YWlscywgcGxlYXNlIGNoZWNrIHRoZSBwYXRjaCBjb21t
aXQgbG9nLiBUaGlzIGhhcyBiZWVuIHZlcmlmaWVkIG9uDQo+IGkuTVg4TVAgcGxhdGZvcm0uDQo+
IA0KPiBTaGVycnkgU3VuICgyKToNCj4gICBFREFDOiBzeW5vcHN5czogQWRkIGRpc2FibGVfaW50
ciBzdXBwb3J0IGZvciBWMy5YIFN5bm9wc3lzIEVEQUMgRERSDQo+ICAgRURBQzogc3lub3BzeXM6
IHJlLWVuYWJsZSB0aGUgaW50ZXJydXB0cyBpbiBpbnRyX2hhbmRsZXIgZm9yIFYzLlgNCj4gICAg
IFN5bm9wc3lzIEVEQUMgRERSDQo+IA0KPiAgZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYyB8
IDExICsrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gMi4xNy4xDQoNCg==
