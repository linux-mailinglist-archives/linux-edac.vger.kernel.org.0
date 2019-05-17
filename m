Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6916321AEC
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 17:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfEQPqX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 11:46:23 -0400
Received: from mail-eopbgr750081.outbound.protection.outlook.com ([40.107.75.81]:42030
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729000AbfEQPqW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 11:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhjFSqv3U9EFLOPwV1OXKdDvCt4B/B8JOvpicyAdcGE=;
 b=E0E/vFTQxk5gwzq/UzsWDg2tUEKOfQT0fEGxoy1Bk7lhnkHqkZPmVKNDJzwB45I1dHpjrCWPHEPDvZjwg3LbLCYFyaiamqgTWlilF5gTMqktuZAznURzRnT0+p9EgLnDmI1YjsxoW2+/NujBOmt0Q90aCLDDvChjG2jZhbIvJTI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2608.namprd12.prod.outlook.com (52.135.102.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 15:46:07 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 15:46:07 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbCAAA1jAIAAAELggAAGlYCAADB8kIAABZ8AgAAG7YCAANzUAIAAUaUw
Date:   Fri, 17 May 2019 15:46:07 +0000
Message-ID: <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic> <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
In-Reply-To: <20190517101006.GA32065@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [172.58.139.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3215e1d8-6134-4984-49a7-08d6dadec6d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2608;
x-ms-traffictypediagnostic: SN6PR12MB2608:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2608E6C7A45BB86F41C42191F80B0@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(13464003)(6116002)(74316002)(446003)(476003)(486006)(3846002)(2906002)(8936002)(66446008)(256004)(66066001)(66476007)(66556008)(64756008)(71200400001)(71190400001)(316002)(6306002)(73956011)(76116006)(9686003)(110136005)(102836004)(8676002)(81156014)(81166006)(54906003)(55016002)(66946007)(6506007)(53546011)(25786009)(76176011)(99286004)(26005)(6246003)(966005)(14454004)(7696005)(86362001)(11346002)(53936002)(6436002)(305945005)(186003)(72206003)(4326008)(5660300002)(229853002)(7736002)(478600001)(33656002)(68736007)(52536014)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2608;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xTWmK3qOm7VqJ2tjsPpzImHVNQs06hW+vw5gfhFuTgmpAja8aTexWsIQ/aipaWm1roxpfAehXit47aSfV0zre/qQZS/FTRgBmvjQsWzxzFj4FJfXOfx3O1vrAGGsP3BBdVcNSuJ12uBmWNVoP/qQG39mfpWZab+gDWaybV5a0UcE28zKsuVna+bUmuJHYcaBTgtJfQPPsfhGRtwAiC/FXloU+QIP8rqPDI7uasCm13zY0w09rN295aySXvApoRKHi2KD9oNq47ROSvcCeF523TUf5GkzQeopYfiVK3ZWwUzq4I9urPBkudyAPwtoCM3k7pXiFD/1n4ZA9w1xGaQXoLf95+7/NDNNlS/rHYtDWXhH23Sk0QZPm3vZ57kAnGqcycDsIgCnAiQ/urdV5lnYl4vksFl9y+9FUnxcSvjVpKc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3215e1d8-6134-4984-49a7-08d6dadec6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 15:46:07.1788
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
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMTkgNToxMCBB
TQ0KPiBUbzogTHVjaywgVG9ueSA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gQ2M6IEdoYW5uYW0s
IFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MyA1LzZdIHg4Ni9NQ0U6IFNhdmUgTUNBIGNvbnRyb2wgYml0cyB0aGF0
IGdldCBzZXQgaW4gaGFyZHdhcmUNCj4gDQo+IA0KPiBPbiBUaHUsIE1heSAxNiwgMjAxOSBhdCAw
MTo1OTo0M1BNIC0wNzAwLCBMdWNrLCBUb255IHdyb3RlOg0KPiA+IEkgdGhpbmsgdGhlIGludGVu
dCBvZiB0aGUgb3JpZ2luYWwgcGF0Y2ggd2FzIHRvIGZpbmQgb3V0DQo+ID4gd2hpY2ggYml0cyBh
cmUgImltcGxlbWVudGVkIGluIGhhcmR3YXJlIi4gSS5lLiB0aHJvdyBhbGwNCj4gPiAxJ3MgYXQg
dGhlIHJlZ2lzdGVyIGFuZCBzZWUgaWYgYW55IG9mIHRoZW0gc3RpY2suDQo+IA0KPiBBbmQsIGlu
IGFkZGl0aW9uLCBjaGVjayAtPmluaXQgYmVmb3JlIHNob3dpbmcvc2V0dGluZyBhIGJhbms6DQo+
IA0KPiAtLS0NCj4gQEAgLTIwOTUsNiArMjA5OCw5IEBAIHN0YXRpYyBzc2l6ZV90IHNob3dfYmFu
ayhzdHJ1Y3QgZGV2aWNlICpzLCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gDQo+
ICAgICAgICAgYiA9ICZwZXJfY3B1KG1jZV9iYW5rc19hcnJheSwgcy0+aWQpW2JhbmtdOw0KPiAN
Cj4gKyAgICAgICBpZiAoIWItPmluaXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RF
VjsNCj4gKw0KPiAgICAgICAgIHJldHVybiBzcHJpbnRmKGJ1ZiwgIiVsbHhcbiIsIGItPmN0bCk7
DQo+ICB9DQo+IA0KPiBAQCAtMjExMyw2ICsyMTE5LDkgQEAgc3RhdGljIHNzaXplX3Qgc2V0X2Jh
bmsoc3RydWN0IGRldmljZSAqcywgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+IA0K
PiAgICAgICAgIGIgPSAmcGVyX2NwdShtY2VfYmFua3NfYXJyYXksIHMtPmlkKVtiYW5rXTsNCj4g
DQo+ICsgICAgICAgaWYgKCFiLT5pbml0KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9E
RVY7DQo+ICsNCj4gICAgICAgICBiLT5jdGwgPSBuZXc7DQo+ICAgICAgICAgbWNlX3Jlc3RhcnQo
KTsNCj4gLS0tDQo+IA0KPiBzbyB0aGF0IHlvdSBnZXQgYSBmZWVkYmFjayB3aGV0aGVyIHRoZSBz
ZXR0aW5nIGhhcyBldmVuIHN1Y2NlZWRlZCBvcg0KPiBub3QuIFJpZ2h0IG5vdyB3ZSdyZSBkb2lu
ZyAic29tZXRoaW5nIiBibGluZGx5IGFuZCBhY2NlcHRpbmcgYW55IGItPmN0bA0KPiBmcm9tIHVz
ZXJzcGFjZS4gWWVhaCwgaXQgaXMgcm9vdC1vbmx5IGJ1dCBzdGlsbC4uLg0KPiANCj4gPiBJIGRv
bid0IG9iamVjdCB0byB0aGUgaWRlYSBiZWhpbmQgdGhlIHBhdGNoLiBCdXQgaWYgeW91IHdhbnQN
Cj4gPiB0byBkbyB0aGlzIHlvdSBqdXN0IHNob3VsZCBub3QgbW9kaWZ5IGItPmN0bC4NCj4gPg0K
PiA+IFNvIHNvbWV0aGluZyBsaWtlOg0KPiA+DQo+ID4NCj4gPiBzdGF0aWMgdm9pZCBfX21jaGVj
a19jcHVfaW5pdF9jbGVhcl9iYW5rcyh2b2lkKQ0KPiA+IHsNCj4gPiAgICAgICAgIHN0cnVjdCBt
Y2VfYmFuayAqbWNlX2JhbmtzID0gdGhpc19jcHVfcmVhZChtY2VfYmFua3NfYXJyYXkpOw0KPiA+
ICAgICAgIHU2NCB0bXA7DQo+ID4gICAgICAgICBpbnQgaTsNCj4gPg0KPiA+ICAgICAgICAgZm9y
IChpID0gMDsgaSA8IHRoaXNfY3B1X3JlYWQobWNlX251bV9iYW5rcyk7IGkrKykgew0KPiA+ICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgbWNlX2JhbmsgKmIgPSAmbWNlX2JhbmtzW2ldOw0KPiA+DQo+
ID4gICAgICAgICAgICAgICAgIGlmIChiLT5pbml0KSB7DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgd3Jtc3JsKG1zcl9vcHMuY3RsKGkpLCBiLT5jdGwpOw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHdybXNybChtc3Jfb3BzLnN0YXR1cyhpKSwgMCk7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgIHJkbXNybChtc3Jfb3BzLmN0bChpKSwgdG1wKTsNCj4gPg0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAvKiBDaGVjayBpZiBhbnkgYml0cyBpbXBsZW1lbnRlZCBpbiBoL3cgKi8N
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgYi0+aW5pdCA9ICEhdG1wOw0KPiA+ICAgICAgICAg
ICAgICAgICB9DQo+IA0KPiAuLi4gZXhjZXB0IHRoYXQgd2UgdW5jb25kaXRpb25hbGx5IHNldCAt
PmluaXQgdG8gMSBpbg0KPiBfX21jaGVja19jcHVfbWNlX2JhbmtzX2luaXQoKSBhbmQgSSB0aGlu
ayB3ZSBzaG91bGQgcXVlcnkgaXQuIEJ0dywgdGhhdA0KPiBuYW1lIF9fbWNoZWNrX2NwdV9tY2Vf
YmFua3NfaW5pdCgpIGlzIGhpZGVvdXMgdG9vLiBJJ2xsIGZpeCB0aG9zZSB1cC4gSW4NCj4gdGhl
IG1lYW50aW1lLCBob3cgZG9lcyB0aGUgYmVsb3cgbG9vayBsaWtlPyBUaGUgY2hhbmdlIGlzIHRv
IHRpY2tsZSBvdXQNCj4gZnJvbSB0aGUgaHcgd2hldGhlciBzb21lIENUTCBiaXRzIHN0aWNrIGFu
ZCB0aGVuIHVzZSB0aGF0IHRvIGRldGVybWluZQ0KPiBiLT5pbml0IHNldHRpbmc6DQo+IA0KPiAt
LS0NCj4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiBEYXRl
OiBUdWUsIDMwIEFwciAyMDE5IDIwOjMyOjIxICswMDAwDQo+IFN1YmplY3Q6IFtQQVRDSF0geDg2
L01DRTogRGV0ZXJtaW5lIE1DQSBiYW5rcycgaW5pdCBzdGF0ZSBwcm9wZXJseQ0KPiANCj4gVGhl
IE9TIGlzIGV4cGVjdGVkIHRvIHdyaXRlIGFsbCBiaXRzIHRvIE1DQV9DVEwgZm9yIGVhY2ggYmFu
aywNCj4gdGh1cyBlbmFibGluZyBlcnJvciByZXBvcnRpbmcgaW4gYWxsIGJhbmtzLiBIb3dldmVy
LCBzb21lIGJhbmtzDQo+IG1heSBiZSB1bnVzZWQgaW4gd2hpY2ggY2FzZSB0aGUgcmVnaXN0ZXJz
IGZvciBzdWNoIGJhbmtzIGFyZQ0KPiBSZWFkLWFzLVplcm8vV3JpdGVzLUlnbm9yZWQuIEFsc28s
IHRoZSBPUyBtYXkgYXZvaWQgc2V0dGluZyBzb21lIGNvbnRyb2wNCj4gYml0cyBiZWNhdXNlIG9m
IHF1aXJrcywgZXRjLg0KPiANCj4gQSBiYW5rIGNhbiBiZSBjb25zaWRlcmVkIHVuaW5pdGlhbGl6
ZWQgaWYgdGhlIE1DQV9DVEwgcmVnaXN0ZXIgcmV0dXJucw0KPiB6ZXJvLiBUaGlzIGlzIGJlY2F1
c2UgZWl0aGVyIHRoZSBPUyBkaWQgbm90IHdyaXRlIGFueXRoaW5nIG9yIGJlY2F1c2UNCj4gdGhl
IGhhcmR3YXJlIGlzIGVuZm9yY2luZyBSQVovV0kgZm9yIHRoZSBiYW5rLg0KPiANCj4gU2V0IGEg
YmFuaydzIGluaXQgdmFsdWUgYmFzZWQgb24gaWYgdGhlIGNvbnRyb2wgYml0cyBhcmUgc2V0IG9y
IG5vdCBpbg0KPiBoYXJkd2FyZS4gUmV0dXJuIGFuIGVycm9yIGNvZGUgaW4gdGhlIHN5c2ZzIGlu
dGVyZmFjZSBmb3IgdW5pbml0aWFsaXplZA0KPiBiYW5rcy4NCj4gDQo+ICBbIGJwOiBNYXNzYWdl
IGEgYml0LiBEaXNjb3ZlciBiYW5rIGluaXQgc3RhdGUgYXQgYm9vdC4gXQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+IENjOiAiSC4gUGV0ZXIgQW52
aW4iIDxocGFAenl0b3IuY29tPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+
DQo+IENjOiAibGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmciIDxsaW51eC1lZGFjQHZnZXIua2Vy
bmVsLm9yZz4NCj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBD
YzogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogIng4NkBrZXJuZWwub3Jn
IiA8eDg2QGtlcm5lbC5vcmc+DQo+IExpbms6IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAx
OTA0MzAyMDMyMDYuMTA0MTYzLTctWWF6ZW4uR2hhbm5hbUBhbWQuY29tDQo+IC0tLQ0KPiAgYXJj
aC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIHwgMjMgKysrKysrKysrKysrKysrKysrLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPiBpbmRleCA1YmNlY2FkY2Y0ZDkuLmQ4NGIwYzcwN2Qw
ZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPiBAQCAtMTQ5Miw5ICsxNDkyLDE2IEBA
IHN0YXRpYyBpbnQgX19tY2hlY2tfY3B1X21jZV9iYW5rc19pbml0KHZvaWQpDQo+IA0KPiAgICAg
ICAgIGZvciAoaSA9IDA7IGkgPCBuX2JhbmtzOyBpKyspIHsNCj4gICAgICAgICAgICAgICAgIHN0
cnVjdCBtY2VfYmFuayAqYiA9ICZtY2VfYmFua3NbaV07DQo+ICsgICAgICAgICAgICAgICB1NjQg
dmFsOw0KPiANCj4gICAgICAgICAgICAgICAgIGItPmN0bCA9IC0xVUxMOw0KPiAtICAgICAgICAg
ICAgICAgYi0+aW5pdCA9IDE7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIC8qIENoZWNrIGlmIGFu
eSBiaXRzIGFyZSBpbXBsZW1lbnRlZCBpbiBoL3cgKi8NCj4gKyAgICAgICAgICAgICAgIHdybXNy
bChtc3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCj4gKyAgICAgICAgICAgICAgIHJkbXNybChtc3Jf
b3BzLmN0bChpKSwgdmFsKTsNCj4gKyAgICAgICAgICAgICAgIGItPmluaXQgPSAhIXZhbDsNCj4g
Kw0KPiArICAgICAgICAgICAgICAgd3Jtc3JsKG1zcl9vcHMuc3RhdHVzKGkpLCAwKTsNCj4gICAg
ICAgICB9DQoNCkkgdGhpbmsgdGhlcmUgYXJlIGEgY291cGxlIG9mIGlzc3VlcyBoZXJlLg0KMSkg
VGhlIGJhbmsgaXMgYmVpbmcgaW5pdGlhbGl6ZWQgd2l0aG91dCBhY2NvdW50aW5nIGZvciBhbnkg
cXVpcmtzLg0KMikgVGhlIGJhbmsgaXMgYmVpbmcgaW5pdGlhbGl6ZWQgd2l0aG91dCBoYXZpbmcg
c2V0IHVwIGFueSBoYW5kbGVyIG9yIG90aGVyIGFwcHJvcHJpYXRlIHNldHVwLg0KDQpUaGFua3Ms
DQpZYXplbg0KDQo=
