Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC742CCBA6
	for <lists+linux-edac@lfdr.de>; Thu,  3 Dec 2020 02:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgLCB3G (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Dec 2020 20:29:06 -0500
Received: from mail-eopbgr1320131.outbound.protection.outlook.com ([40.107.132.131]:3040
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729218AbgLCB3F (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 2 Dec 2020 20:29:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7DDi7ur9BpOQ5zy1Xu/i/RCrDXVGWakOPWkNIfmWGIHLPmS9eZQszMLnc7w/ja3ZmNpKf0mdvIq3eOc3UQg7nMjSTuGOkBPM+fEEr9Ho1dXBC44+TQRsuvpMlQnf6Nt2KL2UMxZ7sguUoYp9l7TdiDqNqx/lfdfjzAxMMtBBuHxSUryzTCnRgfE6ejZSWfrg+f0TG7oLLNItfQqi8PPMEslSBgyc5FhM2rcxCZKF4zDuhtdlx1WXw1xlD10YqrzvjnWctppimdrLBzqVaJpgUMY0EfHGeeaHbcdsycAe1Dnci5n9pLOW/RtnLQHhG7VQ773uvr7tTEfah1v+prEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6utx9DJGKS+FJYyozWhfkKsy2fFQgFO5rYismkAfbc=;
 b=DQOCVBgZQu0FMQOm+L2G/phSg7U5Gwz/CP5Rrt1kaJI36fcqXrh5iZnxPYp5lb3r1dOsQTMUfaXBMb1hFbzP0rK7GHJ7giAIu717iccskYoMRwrdATLOgd0x/JpgLwfKilfR+Lzm6XM8LoRULD5GC48ZHCt/6Qgi7b4NzohsQ9i4JKCXZdsClPSy90tEN6xemB2FI46kCHGQgo+JcKG+N3YqfoBwA2aTTa2pLOBf+nY+QQSdkRc49uLI6uIwt2AaWWuRUze5ihE8DiQua5D0R9+WBoAZe8xCfuO/rs6xCPxbgBhIZutFXc40SDibyESS+WR5CVnisOKrGuTzJf7+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from PS1PR06MB2600.apcprd06.prod.outlook.com (2603:1096:803:4d::19)
 by PSAPR06MB4040.apcprd06.prod.outlook.com (2603:1096:301:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Thu, 3 Dec
 2020 01:27:27 +0000
Received: from PS1PR06MB2600.apcprd06.prod.outlook.com
 ([fe80::7d57:cb3c:146c:36e3]) by PS1PR06MB2600.apcprd06.prod.outlook.com
 ([fe80::7d57:cb3c:146c:36e3%4]) with mapi id 15.20.3632.021; Thu, 3 Dec 2020
 01:27:27 +0000
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     Borislav Petkov <bp@alien8.de>, Andrew Jeffery <andrew@aj.id.au>
CC:     Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        James Morse <james.morse@arm.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        "leetroy@gmail.com" <leetroy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan M Schaeckeler <sschaeck@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Topic: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Index: AQHWyHVye4e51sWvik2/WaCTIMBZeKnjYQGAgAAI5ECAAH2QAIAAOC6AgAB1vlA=
Date:   Thu, 3 Dec 2020 01:27:27 +0000
Message-ID: <PS1PR06MB2600D6A1E73D89EA0D0D59DC8AF20@PS1PR06MB2600.apcprd06.prod.outlook.com>
References: <20201202063612.21241-1-troy_lee@aspeedtech.com>
 <20201202063612.21241-3-troy_lee@aspeedtech.com>
 <CACPK8XcBTm8-cAPmtswHbYAf2B+PdBiZ2s1XK1UqKA_NQX_-mw@mail.gmail.com>
 <PS1PR06MB26008E4BCB805553EDEC45038AF30@PS1PR06MB2600.apcprd06.prod.outlook.com>
 <b6dd3a91-abe7-4e9d-b801-6e54e4c88827@www.fastmail.com>
 <20201202182349.GJ2951@zn.tnic>
In-Reply-To: <20201202182349.GJ2951@zn.tnic>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [118.99.190.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a54a17d-4d8d-4a02-0fb0-08d8972a98a1
x-ms-traffictypediagnostic: PSAPR06MB4040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR06MB4040B16662E6E2E787CEB9F28AF20@PSAPR06MB4040.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55lw4X/mB6tPw7ZjGWJrlWU/mSlBMomX+qvIivbZnETxn3rkgxfRal0LrS1p8zzczxtj9vc9g5skgkhQ3+cRZcYMqgqqWXXFQCHEyNfe94nuGyGD2IrDXgTY7/6KcHjL9NqY+QesGX/HkEAOf8RSGcUplvfWEBacCeoZxgGGSc/WV4Mz2ncvHaJgWUrQCrtH6t70qRt5rCcS2vayAg9y7UjzOIR5Ei1dCGL63iSv6SUbIb61ryWvRGlrlAk2LbIVePwqcGvPuMCUEm6RnIqkHg70ZbHTL55ldW19Y6ry70GFw6XE3fU/MFfxBLwBG8VuFgKBqDAu/NSq9h+GW60OM0lRoWMbWiCK/RrRNFAIwqqtaA84hQrItt31oRyhlESXmoxQj26msRnBhqyqSI/CYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR06MB2600.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39850400004)(366004)(346002)(2906002)(478600001)(76116006)(64756008)(316002)(66946007)(66476007)(66556008)(54906003)(7416002)(71200400001)(66446008)(110136005)(33656002)(186003)(8936002)(52536014)(26005)(9686003)(83380400001)(6506007)(8676002)(966005)(5660300002)(7696005)(55016002)(86362001)(53546011)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NW1zbXZ1ZGxrTVE3TkVaeVdHNGZBVEgvUWZXTWNIVFNWZk9SYVdyT0FXOXU0?=
 =?utf-8?B?SGQ3bWxNOVhMTGd6TDJaaHdjeE5qRkdsNHNKUTVHdzlrWDBXZXRzTXVPeGFo?=
 =?utf-8?B?VkwwRzlMaVUwajdKbGtvU3pTNmxuUllRS2hIeW95WUNURFF0YmJPakZRWGtV?=
 =?utf-8?B?aXA0Z052VldZdlp2VE5CSVBOS1pwdWhQS1pwR3h4OWpOVUJBc2xrc3pqQnk4?=
 =?utf-8?B?L0tSSWFUTmdha0Rtek4zSG8wRjZWWVZtcy9RdnhKQjdueFV6QldldFoyU0NT?=
 =?utf-8?B?WmdIdHFWRUJNaDhKbXZ6ZzEzS21XM3Z2aXdrTnAydjduV3lOZmJxUmZxTXdB?=
 =?utf-8?B?NUtid2xJeW5CWUVFd0VQS3E5ZEMxdDRudHdRdVpRdWJuekU2LzR2RkZnd25y?=
 =?utf-8?B?UWlEY0JDVWxlWHYrN3JERWZKZE5PRldhalR3QWxtNlBwMGxDNElDcldtSEJm?=
 =?utf-8?B?OUlucDlsMFRsSjZ4MTN1Yit3ckZBQ0NLcFZEbmRPKzlKd0pvM2Vsb3NEbHAw?=
 =?utf-8?B?MHF6NlpYajJJa3V0RlBNSXpQRmZOWUF2blhtWTAzNFJxNFpFU3RXME1WTUhC?=
 =?utf-8?B?cDd3WHRxR0hEQzc0eEFWYUFEaW5DWHMwblVLRUs1amRCVkxreXRDMHExT1ZH?=
 =?utf-8?B?RTBoTmNEcWpwdFBxL3B1MVhSVDdTWitTcWxsalRQUCsyZ2JzVlNVZHVKMFln?=
 =?utf-8?B?b2Q1Y2dpRk9KZEZPNHdaVjV4c1BLOVJ1Y0dKWjNHelErbm1CWStrSVJ1d1pH?=
 =?utf-8?B?VzRwZTJMMGVGY21ialFOUDVtaGZ1RHRRM0txQjNDNnU1Vy9xYWZUenhxemZG?=
 =?utf-8?B?U0ZsRVIycVd4K1FFMUM4UFFnYlpia2JuS0ZjV25MSTVOUUVQcERRc0Jmb0NB?=
 =?utf-8?B?VXVwOGIzRE02VHlLT3h2dmtIbEwrOGZxYSs3emFQMWdTUTZOdi9QdmxUS1Fm?=
 =?utf-8?B?dUxWYUtEWVcrVkthN1RyWmRkZXBPRGhjWkI3TWtlelhjVTBzKzM3a2crZzZt?=
 =?utf-8?B?enBleWQvRDFKeU9PR3JtYjBINDRDQkFxdHNibjZyUkFzQmJ1dFhjSDdacUpm?=
 =?utf-8?B?OXQ3QlY5U1JqWkdFWllSeUNoWndzSEVmSFBnTTlORVpXNUtwNmdWYW1IZWQr?=
 =?utf-8?B?QkRKb2UyVjRpZEdOamVEd3U1cWQyR0I2aDIwdnN3MzhVc3BoZjlCS2NVRGRM?=
 =?utf-8?B?V2NYM1JvZUx1ZHlmODM1WGs2U2tRbCtxSGRGNnlsSjFjcy8xNDNsY214b09B?=
 =?utf-8?B?UGRvdytHT3ZyTXF0YW9WNm1nTTJCYm1BaGNXMkdPMTZIeVlaREVLU1JJNXdY?=
 =?utf-8?Q?K4JmoCqnACwvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR06MB2600.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a54a17d-4d8d-4a02-0fb0-08d8972a98a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 01:27:27.6948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kFsyWzZEfH9W6uHABhJwhblK3Sk7AidrXVo68ootQspj+bUD0IlmsgyAr+d/fgMiOQAXu3/m4d4hw9udC5xIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4040
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQnJvaXNsYXYgYW5kIEFuZHJldywNCg0KSSByZW1vdmVkIHRoZXNlIGV4cG9ydGVkIGZ1bmN0
aW9uIGFuZCBzdWJtaXR0ZWQgdjMgUEFUQ0guDQoNClRoYW5rcywNClRyb3kgTGVlDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGll
bjguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAzLCAyMDIwIDI6MjQgQU0NCj4gVG86
IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+DQo+IENjOiBUcm95IExlZSA8dHJveV9s
ZWVAYXNwZWVkdGVjaC5jb20+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0K
PiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUw0K
PiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRl
bC5jb20+OyBSeWFuIENoZW4NCj4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT47IEphbWVzIE1v
cnNlIDxqYW1lcy5tb3JzZUBhcm0uY29tPjsNCj4gbW9kZXJhdGVkIGxpc3Q6QVJNL0FTUEVFRCBN
QUNISU5FIFNVUFBPUlQNCj4gPGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnPjsgb3BlbiBs
aXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gUm9iZXJ0IFJpY2h0ZXIgPHJy
aWNodGVyQG1hcnZlbGwuY29tPjsgbGVldHJveUBnbWFpbC5jb207IFJvYiBIZXJyaW5nDQo+IDxy
b2JoK2R0QGtlcm5lbC5vcmc+OyBTdGVmYW4gTSBTY2hhZWNrZWxlciA8c3NjaGFlY2tAY2lzY28u
Y29tPjsgTWF1cm8NCj4gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBtb2Rl
cmF0ZWQgbGlzdDpBUk0vQVNQRUVEDQo+IE1BQ0hJTkUgU1VQUE9SVCA8bGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgb3Blbg0KPiBsaXN0OkVEQUMtQ09SRSA8bGludXgtZWRh
Y0B2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy8zXSBlZGFjOiBT
dXBwb3J0aW5nIEFTVDI0MDAgYW5kIEFTVDI2MDAgZWRhYw0KPiBkcml2ZXINCj4gDQo+IE9uIFRo
dSwgRGVjIDAzLCAyMDIwIGF0IDAxOjMyOjQ0QU0gKzEwMzAsIEFuZHJldyBKZWZmZXJ5IHdyb3Rl
Og0KPiA+IE9uIFdlZCwgMiBEZWMgMjAyMCwgYXQgMTk6MTEsIFRyb3kgTGVlIHdyb3RlOg0KPiA+
ID4gSGkgSm9lbCwNCj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLCBJJ2xs
IGZpeCB0aGUgcmV2aWV3IGFuZCBjcmVhdGUgYW4gbmV3DQo+ID4gPiBwYXRjaCBhZ2FpbnN0IGxh
dGVzdCBMaW51eCBicmFuY2guIFRob3NlIGV4cG9ydGVkIGZ1bmN0aW9uIHdpbGwgYmUNCj4gPiA+
IHJlZmVyZW5jZWQgaW4gb3RoZXIgZHJpdmVyIHlldCB0byBiZSB1cHN0cmVhbSwgc28gc2hvdWxk
IEkgbW92ZQ0KPiA+ID4gdGhvc2UgZXhwb3J0ZWQgZnVuY3Rpb25zIG91dCBvZiB0aGlzIHBhdGNo
Pw0KPiA+ID4NCj4gPg0KPiA+IFllcywgbGV0J3MgbGVhdmUgdGhlIGV4cG9ydHMgb3V0IG9mIHRo
aXMgcGF0Y2gsIGFuZCBhZGQgdGhlbSBpbiB3aGVuDQo+ID4geW91IHNlbmQgdGhlIHBhdGNoIHRo
YXQgZGVwZW5kcyBvbiB0aGVtLg0KPiANCj4gQW5kIHdoZW4geW91IGRvLCBhbG1vc3QgYWxsIG5l
dyBleHBvcnRzIGFyZSBFWFBPUlRfU1lNQk9MX0dQTCAtIG5vdA0KPiBFWFBPUlRfU1lNQk9MLg0K
PiANCj4gQWxzbywgSSdkIGxpa2UgdG8gc2VlIGhvdyB0aG9zZSBleHBvcnRzIGFyZSBnb2luZyB0
byBiZSB1c2VkLiBBbiBFREFDIGRyaXZlcg0KPiBmdW5jdGlvbiBleHBvcnRlZCB0byBhbm90aGVy
IGRyaXZlciBzb3VuZHMgc3RyYW5nZS4gV2UgaGF2ZSBvbmx5IG9uZSBvdGhlcg0KPiBjYXNlIGxp
a2UgdGhpcyBpbiB0aGUgRURBQyB0cmVlOg0KPiANCj4gZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMu
Yzo1NTQ6RVhQT1JUX1NZTUJPTF9HUEwoYW1kNjRfZ2V0X2RyYW1faG9sDQo+IGVfaW5mbyk7DQo+
IA0KPiBhbmQgZXZlbiB0aGF0IGlzIG5vdCByZWFsbHkgbmVlZGVkLi4uDQo+IA0KPiBUaHguDQo+
IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMuDQo+IA0KPiBodHRwczovL3Bl
b3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0K
