Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B349D245
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2019 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfHZPFZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Aug 2019 11:05:25 -0400
Received: from mail-eopbgr740088.outbound.protection.outlook.com ([40.107.74.88]:44804
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732812AbfHZPFZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Aug 2019 11:05:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kwy1x8hfqzA/ha1/3CxCwqf+H1n7mYxTtqbisTdtZPOpqo7X0rLqe1eIaRBkuf1BdkV/VL6pfuj2Iz0irPfMdTmCB/iZNf1oa1ghSC/upkVZIOjn7/t091fIRhUggjX/Rz5FIONVJusqr9LHfdVW3qNY0h8qiwTwy4dhdxbpiHWGhHzDUgz1YJUoDrj0jR/gGPSfmHrnLDaWZevhve1tVRSZ+72k0zzIsnDuoOEFq4MswVXTJHCKcGOKv9OzwZteA5aTKJ/B1pokfqK1zZRTx0cFzdOeXGx70cllIujhf6n2qq8Yr+SVaVCl5fQX8ju4UtG7/O3NCyBtp5NQJ6CTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpIDE+a+1xmo0A6TrAJqWkf1p2TRolFmxY6DDTsZSF0=;
 b=EPZhItxwsubwhg4Fd+dgr7TS/52IFeA1/7iIefRhREAV/WEVsPkAQaSZVyoNKy4Gh8hraT6QfG9fQ9S82F+v3X3wuhtnBaEMkbDhUiRlC1EoB6dGvJ805ZGHA+Jnjxls87XqcFMxI2vZUlGG8IJyCA7r1lHn0RTaRa5QriAEmI2b1GdY4wZny9Oj4KoIT/vMvXyQhB1wBvOO5dGZY4DYsZisXZFJlFEJOIcg+tUevOPtmdG2j4wDzis5yT6wc8m304sN6SFq3M+eUb3Xz8mdr+oIOdQQkKKEU/5CNBOtZlngNPHmYTqMQRGrI419hnkS2MnSq8/Ry9c3xQTJG+uLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpIDE+a+1xmo0A6TrAJqWkf1p2TRolFmxY6DDTsZSF0=;
 b=feyTleVGGcbMt5t/dfW8IPvHohxPynIeaQtKOF0fKxjA9do7Owd0qwp7BuIgo5bWpadG3DfQ5rnwB5mePW77D3tylRCFAFyBVxi5otzcoTo9e4nFHbpwIQBJbbFZx31nWuICIRn8nBPW0oUG2Q0+BkZkk+lpOlDVMbM0hlOTAdk=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Mon, 26 Aug 2019 15:05:21 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 15:05:20 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Adam Borowski <kilobyte@angband.pl>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Topic: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Index: AQHVWHyGkq5ZZJpNOUKXQmjNKGyrbqcGViwAgAEuRFCAAVZ98IAABX2AgASfGOCAAA0bgIAAAIoQ
Date:   Mon, 26 Aug 2019 15:05:20 +0000
Message-ID: <SN6PR12MB26392D6BD4846C7BE25431FFF8A10@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
 <SN6PR12MB2639CD6D755B6FFCF5C4B756F8A50@SN6PR12MB2639.namprd12.prod.outlook.com>
 <SN6PR12MB263989CCDCC0F74138B6B747F8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190823153739.GC28379@zn.tnic>
 <SN6PR12MB2639E02109E30165D4A37D8AF8A10@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190826145901.GH27636@zn.tnic>
In-Reply-To: <20190826145901.GH27636@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54f9d263-2669-4a42-b6d0-08d72a36d06c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2670;
x-ms-traffictypediagnostic: SN6PR12MB2670:
x-microsoft-antispam-prvs: <SN6PR12MB2670E109323E495A8ADDDAEBF8A10@SN6PR12MB2670.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(13464003)(189003)(199004)(76116006)(55016002)(8936002)(66946007)(54906003)(6246003)(6436002)(6506007)(25786009)(229853002)(53546011)(53936002)(305945005)(14454004)(478600001)(33656002)(6916009)(5660300002)(46003)(186003)(66446008)(11346002)(66476007)(316002)(64756008)(446003)(66556008)(74316002)(9686003)(7736002)(256004)(14444005)(52536014)(86362001)(81156014)(8676002)(81166006)(76176011)(7696005)(102836004)(476003)(486006)(71200400001)(2906002)(71190400001)(6116002)(99286004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2670;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 42U+UXkfHZuesobTvxRie2N78NbVKsAdzstvoh/exmpLQ+w0rYUfaSoXyHklCUr+ZQ0jZIf8Cxjtfso/ZCkarOLfoR/S9lnOZB/F++DxbS8G9hzCQLtCuLs6x6QQ2px2v0DATg+qxUzCQa0AWGUXsLKvvZSx1wJzr/jQ8ZnRFz3aZuMzFqFYjgqJaPaoLbEKnAMKU91h9Uj1WME8I915CM5e6TZjr41WcvTq6gwNx3AjriWctAPPEA/1kIaoeJ+hTWnVBSPboZiAzSrkp/H568Z7ZKpN4F2DWLbsn4rIM95HtS0uEpa24h9Hv4S1nGhniVWIriZnuoP8f0jurgvbph6R+hVSj2Jsp9atzERukpFKGVepY22NMttx7kHnjV4GQ2Vnrj171vRYyrZHeIAFLO/lbOoxP+E3QwIs9pwR/2Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f9d263-2669-4a42-b6d0-08d72a36d06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 15:05:20.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46hXM6vtJw/MdTB9vXn7NRY70Nk/34zLbbqg787zsSt1wfiQF2m5V7CVo5yO4Z+yuXF0qCFgU3PSUmuAw3qwTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjYsIDIwMTkgOTo1
OSBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6
IEFkYW0gQm9yb3dza2kgPGtpbG9ieXRlQGFuZ2JhbmQucGw+OyBsaW51eC1lZGFjQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDAvOF0gQU1ENjQgRURBQyBmaXhlcw0KPiANCj4gT24gTW9uLCBBdWcgMjYsIDIwMTkg
YXQgMDI6MTk6MThQTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gSSB3YXMgdHJh
Y2tpbmcgZG93biB0aGUgZmFpbHVyZSB3aXRoIEVDQyBkaXNhYmxlZCwgYW5kIHRoYXQgc2VlbXMg
dG8gYmUgaXQuDQo+ID4NCj4gPiBTbyBJIHRoaW5rIHdlIHNob3VsZCByZXR1cm4gMCAiaWYgKCFl
ZGFjX2hhc19tY3MoKSkiLCBiZWNhdXNlIHdlJ2Qgb25seSBnZXQNCj4gPiB0aGVyZSBpZiBFQ0Mg
aXMgZGlzYWJsZWQgb24gYWxsIG5vZGVzIGFuZCB0aGVyZSB3YXNuJ3Qgc29tZSBvdGhlciBpbml0
aWFsaXphdGlvbg0KPiA+IGVycm9yLg0KPiA+DQo+ID4gSSdsbCBzZW5kIGEgcGF0Y2ggZm9yIHRo
aXMgc29vbi4NCj4gPg0KPiA+IEFkYW0sIHdvdWxkIHlvdSBtaW5kIHRlc3RpbmcgdGhpcyBwYXRj
aD8NCj4gDQo+IFlvdSBjYW4ndCByZXR1cm4gMCB3aGVuIEVDQyBpcyBkaXNhYmxlZCBvbiBhbGwg
bm9kZXMgYmVjYXVzZSB0aGVuIHRoZQ0KPiBkcml2ZXIgcmVtYWlucyBsb2FkZWQgd2l0aG91dCBk
cml2aW5nIGFueXRoaW5nLiBUaGF0IHNpbGx5IHVzZXJzcGFjZQ0KPiBuZWVkcyB0byB1bmRlcnN0
YW5kIHRoYXQgRU5PREVWIG1lYW5zICJzdG9wIHRyeWluZyB0byBsb2FkIHRoaXMgZHJpdmVyIi4N
Cj4gDQoNClllcywgeW91J3JlIHJpZ2h0Lg0KDQpJJ2xsIHRyeSBhbmQgdHJhY2sgZG93biB0aGUg
aW50ZXJhY3Rpb24gaGVyZSBiZXR3ZWVuIHVzZXJzcGFjZSBhbmQgdGhlIG1vZHVsZS4NClBsZWFz
ZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMuDQoNClRoYW5rcywNCllh
emVuDQo=
