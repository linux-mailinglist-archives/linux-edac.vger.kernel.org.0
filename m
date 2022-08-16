Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBB595BFC
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 14:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiHPMne (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 08:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiHPMnb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 08:43:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D4710FE;
        Tue, 16 Aug 2022 05:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBCbPBhibBSAg8fIFz/fteTYbn+sJM+ajRGubSJLHN87SrXoFc3Y+svyxsT3XYc6/xQyxHi9ly75MZEfv3vqZ8wBQatAtLVcdab+bAlxYzMRv3FMeJMMgHPthEksNH+SlFwKXe4vncBxqeSP3Yv3lPe/8wgoUrphETrfJ+XVEUR5J5n1Fxpy873sqifPuTZBM/n930U/nk9QiT5zxEDpUarVI+iq5/73ZtrPzRVuSZmZfksDhJkQO0muawQaDuQJksPw+81JB9xVAMmBKZhrYB9an99Sa2nLmbBnw4NkFab0JhxgxxgBjzac3oS//nH2pG9SB1vLXFa0nMUiD6WvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TCD2ZrKOFwN7T39W7iswyQuf4UNB1gSNSGSLx8HyQ8=;
 b=d8sb2UvBl4FqZrAXTi+MWwodSUoL1FTytNra3xN9+wBxN+WRyHx99nZ9JHkf/4zzNDquM/cQ/G5yHoaumB3O5zenRy7mHnOXNfpE3m4R0WWBmycRU4R3dGv0iFtf7hdsJxjCJYuvkfdMjXovIBB3kSpUPuDTYFytBtmg2o43vL8gN35JiHTVpp0X5T8VYhBayzZLcAU1F3gjIerFHcLtZtQIE7sY6eB0ylX4CbDkG+lyLgZ7P1CZKPQtRTBBidCV92S8WEfy6T1G2KTo4PJ9M+tetzJixnnqzrT9OveGnTV7KcCCUqJK3//G5QUNQvDVBVH4jiifLytxMtRjNjLzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TCD2ZrKOFwN7T39W7iswyQuf4UNB1gSNSGSLx8HyQ8=;
 b=Jtj3Mrs1fKxcrILi+X2q9BWKOjq892Hbkp4xUNQlplu3XKdhwgWai34szX1b9ATQBXBQW4tlsFU/lt9HP3PQsEGoJeuRUx4rinuEXpTn/97KjmtetOoILJzkB+fhKB1Ku/jnXpFSwBSBCtLxdN/21gaLes8ks+t5+5qycS+12NU=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by BN7PR12MB2721.namprd12.prod.outlook.com (2603:10b6:408:2b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 12:43:22 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::28ea:aeb4:301e:c253]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::28ea:aeb4:301e:c253%5]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 12:43:22 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: RE: [PATCH 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Thread-Topic: [PATCH 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP
 OCM
Thread-Index: AQHYsULcDijjhe4ckkinweUX5cYg3a2xKbOAgABFuJA=
Date:   Tue, 16 Aug 2022 12:43:22 +0000
Message-ID: <BY5PR12MB4258CAD5AA8BEFAAB444E4E3DB6B9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220816073203.27314-1-sai.krishna.potthuri@amd.com>
 <20220816073203.27314-2-sai.krishna.potthuri@amd.com>
 <c7146f96-fec6-5371-7137-9829e635ea20@linaro.org>
In-Reply-To: <c7146f96-fec6-5371-7137-9829e635ea20@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68a05d7c-aaa0-4ac9-877f-08da7f84e78a
x-ms-traffictypediagnostic: BN7PR12MB2721:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RK1ce7mNjduTn9fO0p48azr8H/CUaRKtPvXyuutK/wIw5L7fZHORUl/V3ZGjk/uqTUQV4Roxr7zphcm9GQiK7VgivQqK9kBykRxRBahvHR0UGO6yWTQAaDn9zMFWVtTY0iVsTfIAn4Gn6H7ArgwZPX/bVXdQUanIwDC7NA9XgZfgEfzjNMEQ5Fq8I7CsWl7fMrXEkfXmBfPiriBhctJZ1cMo8JJqOY9KlaALRYXBkOQfQ7HWgKp2avkiUlRxnJQDOY/2Bbe4RhO8BmhHQkgej+zdlJfuPjzqxJjKOj0z9nvL/M7l1nQeg7w3SRc0IWnUYTggoRT+1T+TScnzoLhsMhyH/aahno6hjk7jwqcO/CXKDwopHkN5Vh5GXMFbuuSurBEl5NyXbACCeQUwI/K87RKF8zEFxfPLuMvwMsWcj1n6dGCdDLSZXduktREhvh7d2EyW4kWa4Lgeb/lbL5R3YCd9QYgoWay78D+pw4MDmtO51bb20NUoeCxRpkRnXVskq7C8lsdTjMM5EpeAHOFYB949T6YCSNo/XtCoXIxeXxlenHTHxG22oi+tpPnD6u/N5PKieaNF2FbocAeAAgWxierThyPyYxyFoafPzrMZkPTvbJ7defbcwSHncngpeRax+DVpwCzw9bc3IJKM3JUryKxNaKFn+7aQobwx5l9CYIW3/a5I5gwsQLyNqumhPPFMFd2U/qvfAc8eGyxWy7U4Z9RJE0Cnutji5iwCz0fG8wZ5eDCRrhVEYWowpTUTlhOL59QbXzv0+wwvhnIHHSWRhdopHwGFnJbW2LSOxCkfV/4GfKHiQaHTnsewBQm7emnIb07imjcOLiBATjtSYglSXwn5piRwnYmaUdE82SMQovQjg/OnjsqwPcbtcL9OxqQt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(33656002)(110136005)(54906003)(41300700001)(71200400001)(186003)(26005)(107886003)(9686003)(2906002)(64756008)(66556008)(8676002)(66476007)(4326008)(66946007)(122000001)(66446008)(38100700002)(86362001)(316002)(76116006)(53546011)(7696005)(7416002)(478600001)(5660300002)(83380400001)(55016003)(52536014)(38070700005)(8936002)(966005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3UwdVVTcEtkRGVzNXZTaEJrL1NTRURaTFA4dHI3YU1yRjErOThqZlJseUtm?=
 =?utf-8?B?cHpXbmhQZXJHb1RHYUx2N3BhSlVPWlM5dGNYZzlJQ09tdEtpcHUzVU1CMDYy?=
 =?utf-8?B?V0lKZzZGdGRQMW5JcTRhVm9wVEhoV25PSTd6SytBOXhEeFJoREV0SlBtdnRk?=
 =?utf-8?B?bWF3SGJyeFBtMFFLYzJ3aVZwUWl1dW5aZnBuVHdFK0orZ0twelROU3lQVmY3?=
 =?utf-8?B?dFJWYWJISW4yenQ1eG11aVJiS2lmWVFMdUhxRUtma3ZESmlPeFdEWGdNbjJu?=
 =?utf-8?B?czhacUI4cmpkVzZKTXJmRWgvRUJGY3VGWUdad3lEOTErVnM1RHVpbTRSYWxw?=
 =?utf-8?B?bzYxVEo2NXQwRkFhMjZzMFIrY3AwSzdaNC85anRXWGxhSkpkQXZjR0FlVW91?=
 =?utf-8?B?L3R4NGF1cnJSNHlGWFJLd0htMk5zcDNJY3Y2VTU0b1Y4MDBjZG9MODRPbGZ1?=
 =?utf-8?B?cGNGT0ZLOHM1SFpoVFhrUENCQWJobm1KVU1DajFKNGxqLytPQ3NCT0doaEUy?=
 =?utf-8?B?K2hNZ0w2SjdUUTdkaVJOaDZqTHhHd29BUmJlYWthdXhPUHltalp5R0U0eE1N?=
 =?utf-8?B?U05ybk56bGY5L3h6RU9BbFZ6eGhFbkk5b3BnOHdqZ042MnJrK3dpTXgxTGZn?=
 =?utf-8?B?TGVMTjM4NWJPK0tOaHNiZ0gxZUxPblIrODgwNnA5cWNCQm4wbDdmQVk5SHZF?=
 =?utf-8?B?TStkc3Y5UTBveEVQc21XOW0wMWRHZEhJVXdZaXdWekJTT3huL2tSQTJiT01O?=
 =?utf-8?B?ZnR5aDNJZmxQK1hwVlVIeVRNRWxFMFd3a3pMcFhJSFFoZWxwWlFaVHBwTG9x?=
 =?utf-8?B?Tk42K3kvTXlhRGdVUFlMSHNHOW83c2VkZWdXanpmV1Y3Q01IeEo2M053bG9P?=
 =?utf-8?B?Y2tndzFEeVgreUs4YWVNeDV1b081UzltN0gzVS8wMVpQbzdveFVzczZBNnV0?=
 =?utf-8?B?dzc4QVB2UXNCak5kYytPMWZkd1piVzErQUEzcEZXTEtvbXE1T2dlWlh4TWQ1?=
 =?utf-8?B?cnV0S2dKczVBQ2VmYkliNFhNTzVZeGRxdW1ZbXBXZzRzTHJtMUlMK0Myc0Vt?=
 =?utf-8?B?THk2dUpKU2RBYWQzRG9QNEpUZXRjWFpTTTV6TDlpRE1mS2F5UVNhQTA4MVBv?=
 =?utf-8?B?Tkp3b1VFcllqYnpSVCtZREhDc0cvcGk4ZHBPeFlBUmVRa3RVNUFRSVdnRnBB?=
 =?utf-8?B?ZnZSOXRPc2dQL2ZJYjB6OGJTMHQ5YmU1WUVZTTZiNG96V3h4aHl5Q3duRmx0?=
 =?utf-8?B?dnJMeHkrcHdmdGh5anY0L3dnVTI3TDlBUjJhcWptcHNjTWpiYWpBZDBrempT?=
 =?utf-8?B?emEvc2tGVEl6Ny9TL3NyWVdFUlRFUjN2TlBGNEZhM2VoTUVxZ1dlOFdQSEty?=
 =?utf-8?B?V1dERWJHQXI2bFRrbkE2YUNNcVJzWEpiNFg3aFp4cVB3a2g5YUlVWXZvenNY?=
 =?utf-8?B?ZjErSWViSWNEWDhvakNXUW1yNFpVbU5BeWxueXg2N0RZWndGQ2QyckFod2Fh?=
 =?utf-8?B?K2dyeFZRV1dCdkplZ2Y2MllaaUdpR3czcmlLb3Y4d3JoVjc4blVTbEduYitu?=
 =?utf-8?B?bGpMaXd0YVUyL3dFdlpTMnBESnpraHJsOVdSTU91eEZRRnJkZi9GUkhGT2d2?=
 =?utf-8?B?R0RaSlMxWVM0ZEJJZURWTldzNm1uNXROYnREaUdoRisyOUk0QkI2NzdaL1ho?=
 =?utf-8?B?L2JudnBBRGZ6YitaK1Z5THhTUGRCKzBObnpDazg0YlB3TFFWZlliNmEzeFRE?=
 =?utf-8?B?WnU3ZmlyUWExc00wTDBLNVlsYVh2N3Y5TDR0Z2h2ZVFXbnNqeVdEVm8rL3Jm?=
 =?utf-8?B?cGJVaXdDSkZCMkNVbWgwSGZjQmEzU25TVzNLSXh4bnozaFB3dktvRWpmR2I4?=
 =?utf-8?B?a1I2TG5NLzZ2ZzBCZXVLQWRlaHlDUGVBTVYyMUcxZHlDa2JJWWJoTFhvVThi?=
 =?utf-8?B?bWpZTW1HRDdOVGxBSUk5dC9lL3Ria0RRUUJFeUpCQWRScUlSRnFOakZ6RzFQ?=
 =?utf-8?B?Z3M2ZFpxU1FZRkh5K1liVFhtZk0xN2tVUjVWeGlmTG1CVERVNlg0Qm1BSWNM?=
 =?utf-8?B?RkdRZkpsUFZnZU1QSElHZ2taRkdzayt3c1dOS0dqc1Vud01HZUxtT0F3Z3k1?=
 =?utf-8?Q?gUDM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a05d7c-aaa0-4ac9-877f-08da7f84e78a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 12:43:22.2903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luAO3Q9aMf9giFZ6r+vQzdLhmtzx49PnelyzM25wC5wWazkmnX4Hd9l2Kgk2Kuyw/1bFla4J8zaZ1mMx/++Zng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogVHVlc2RheSwgQXVndXN0IDE2LCAyMDIyIDE6MjkgUE0NCj4gVG86IFBvdHRodXJpLCBTYWkg
S3Jpc2huYSA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxy
b2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc+OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbC5zaW1la0B4aWxp
bnguY29tPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+OyBNYXVybw0KPiBDYXJ2YWxo
byBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVs
LmNvbT47DQo+IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBhcm0uY29tPjsgUm9iZXJ0IFJpY2h0
ZXIgPHJyaWNAa2VybmVsLm9yZz4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsNCj4gc2Fpa3Jpc2huYTEy
NDY4QGdtYWlsLmNvbTsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBTaHViaHJhanlv
dGkNCj4gRGF0dGEgPHNodWJocmFqeW90aS5kYXR0YUB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IGVkYWM6IEFkZCBiaW5kaW5ncyBmb3IgWGlsaW54
IFp5bnFNUA0KPiBPQ00NCj4gDQo+IE9uIDE2LzA4LzIwMjIgMTA6MzIsIFNhaSBLcmlzaG5hIFBv
dHRodXJpIHdyb3RlOg0KPiA+IEZyb206IFNodWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWp5b3Rp
LmRhdHRhQHhpbGlueC5jb20+DQo+ID4NCj4gPiBBZGQgYmluZGluZ3MgZm9yIFhpbGlueCBaeW5x
TVAgT0NNIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHViaHJhanlvdGkg
RGF0dGEgPHNodWJocmFqeW90aS5kYXR0YUB4aWxpbnguY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFNhaSBLcmlzaG5hIFBvdHRodXJpIDxzYWkua3Jpc2huYS5wb3R0aHVyaUBhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvZWRhYy94bG54LHp5bnFtcC1vY21jLnlhbWwgICAgICAg
fCA0MSArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRp
b25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9lZGFjL3hsbngsenlucW1wLW9jbWMueWFtbA0KPiA+DQo+ID4gZGlmZiAt
LWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2VkYWMveGxueCx6
eW5xbXAtb2NtYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZWRhYy94bG54LHp5bnFtcC1vY21jLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+
IGluZGV4IDAwMDAwMDAwMDAwMC4uOWJjZWNhY2NhZGUyDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9lZGFjL3hsbngsenlucW1w
LW9jbWMueWFtbA0KPiA+IEBAIC0wLDAgKzEsNDEgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+
ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZWRhYy94bG54LHp5bnFtcC1v
Y21jLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IFhpbGlueCBaeW5xbXAgT0NNIEVEQUMg
ZHJpdmVyDQo+IA0KPiBzL0VEQUMgZHJpdmVyLy8NCj4gSXMgaXQgYSBtZW1vcnkgY29udHJvbGxl
cj8NClRoaXMgZHJpdmVyIGlzIGFib3V0IEVycm9yIERldGVjdGlvbiBhbmQgQ29ycmVjdGlvbiBm
ZWF0dXJlIGZvciBPQ00gKE9uIENoaXANCk1lbW9yeSkgY29udHJvbGxlciB3aGljaCBzdXBwb3J0
cyBFQ0MgZnVuY3Rpb25hbGl0eS4NCj4gDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiAr
ICAtIFNodWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+DQo+ID4g
KyAgLSBTYWkgS3Jpc2huYSBQb3R0aHVyaSA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT4N
Cj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgWGlsaW54IFp5bnFNUCBPQ00gRURB
QyBkcml2ZXIsIGl0IGRvZXMgcmVwb3J0cyB0aGUgT0NNIEVDQyBzaW5nbGUNCj4gPiArYml0IGVy
cm9ycw0KPiANCj4gVGhlIHNhbWUuIERlc2NyaWJlIHRoZSBoYXJkd2FyZSwgbm90IHRoZSBMaW51
eCBkcml2ZXIgb3IgaXRzIHN1YnN5c3RlbS4NCkkgd2lsbCBmaXggaW4gdjIuDQo+IA0KPiA+ICsg
IHRoYXQgYXJlIGNvcnJlY3RlZCBhbmQgZG91YmxlIGJpdCBlY2MgZXJyb3JzIHRoYXQgYXJlIGRl
dGVjdGVkIGJ5DQo+ID4gKyB0aGUgT0NNDQo+IA0KPiBzL2VjYy9FQ0MvDQpJIHdpbGwgZml4IGlu
IHYyLg0KPiANCj4gPiArICBFQ0MgY29udHJvbGxlci4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6
DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiB4bG54LHp5bnFtcC1vY21jLTEu
MA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiAr
ICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK3JlcXVpcmVk
Og0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRz
DQo+ID4gKw0KPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtl
eGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIG1lbW9yeS1jb250cm9sbGVyQGZmOTYwMDAw
IHsNCj4gPiArICAgICAgY29tcGF0aWJsZSA9ICJ4bG54LHp5bnFtcC1vY21jLTEuMCI7DQo+ID4g
KyAgICAgIHJlZyA9IDwweGZmOTYwMDAwIDB4MTAwMD47DQo+ID4gKyAgICAgIGludGVycnVwdHMg
PSA8MCAxMCA0PjsNCj4gDQo+IElzbid0IHRoZSBpbnRlcnJ1cHQgdXNpbmcgY29tbW9uIGZsYWdz
PyBJZiBzbywgdXNlIHByb3BlciBkZWZpbmVzLg0KSSB3aWxsIGZpeCBpbiB2Mi4NCg0KUmVnYXJk
cw0KU2FpIEtyaXNobmENCj4gDQo+ID4gKyAgICB9Ow0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo=
