Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40ED1992
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfJIUba (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 16:31:30 -0400
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:25089
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728804AbfJIUba (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 9 Oct 2019 16:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/c7z6xZ6P3p7cDUOexiwQjMkwxsXetVL4iXHKQNhlK7F5imLQ3o3lPhJWTytUPXnYRfvg1BlvBKIHPa+VxqhmHzWvu8MGc/IK6qz2LCwxpdxixc0/evEtP/FcRGQFy+EcuSHL/Fhnh6XPQAM2MDSJVZ5+9QNV4GmtcwXFpuPGizxBvgeuN6HoICv571vmrBOO7N5tlwfhLH9xeLnzZgzt9QC8YaG7ypo5Yz4vekwYeF5gQkFXN09vsbNiYufp+uYbzkQuyXA00XPtl1k7DIV+A9NgF8sMVatAgkGZKBuCSgfZae6ock4KrjE/Zf4yq+K7UlkCoiBGPI5CuhpOOLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvK/oGjmLCVvWbe2j7b812eEXf66+49PtSC1Oe2eSWE=;
 b=J/h6WkAqSBTy13zgU05N8+GPX8e/gEOWr+2CN7yeGqHFTyHAUs/S8qWyb+G6ywjGp2EChu+D4j/tVJf/qYCg4OAe5Kh46JBYqSRe0G/eZ0RoBI/ivaoSvLCCU9hWQ7CARFAOwxeyLAzIWyymEJ3t5g0T0L5EXV3IYd6b/D07DVz0KRNmbx/DXMQ8lMllV9zw0k/gLFYu+niFdSn0yVbXfnCAneH/Wwl1s8prf45k0XA1X4pi3dpbChxkLUdW8PIbRt9fZdv/iLi2dATkzVSKg6VYZZben+Uf+f9kyl4wS5XTHv5uxh4WdWQvXQfNplxW1mP64N9t455pulm9I5llwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvK/oGjmLCVvWbe2j7b812eEXf66+49PtSC1Oe2eSWE=;
 b=e96d8Dhmhfb9GMBJ0BTluBCQDvMiL55lAV+E4VkRuSs2zP9YCqRe1+ubeURtKalSD8of9FDW8fH6P4bo7xEEyf3BlSbfC6Bw27ih4d1xLR+TOMQMwWkOagRb38/rRVzmpV5C0bR+LhQv3UE4pdgQSb2YcNj2JmA0unYOHcsd498=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2752.namprd12.prod.outlook.com (52.135.107.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 9 Oct 2019 20:31:26 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 20:31:26 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Jeff God <jfgaudreault@gmail.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Thread-Topic: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h
 support
Thread-Index: AQHVe51JKTDxmyKbykahkp73y8AC1qdOxx+AgABffACAAX9igIAAg6EAgAA5tACAAL6mgIAAp9WA
Date:   Wed, 9 Oct 2019 20:31:26 +0000
Message-ID: <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic>
 <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
 <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
In-Reply-To: <20191009103041.GC10395@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1701CA0004.namprd17.prod.outlook.com
 (2603:10b6:405:15::14) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 547e04f7-5432-4c4e-2d55-08d74cf7a8a5
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2752:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2752C594533B2D8638C8D082F8950@SN6PR12MB2752.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(31686004)(486006)(71200400001)(966005)(446003)(476003)(11346002)(7736002)(2616005)(71190400001)(25786009)(66066001)(229853002)(6436002)(6486002)(110136005)(6306002)(6512007)(478600001)(2906002)(6246003)(4326008)(66946007)(36756003)(316002)(99286004)(66556008)(66446008)(64756008)(52116002)(76176011)(81166006)(81156014)(86362001)(14444005)(256004)(31696002)(8676002)(66476007)(102836004)(5660300002)(3846002)(386003)(6506007)(305945005)(14454004)(186003)(8936002)(26005)(53546011)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2752;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DVEgimwGOYWOJ3WOFmI5Wb8FBAW+lbIUaqCqgu9/X5Ko984Hl6MyFaAnTa5rq8mfuQI9sto6rf+NbfHxbZom3OfIKAYui1Q62TEYMe/0QkaHibtCwfY+cUQLSYPQnAFMb4m6U/I4vFDdQmevxLmPxdy6baXRTlnYokiZwcq8zsSm141BWpbbT50+PDoow/K56phfB9HZyXRllTG90KkYPyLW7Jnfl2EgNBuTuxXVclBSZtqSwFaR5geNmXQRthJtQf49NsMUnTW0zwVuyCp0o3Z4k9mDWiZPkHDkPwkLSjx+ukRloZvFVn9+4y+li+EjxotlZTob+mFykbtOFk4/UV7b3UgGBKQYlmj/N+vXzkSROiaLYDTyzU2IZ1WxaFpAz0OvDuhOLLUDPSF1mrcWjSuitVeWi4+BqYdii0QPAeQqZsrd7RU/hgBdOvBm59whmxuYWY6N3PZT9nkDiEykPw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A6DA56ECDE9924AA3350D7FE5D995D4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547e04f7-5432-4c4e-2d55-08d74cf7a8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 20:31:26.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFMsSct0ZbPT1I00RSmabAz1xLDCU/dkSDrFkLnLIvMMLhviFp9BtHuSf2iIAFeEShMKL3hxIGC5xBxB4JkQRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMTAvOS8yMDE5IDY6MzAgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMDgsIDIwMTkgYXQgMDc6MDg6MjBQTSAtMDQwMCwgSmVmZiBHb2Qgd3JvdGU6DQo+PiBJIGFs
c28gd2FudGVkIHRvIGFwb2xvZ2lzZSBmb3IgdGhlIHRleHQgZW1haWxzIGxpbmUgd3JhcHBpbmcs
IEkNCj4+IGhhdmVuJ3QgZm91bmQgYSB2aWFibGUgZW1haWwgY2xpZW50IGFsdGVybmF0aXZlLi4u
DQo+IA0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2Vt
YWlsLWNsaWVudHMuaHRtbA0KPiANCj4+IEkgZGlkIG5vdCBzZWUgYW55dGhpbmcgaW4gZG1lc2cs
IGFuZCBhbGwgc3RhdHVzIGZpbGVzIHJlbWFpbmVkIDANCj4+IChleGNlcHQgZmxhZyB3aGljaCB3
YXMgaHcpDQo+IA0KPiBOb3RoaW5nIGhlcmUgZWl0aGVyIGJ1dCBteSBtYWNoaW5lIGlzDQo+IA0K
PiB2ZW5kb3JfaWQgICAgICAgOiBBdXRoZW50aWNBTUQNCj4gY3B1IGZhbWlseSAgICAgIDogMjMN
Cj4gbW9kZWwgICAgICAgICAgIDogMQ0KPiBtb2RlbCBuYW1lICAgICAgOiBBTUQgRVBZQyA3MjUx
IDgtQ29yZSBQcm9jZXNzb3INCj4gc3RlcHBpbmcgICAgICAgIDogMg0KPiANCj4gc28gSSdtIGd1
ZXNzaW5nIGl0IG5lZWRzIHNvbWV0aGluZyBlbHNlIGZvciBpbmplY3Rpb24gdG8gd29yayBvbiB0
aG9zZQ0KPiBtb2RlbHMuLi4NCj4gDQoNCkFoIHllcywgc29ycnkgSSBmb3Jnb3QgdG8gbWVudGlv
biB0aGF0IHlvdSB3aWxsIG5lZWQgdG8gZGlzYWJsZSBQbGF0Zm9ybSBGaXJzdA0KRXJyb3IgSGFu
ZGxpbmcuIFRoaXMgY2FuIGJlIGRvbmUgaW4gdGhlIEJJT1MuIEl0J3MgdXN1YWxseSB1bmRlciBz
b21ldGhpbmcNCmxpa2U6DQoNCkFNRCBDQlMgLT4gIkNvcmUiIENvbW1vbiBPcHRpb25zIC0+IFBs
YXRmb3JtIEZpcnN0IEVycm9yIEhhbmRsaW5nDQoNClRoaXMgZmVhdHVyZSB3aWxsIHByZXZlbnQg
d3JpdGVzIHRvIHRoZSBNQ0EgcmVnaXN0ZXJzLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhp
cyB3b3JrcyBvciBub3QgZm9yIHlvdS4gSSdsbCBuZWVkIHRvIGRvIHNvbWUgbW9yZQ0KZGVidWcg
aWYgaXQgZG9lc24ndCB3b3JrLg0KDQo+PiBUaGUgbWVtb3J5IGNvbnRyb2xsZXIgYmFua3MgYXJl
IDE3IChjaGFubmVsIDApIGFuZCAxOCAoY2hhbm5lbCAxKSBvbiBGYW1pbHkNCj4+IDE3aCBNb2Rl
bCA3WGgsIGFuZCB0aGVzZSBhcmUgbWFuYWdlZCBieSBDUFUgMC4NCj4gDQo+IEJ0dywgWWF6ZW4s
IHdlIHByb2JhYmx5IG5lZWQgdG8gaGF2ZSBhbiBlYXN5IHdheSB0byBmaW5kIG91dA0KPiBob3cg
dGhlIGJhbmsgbWFwcGluZyBpcyBub3cgb24gU01DQSBtYWNoaW5lIHdoZW4gd2FudGluZyB0byBk
bw0KPiBpbmplY3Rpb24uIEkga25vdyB3ZSB0YWxrZWQgYWJvdXQgaGF2aW5nIHNvbWUgb2YgdGhh
dCBpbmZvIGluDQo+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbWFjaGluZWNoZWNrL21hY2hpbmVjaGVj
a1guLi4NCj4gDQoNClllcCwgSSBhZ3JlZS4gSSBoYXZlIHNvbWUgaWRlYXMsIGFuZCBJJ2xsIHNl
bmQgdGhlbSBhcyBSRkMgcGF0Y2hlcy4NCg0KPj4gQW5kIGV2ZW4gdGhpczoNCj4+IFsgIDYwOS42
ODE3MTRdIG1jZTogW0hhcmR3YXJlIEVycm9yXTogTWFjaGluZSBjaGVjayBldmVudHMgbG9nZ2Vk
DQo+PiBbICA2MDkuNjgxNzE2XSBbSGFyZHdhcmUgRXJyb3JdOiBDb3JyZWN0ZWQgZXJyb3IsIG5v
IGFjdGlvbiByZXF1aXJlZC4NCj4+IFsgIDYwOS42ODE3MjBdIFtIYXJkd2FyZSBFcnJvcl06IENQ
VTowICgxNzo3MTowKQ0KPj4gTUMxN19TVEFUVVNbLXxDRXxNaXNjVnxBZGRyVnwtfFN5bmRWfENF
Q0N8LXwtfFNjcnViXToNCj4+IDB4OWMyMDQxMDAwMDAwMDExYg0KPj4gWyAgNjA5LjY4MTcyM10g
W0hhcmR3YXJlIEVycm9yXTogRXJyb3IgQWRkcjogMHgwMDAwMDAwMDZkM2Q0ODNiDQo+PiBbICA2
MDkuNjgxNzI0XSBbSGFyZHdhcmUgRXJyb3JdOiBJUElEOiAweDAwMDAwMDAwMDAwMDAwMDAsIFN5
bmRyb21lOg0KPj4gMHgwMDAwMDAwMDAwMDAwMDAwDQo+PiBbICA2MDkuNjgxNzI2XSBbSGFyZHdh
cmUgRXJyb3JdOiBVbmlmaWVkIE1lbW9yeSBDb250cm9sbGVyIEV4dC4gRXJyb3INCj4+IENvZGU6
IDAsIERSQU0gRUNDIGVycm9yLg0KPj4gWyAgNjA5LjY4MTc0M10gLS0tLS0tLS0tLS0tWyBjdXQg
aGVyZSBdLS0tLS0tLS0tLS0tDQo+PiBbICA2MDkuNjgxNzQ4XSBXQVJOSU5HOiBDUFU6IDQgUElE
OiAyNDQ3IGF0DQo+PiBkcml2ZXJzL2VkYWMvZWRhY19tYy5jOjEyMzggZWRhY19tY19oYW5kbGVf
ZXJyb3IrMHg1YTYvMHg2ZDANCj4gDQo+IFlvdSBjYW4gaWdub3JlIHRoYXQgZm9yIG5vdy4gVGhh
dCdzIGEgc2FuaXR5LWNoZWNrIGZvciBhIGRyaXZlciBzdXBwbHlpbmcgYSAwDQo+IGZvciBncmFp
bi4NCj4gDQoNCkkndmUgc2VlbiB0aGlzIHRvbywgYW5kIEknbSBsb29raW5nIGludG8gaXQuIEkn
bSBkb2luZyBzb21lIHJlc2VhcmNoIHRvIGZpbmQNCnRoZSBjb3JyZWN0IChvciBhdCBsZWFzdCBz
YW5lKSB2YWx1ZSBmb3IgY3VycmVudCBhbmQgbGVnYWN5IHN5c3RlbXMuDQoNClRoYW5rcywNCllh
emVuDQo=
