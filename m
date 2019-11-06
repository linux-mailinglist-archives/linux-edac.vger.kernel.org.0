Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDAAF1D4C
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfKFSQS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 13:16:18 -0500
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:62116
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfKFSQS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Nov 2019 13:16:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meS9J3MJUzu1xP+9Ju78vy5r9jzvwJkkRZLsjA84Uomqv4+w+m5nGLKr/GWntnGH1eQ20WRAtIYApjqVQRamQIgqyD9EEslPDTJpvkF3p80kMEdyudtRa5eOwNtNQg+A8xe6MIuS8j+kp2PPT1NV20iDPU0qGDVqYYGGqyZlkxYX3Rp7taki4ACm8NEz3xCAHfSZ5OQ7Tv2MuVjlsB38/yWMHb7ipJOpHhm4xNDZZ58Mzh0bHPAuShi/MDVwucCCbaJ7+dAHrXhVKPA2Cloz4NM381F+MtapEodhoHY3kXEUPwR/VWBQ7cp3/hiAEo+dxEXv/U5ZMsvWzXAVhO3FDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLjVYJtV6BMik4OvroEnJmnQFfaDxbrStP3zmhCsQFk=;
 b=Acjwk1Okx1OlKCsNbwH2GueWqMYrjJ72Hq488QkGi6JunCAMyXeYhMfy5g+Ol4cgShbNJtUT36ZdjOtq77iVzQlJiVaLd9z5aeJsMmkQ0caJTBgvVNq7wsQOkTo/b1rM9mXxiikp8lHW9zN8XxLb3FxkfmQuGv4cvls4wfA9YdpAg52CS63XQ7A7pJBwx70oR2c6oDGbjBJ1f/Za7YPMA4WbfSYybp1RhDHSPSp4wQr3f+bIyy1LNhHH4Lz+n17gIMFILdpCzVnSb6rS5b4Dw8Y/ZxA70RkEKAajSDsAXBKePFujRPFh75XcjwTKRCNFB1JU0l24cBHBCFj9nO9Fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLjVYJtV6BMik4OvroEnJmnQFfaDxbrStP3zmhCsQFk=;
 b=LPalTHJLEcKaIoxqlEJWRCUaYOC1fZYpWwEYzEVPAtsLHhYWhKPc5/KGRHuyvUPf0UWh1pYtsoAVK+CKPgkKpij+qSVrpUjg1/JbSFwX3tkP9+6ELgkURP98ZuZQlxMIWcIDhCdP30qaMiLBhz63OiWJ4BJuMAq9egLvZDlIcPY=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2781.namprd12.prod.outlook.com (52.135.107.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 18:16:12 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 18:16:12 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHVlEEBkkiHg8UvLEKx+Q/uzElWBqd+T6+AgAAi68A=
Date:   Wed, 6 Nov 2019 18:16:12 +0000
Message-ID: <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
In-Reply-To: <20191106160607.GC28380@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 579e1922-106d-4cc5-6bed-08d762e567e0
x-ms-traffictypediagnostic: SN6PR12MB2781:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB278149C45D1C9EAF6EE18050F8790@SN6PR12MB2781.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(13464003)(189003)(199004)(6436002)(256004)(3846002)(7696005)(74316002)(8676002)(81156014)(66066001)(6116002)(86362001)(11346002)(446003)(4326008)(229853002)(9686003)(6306002)(26005)(476003)(14454004)(52536014)(478600001)(5660300002)(486006)(33656002)(966005)(6916009)(6506007)(25786009)(53546011)(316002)(102836004)(7736002)(14444005)(99286004)(186003)(2906002)(54906003)(8936002)(66946007)(305945005)(76176011)(64756008)(71190400001)(66446008)(66476007)(76116006)(71200400001)(66556008)(81166006)(55016002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2781;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: veKks/og2/FlCFeeKwXnpUY2YoPF+kJKFNFnlujrT91Ponos/d4UW0xx99t+D0LrJIy3wQjWvi9vbqLvI1/Mp9LjdzC79GTT6Wyuw/vV1wac5eHQ/6pcZ73MLSlYx+28/HooPLLOi66JFI/w4WMArc6KHujQK5rHz1ReZ7S7bdfdIuosH3AB6YR2+V6QGPT1R0L/nbH1q12ffROmRDlHHF7BVOhmZKeGUWTgVt4lb8MX2iJykLyCYK4iAHhBFEFYhzAycCeO36MMw5L5nLvGdplY3lTCnVMk+ijAYg3jjYUWioHC49LPB+3RZ+A2w9gbQryV1udy5ib1fCQhfLrXTMYCUinA+xWU99TcexT4s3dLfU+X9m6GZD+Yne8yzWpL4yfMayzdQUfKbbYosuBbtZy8qe5/50Xnzl3pGXdnSTnEceJ1OxocWOZur1RGwdEX0CLu1Kdxfbb/UJRDBcYciuXxCDiE+Qxg+UzClFP3rNk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579e1922-106d-4cc5-6bed-08d762e567e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 18:16:12.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKXceqKKFsxPZQvNpUJUuXU+8XatwyLXxvEZ11rYRQDC0cvefyhN2JVVagMcJz2PEWeOpDd37I/lH9CU9xNcXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA2LCAyMDE5
IDExOjA2IEFNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0K
PiBDYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzVdIEFNRDY0IEVEQUM6IENoZWNrIGZv
ciBub2RlcyB3aXRob3V0IG1lbW9yeSwgZXRjLg0KPiANCj4gT24gV2VkLCBOb3YgMDYsIDIwMTkg
YXQgMDE6MjQ6NTlBTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gRnJvbTogWWF6
ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiA+DQo+ID4gSGkgQm9yaXMsDQo+
ID4NCj4gPiBUaGVzZSBwYXRjaGVzIGFkZHJlc3MgdGhlIGlzc3VlIHdoZXJlIHRoZSBtb2R1bGUg
Y2hlY2tzIGFuZCBjb21wbGFpbnMNCj4gPiBhYm91dCBEUkFNIEVDQyBvbiBub2RlcyB3aXRob3V0
IG1lbW9yeS4NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSBsYXN0IHJldmlzaW9uOg0KPiA+ICAgMSkg
RHJvcHBlZCBwYXRjaCA2IHdoaWNoIHdhcyBmb3IgYWRkaW5nIGEgZ3JhaW4gdmFsdWUuDQo+ID4g
ICAyKSBBZGRlZCBhbiBlcnJvciBjb2RlIGZvciAhZWNjX2VuYWJsZWQoKSBpbiBwYXRjaCA1Lg0K
PiANCj4gU3RpbGwgZG9lc24ndCBoZWxwLiBUaGUgbG9hZCBnZXRzIGF0dGVtcHRlZCB0d2ljZSBz
dGlsbC4gVHJ5IHJlcHJvZHVjaW5nDQo+IGl0IG9uIGEgc21hbGwsIHNpbmdsZS1ub2RlIGJveCB3
aGVyZSBFQ0MgaXMgZGlzYWJsZWQuDQo+IA0KDQpXZSBoYWQgYSB0aHJlYWQgYmVmb3JlIGFib3V0
IHVzZXJzYXBjZSBsb2FkaW5nIHRoZSBtb2R1bGUgbXVsdGlwbGUgdGltZXMgb24NCmZhaWx1cmU6
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1lZGFjLzIwMTkwODIyMDA1MDIwLkdBNDAz
QGFuZ2JhbmQucGwvDQoNCkkgdHJpZWQgdG8gbG9vayBpbnRvIGl0IGEgYml0LCBidXQgSSBkaWRu
J3QgZ2V0IHZlcnkgZmFyLg0KDQpTbyBpcyB0aGUgYmVoYXZpb3IgeW91IHNlZSBvbmx5IGhhcHBl
bmluZyB3aXRoIHRoZSBuZXcgcGF0Y2hzZXQgYXBwbGllZD8gVGhhdA0KbWF5IGJlIGEgY2x1ZSB0
aGF0IHdlIGNhbiBmaXggdGhpcyBpbiB0aGUgbW9kdWxlLg0KDQpUaGFua3MsDQpZYXplbg0K
