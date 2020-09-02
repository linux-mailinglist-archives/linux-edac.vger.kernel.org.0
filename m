Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910CD25A49C
	for <lists+linux-edac@lfdr.de>; Wed,  2 Sep 2020 06:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIBEg0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Sep 2020 00:36:26 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:18977
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgIBEgX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 2 Sep 2020 00:36:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Thp0PU7DSdHbEa1lr4Ei2/nq2wkzEBx+gjkbbV28rN9uL587ZmpqTOJzX/ChI/LpNowbY2/YVvVDWxg3z0Z0DfHCnK5cNInm/uqwxwONZ70zydNodZmwtT3itH6TEzma4YP+sdXRgD3P5RE5wguR+cUbIXLBh+F/kl/4MJ3yiFJ7eqdply6xo5PHrFf8HORNtGCnPHed1uteeUm5BF+M9e3P82iUAAG85vk1a9Zqqd2u1zMdErnvolAQdQZpnNObFpQ4OztQQkykCY+uY3ZtCeX2RLsjwaMUoIvs47PArGuv9RdAklXQSOCLaQ9tCmqXMUAeiMaHFL7uRbnhumQkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXv7ZY3pu6bvIgpCjSENRLdfMeccFkJPTGtOJwhnx6Y=;
 b=bAli5Lksmq0ZQ412o0e9FSrh3/nj+Mh9npLUXOcXp2YjPNZOQQ0SLlnBajOOqqxjDjVuHRI7MPWRxmiLKDFmeTCbOKv6NZs5IzPQOZbLta5Rkw75ZTYdPeMezfACgvyf1jHnbHrlC2/xR+CIwMj+OaD2pc/2VJ3Dyg7WskyC9NjRMG9m3N63zzl+ngshFDEv9JjYZijfg/Zs1G3SXfWiwqweq7iNpuupi3btf4abSwP47HkqO1nhiuuQSunNtZDBt+h2wap+PRaz+d9dQutPGc0zkaUhOx+HCg4XpFdZCDgx3j9/7htJsh9zEns6py/1MNd68a5UxYTfGPO7UIg8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXv7ZY3pu6bvIgpCjSENRLdfMeccFkJPTGtOJwhnx6Y=;
 b=eN24dHDEqYB4OEXnQxKWnGkmSs8KEn6/1m/taOqOHU+XBmB1RJ8jCjJnk38HTPwGOnHwe4Jb3SrxKSjlRlckC+MLhMDtKBXG5cPk0m8WVTarUXYUApag/dzE327bikqfRsFXB5fjYxo+DH61NyKE29CiHE56U3436Hio6iI5vuo=
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN8PR13MB2658.namprd13.prod.outlook.com
 (2603:10b6:408:8d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.6; Wed, 2 Sep
 2020 04:36:16 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::a446:9877:b346:93ad]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::a446:9877:b346:93ad%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 04:36:16 +0000
From:   Yash Shah <yash.shah@openfive.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@openfive.com>
Subject: RE: [PATCH 3/3] edac: sifive: Add EDAC support for Memory Controller
 in SiFive SoCs
Thread-Topic: [PATCH 3/3] edac: sifive: Add EDAC support for Memory Controller
 in SiFive SoCs
Thread-Index: AQHWetg9bWAU/X2EEUCxwoJcYxGZSqlR8k2AgALb+6A=
Date:   Wed, 2 Sep 2020 04:36:15 +0000
Message-ID: <BN6PR1301MB2020B40D95C82FB12940FA10822F0@BN6PR1301MB2020.namprd13.prod.outlook.com>
References: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
 <1598357182-4226-4-git-send-email-yash.shah@sifive.com>
 <20200831085203.GB27517@zn.tnic>
In-Reply-To: <20200831085203.GB27517@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [103.109.13.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd2651f3-7d3a-427c-08a5-08d84ef9bb11
x-ms-traffictypediagnostic: BN8PR13MB2658:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR13MB26583EFC94A2C46DE4FB97D2822F0@BN8PR13MB2658.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clz3UYKbMRB/Iye47srXIbqBSG6QgSJ5hHXyok6Su3aKB980nmZJfrmxv3oow+chhJYU+gCsSljbsLbvDuP4xSZxxxo2UEZqZblv/bHR53PMa25UglnNy12xF1nbpS+AmWF7n0vBuLxDb8ToiVIaz5vYyvHnlEYsrKKK8Hj2NCJSVFMWQp+EeI3KyZseKKahAq56R9zerPz/a7fBdS1gCyLsLqQGrpMhBPYVOiNDMYMBoO4RLbaHjsehinyEiREm86A7loi/u1LFiFWyzA3cENl9rpHvSI/m90nH7qklxo/hbW/IdJ7LLzWLnvAnZaBSWGYVqj/5WOf3TfvC9hQwrmLLbB+nhtlHoBQCH/r+QFvI4JcXoYZHQ9QDtcBDsRcgqeJorw1JD6saC50QIL9QNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(366004)(396003)(376002)(346002)(136003)(39840400004)(83380400001)(7696005)(2906002)(6506007)(26005)(52536014)(5660300002)(86362001)(478600001)(44832011)(107886003)(8936002)(8676002)(9686003)(53546011)(54906003)(7416002)(186003)(33656002)(76116006)(316002)(966005)(55016002)(66946007)(66446008)(64756008)(66556008)(71200400001)(4326008)(6916009)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rcoKVwtOSdhOHl+W7U9JFCMg5dHjIkqK5ZxgTVNbroYjJ4+glLWj81Vtw8ETov3n4c/+ZzcHr3kzFZRceTF01ccjuD8bx3Hfnf48APSQqgp6iSHsWWj+E4eu1BbIDZpR6gyrRytrJY/8wfQqHIjXKKwqWRTtRFr9YhEfbl51/Bh8ep4/Llamd4WIMvlQHRDmnXQ40IfOuR41pQosILRo5h49a9Cxu6zkkyRh+RlCdjRGy+fZ8nzkx8JMC7mE4/kjWIEDqtnc+VN4Z5Dm6hV/R/ZtxBJKQzjtP0sYG27iIr15arOw0gjbTFpkfoTk2t4k/hvf+aBQQ6w+VrScUzVne6eEymZ8ELghGwP3aZvyBTZKAVepQP+kl1LZQpGaPr9C52z0B348NWS9YUIqAEe0BZbMCQzn01O3wS1wOpup5jmtots541J1vmp8vOsVK5M+DSXQVl2Q6Bwncy6Mi0YbBKVfIFyrc1bOC8U0wU3oZY119j7wRzurb/Q/+mQGJlGVyRq2d0JuinQmji75IJ/Eqq1qgIpvfuGn3r0YHQAPPQqmvYLyW82FxMQ8vbyo5cjozmYucrwOUcGixw7WzgZNLqf91wQbyVjze7L0uS5Rw936bSFcudhHwui8Cqwvqo/xbmZcgtzfW4MZe2RLqxkueA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2651f3-7d3a-427c-08a5-08d84ef9bb11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 04:36:16.4124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9Q+PkSZxxS+xmLPM0p3nQ6h51KKFhaWJZgR3bd+Du6rpTfILTVQ+TgO9tXIUxLgSrjw3IgJx9GCtGegyAJiBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2658
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogMzEgQXVndXN0IDIwMjAgMTQ6MjINCj4gVG86IFlhc2ggU2hh
aCA8eWFzaC5zaGFoQG9wZW5maXZlLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgcGFs
bWVyQGRhYmJlbHQuY29tOyBQYXVsIFdhbG1zbGV5ICggU2lmaXZlKQ0KPiA8cGF1bC53YWxtc2xl
eUBzaWZpdmUuY29tPjsgbWNoZWhhYkBrZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOw0K
PiBhb3VAZWVjcy5iZXJrZWxleS5lZHU7IGphbWVzLm1vcnNlQGFybS5jb207IHJyaWNodGVyQG1h
cnZlbGwuY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmlzY3ZAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWVkYWNAdmdlci5rZXJuZWwub3JnOyBTYWNoaW4gR2hhZGkNCj4gPHNhY2hpbi5naGFkaUBvcGVu
Zml2ZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBlZGFjOiBzaWZpdmU6IEFkZCBF
REFDIHN1cHBvcnQgZm9yIE1lbW9yeQ0KPiBDb250cm9sbGVyIGluIFNpRml2ZSBTb0NzDQo+IA0K
PiBbRXh0ZXJuYWwgRW1haWxdIERvIG5vdCBjbGljayBsaW5rcyBvciBhdHRhY2htZW50cyB1bmxl
c3MgeW91IHJlY29nbml6ZSB0aGUNCj4gc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUNCj4gDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGVkYWM6IHNpZml2ZTogQWRkIEVE
QUMgc3VwcG9ydCBmb3IgTWVtb3J5DQo+ID4gQ29udHJvbGxlciBpbiBTaUZpdmUgU29Dcw0KPiAN
Cj4gRml4IHN1YmplY3QgcHJlZml4OiAiRURBQy9zaWZpdmU6IC4uLiINCj4gDQo+IE9uIFR1ZSwg
QXVnIDI1LCAyMDIwIGF0IDA1OjM2OjIyUE0gKzA1MzAsIFlhc2ggU2hhaCB3cm90ZToNCj4gPiBB
ZGQgTWVtb3J5IGNvbnRyb2xsZXIgRURBQyBzdXBwb3J0IGluIGV4aXNpdGluZyBTaUZpdmUgcGxh
dGZvcm0gRURBQw0KPiANCj4gcy9pbiBleGlzaXRpbmcvdG8gdGhlLw0KPiANCj4gPiBkcml2ZXIu
IEl0IHJlZ2lzdGVycyBmb3Igbm90aWZpZXIgZXZlbnRzIGZyb20gdGhlIFNpRml2ZSBERFINCj4g
PiBjb250cm9sbGVyIGRyaXZlciBmb3IgRERSIEVDQyBldmVudHMuDQo+IA0KPiBTaW1wbGlmeToN
Cj4gDQo+ICJJdCByZWdpc3RlcnMgZm9yIEVDQyBub3RpZmllciBldmVudHMgZnJvbSB0aGUgbWVt
b3J5IGNvbnRyb2xsZXIuIg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYXNoIFNoYWggPHlhc2gu
c2hhaEBzaWZpdmUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2VkYWMvS2NvbmZpZyAgICAg
ICB8ICAgMiArLQ0KPiA+ICBkcml2ZXJzL2VkYWMvc2lmaXZlX2VkYWMuYyB8IDExNw0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDExOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9lZGFjL0tjb25maWcgYi9kcml2ZXJzL2VkYWMvS2NvbmZpZyBpbmRl
eA0KPiA+IDdiNmVjMzAuLmY4YjNiNTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL0tj
b25maWcNCj4gPiArKysgYi9kcml2ZXJzL2VkYWMvS2NvbmZpZw0KPiA+IEBAIC00NjIsNyArNDYy
LDcgQEAgY29uZmlnIEVEQUNfQUxURVJBX1NETU1DDQo+ID4NCj4gPiAgY29uZmlnIEVEQUNfU0lG
SVZFDQo+ID4gICAgICAgYm9vbCAiU2lmaXZlIHBsYXRmb3JtIEVEQUMgZHJpdmVyIg0KPiA+IC0g
ICAgIGRlcGVuZHMgb24gRURBQz15ICYmIFNJRklWRV9MMg0KPiA+ICsgICAgIGRlcGVuZHMgb24g
RURBQz15ICYmIChTSUZJVkVfTDIgfHwgU0lGSVZFX0REUikNCj4gPiAgICAgICBoZWxwDQo+ID4g
ICAgICAgICBTdXBwb3J0IGZvciBlcnJvciBkZXRlY3Rpb24gYW5kIGNvcnJlY3Rpb24gb24gdGhl
IFNpRml2ZSBTb0NzLg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9zaWZpdmVf
ZWRhYy5jIGIvZHJpdmVycy9lZGFjL3NpZml2ZV9lZGFjLmMNCj4gPiBpbmRleCAzYTNkY2IxLi5j
ZjAzMjY4NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2VkYWMvc2lmaXZlX2VkYWMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZWRhYy9zaWZpdmVfZWRhYy5jDQo+ID4gQEAgLTExLDE0ICsxMSwxMjAg
QEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICAjaW5jbHVk
ZSAiZWRhY19tb2R1bGUuaCINCj4gPiAgI2luY2x1ZGUgPHNvYy9zaWZpdmUvc2lmaXZlX2wyX2Nh
Y2hlLmg+DQo+ID4gKyNpbmNsdWRlIDxzb2Mvc2lmaXZlL3NpZml2ZV9kZHIuaD4NCj4gPg0KPiA+
ICAjZGVmaW5lIERSVk5BTUUgInNpZml2ZV9lZGFjIg0KPiA+ICsjZGVmaW5lIFNJRklWRV9FREFD
X01PRF9OQU1FICJTaWZpdmUgRUNDIE1hbmFnZXIiDQo+IA0KPiBzL1NJRklWRV9FREFDX01PRF9O
QU1FL0VEQUNfTU9EX05BTUUvZw0KPiANCj4gbGlrZSB0aGUgb3RoZXIgRURBQyBkcml2ZXJzLg0K
PiANCg0KU3VyZSwgd2lsbCBtYWtlIGFsbCB0aGUgYWJvdmUgc3VnZ2VzdGVkIHRleHR1YWwgY2hh
bmdlcyBpbiB2Mi4NCg0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgZWNjX21jX3JlZ2lzdGVy
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArICAgICBzdHJ1Y3Qgc2lmaXZl
X2VkYWNfbWNfcHJpdiAqcDsNCj4gPiArICAgICBzdHJ1Y3QgZWRhY19tY19sYXllciBsYXllcnNb
MV07DQo+ID4gKyAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgcCA9IGRldm1fa3phbGxv
YygmcGRldi0+ZGV2LCBzaXplb2YoKnApLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICBpZiAoIXAp
DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKyAgICAgcC0+
bm90aWZpZXIubm90aWZpZXJfY2FsbCA9IGVjY19tY19lcnJfZXZlbnQ7DQo+ID4gKyAgICAgcGxh
dGZvcm1fc2V0X2RydmRhdGEocGRldiwgcCk7DQo+ID4gKw0KPiA+ICsgICAgIGxheWVyc1swXS50
eXBlID0gRURBQ19NQ19MQVlFUl9DSElQX1NFTEVDVDsNCj4gPiArICAgICBsYXllcnNbMF0uc2l6
ZSA9IDE7DQo+ID4gKyAgICAgbGF5ZXJzWzBdLmlzX3ZpcnRfY3Nyb3cgPSB0cnVlOw0KPiA+ICsN
Cj4gPiArICAgICBwLT5tY2kgPSBlZGFjX21jX2FsbG9jKDAsIEFSUkFZX1NJWkUobGF5ZXJzKSwg
bGF5ZXJzLCAwKTsNCj4gPiArICAgICBpZiAoIXAtPm1jaSkgew0KPiA+ICsgICAgICAgICAgICAg
ZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIG1lbSBhbGxvY2F0aW9uIGZvciBtYyBpbnN0YW5j
ZVxuIik7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArICAgICB9DQo+
ID4gKw0KPiA+ICsgICAgIHAtPm1jaS0+cGRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgLyog
SW5pdGlhbGl6ZSBjb250cm9sbGVyIGNhcGFiaWxpdGllcyAqLw0KPiA+ICsgICAgIHAtPm1jaS0+
bXR5cGVfY2FwID0gTUVNX0ZMQUdfRERSNDsNCj4gPiArICAgICBwLT5tY2ktPmVkYWNfY3RsX2Nh
cCA9IEVEQUNfRkxBR19OT05FIHwgRURBQ19GTEFHX1NFQ0RFRDsNCj4gPiArICAgICBwLT5tY2kt
PmVkYWNfY2FwID0gRURBQ19GTEFHX1NFQ0RFRDsNCj4gPiArICAgICBwLT5tY2ktPnNjcnViX2Nh
cCA9IFNDUlVCX1VOS05PV047DQo+ID4gKyAgICAgcC0+bWNpLT5zY3J1Yl9tb2RlID0gU0NSVUJf
SFdfUFJPRzsNCj4gPiArICAgICBwLT5tY2ktPmN0bF9uYW1lID0gZGV2X25hbWUoJnBkZXYtPmRl
dik7DQo+ID4gKyAgICAgcC0+bWNpLT5kZXZfbmFtZSA9IGRldl9uYW1lKCZwZGV2LT5kZXYpOw0K
PiA+ICsgICAgIHAtPm1jaS0+bW9kX25hbWUgPSBTSUZJVkVfRURBQ19NT0RfTkFNRTsNCj4gPiAr
ICAgICBwLT5tY2ktPmN0bF9wYWdlX3RvX3BoeXMgPSBOVUxMOw0KPiA+ICsNCj4gPiArICAgICAv
KiBJbnRlcnJ1cHQgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgYnkgY2FkZW5jZSBtYyAqLw0KPiA+ICsg
ICAgIGVkYWNfb3Bfc3RhdGUgPSBFREFDX09QU1RBVEVfSU5UOw0KPiA+ICsNCj4gPiArICAgICBy
ZXQgPSBlZGFjX21jX2FkZF9tYyhwLT5tY2kpOw0KPiA+ICsgICAgIGlmIChyZXQpIHsNCj4gPiAr
ICAgICAgICAgICAgIGVkYWNfcHJpbnRrKEtFUk5fRVJSLCBTSUZJVkVfRURBQ19NT0RfTkFNRSwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8gcmVnaXN0ZXIgd2l0aCBF
REFDIGNvcmVcbiIpOw0KPiA+ICsgICAgICAgICAgICAgZ290byBlcnI7DQo+ID4gKyAgICAgfQ0K
PiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR19TSUZJVkVfRERSDQo+IA0KPiBJdCBzZWVtcyBhbGwg
dGhhdCBpZmRlZmZlcnkgY2FuIGJlIHJlcGxhY2VkIHdpdGgNCj4gDQo+ICAgICAgICAgaWYgKElT
X0VOQUJMRUQoQ09ORklHXy4uLikpDQoNClllcywgd2lsbCByZXBsYWNlIGFsbCB0aGUgaWZkZWZm
ZXJ5IGluIHYyDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCi0gWWFzaA0KDQo+IA0KPiBUaHgu
DQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMuDQo+IA0KPiBodHRwczov
L3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0K
