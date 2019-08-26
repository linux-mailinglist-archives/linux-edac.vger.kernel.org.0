Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3A9D180
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2019 16:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbfHZOTX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Aug 2019 10:19:23 -0400
Received: from mail-eopbgr780048.outbound.protection.outlook.com ([40.107.78.48]:23599
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729138AbfHZOTW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Aug 2019 10:19:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7uluyC7WGGlfKiJ5p3xAAzfcbyDuWkB4eHu4CS4jS+rTZUL75VRMtzCSNmf8veYzl6OegT2NthOXI8jj/T/59M5tRUjvPDWngOuLLHI1wNmkyO47zN2Iid1uyAcMR3NXrfhQdp8Cj3KjoM8brTABJPQPaFX5ylbxQm2qRowRAqL8ygWVESSzQZzXYFm4VnwF23blULETjQN6xVlShnZQS4JkccfhkNQ15NZPceIP+H2h/tgEXvY/jNrQB1CFtUS+DM+5Q0MPDOxvqgA3m7t4BcbWhyyVxhn5kKQDlr3/qTra6/+S4yhEcfK5eOCBcXV2900PwARZoYL7CwTtB2Drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY6uazmJgLfjeUB+hZpspyP4i9suiBlERg1Y6wMESM4=;
 b=RZru36xrMTA5rYp93tGqbdBBxy+Yv3RypSUtNs2n4wtRQ6e/SkSQqr1SQyyH9Oj/HXd9Uj9wiohW5AALZmsOxEDIHeog/6w7hkLj9+HkJTA+I/nYFhoVp2Spygm8soQHG+KLfQ3DkviNQxY9KhVMFzCkubEcVkc+bgO+Q6MVspd/CFBDQ1LVgLJ/ejiVTRrXUugEY8pgL7Paq90tTH9Jb8jNHR5YdewCzYHRL5GvZKq/UkuVQETz0c1NtVLyNHVfLsKqBRiwQkckIWYQbTS3T4XWQGBy2gAtpfBdmtX55bZh9BtqtvIla4VmacF4xsh9qnvKXZOYYoxkvkD8XW+Frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY6uazmJgLfjeUB+hZpspyP4i9suiBlERg1Y6wMESM4=;
 b=TTE13hfy/m4JzWAONEE3RPBiLqXZEm5G5NbEAitBBNDuh2KOhqxorW1zjJAWknfGK1cCA7prIOQYKcPYJlQ5nm54MJ0W9Io0da270EyFH8i4IbiEg0/o7q52mQUeQr8hWEGmBCwZhgCbBSmetpCeKq26KmtphI63Nnx6VeC8U94=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2768.namprd12.prod.outlook.com (52.135.107.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 26 Aug 2019 14:19:18 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 14:19:18 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Adam Borowski <kilobyte@angband.pl>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Topic: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Index: AQHVWHyGkq5ZZJpNOUKXQmjNKGyrbqcGViwAgAEuRFCAAVZ98IAABX2AgASfGOA=
Date:   Mon, 26 Aug 2019 14:19:18 +0000
Message-ID: <SN6PR12MB2639E02109E30165D4A37D8AF8A10@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
 <SN6PR12MB2639CD6D755B6FFCF5C4B756F8A50@SN6PR12MB2639.namprd12.prod.outlook.com>
 <SN6PR12MB263989CCDCC0F74138B6B747F8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190823153739.GC28379@zn.tnic>
In-Reply-To: <20190823153739.GC28379@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38eb25d7-b6da-4737-d1c5-08d72a306227
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2768;
x-ms-traffictypediagnostic: SN6PR12MB2768:
x-microsoft-antispam-prvs: <SN6PR12MB27681A8AA5DDACA738D7F30CF8A10@SN6PR12MB2768.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(13464003)(199004)(189003)(66476007)(66946007)(33656002)(25786009)(66556008)(186003)(86362001)(64756008)(66446008)(6506007)(53546011)(53936002)(102836004)(5660300002)(476003)(11346002)(446003)(486006)(52536014)(46003)(6116002)(76116006)(4326008)(6436002)(6246003)(305945005)(7736002)(74316002)(478600001)(14444005)(256004)(99286004)(76176011)(14454004)(7696005)(55016002)(316002)(54906003)(8676002)(9686003)(6916009)(81156014)(81166006)(8936002)(2906002)(71190400001)(229853002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2768;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d/L9ABFD0VgAL0YFaD/nXhWHyyUg/vICt2PfIgr8K413iY/nGvEaXr6cpTSRTj1P9tu2LivFb9MUZBRW12TSPExTI/X/4wNvFb3t18MsDGkyDZWcxpSPUdY6Fon/MQVrssdkPLoNd2wb6mG799kDWtXbfTPQYMBVfYO2dAxchhSSP9+urEkc5tNhBC/YDWHdEUfyx1ty8y715bPFXg+yKP3gQeNAKWTL7e1G4gHBokXW0NjtbW9sEtrRbgzt1PIA2DHV5gXpjNuhLPQ7qvWfnv3pKMaQ0zzmLruj1WQnZYYcVR8CF4nR5C0IFkkG1enJx5kDSbvHuzmFY1JG71cWaz/wp+BtJrwU1qj9Gs/YWRIyo7vCsiAh3NT3L6g064RyQtiA0yzYVmj/8nYf1rJlV2rqls4WIX0agETVy0VvJII=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38eb25d7-b6da-4737-d1c5-08d72a306227
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 14:19:18.7529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9Z83eb/KLemWtv8cfU63HPiTvI1K3f6ATH4aEucrHcYpD4BBuCuPicQK9mvDcpVvR2dj9PUeMsdfMcLPbhYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjMsIDIwMTkgMTA6
MzggQU0NCj4gVG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENj
OiBBZGFtIEJvcm93c2tpIDxraWxvYnl0ZUBhbmdiYW5kLnBsPjsgbGludXgtZWRhY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAwLzhdIEFNRDY0IEVEQUMgZml4ZXMNCj4gDQo+IE9uIEZyaSwgQXVnIDIzLCAyMDE5
IGF0IDAzOjI4OjU5UE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0KPiA+IEJvcmlzLCBE
byB5b3UgdGhpbmsgaXQnZCBiZSBhcHByb3ByaWF0ZSB0byBjaGFuZ2UgdGhlIHJldHVybiB2YWx1
ZXMNCj4gPiBmb3Igc29tZSBjYXNlcz8NCj4gPg0KPiA+IEZvciBleGFtcGxlLCBFQ0MgZGlzYWJs
ZWQgaXMgYSBoYXJkd2FyZSBjb25maWd1cmF0aW9uLiBUaGlzIGRvZXNuJ3QNCj4gPiBtZWFuIHRo
YXQgdGhlIG1vZHVsZSBmYWlsZWQgYW55IG9wZXJhdGlvbnMgaW4gdGhpcyBjYXNlLg0KPiA+DQo+
ID4gSW4gb3RoZXIgd29yZHMsIHRoZSBtb2R1bGUgY2hlY2tzIGZvciBhIGZlYXR1cmUuIElmIHRo
ZSBmZWF0dXJlIGlzIG5vdA0KPiA+IHByZXNlbnQsIHRoZW4gcmV0dXJuIHdpdGhvdXQgZmFpbHVy
ZSAoYW5kIG1heWJlIGdpdmUgYSBtZXNzYWdlKS4NCj4gDQo+IFRoYXQgbWFrZXMgc2Vuc2UgYnV0
IEFGQUlDVCBpZiBwcm9iZV9vbmVfaW5zdGFuY2UoKSBzZWVzIHRoYXQgRUNDIGlzIG5vdA0KPiBl
bmFibGVkLCBpdCByZXR1cm5zIDAuDQo+IA0KPiBUaGUgImlmICghZWRhY19oYXNfbWNzKCkpIiBj
aGVjayBsYXRlciBpcyB0byB2ZXJpZnkgdGhhdCBhdCBsZWFzdCBvbmNlDQo+IGluc3RhbmNlIHdh
cyBsb2FkZWQgc3VjY2Vzc2Z1bGx5IGFuZCwgaWYgbm90LCB0aGVuIHJldHVybiBhbiBlcnJvci4N
Cj4gDQo+IFNvIHdoZXJlIGRvZXMgaXQgcmV0dXJuIGZhaWx1cmU/DQo+IA0KDQpJIHdhcyB0cmFj
a2luZyBkb3duIHRoZSBmYWlsdXJlIHdpdGggRUNDIGRpc2FibGVkLCBhbmQgdGhhdCBzZWVtcyB0
byBiZSBpdC4NCg0KU28gSSB0aGluayB3ZSBzaG91bGQgcmV0dXJuIDAgImlmICghZWRhY19oYXNf
bWNzKCkpIiwgYmVjYXVzZSB3ZSdkIG9ubHkgZ2V0DQp0aGVyZSBpZiBFQ0MgaXMgZGlzYWJsZWQg
b24gYWxsIG5vZGVzIGFuZCB0aGVyZSB3YXNuJ3Qgc29tZSBvdGhlciBpbml0aWFsaXphdGlvbg0K
ZXJyb3IuDQoNCkknbGwgc2VuZCBhIHBhdGNoIGZvciB0aGlzIHNvb24uDQoNCkFkYW0sIHdvdWxk
IHlvdSBtaW5kIHRlc3RpbmcgdGhpcyBwYXRjaD8NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
