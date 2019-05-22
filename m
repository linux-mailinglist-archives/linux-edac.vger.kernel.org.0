Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4126551
	for <lists+linux-edac@lfdr.de>; Wed, 22 May 2019 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfEVOBY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 May 2019 10:01:24 -0400
Received: from mail-eopbgr820059.outbound.protection.outlook.com ([40.107.82.59]:55616
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbfEVOBY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 May 2019 10:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxBppLEijZ4yUlx2wqTTRZ4Dlj49bmha9+EBSzSjwuk=;
 b=fRUcQO90Kf+NPtu+WEGzkWsrUS3VBf6HUpfw0hJfEXDAFEqagU1j6Odl6SFd98SnUmpJKegv3YFdb64BlhiLhOfXYXduO5ks1HCAcyF0N8xyKd+e1CsWCEVJrv65ML0uh9/dv4EcLmjSFvFkGKbjG8H3Upcy8Ou4Uw2xAXimd6k=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Wed, 22 May 2019 14:01:21 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.017; Wed, 22 May 2019
 14:01:21 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 4/6] x86/MCE: Make number of MCA banks per_cpu
Thread-Topic: [PATCH v3 4/6] x86/MCE: Make number of MCA banks per_cpu
Thread-Index: AQHU/5PPM7ZBD2KPAEGkkqngr+ktbaZw2aaAgAT1zzCAAFkKAIAAA88AgAApA4CAAPi2gA==
Date:   Wed, 22 May 2019 14:01:21 +0000
Message-ID: <SN6PR12MB26392392901AD4379E133BE0F8000@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-5-Yazen.Ghannam@amd.com>
 <20190518112530.GA26276@zn.tnic>
 <SN6PR12MB2639571E33EBC7342A0607F8F8070@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190521202902.GC7793@cz.tnic> <20190521204239.GA11029@agluck-desk>
 <20190521230927.GB2435@cz.tnic>
In-Reply-To: <20190521230927.GB2435@cz.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:e187:3cf8:9bd2:2742]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70bc8c0d-1f42-4f9a-72fa-08d6debdf86c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2639;
x-ms-traffictypediagnostic: SN6PR12MB2639:
x-microsoft-antispam-prvs: <SN6PR12MB2639E5F74B17346ACF00616AF8000@SN6PR12MB2639.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(13464003)(199004)(189003)(51444003)(6436002)(229853002)(73956011)(66946007)(15650500001)(478600001)(81156014)(53936002)(256004)(68736007)(7696005)(52536014)(64756008)(66446008)(66556008)(2906002)(186003)(76116006)(66476007)(33656002)(446003)(11346002)(72206003)(14454004)(486006)(8676002)(4326008)(305945005)(86362001)(81166006)(102836004)(6116002)(476003)(25786009)(46003)(6246003)(53546011)(7736002)(9686003)(6506007)(55016002)(54906003)(110136005)(76176011)(71190400001)(71200400001)(316002)(5660300002)(74316002)(8936002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2639;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y4RhJR8n1OJcA44DqIkytithg3bEj5iE8067uFK6n5iWmyCRbz1OmImoWr359waVin0e1nej4Nvgs/h1n5cP/YCbpEgBtuocN6KFlE/kp4k232pbbrFEovHJmoMUQPFUWUltaKUOdWL0OARByx2wHi1k1+qkhlaqjyfQzhT6EUqokId5GPLSdVID1QLFnPssodkel6J8poFvGqUoATCihqwKYEWetiMoHERtPy3zgkhQcFsRSs3CLwpgFjlwHvFrlcfFCB0A95ABD7249oNafp0BiTJQoxTWeGKq3AXVfKqA0JrBV/RT3g88TmPbsCUEstKJ2xpMvmoAQE3xoFmgE0zsLtRY3pPboNlCyb3BvcTSmUpoxQqGQ9c1FU3q09vVo+JYw/Yz1/DJv5W3x5XwJXLXVLJe0hAuQYz9fzGZzq8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bc8c0d-1f42-4f9a-72fa-08d6debdf86c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 14:01:21.6326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2639
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVHVlc2RheSwgTWF5IDIxLCAyMDE5IDY6MDkg
UE0NCj4gVG86IEx1Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IENjOiBHaGFubmFt
LCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPjsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgNC82XSB4ODYvTUNFOiBNYWtlIG51bWJlciBvZiBNQ0EgYmFua3Mg
cGVyX2NwdQ0KPiANCj4gDQo+IE9uIFR1ZSwgTWF5IDIxLCAyMDE5IGF0IDAxOjQyOjQwUE0gLTA3
MDAsIEx1Y2ssIFRvbnkgd3JvdGU6DQo+ID4gT24gVHVlLCBNYXkgMjEsIDIwMTkgYXQgMTA6Mjk6
MDJQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiA+ID4NCj4gPiA+IENhbiB3ZSBk
byBpbnN0ZWFkOg0KPiA+ID4NCj4gPiA+IC1zdGF0aWMgREVGSU5FX1BFUl9DUFVfUkVBRF9NT1NU
TFkoc3RydWN0IG1jZV9iYW5rICosIG1jZV9iYW5rc19hcnJheSk7DQo+ID4gPiArc3RhdGljIERF
RklORV9QRVJfQ1BVX1JFQURfTU9TVExZKHN0cnVjdCBtY2VfYmFuaywgbWNlX2JhbmtzX2FycmF5
W01BWF9OUl9CQU5LU10pOw0KPiA+ID4NCj4gPiA+IHdoaWNoIHNob3VsZCBiZSBzb21ldGhpbmcg
bGlrZSA5KjMyID0gMjg4IGJ5dGVzIHBlciBDUFUuDQo+ID4gPg0KPiA+DQo+ID4gV2hlcmUgZGlk
IHlvdSBnZXQgdGhlICI5IiBmcm9tPyAgc3RydWN0IG1jZV9iYW5rIGxvb2tzIHRvDQo+ID4gYmUg
b3ZlciA1MCBieXRlcy4NCj4gDQo+IFBhdGNoIDIvNiBjaGFuZ2VzIHRoYXQ6DQo+IA0KPiAgc3Ry
dWN0IG1jZV9iYW5rIHsNCj4gICAgICAgICB1NjQgICAgICAgICAgICAgICAgICAgICBjdGw7ICAg
ICAgICAgICAgICAgICAgICAvKiBzdWJldmVudHMgdG8gZW5hYmxlICovDQo+ICAgICAgICAgYm9v
bCAgICAgICAgICAgICAgICAgICAgaW5pdDsgICAgICAgICAgICAgICAgICAgLyogaW5pdGlhbGlz
ZSBiYW5rPyAqLw0KPiArfTsNCj4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVV9SRUFEX01PU1RMWShz
dHJ1Y3QgbWNlX2JhbmsgKiwgbWNlX2JhbmtzX3BlcmNwdSk7DQo+ICsNCj4gKyNkZWZpbmUgQVRU
Ul9MRU4gICAgICAgICAgICAgICAxNg0KPiArLyogT25lIG9iamVjdCBmb3IgZWFjaCBNQ0UgYmFu
aywgc2hhcmVkIGJ5IGFsbCBDUFVzICovDQo+ICtzdHJ1Y3QgbWNlX2JhbmtfZGV2IHsNCj4gICAg
ICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBhdHRyOyAgICAgICAgICAgICAgICAgICAvKiBk
ZXZpY2UgYXR0cmlidXRlICovDQo+ICAgICAgICAgY2hhciAgICAgICAgICAgICAgICAgICAgYXR0
cm5hbWVbQVRUUl9MRU5dOyAgICAgLyogYXR0cmlidXRlIG5hbWUgKi8NCj4gKyAgICAgICB1OCAg
ICAgICAgICAgICAgICAgICAgICBiYW5rOyAgICAgICAgICAgICAgICAgICAvKiBiYW5rIG51bWJl
ciAqLw0KPiAgfTsNCj4gK3N0YXRpYyBzdHJ1Y3QgbWNlX2JhbmtfZGV2IG1jZV9iYW5rX2RldnNb
TUFYX05SX0JBTktTXTsNCj4gDQo+ID4gU3RpbGwgb25seSAxLjVLIHBlciBjcHUgdGhvdWdoLg0K
PiANCj4gWWFoLCBJIHRoaW5rIHRoYXQgdXNpbmcgc3RhdGljIHBlci1DUFUgbWVtb3J5IHNob3Vs
ZCBiZSBiZXR0ZXIgdGhhbg0KPiBHRlBfQVRPTUlDLg0KPiANCg0KT2theSwgbWFrZXMgc2Vuc2Uu
IEknbGwgc2VuZCBhIHBhdGNoIHNvb24uDQoNClRoYW5rcywNCllhemVuDQo=
