Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6647BDEF60
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2019 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfJUOYJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Oct 2019 10:24:09 -0400
Received: from mail-eopbgr740049.outbound.protection.outlook.com ([40.107.74.49]:23328
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJUOYI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Oct 2019 10:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCuz6hJpxppwMzrLrd8J8iP8WKCxQ2ZNHSaTQSNemnQD53OUe+IJ93cfCKOk3UzmPt0Z3cllSC/JkJV3uin4lGm2y46183k6A5fV05sLQkbouEvRgMl5vgNlCq+bTs0T8ypS5Y5cK9EU1F1s8g6Aa9YGNr2HNrymkAcReXAjcMP/hscYzUCq0TUlOI23Tm1CSxcKgZZH1HnL64kguITb318QJwVgjMr4p5BvL4fFU/V4DouWmu74j4K5D3N/avUTahJRQDHaZB1ar6Tt7AEv+21I9ntYjPzcnC/oK/sIPzH9pHcn3HNaIrR9ujvaNkFtpU4O71RFoh2xRm0FHwVQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RLpZpop34fHFopp/tKBLtoCwDIKyB9x1a+UxKZS2yo=;
 b=ZNM8ZtaSivG5WpTeGoA/mQuB/YNEMv4FEudlmrjF/q4U6ag9vaIl1ciL13l7fpxOLo3PGSn6U9KS+7jPK72NhNO304vsc7/CgmnxoKygkNxxoaro0IhEEFGF258l+XfaVWxhzEA8frocyJp+I46zFzxj6iYS/+fEkN5kNljHoOiTYn+8ByPTFgBzqIb21UBWoJOzY79GolwFNApzLk4b++cWnc/UsAiJWSXfl9s7/YT1Xx5iIwD9GrL+dn8Zs9USqay0uHR2TPVTrll1i8NEh6yxjKhLcZkDEF49YPpFegbZ57FUCO12I7GUcU2GfGjTh0qxvVfY4QBwsPMK2WNykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RLpZpop34fHFopp/tKBLtoCwDIKyB9x1a+UxKZS2yo=;
 b=pcTCMQahvb6gHdWQW7peaIFrSb8/ticJO3r+Gz5JWmgKq+xSqWKnfg85swtYz/5JoXCwMI/aDlpjrz8JWLZVrSrpuHxPvq3/IJWmQLE2CJmlQYirXI5dWbzdPLlV0RBEJzWsLyYybzCc2OSgt50uUJFIr6mMv7fbGjq1c1O6vwM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2654.namprd12.prod.outlook.com (52.135.103.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 21 Oct 2019 14:24:05 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2367.019; Mon, 21 Oct 2019
 14:24:05 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Jean-Frederic <jfgaudreault@gmail.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Thread-Topic: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h
 support
Thread-Index: AQHVe51JKTDxmyKbykahkp73y8AC1qdOxx+AgABffACAAX9igIAAg6EAgAA5tACAAL6mgIAAp9WAgAA40oCAAKg4AIAAL+sAgAAO2ACAAFkOAIAAZdaAgAxyMwCAAJu6AIAAgn6AgAMB5LA=
Date:   Mon, 21 Oct 2019 14:24:04 +0000
Message-ID: <SN6PR12MB26390DC298E06A5443699D02F8690@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
 <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
 <20191010095650.GC7658@zn.tnic>
 <9f3ce002-7380-0e93-7bd5-20bb944d0b77@gmail.com>
 <20191010134128.GF7658@zn.tnic>
 <60b68d6c-5aff-3e7c-9461-c26a5f28cd87@amd.com>
 <79bca0d0-42eb-c232-6bbe-a958734e096d@gmail.com>
 <f5820b41-c97a-b6be-df97-bbff85a7e5ee@gmail.com>
 <20191019082554.GB5571@zn.tnic>
 <fddfb084-69a0-a913-f750-ef0a7830dd1e@gmail.com>
In-Reply-To: <fddfb084-69a0-a913-f750-ef0a7830dd1e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96949d1c-4c56-4cd5-9e62-08d7563253c8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2654:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2654E37E3840471BC5CDEE2EF8690@SN6PR12MB2654.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(13464003)(189003)(199004)(3846002)(110136005)(6116002)(71200400001)(9686003)(11346002)(476003)(64756008)(66556008)(446003)(6306002)(76116006)(305945005)(66476007)(66946007)(66066001)(7736002)(25786009)(2906002)(52536014)(71190400001)(316002)(8936002)(8676002)(6246003)(486006)(86362001)(66446008)(81166006)(74316002)(81156014)(26005)(5660300002)(14454004)(229853002)(186003)(33656002)(966005)(4001150100001)(4326008)(7696005)(53546011)(6506007)(76176011)(99286004)(256004)(6436002)(102836004)(478600001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2654;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t/VN5YLaeJNfb51/5Vji2XZ2f3afwKAUdfsX4DvB7zVlXVKQdFy6Lic0Sj65ITK2RwXAiNtGfs8CnwfRdQVXXpqtyGXT4p6Bo/x5a5nAxzALOmEFE/aTHJpcIkzmfe9fgD8Q/lDL+I3/l5RUwFaLRXpqYSAURWbeo8nK+yeMz/WLdcJ9CNY8eCp/vBQq9sf1mHR9XdCLpHvKVl7/ZaynryEC5n3EB1HlNYNG3C+G3Dy0tqbVug6sBCKYT+4WNJ/A7v86nfhrdbv8hW+RDtc6lQG5RwC+Odt36w5vg1O/1Qtw9oZCkuC0UT55ciNfQRTdDioaxHiPsgfiH+nEa3HHPkNAQ40MVh2+aRTyH9lT63YM83UmultKZ2FTZYXsHMLaZm5E2VD2nRH0eIMcIlpgs3wJp4hHcuGW/xixOIYUU9mO7kFJzoa0XP7mxjCLC7xrtdoBOyXglNpuUHjYsI/Omg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96949d1c-4c56-4cd5-9e62-08d7563253c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 14:24:04.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQJBLGHMUtwx95flcEQvQNAX/H6blw/zVq+ToqcU9XjXIdg9dnOV3sOTV3DSB9VHw08ZOYeg/aPAAWo9K5hm1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2654
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWFuLUZyZWRlcmljIDxqZmdh
dWRyZWF1bHRAZ21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxOSwgMjAxOSAx
MjoxMyBQTQ0KPiBUbzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IENjOiBHaGFu
bmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPjsgbGludXgtZWRhY0B2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtHSVQgUFVMTF0gRURBQyBwaWxlIGZvciA1LjQgLT4gQU1E
IGZhbWlseSAxN2gsIG1vZGVsIDcwaCBzdXBwb3J0DQo+IA0KPiBPbiAyMDE5LTEwLTE5IDQ6MjUg
YS5tLiwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiA+IExvb2sgaGVyZSBvbiBwYWdlIDY6DQo+
ID4gaHR0cHM6Ly93d3cuYW1kLmNvbS9zeXN0ZW0vZmlsZXMvMjAxNy0wNi9BTUQtRVBZQy1Ccmlu
Z3MtTmV3LVJBUy1DYXBhYmlsaXR5LnBkZg0KPiA+DQo+ID4gSXQgaGludHMgYXQgd2hhdCBQRkVI
IGRvZXMuDQo+ID4gIFsgSSBiZWxpZXZlIGlmIHRoZSBlcnJvciBjYW5ub3QgYmUgaGFuZGxlZCBi
eSB0aGUgZmlybXdhcmUsIGl0IGdldHMNCj4gPiAgICByZXBvcnRlZCB0byB0aGUgT1MgYnV0IEkn
bGwgbGV0IFlhemVuIGNvbW1lbnQgb24gdGhhdC4gXQ0KPiANCj4gWWVzLCBJIGZvdW5kIHRoYXQg
ZG9jdW1lbnQgdG9vIGFmdGVyIEkgc2VudCBteSBlbWFpbCB5ZXN0ZXJkYXksIGFuZCBJIGtpbmQg
b2YNCj4gaGFkIGEgc2ltaWxhciB1bmRlcnN0YW5kaW5nLi4uDQo+IA0KDQpZZXMsIHRoYXQncyBy
aWdodC4gQW5kIGV2ZW4gaWYgdGhlIGZpcm13YXJlIGhhbmRsZXMgdGhlIGVycm9yIGl0IG1heSBz
dGlsbA0KcmVwb3J0IHRvIHRoZSBPUy4gVGhhdCdzIHJlYWxseSBhIHBvbGljeSBkZWNpc2lvbiBh
bmQgaXQgbWF5IHZhcnkgYmV0d2Vlbg0KdmVuZG9ycy4NCg0KPiA+IEkga25vdywgSSBrbm93LCB3
ZSBkb24ndCB0cnVzdCB0aGUgZmlybXdhcmUgdG8gZG8gaXQgcmlnaHQgYW5kIHNvIG9uLA0KPiA+
IGJ1dCBpdCBpcyB3aGF0IGl0IGlzLiBMaWtlIG90aGVyIHN0dWZmIHdlIGhhdmUgdG8gcmVseSBv
biB0aGUgZmlybXdhcmUNCj4gPiB0byBkbyByaWdodC4NCj4gDQo+IEkgdGhpbmsgd2Ugd291bGQg
YWxsIGxpa2UgdG8gdHJ1c3QgdGhlIGZpcm13YXJlIGlmIGl0IHdhcyBjbGVhciB3aGF0IGl0IGlz
IGRvaW5nDQo+IHRvIGJlIGhvbmVzdC4NCj4gSG93ZXZlciB0aGUgd2F5IHRoZXNlIGNvbnN1bWVy
IHByb2R1Y3RzIGFyZSBzb2xkIGFuZCBkb2N1bWVudGVkICh0aGUgbW90aGVyYm9hcmQgSSBtZWFu
KSwNCj4gZXNwZWNpYWxseSBmb3IgQU1EIFJZWkVOIGFuZCBFQ0Mgc3VwcG9ydCwgaXMganVzdCB0
aGF0IHRoZXJlIGlzIGFsbW9zdCBubyBpbmZvcm1hdGlvbg0KPiAoYSB2YWd1ZSBzdGF0ZW1lbnQg
YWJvdXRpdCAic3VwcG9ydHMgZWNjIi4uLikNCj4gDQo+IFRoZSBjb25jZXB0IG9mIHRoZSBQRkVI
IGFuZCBSQVMgSSB0aGluayBpcyBnb29kIHRoZSBtb3JlIEkgcmVhZCBhYm91dCBpdCwgYnV0IG1v
c3RseSBmb3INCj4gZW50ZXJwcmlzZSBzb2x1dGlvbnMsIGFuZCBpdCB3b3VsZCBiZSBnb29kIHRv
byBJIGd1ZXNzIGZvciBhIGNvbnN1bWVyIHByb2R1Y3QgaWYgd2Uga25ldw0KPiB3ZSBjb3VsZCBy
ZWx5IG9uIGl0Lg0KPiANCj4gQXMgaXQgc3RhbmRzIHJpZ2h0IG5vdywgSSBkb24ndCByZWFsbHkg
a25vdyBpZiBJIGNhbiB0cnVzdCBpdC4gV2hlbiBJIGRpZCBteSBvd24gdGVzdHMNCj4gb2YgZ2Vu
ZXJhdGluZyByZWFsIGVycm9ycyBpdCB3YXMgZWl0aGVyIHRoZSBzeXN0ZW0gaXMgdG90YWxseSBz
dGFibGUsIG9yIHdvdWxkIG5vdCBib290LA0KPiBvciB3b3VsZCBjcmFzaCBzdWRkZW5seS4gSSBj
b3VsZCBzZWUgdGhhdCBlY2MgcmVhbGx5IGNvcnJlY3RzIHRoaW5ncywgYmVjYXVzZSBvdGhlcndp
c2UNCj4gSSB3b3VsZCBnZXQgc29mdHdhcmUgc2VsZiBjaGVjayBlcnJvcnMgaW4gbXByaW1lIHVu
ZGVyIHRob3NlIGNvbmRpdGlvbnMgZmFpcmx5IHF1aWNrbHkNCj4gKGFmdGVyIDEtMiBtaW51dGVz
KSwgYnV0IHdpdGggZWNjIGVuYWJsZWQgSSBjYW4gcnVuIGZvciBob3VycyB3aXRob3V0IGFueSBz
aWduIG9mIGlzc3VlDQo+IHVuZGVyIHRoZSBzYW1lIGNvbmRpdGlvbnMuDQo+IA0KPiBTbyBjYW4g
SSByZWx5IG9uIHRoaXMgdG8ga25vdyBvbmUgZGF5IHRoYXQgSSBhbSBzdGFydGluZyB0byBoYXZl
IGhhcmR3YXJlIGlzc3VlcyBhbmQgSQ0KPiBzaG91bGQgcmVwbGFjZSBteSBtZW1vcnkgKG9yIHN5
c3RlbSk/IEkgZG9uJ3QgZXZlbiBrbm93IGhvdyB0aGUgZmlybXdhcmUgd2lsbCByZXBvcnQNCj4g
YW55dGhpbmcgdG8gbWUuIFRoZXJlIGlzIG5vdGhpbmcgaW4gdGhlIGJpb3MgdGhhdCBzZWVtcyB0
byBnaXZlIGFueSByZXBvcnQgYWJvdXQgZWNjLA0KPiANCg0KR2VuZXJhbGx5LCB0aGUgZmlybXdh
cmUgd2lsbCByZXBvcnQgdGhlIGVycm9yIHVwIHRvIHRoZSBPUyBhbmQgdGhlIE9TIHdpbGwNCnJl
cG9ydCB0byB0aGUgdXNlci4gU28geW91IHNob3VsZCBmaW5kIHRoZSBlcnJvciByZXBvcnRlZCB0
aHJvdWdoIEVEQUMsIGV0Yy4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
