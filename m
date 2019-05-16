Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90A120F8C
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfEPUVD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 16:21:03 -0400
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:30784
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726409AbfEPUVC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 16:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs4z4NY3V5fnHVdTAc8f8dMW6CJWTRHQJl4fA3vb1So=;
 b=d9DNo1U4j2xuebXxzHu9U6u9Gm0ehwGTfP/PMtGqhWucc/9Z0S7Tuk6ErZfhNc3J98rMgSJdxDf/djq3J/SO3G/G0FVazLP69FJ1tYALUUvF+imrOnOf2ePhnAF16iSd9BUp7jIqMf9M/qhlufj6OZd7kAKaZPsJ7oRDw900QX4=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2608.namprd12.prod.outlook.com (52.135.102.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 20:20:58 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 20:20:58 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbCAAA1jAIAAAELggAAGlYCAADB8kA==
Date:   Thu, 16 May 2019 20:20:58 +0000
Message-ID: <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
In-Reply-To: <20190516172117.GC21857@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [208.54.70.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de854750-6a35-4d5d-fd90-08d6da3c01f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2608;
x-ms-traffictypediagnostic: SN6PR12MB2608:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB26088888576686F00C41C49AF80A0@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(13464003)(305945005)(6916009)(186003)(99286004)(53936002)(26005)(72206003)(6436002)(25786009)(14454004)(76176011)(86362001)(7696005)(6246003)(966005)(478600001)(33656002)(7736002)(52536014)(68736007)(4326008)(229853002)(5660300002)(8936002)(256004)(476003)(74316002)(446003)(2906002)(486006)(6116002)(11346002)(66066001)(3846002)(81166006)(54906003)(81156014)(8676002)(102836004)(64756008)(66556008)(66476007)(6306002)(9686003)(53546011)(6506007)(66446008)(55016002)(71200400001)(71190400001)(316002)(66946007)(73956011)(76116006)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2608;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xAnlB31FOIxevJmemIlVUGqiVKrhWjc47PFhcQsVOBILhnnnnyVBQ9G+0P+Y7RktafnvXR5Y8yxKgTIYlEdGeWK+i2QoL+XQJ3nlvPzjkXwu5+vRICwOltuyCOHYgtB+KEfhJdQzImcoHjERG1ByhhKtSuwDh5AlYm0Bliga2LQw2rCrgMs5HEfSQ2t/auRXbMhKuME3GU1so1SNZKz9VSFmZD/6MY/2tESjpo0r7oOgtbYfJojN5o/2mSBDDqxO5M6kUMH6dFhJHk/ornf0sSgBzvViI5lbJudup8G2P4NsKWntnf+vEB8EzD0IQnn8UVoBkHQmAE6wT220hCCpPCeGpRRmkADM816FoUghbPnaJJ86QNhYoxMY5aNat34IObDHHpmzCkVHeshSlieBPD/81dvTEX4qy/Ya6akagcE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de854750-6a35-4d5d-fd90-08d6da3c01f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 20:20:58.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVGh1cnNkYXksIE1heSAxNiwgMjAxOSAxMjoy
MSBQTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6
IEx1Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRlbC5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyA1LzZdIHg4Ni9NQ0U6IFNhdmUgTUNBIGNvbnRyb2wgYml0cyB0
aGF0IGdldCBzZXQgaW4gaGFyZHdhcmUNCj4gDQo+IA0KPiBPbiBUaHUsIE1heSAxNiwgMjAxOSBh
dCAwNTowOToxMVBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBTbyB0aGF0IHRo
ZSBzeXNmcyBmaWxlcyBzaG93IHRoZSBjb250cm9sIHZhbHVlcyB0aGF0IGFyZSBzZXQgaW4gdGhl
DQo+ID4gaGFyZHdhcmUuIEl0IHNlZW1lZCBsaWtlIHRoaXMgd291bGQgYmUgbW9yZSBoZWxwZnVs
IHRoYW4gc2hvd2luZyBhbGwNCj4gPiAweEYncy4NCj4gDQo+IFllYWgsIGJ1dCBpdCBoYXMgYmVl
biBsaWtlIHRoYXQgc2luY2UgZm9yZXZlciBhbmQgaXQgaGFzbid0IGJ1Z2dlZA0KPiBhbnlib2R5
LiBQcm9iYWJseSBiZWNhdXNlIGFueWJvZHkgZG9lc24ndCBldmVuIGxvb2sgYXQgdGhvc2UgZmls
ZXMuIEFzDQo+IFRvbnkgc2F5czoNCj4gDQo+ICJSQVMgaXMgYSBsb25lbHkgc3Vic3lzdGVtIC4u
LiBldmVuIEVEQUMgZ2V0cyBtb3JlIGxvdmUuIg0KPiANCj4gOi0pKSkNCj4gDQo+IEFuZCBhZGRp
bmcgeWV0IGFub3RoZXIgdmVuZG9yIGNoZWNrIGZvciB0aGlzIHNlZW1lZCBqdXN0IG5vdCB3b3J0
aCBpdC4NCj4gDQo+ID4gU2hvdWxkIEkgc2VuZCBvdXQgYW5vdGhlciB2ZXJzaW9uIG9mIHRoaXMg
c2V0Pw0KPiANCj4gSSBzaW1wbHkgemFwcGVkIDUvNi4gSSBzdGlsbCB0aGluayB5b3VyIDYvNiBt
YWtlcyBzZW5zZSB0aG91Z2guDQo+IA0KPiAtLS0NCj4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6
ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiBEYXRlOiBUdWUsIDMwIEFwciAyMDE5IDIwOjMyOjIxICsw
MDAwDQo+IFN1YmplY3Q6IFtQQVRDSF0geDg2L01DRTogRGV0ZXJtaW5lIE1DQSBiYW5rcycgaW5p
dCBzdGF0ZSBwcm9wZXJseQ0KPiANCj4gVGhlIE9TIGlzIGV4cGVjdGVkIHRvIHdyaXRlIGFsbCBi
aXRzIHRvIE1DQV9DVEwgZm9yIGVhY2ggYmFuaywNCj4gdGh1cyBlbmFibGluZyBlcnJvciByZXBv
cnRpbmcgaW4gYWxsIGJhbmtzLiBIb3dldmVyLCBzb21lIGJhbmtzDQo+IG1heSBiZSB1bnVzZWQg
aW4gd2hpY2ggY2FzZSB0aGUgcmVnaXN0ZXJzIGZvciBzdWNoIGJhbmtzIGFyZQ0KPiBSZWFkLWFz
LVplcm8vV3JpdGVzLUlnbm9yZWQuIEFsc28sIHRoZSBPUyBtYXkgYXZvaWQgc2V0dGluZyBzb21l
IGNvbnRyb2wNCj4gYml0cyBiZWNhdXNlIG9mIHF1aXJrcywgZXRjLg0KPiANCj4gQSBiYW5rIGNh
biBiZSBjb25zaWRlcmVkIHVuaW5pdGlhbGl6ZWQgaWYgdGhlIE1DQV9DVEwgcmVnaXN0ZXIgcmV0
dXJucw0KPiB6ZXJvLiBUaGlzIGlzIGJlY2F1c2UgZWl0aGVyIHRoZSBPUyBkaWQgbm90IHdyaXRl
IGFueXRoaW5nIG9yIGJlY2F1c2UNCj4gdGhlIGhhcmR3YXJlIGlzIGVuZm9yY2luZyBSQVovV0kg
Zm9yIHRoZSBiYW5rLg0KPiANCj4gU2V0IGEgYmFuaydzIGluaXQgdmFsdWUgYmFzZWQgb24gaWYg
dGhlIGNvbnRyb2wgYml0cyBhcmUgc2V0IG9yIG5vdCBpbg0KPiBoYXJkd2FyZS4gUmV0dXJuIGFu
IGVycm9yIGNvZGUgaW4gdGhlIHN5c2ZzIGludGVyZmFjZSBmb3IgdW5pbml0aWFsaXplZA0KPiBi
YW5rcy4NCj4gDQo+ICBbIGJwOiBNYXNzYWdlIGEgYml0LiBdDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4gQ2M6ICJILiBQZXRlciBBbnZpbiIgPGhw
YUB6eXRvci5jb20+DQo+IENjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCj4gQ2M6
ICJsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZyIgPGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3Jn
Pg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENjOiBUb255
IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IENjOiAieDg2QGtlcm5lbC5vcmciIDx4ODZA
a2VybmVsLm9yZz4NCj4gTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MDQzMDIw
MzIwNi4xMDQxNjMtNy1ZYXplbi5HaGFubmFtQGFtZC5jb20NCj4gLS0tDQo+ICBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L21jZS9jb3JlLmMgfCAxNyArKysrKysrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9t
Y2UvY29yZS5jDQo+IGluZGV4IDViY2VjYWRjZjRkOS4uYzA0OTY4OWYzZDczIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL2NwdS9tY2UvY29yZS5jDQo+IEBAIC0xNTY3LDEwICsxNTY3LDEzIEBAIHN0YXRpYyB2b2lk
IF9fbWNoZWNrX2NwdV9pbml0X2NsZWFyX2JhbmtzKHZvaWQpDQo+ICAgICAgICAgZm9yIChpID0g
MDsgaSA8IHRoaXNfY3B1X3JlYWQobWNlX251bV9iYW5rcyk7IGkrKykgew0KPiAgICAgICAgICAg
ICAgICAgc3RydWN0IG1jZV9iYW5rICpiID0gJm1jZV9iYW5rc1tpXTsNCj4gDQo+IC0gICAgICAg
ICAgICAgICBpZiAoIWItPmluaXQpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
Ow0KPiAtICAgICAgICAgICAgICAgd3Jtc3JsKG1zcl9vcHMuY3RsKGkpLCBiLT5jdGwpOw0KPiAt
ICAgICAgICAgICAgICAgd3Jtc3JsKG1zcl9vcHMuc3RhdHVzKGkpLCAwKTsNCj4gKyAgICAgICAg
ICAgICAgIGlmIChiLT5pbml0KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHdybXNybCht
c3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgd3Jtc3Js
KG1zcl9vcHMuc3RhdHVzKGkpLCAwKTsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKw0KPiArICAg
ICAgICAgICAgICAgLyogQmFuayBpcyBpbml0aWFsaXplZCBpZiBiaXRzIGFyZSBzZXQgaW4gaGFy
ZHdhcmUuICovDQo+ICsgICAgICAgICAgICAgICBiLT5pbml0ID0gISFiLT5jdGw7DQoNCldlIGRv
bid0IGFjdHVhbGx5IGtub3cgaWYgdGhlcmUgYXJlIGJpdHMgc2V0IGluIGhhcmR3YXJlIHVudGls
IHdlIHJlYWQgaXQgYmFjay4gU28gSSBkb24ndCB0aGluayB0aGlzIGlzIGFkZGluZyBhbnl0aGlu
ZyBuZXcuDQoNClRoYW5rcywNCllhemVuDQo=
