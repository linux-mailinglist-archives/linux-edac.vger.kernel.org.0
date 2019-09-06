Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3BAC052
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2019 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406390AbfIFTPA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Sep 2019 15:15:00 -0400
Received: from mail-eopbgr800088.outbound.protection.outlook.com ([40.107.80.88]:19808
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406259AbfIFTPA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Sep 2019 15:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD3RUvO4yIqGK3v8D/QUkPdulUxirljYblhNKgeDfDe+GsPEPDUqqfxPvr2lGkQKP34hh81tY7JN7xSX4lU0AYULy1j2+qUpPluWT9yfqnHalXyQXSHjoQetZ5vHGAK0Mi1KhT+XejmcYx1jONlTEgSrnMe9UYoxDOHeszgfolOuGEYIlxBc2LBhnRYXleaMSEFs3lN3opqW97wEhhlJd045H7jOksqQuRZyVb0BhrTLTYSAJMIML/O3zM7QI6b9i0XFjmdMwaWmaG1Su+VuIHIlPO9N8FnO9qYYp2oy1q5pJaez60faGYVuFoY+zXMsq68J8Gs8KvSVEiS13+PS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB3k6bTgF3j7lQfLGYLics0aGFFEQ6mC1UELbqQvzi4=;
 b=con088tAeUjbJ5kd5+gNMcu/w/udddqKfbxV/vdeWmCNPqI6wesCBj7MoofG416vA+rug8eth7zrUGGCUwdgKXwqximvMSxhld59OueKDMRsZGgRqGtXmJxw6RnldDsNW3db/j87Sj3bjycK8tBDc8AAUBYqFtLJd+2HwcyWT+LqdQvVu0dJPmkMtKLLmmXXlFkUpgioBIbCUPbjQB3g0D5zhbmUhahgrUYKsdgzttZHkgS21x8cNilUUtiy9eDiphNaFRkgJPFiJJM05n+gFnCg05Pz/VTNvNq2MxCxZe4dTl6RMC/0FkmTOzL8yXiDXHxa3XkfYWr/nX/v4v3lMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB3k6bTgF3j7lQfLGYLics0aGFFEQ6mC1UELbqQvzi4=;
 b=iPa+iYblccT3fzqPg7JsYioqPo4eWeXL5fFFOVF5+Bb86+TYET1r23D2NjTFys5hHunirQRyZaD6cu4zS/SNCKNwP6UCg2IXHqdSu/hGmJZ2aXPUiQlvxgJZjxTK2nvLe35zTsKX+7SEfSVuHdGx0hLkylSyVgbylp7MNLbidMk=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2653.namprd12.prod.outlook.com (52.135.103.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 6 Sep 2019 19:14:58 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::307c:a378:f96e:690]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::307c:a378:f96e:690%7]) with mapi id 15.20.2220.020; Fri, 6 Sep 2019
 19:14:58 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information
 early
Thread-Topic: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information
 early
Thread-Index: AQHVWHyM0yWTJ6Qnuku4Pj6P3bApxacR5aOAgA03aPA=
Date:   Fri, 6 Sep 2019 19:14:57 +0000
Message-ID: <SN6PR12MB26393DDA0F1818DCDD2D7953F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190821235938.118710-9-Yazen.Ghannam@amd.com>
 <20190829092241.GB1312@zn.tnic>
In-Reply-To: <20190829092241.GB1312@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab6e0dd1-b31f-4e3d-e54f-08d732fe8208
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2653;
x-ms-traffictypediagnostic: SN6PR12MB2653:
x-microsoft-antispam-prvs: <SN6PR12MB26539FDDEA4288A6DD99192EF8BA0@SN6PR12MB2653.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(199004)(189003)(13464003)(99286004)(74316002)(7736002)(14454004)(11346002)(478600001)(476003)(6436002)(2906002)(55016002)(305945005)(446003)(9686003)(71190400001)(66476007)(66446008)(64756008)(66556008)(66946007)(25786009)(76116006)(229853002)(26005)(76176011)(186003)(256004)(7696005)(102836004)(53546011)(71200400001)(6506007)(6916009)(5660300002)(3846002)(4326008)(33656002)(52536014)(53936002)(81166006)(81156014)(8676002)(86362001)(66066001)(486006)(316002)(54906003)(6246003)(6116002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2653;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sy/pSm+aXgAiHCFufxJu1hsZSFPRdOgXFuvV+QBUC7PfzQjJ90MRXNImOV6kcrPe1PmipM/HrW1GUgk80rz4tTTJXgx7aegl7Vt8lOWLAo6sSqlieHCmvIFkjk+zfWpWr/S3cdfthrJG+5M2g2QR+5uBAMIcZ+WvgeJ/6RaOZOf+tvndreLewu0x98klGrwoiHMzce3g0wdZ+IHMftSLrLwwv0v5jQBWGo+diGFkfDQgLQhsF3/CNk7SpNo335SDbVwO0AHToLFoO0tcfJXI+rpnkW1Gv+lbk+FA19c+/sTcvG4SDhsA+Ol6ud6E6fKhD/gQP4xUDpGkc4kNgLXxbwMcKPvNdgHx15qOtf+kgJWgM/3b/QVKSH1egKo/PSytxxwDiPgzXOVtPLDFAZIBFGUn5I78Gc46eEawtolzdvA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6e0dd1-b31f-4e3d-e54f-08d732fe8208
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:14:57.8818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5yspuBDMId9CgTQJP7/OiVT8VgwwX4vVWZisXon/T8KsoLuAL5UPM7ZgZkH4ZKgreJvVjdsrM5ZIRh4CqqwHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2653
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBC
ZWhhbGYgT2YgQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjksIDIw
MTkgNDoyMyBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4N
Cj4gQ2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYzIDA4LzEwXSBFREFDL2FtZDY0OiBH
YXRoZXIgaGFyZHdhcmUgaW5mb3JtYXRpb24gZWFybHkNCj4gDQo+IE9uIFRodSwgQXVnIDIyLCAy
MDE5IGF0IDEyOjAwOjAyQU0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0KPiA+IEZyb206
IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4gPg0KPiA+IFNwbGl0IG91
dCBnYXRoZXJpbmcgaGFyZHdhcmUgaW5mb3JtYXRpb24gZnJvbSBpbml0X29uZV9pbnN0YW5jZSgp
IGludG8gYQ0KPiA+IHNlcGFyYXRlIGZ1bmN0aW9uIGdldF9oYXJkd2FyZV9pbmZvKCkuDQo+ID4N
Cj4gPiBUaGlzIGlzIG5lY2Vzc2FyeSBzbyB0aGF0IHRoZSBpbmZvcm1hdGlvbiBjYW4gYmUgY2Fj
aGVkIGVhcmxpZXIgYW5kIHVzZWQNCj4gPiB0byBjaGVjayBpZiBtZW1vcnkgaXMgcG9wdWxhdGVk
IGFuZCBpZiBFQ0MgaXMgZW5hYmxlZCBvbiBhIG5vZGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgfCA3NiArKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDMxIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFj
LmMgYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQo+ID4gaW5kZXggNGQxZTZkYWE3ZWM0Li44
NDgzMjc3MWRlYzAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCj4gPiBAQCAtMzQwNSwzNCArMzQw
NSwxNyBAQCBzdGF0aWMgdm9pZCBjb21wdXRlX251bV91bWNzKHZvaWQpDQo+ID4gIAllZGFjX2Ri
ZygxLCAiTnVtYmVyIG9mIFVNQ3M6ICV4IiwgbnVtX3VtY3MpOw0KPiA+ICB9DQo+ID4NCj4gPiAt
c3RhdGljIGludCBpbml0X29uZV9pbnN0YW5jZSh1bnNpZ25lZCBpbnQgbmlkKQ0KPiA+ICtzdGF0
aWMgaW50IGdldF9oYXJkd2FyZV9pbmZvKHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCwNCj4gPiArCQkJ
ICAgICBzdHJ1Y3QgYW1kNjRfZmFtaWx5X3R5cGUgKmZhbV90eXBlKQ0KPiA+ICB7DQo+ID4gLQlz
dHJ1Y3QgcGNpX2RldiAqRjMgPSBub2RlX3RvX2FtZF9uYihuaWQpLT5taXNjOw0KPiA+IC0Jc3Ry
dWN0IGFtZDY0X2ZhbWlseV90eXBlICpmYW1fdHlwZSA9IE5VTEw7DQo+ID4gLQlzdHJ1Y3QgbWVt
X2N0bF9pbmZvICptY2kgPSBOVUxMOw0KPiA+IC0Jc3RydWN0IGVkYWNfbWNfbGF5ZXIgbGF5ZXJz
WzJdOw0KPiA+IC0Jc3RydWN0IGFtZDY0X3B2dCAqcHZ0ID0gTlVMTDsNCj4gPiAgCXUxNiBwY2lf
aWQxLCBwY2lfaWQyOw0KPiA+IC0JaW50IGVyciA9IDAsIHJldDsNCj4gPiAtDQo+ID4gLQlyZXQg
PSAtRU5PTUVNOw0KPiA+IC0JcHZ0ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGFtZDY0X3B2dCks
IEdGUF9LRVJORUwpOw0KPiA+IC0JaWYgKCFwdnQpDQo+ID4gLQkJZ290byBlcnJfcmV0Ow0KPiA+
IC0NCj4gPiAtCXB2dC0+bWNfbm9kZV9pZAk9IG5pZDsNCj4gPiAtCXB2dC0+RjMgPSBGMzsNCj4g
PiAtDQo+ID4gLQlyZXQgPSAtRUlOVkFMOw0KPiA+IC0JZmFtX3R5cGUgPSBwZXJfZmFtaWx5X2lu
aXQocHZ0KTsNCj4gPiAtCWlmICghZmFtX3R5cGUpDQo+ID4gLQkJZ290byBlcnJfZnJlZTsNCj4g
PiArCWludCByZXQgPSAtRUlOVkFMOw0KPiA+DQo+ID4gIAlpZiAocHZ0LT5mYW0gPj0gMHgxNykg
ew0KPiA+ICAJCXB2dC0+dW1jID0ga2NhbGxvYyhudW1fdW1jcywgc2l6ZW9mKHN0cnVjdCBhbWQ2
NF91bWMpLCBHRlBfS0VSTkVMKTsNCj4gDQo+IFllYWgsIGEgZ2V0X2hhcmR3YXJlX2luZm8oKSBm
dW5jdGlvbiB3aGljaCBkb2VzIGFuIGFsbG9jYXRpb24gb2YgdGhhdA0KPiBzdHJ1Y3QgYW1kNjRf
dW1jIG9uID0+IEYxNyB3aGljaCBpcyBvbmx5IDIwIGJ5dGVzLiBKdXN0IGFkZCBpdCBpbnRvIHRo
ZQ0KPiBwdnQgc3RydWN0Og0KPiANCj4gc3RydWN0IGFtZDY0X3B2dCB7DQo+IAkuLi4NCj4gCXN0
cnVjdCBhbWQ2NF91bWMgdW1jOyAgLyogVU1DIHJlZ2lzdGVycyAqLw0KPiB9Ow0KPiANCj4gYW5k
IGJlIGRvbmUgd2l0aCBpdC4gVGhpcyBzaG91bGQgc2ltcGxpZnkgdGhlIGNvZGUgZmxvdyBoZXJl
IGEgYml0IGFuZA0KPiAyMCBieXRlcyBtb3JlIHBlciBwdnQgaXMgbm90IGEgYmlnIGRlYWwuDQo+
IA0KDQpUaGlzIHN0cnVjdCBpcyB1c2VkIHBlciBjaGFubmVsLCBzbyB3ZSBtYXkgaGF2ZSAyLTgg
cGVyIHN5c3RlbS4gV2UgY291bGQgZml4IGl0IGF0IHRoZSBtYXggKDgpLg0KV2hhdCBkbyB5b3Ug
dGhpbms/DQoNClRoYW5rcywNCllhemVuDQo=
