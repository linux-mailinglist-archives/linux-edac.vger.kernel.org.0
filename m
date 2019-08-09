Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02987C64
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2019 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfHIONi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Aug 2019 10:13:38 -0400
Received: from mail-eopbgr130133.outbound.protection.outlook.com ([40.107.13.133]:58521
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfHIONi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 9 Aug 2019 10:13:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebD4TfFzKaUhuKPDTZ7+9oyTNiKeO/OGjuGDarjgEDJlgeESxspaIVdO9WdTfcg+hCeijJ4kMJJzy6qP08ZW3eT35Nubw1apIrqSOgWuQBkTj03Ov6xeNUydSAib/m7blJqT0T3QV/0mGtU+TBjBlIA+FYhhiyhF1WLVklybgAGkeKPcBAEmzloDESJX0sCBAlKevoEUMPuu1X1zKTYOABOoL0B00vjvdL/9baD5JMhbMFXkbKX2DdngGLFmGg0sntuKB+csUvk6V8cqlcz+T6RWQ9/4F4XLScZ927NyRe7Z7+x7HOVvnPcQu8jinmmPKLUzQL1JhRsiW0XYC272nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKifQRYV5lKuI9xhCIiFbLqGFCI/+pvnjeFV2zLzosc=;
 b=JDa7gXfzPQ4RICXBcoCJwvQgw0wB48VzcotXw+8vHvr0UZ+cQbzsatvF/zIchsWZHrs7PES1dDrtbcauhRCGkE41ohlJ/KA4Iw/vJk6zadrybSeDNQbzKgipD4qwlz/HJNYNcJJ5PGaeAAtNIjxhdCvuONlpUZNHAun0yOn4mFpVcoR4v4FkZdmcYVh9zglVilS1680nnD5eRaZrUhTu0bD6343XL7J0yIMSGkqAq3cg0b6MFfDQN/5OTEik7G4Zej+gvT+A5rgPW7pYUoReyZCV0P/u1Lbld1MZ01wevj9v2bfXFYGM7xwGb90rjd29D2sa/FHuaC+7PZHGtZR0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKifQRYV5lKuI9xhCIiFbLqGFCI/+pvnjeFV2zLzosc=;
 b=akgJrY4/s4FnIFIe6PTBzYhrm7o4dygZtUO9EWbPkzOKCevYBGIyPsklOYGVTaTAeMxZ6NhHBlrosBKp9m1qMJK8Mqpm0u11bNg5I6JlY7YJRQX8facUpNYEgAiLabvU9Kwde8KuLWi0EFFCnL6/VZXl3VgsAy7ie28KTvpG8+k=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3854.eurprd04.prod.outlook.com (52.134.16.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Fri, 9 Aug 2019 14:13:32 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:13:32 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg() from 64K
 -> 32K
Thread-Topic: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg() from 64K
 -> 32K
Thread-Index: AQHVTiskHjYyDh8ZF0eccCUFKX9IfabxvLZQgAEgJoA=
Date:   Fri, 9 Aug 2019 14:13:31 +0000
Message-ID: <57c16c37-c81c-a935-6b8f-efd41657aaad@silicom-usa.com>
References: <20190808205147.25547-1-stephend@silicom-usa.com>
 <3908561D78D1C84285E8C5FCA982C28F7F416946@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F416946@ORSMSX115.amr.corp.intel.com>
Reply-To: Stephen Douthit <stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:408:ac::28) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccbf4e39-0aa3-43f6-2734-08d71cd3c1ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB3854;
x-ms-traffictypediagnostic: VI1PR0402MB3854:
x-microsoft-antispam-prvs: <VI1PR0402MB385413E2AC3E5AF1F12A6B4194D60@VI1PR0402MB3854.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39840400004)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(53936002)(71200400001)(71190400001)(3450700001)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(2906002)(31686004)(43066004)(6512007)(3846002)(6116002)(53546011)(6506007)(386003)(81166006)(478600001)(81156014)(4326008)(186003)(6436002)(7736002)(305945005)(6246003)(66066001)(5660300002)(8936002)(52116002)(36756003)(76176011)(99286004)(25786009)(102836004)(26005)(14454004)(8676002)(2616005)(446003)(11346002)(31696002)(476003)(86362001)(229853002)(256004)(486006)(14444005)(110136005)(54906003)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3854;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4IxEgkgkNyPeMZoYVvRZUvRwo15NEzKLPvGSr9vSvbwVNqXY3bIV6eTWoFvRZHXbnqO5iLdGpJH/V5w60/o7ObSTIucTlw+RWQj4hRhsUzlOU1T9tRm+ogvy7HWkOeRd2RymRbfh/icXC7XP3DHfYpVVdyB9rH0QbV1WbPy50oRmPxIYzOhgIUup+Ok4tw+VqdmeFWsaU2eePGyvfLpz4Q/lzAFW8rNXKE2GocUo3JHl6YVOri7p1Lq9zMjzHr5X2RfOFN2jnHnY5P/Hvz1a1ADMmByF4RO/vl3xrOiAVSWqKj2JrujdbEuMGuNLw1C/UqjmV9oVq0pEsr9YK23Ta4ClJKH4V6rU9TobxqfbC92EW6h1TXGim27ppGF83wBS8bj+PF+lO7exPFz8Ojb7pNUp6SzqsRp5BX0UQ2d05uw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0355ED99921C05419263F7D68E36E214@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbf4e39-0aa3-43f6-2734-08d71cd3c1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:13:31.8094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPqL7DE20tcQQ61unYCcJlwv/Uur4nqignZaPmC4McdmnlJrdNagBBaQkfX2hTVh9VvOHinAgAC7DvGatIZLXRDyJ8Ns3B1tO5gZGUSb0DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3854
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gOC84LzE5IDU6MDUgUE0sIEx1Y2ssIFRvbnkgd3JvdGU6DQo+IC0JCWJhc2UgPSBpb3JlbWFw
KChyZXNvdXJjZV9zaXplX3QpYWRkciwgMHgxMDAwMCk7DQo+ICsJCWJhc2UgPSBpb3JlbWFwKChy
ZXNvdXJjZV9zaXplX3QpYWRkciwgMHg4MDAwKTsNCj4gDQo+IENoYW5naW5nIG9uZSBtYWdpYyB2
YWx1ZSBmb3IgYW5vdGhlci4gIDotKA0KDQpPaywgSSdsbCBnaXZlIGl0IGEgbmFtZS4NCg0KPiBE
byBkaWZmZXJlbnQgQklPUyBkbyBkaWZmZXJlbnQgdGhpbmdzPyAgSSBkb24ndCByZWNhbGwgc2Vl
aW5nIHRoaXMgZXJyb3INCj4gKGJ1dCBwZXJoYXBzIEkgbWlzc2VkIGl0LCBvciBwZXJoYXBzIHRo
ZSBrZXJuZWwgaGFzIGFkZGVkIGJldHRlciBjaGVja3MpLg0KDQpTdXJlLCBkZXBlbmRpbmcgb24g
d2hlcmUgYSBCSU9TIGxvY2F0ZXMgTU1JTyByZXNvdXJjZXMgdGhlIHJlcG9ydGVkDQpyZXNlcnZl
ZCByYW5nZXMgd2lsbCB2YXJ5LiAgTm9ybWFsbHkgdGhvc2UgcmVzb3VyY2VzIGFyZSBwYWNrZWQg
Ynkgc2l6ZQ0Kc28gYW55IGNoYW5nZXMgaW4gdGhlIGluc3RhbGxlZC9lbmFibGVkIGRldmljZSBs
aXN0IGNhbiBjaGFuZ2UgdGhlDQpsYXlvdXQgb2YgdGhlIE1NSU8gcmVzZXJ2ZWQgcmVnaW9ucyBh
cyB3ZWxsLg0KDQpUaGUgQklPUyBjb3VsZCBhbHNvIGNob29zZSB0byByZXBvcnQgYWRqYWNlbnQg
TU1JTyByZXNvdXJjZXMgYXMgb25lDQpsYXJnZXIgcmVzZXJ2ZWQgcmVnaW9uLg0KDQo+IElmIHRo
aXMgbnVtYmVyIGlzIGF0IHRoZSB3aGltIG9mIHRoZSBCSU9TLCBpcyB0aGVyZSBzb21lIHdheSB0
bw0KPiBmaWd1cmUgb3V0IHdoYXQgaXMgdGhlIHJpZ2h0IHZhbHVlIG9uIGEgc3BlY2lmaWMgaW1w
bGVtZW50YXRpb24/DQpEaWdnaW5nIGJhY2sgdGhvdWdoIHRoZSBFRFMgKEludGVsIERvYyAjNTU4
NTc5KSBJIGZvdW5kIHRoYXQgdGhlcmUgYXJlDQp0d28gc2l6ZXMgd2UgbmVlZCB0byBoYW5kbGUu
ICBJZiB3ZSdyZSByZWFkaW5nIHZpYSB0aGUgbWVtb3J5IGNvbnRyb2xsZXINCmh1YiB0aGF0IEJB
UiBpcyAzMktCIHBlciBzZWN0aW9uIDQ0LjIuNyBvZiB0aGUgRURTLg0KDQpBbGwgc2lkZWJhbmQg
cG9ydHMgYXJlIDY0S0IsIEknbGwgcmVzdWJtaXQgdGFraW5nIHRoYXQgaW50byBhY2NvdW50Lg0K
