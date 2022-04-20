Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6CB50810F
	for <lists+linux-edac@lfdr.de>; Wed, 20 Apr 2022 08:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiDTG0t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiDTG0r (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 02:26:47 -0400
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40043.outbound.protection.outlook.com [40.107.4.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB553A1B5;
        Tue, 19 Apr 2022 23:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFBUNVeTPOGpRPKPMTvJZxkTQrxo6CQSxr+HMWZMsY76xoPahxwUrUyngh8+H9xOFIeB889OBKrOIwkgresjoVkfur/LGZcrvUjBCKQ2sS3Z3yfhQyUZsUZA6BxjRIYBG3WU4rQiVWzcE3nrBzkKpmrQ2KEVKHDPuHlqqEXxP5ZGhnCGIcz11PLGqTJx3oRjtszPgYpQtex+7SZQshbLkKnHUGBdfHBQ746FhX752h309TfA3qo9uIy0+zoS6LqxWtHB1megFhOLQC/jS90j0CxpobD/gIoi0erRkRMVJDC179wmRU2hgtYPZLEpfZ2n0F7Ih4tukJY3w7tAYXjBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IimbG+ABu/1TN+ZiqXF4PAw8ZwtaujZPDLrayL47Qx0=;
 b=XP5sgNnY0WtoP+f0EzlOcHlnUP5SwM0GM721lw4nk1BIUknbWm7ZQnm6SCjhr0c0YdgRkmWKOcjtkikPul1EdAK0Un/nGyJU9ThlW03Mt5dJkvbpvlJwkhElY8RPbYIkZsoLVL3iCr1GL6vjV69SYppquGLYUQuRNGsHsQCSGiYYT9dWtE4VxQP9j/stDvLPNz21uqOkt5wQfFSFJQ6YPjexML0ls3RZA26ULuxfOxW/gz50FY9q92pISX88uXz/N0MRnNzkn4zUE33Jqeiygzv3CUZlVk533ZS82/YqtKW2Pccp8cgaIXldUzn2TeFXdN89qLeRmChoxW7ug3V76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IimbG+ABu/1TN+ZiqXF4PAw8ZwtaujZPDLrayL47Qx0=;
 b=kuQeSioWPmPp+IgY1Kiu1nl2tZPs0qnehyDRHhoInGMy5Fx0/EMTH91oIbyXPxV4Y4RrAe0Q0uirlosAhGuM3h7bYkc+IShulI0yQAETmx/QVCsUI0ij5kZUmP69fYHyCiRacdsKfjGfT92Q3UHJWE7LfdPCWT+X6o95tPJyfHQ=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB5888.eurprd04.prod.outlook.com (2603:10a6:803:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 06:23:59 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::55a2:d9e8:2c99:1433]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::55a2:d9e8:2c99:1433%4]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 06:23:59 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Thread-Topic: [PATCH 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Thread-Index: AQHYOrow3JqOaf3SgUSOl308YaQ1c6z4gZEAgAAG8wA=
Date:   Wed, 20 Apr 2022 06:23:59 +0000
Message-ID: <AS8PR04MB840489588D0DA46B8FFECFFF92F59@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
 <20220318111742.15730-3-sherry.sun@nxp.com>
 <ab18f598-d4f5-049c-66f3-3ce2d5c01670@xilinx.com>
In-Reply-To: <ab18f598-d4f5-049c-66f3-3ce2d5c01670@xilinx.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2518284f-e994-4611-69a4-08da22965b31
x-ms-traffictypediagnostic: VI1PR04MB5888:EE_
x-microsoft-antispam-prvs: <VI1PR04MB588856CEC53731775AABA65B92F59@VI1PR04MB5888.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrQuIw43tTBkQQR4zJn6dLAiN72v+1rxylK5E139Aw5Z8y01BJ9s9yoRIsYyhoNr5okmTDIpROjm9OJYH0yFvgYYKQnXHBKqz4M2lYL8WMOUe1C3w2FGH8moV//6hcXI8tRYGLBFm+HPiS50npA1OKO7hFsFUFx+Nf60wxCKzBB/8oXvx91AwebB5vY/vnscefnArVxD46pM/uCTtYyj8YZLi2HjASgUF7VLRRrqZmGnuJEZ+CdQ+aLe/wXfSGSOCRMzjzNcy1XEx+fzG/mWxLCvipF+UPx/usb1xTjA6al0EmMB4YIfBM5qkd5PKzbsvZmBJlGQfgEL1UVY5D78YG5Cmay1D/SlmxdrWupSEzODh0JWq2cAmSF+a4dhAc2xE5/Wilw1+yTPXeebsd+TJqdP2rft4gKhLjMFzmEgnp/Qu8ivESAj8lNS8qM9wprHmFnGbsfxRIGA8AF2PQEPPGEIW8JGlvJ3CDd26x776rUDJR7h2m6AOc24XNMLc9ii6UVEPl7n9QhEQmDp8H3eRr7SSHPJn0p4WYW3bKP4mCGSImrraITxwwa6rxPFGqmiWVBvzgQIHRKcsAQsDVS9vTGiBae5JRwTmRHcweXi+jY7mZFxn44CHoduyEg5fhx/Q3CtvXjAfKJedf/icBbl7nEgeG7QBltPc5b+waHQOkMJmCy/vQkfd0TRp5khRZClTrvBhZniBmvpF+T99m8biw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(76116006)(66476007)(86362001)(316002)(38100700002)(64756008)(110136005)(66556008)(66446008)(66946007)(33656002)(8936002)(186003)(55016003)(5660300002)(2906002)(4326008)(6506007)(44832011)(83380400001)(38070700005)(508600001)(52536014)(8676002)(122000001)(71200400001)(7696005)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjQvdHlqbEVBb2JtSEJUazNLK0NrWXppbzNtRnNDT0RydERIbjhKME5MeDgz?=
 =?utf-8?B?QTNaN1psdjNBbU1zdlo1ZU1lYVJjQnlDY0RvTEVOWEZnd2VJVFR5WUREZTJL?=
 =?utf-8?B?NlhUSW5obGdWZnJ2U1VEdlJDTklEOGdjQnI1MGxHODZEeU1PZmRlWENtLy9x?=
 =?utf-8?B?UW9RNDBPQ1g1MWpuYlduY2FqQnFDeDlEV2Q2dmM3WXArNCtPb1FaN0JFVkhp?=
 =?utf-8?B?NTVDbWU5NEhWNCtkcnEzcEVEM0Z2Q0szb3NENUZNTHh0bmc0RzlyZkRscDdw?=
 =?utf-8?B?VlNyUFJaZ1ZPdUxXeTlFdG9SSEU2d0lzSlNNS0lBdmx2V2VFU1FITUxBOTZo?=
 =?utf-8?B?WUFyT3NNTFFoU2o0RXM1b3dKUkFxb0FXdmhpa0kwTnF2a28rOXpjZUw3d1ZS?=
 =?utf-8?B?RDV1UXovMFFEOUs5ZzZWRDV3ajJjcEtZcUhwVDU1VDFBVng5enhoRDdvdjJk?=
 =?utf-8?B?REdqWmMrM1JlU3lxL09WNldlTml3MGx6MkFWV21LQXZXV2xFdU80d25TemVW?=
 =?utf-8?B?cXZNN0FFOWR5ek9NdTFuT2I0ZFhaVm9maW9uY012S2MvNjkzNEE4b1FNOElp?=
 =?utf-8?B?Y1FkNlBUK1h4Z2hYVHo3akdJTUxGZFU5TkxhNnFRYnZTWGFVN0s1dVZZdmhq?=
 =?utf-8?B?cmNoM1IyS2tOMCtZMmdIWlVPUDZ3MzNBUDFUTkZ0aFNOYzN0Q2t6MlZNMVI3?=
 =?utf-8?B?L0JZNEI4SDlzUEpmeU9Kc2pOa09LbUFIY2g5S2MvN2VQSDJSVG5wSEdLYWtK?=
 =?utf-8?B?ZVdManpPdXlDem1QNzAyaXM5WFFLRVgycERVZEgvV3ZZT0k2TG1vRTZHZ09P?=
 =?utf-8?B?d2w2MHVYRzBZU0tQWWZTNGtyMDZSdXZsUi9PVmk4UHlIWVgrZHgrWWoxWHJ2?=
 =?utf-8?B?c0wrQ3UyTnVwdEJacUhCbjBkMXNnZVliRVJ3Ry8yRzRvR05rT1E2KzhhQUZL?=
 =?utf-8?B?OGc0V3ZkSWNQUDVBZTZFSU9CM2VsU000d0VsQUpEMmpMSTNrb0g5YjlpMkJp?=
 =?utf-8?B?c2VORWJRT0M4L3JFOVpaeXR1L2EwQTdGZ3M3Qy9Xb2hkbURkZ2pDRlRhUFRj?=
 =?utf-8?B?ckdCcnNHZHV5dWh6dUkza2lHNE4vZXp2TDRYN3d5L2ZZdjZONG5RYmdWWURO?=
 =?utf-8?B?aFNxajNCVlloc0M0SDRPYVY2akRqaU10YlJ5ckc2STdCOHhERjRNbGgwREJ2?=
 =?utf-8?B?ODlIOXRpWlIyaEp0VjY5U3JKQTZyM0QwdDV2YU5XbHdNRXg5K0lNRno4VjY2?=
 =?utf-8?B?L2JxTHZaZGpGYk9YendNcUk5QlJyRGM2TjAySmJSTWFvaXJ4V1hZV2x5bWkx?=
 =?utf-8?B?Z1FvalJ5TCtBSEFKSk5DbjdlN1phdTlyZkVZdDhrMWEwWmt4NzIyV2sxbXBq?=
 =?utf-8?B?STlBZ1JQY1Z4NENYSHE0bEt2TkFsalFsNnZjL0hpZFc0ZnlTZnpuM0lITVh0?=
 =?utf-8?B?U204K2N4R1ZFTkQ1cUsxMmRFMGF0NTMySFRta0lMaG1MR3FNRlVIMGJzSVY3?=
 =?utf-8?B?QUpEVUxDYVgzR0crTU84cWtBb3NxaWo4WUlDdHFhZnFaZGpSekNuWnpkdm45?=
 =?utf-8?B?VCsxWHp0Vkx1ZUFUN1ljNEh5VkVrcDB1WWdKb2gwam01aFNReGNVNkZKY01V?=
 =?utf-8?B?SHhvdjFFT0U5VVowOXRZcTd1SHlrT2V4ZWM4RUMzaGdVa0JWRGY3bVNWVFkr?=
 =?utf-8?B?NVMxRTZrSG1pOFBIbHk4RENPRldrSDJCQ2M0MUtCbzBETUtlNVEvN3g2ZzlQ?=
 =?utf-8?B?dkpYbUhmQktnS0JKR3FWeUJkdGlibnJoR0ZYRFBKK1BJZWU2M2dKNW1rckN6?=
 =?utf-8?B?RUhLUDU1bURIR0o1OFkzR1l2YUtsS05nbFkrWkZUTlcrQlUybzVHajZXSWF5?=
 =?utf-8?B?dE1aRWk2MWVMTnMvTkY2VWU5SXFac0h1ZzZVZnkrSnF6MUU1VzZXOWQ3eDE2?=
 =?utf-8?B?TzZraldZWVZRYTZJNG9VNHhYYjYrL0ZlK0RhbWQ4MEFPUE1QRHpFMVZaL3Ri?=
 =?utf-8?B?YXdtaThiSzk5aXdqaUpIVXpzaHFMSUJ2c2l4YW81Q1ZYUE1RUHdkd0l6dzJq?=
 =?utf-8?B?aGlVc25zVnI3VEdURlcyWEZzR3FZK3d5V3l6WCsxSk8wdEpMT2RMTE5TZnJ5?=
 =?utf-8?B?cmU3VTVnUlVOR1A4NGZnallyVkdZSmVFZkZRNk1aekw2cHJPdjE2ejNnMkl6?=
 =?utf-8?B?M1o0Z0RQZXZ6RCtIQ0JiYW12N2ZmcHZFTnpONkF5MlVTUlNFTEVNMk41a044?=
 =?utf-8?B?UjZGdWpBSGFiem5zMTZLQk1SMEhqVmpRdkdqYllOc3o1MHBrYkU1Qi9veGhF?=
 =?utf-8?B?VTZhM1VVZkpPWUdDRVAyRjZoQ3o4RmlMYlZVOXhVUkNOakJReXByUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2518284f-e994-4611-69a4-08da22965b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 06:23:59.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4dI3X7kDCX7MVjwuM9ZL8ovbtVHlZDvC3tjfGM4hKiNGtbetkjErMZy5cNk/Qm9a82KTGKvUmnuPd+icRZkug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DQo+ID4gU2luY2UgenlucW1wX2dldF9lcnJvcl9pbmZvKCkgaXMgY2FsbGVkIGR1cmluZyBDRS9V
RSBpbnRlcnJ1cHQsIGF0IHRoZQ0KPiA+IGVuZCBvZiB6eW5xbXBfZ2V0X2Vycm9yX2luZm8oKSwg
aXQgd2lydGVzIDAgdG8gRUNDX0NMUl9PRlNULCB3aGljaCBjYXVzZQ0KPiA+IHRoZSBDRS9VRSBp
bnRlcnJ1cHRzIG9mIFYzLlggU3lub3BzeXMgRURBQyBERFIgYmVlbiBkaXNhYmxlZCwgdGhlbiB0
aGUNCj4gPiBpbnRlcnJ1cHQgaGFuZGxlciB3aWxsIGJlIGNhbGxlZCBvbmx5IG9uY2UsIHNvIG5l
ZWQgdG8gcmUtZW5hYmxlIHRoZQ0KPiA+IGludGVycnVwdHMgYXQgdGhlIGVuZCBvZiBpbnRyX2hh
bmRsZXIgZm9yIFYzLlggU3lub3BzeXMgRURBQyBERFIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJz
L2VkYWMvc3lub3BzeXNfZWRhYy5jIHwgNCArKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL3N5bm9wc3lz
X2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiBpbmRleCAxYjYzMGYw
YmUxMTkuLjNhMWRiMzRhODU0NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2VkYWMvc3lub3Bz
eXNfZWRhYy5jDQo+ID4gKysrIGIvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYw0KPiA+IEBA
IC01MjEsNiArNTIxLDggQEAgc3RhdGljIHZvaWQgaGFuZGxlX2Vycm9yKHN0cnVjdCBtZW1fY3Rs
X2luZm8gKm1jaSwNCj4gc3RydWN0IHN5bnBzX2VjY19zdGF0dXMgKnApDQo+ID4gICAJbWVtc2V0
KHAsIDAsIHNpemVvZigqcCkpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGVuYWJs
ZV9pbnRyKHN0cnVjdCBzeW5wc19lZGFjX3ByaXYgKnByaXYpOw0KPiA+ICsNCj4gPiAgIC8qKg0K
PiA+ICAgICogaW50cl9oYW5kbGVyIC0gSW50ZXJydXB0IEhhbmRsZXIgZm9yIEVDQyBpbnRlcnJ1
cHRzLg0KPiA+ICAgICogQGlycTogICAgICAgIElSUSBudW1iZXIuDQo+ID4gQEAgLTU2Miw2ICs1
NjQsOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgaW50cl9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRl
dl9pZCkNCj4gPiAgIAkvKiB2My4wIG9mIHRoZSBjb250cm9sbGVyIGRvZXMgbm90IGhhdmUgdGhp
cyByZWdpc3RlciAqLw0KPiA+ICAgCWlmICghKHByaXYtPnBfZGF0YS0+cXVpcmtzICYgRERSX0VD
Q19JTlRSX1NFTEZfQ0xFQVIpKQ0KPiA+ICAgCQl3cml0ZWwocmVndmFsLCBwcml2LT5iYXNlYWRk
ciArIEREUl9RT1NfSVJRX1NUQVRfT0ZTVCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJZW5hYmxlX2lu
dHIocHJpdik7DQo+IA0KPiBuaXQ6IG5ld2xpbmUgaGVyZSB3b3VsZCBiZSBnb29kLg0KDQpIaSBN
aWNoYWwsIHRoYW5rcyBmb3IgeW91ciBjb21tZW50cywgSSB3aWxsIGFkZCB0aGUgbmV3bGluZSBo
ZXJlIGluIFYyLg0KDQpCZXN0IHJlZ2FyZHMNClNoZXJyeQ0KPiANCj4gPiAgIAlyZXR1cm4gSVJR
X0hBTkRMRUQ7DQo+ID4gICB9DQo+ID4NCj4gDQo+IEFja2VkLWJ5OiBNaWNoYWwgU2ltZWsgPG1p
Y2hhbC5zaW1la0B4aWxpbnguY29tPg0KPiANCj4gVGhhbmtzLA0KPiBNaWNoYWwNCg==
