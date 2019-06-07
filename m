Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07BB392C5
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfFGRIH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 13:08:07 -0400
Received: from mail-eopbgr710053.outbound.protection.outlook.com ([40.107.71.53]:12907
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728989AbfFGRIH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 13:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMudd+xc/xqETJeGxFP4rxMXb9jluzX2RF5EeMf9Ua0=;
 b=bg+UwTLhAlLzOmECSBjlZwup6i3mYtfwoiaUkX9kzq5M3DvpHnqMJuyYGbv0vqp3FhLbE+l9+turT7GDeJJ1zQYhDaSQuYIjeaX/Kfcee15C8a4ZXJFqU49CEIL8aA/LctuxL4DLkkAUEs/eoDFJMR6Amp6OnUO6Uv4Wl5rHPsQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2605.namprd12.prod.outlook.com (52.135.102.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 7 Jun 2019 17:08:05 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 17:08:05 +0000
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
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbCAAA1jAIAAAELggAAGlYCAADB8kIAABZ8AgAAG7YCAANzUAIAAUaUwgAAal4CAAA3JgIAABf+AgAAE/ICAABizgIAAAygAgAAEo4CACWuboIAGhWIAgBC3iXCAAB8mgIAAANXggAAFOACAAABXsA==
Date:   Fri, 7 Jun 2019 17:08:04 +0000
Message-ID: <SN6PR12MB263905712C2375078012E833F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190517174817.GG13482@zn.tnic>
 <20190517180607.GA21710@agluck-desk> <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517200225.GK13482@zn.tnic>
 <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190527232849.GC8209@cz.tnic>
 <SN6PR12MB263998ECCDF1E345FEB0869AF8100@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190607163723.GG20269@zn.tnic>
 <SN6PR12MB263968DE0DD98EBE14450698F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190607165902.GJ20269@zn.tnic>
In-Reply-To: <20190607165902.GJ20269@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c269f6f1-0d3f-4b60-c55e-08d6eb6ab4c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2605;
x-ms-traffictypediagnostic: SN6PR12MB2605:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2605E7D18CFBDBFDEF942A08F8100@SN6PR12MB2605.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(13464003)(199004)(189003)(11346002)(6246003)(33656002)(52536014)(66446008)(186003)(66066001)(74316002)(8936002)(81166006)(8676002)(81156014)(229853002)(55016002)(446003)(6306002)(53936002)(9686003)(66476007)(76116006)(316002)(2906002)(86362001)(14454004)(6916009)(76176011)(486006)(73956011)(5660300002)(66556008)(66946007)(64756008)(54906003)(71190400001)(25786009)(3846002)(102836004)(6116002)(6436002)(256004)(72206003)(478600001)(476003)(305945005)(4326008)(7736002)(6506007)(53546011)(99286004)(26005)(7696005)(71200400001)(966005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2605;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gCpw+678l3bkbYFyaUNAiPejMe7fr0J+ET/BBHbZLI9YyKYFrYJpfd3SVGvZwZHbt4nP3AJhTvNlTT6JqbHXFTgUPcqm7yDnvr9qNRA9v0GXrWi7xeExQBfAstUDF7VTcyijorWoI/kbxtlWFmqTHJB3wpaCFdbwZEf8ECvZbWDBnUlijYPiVpgtRMhnsLZEmgFbRXaaIYTdRthZTk5G/JNMKbZx+IcbctGCeAiwaBC2dKGkJ34KxklmjxJKG/nmMZQaDzH1rM2+b4m8ToY76eo3M5RWWcEOeBDb1Jo+NNzTfN1VIJWm80XNceHf2iVqEuv8VHFPnyeUuoiqQbgVffQ/XV8sKnl252HHFsJZyjdGR0sqLEyQII5RZljJ9QqyHrIWABiF5ByOXV5s1g7FWWW48yaDBv7tv6wAOVaELyg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c269f6f1-0d3f-4b60-c55e-08d6eb6ab4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 17:08:04.9691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBKdW5lIDcsIDIwMTkgMTE6NTkg
QU0NCj4gVG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENjOiBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgNS82XSB4ODYvTUNFOiBTYXZlIE1DQSBjb250cm9sIGJpdHMgdGhh
dCBnZXQgc2V0IGluIGhhcmR3YXJlDQo+IA0KPiBPbiBGcmksIEp1biAwNywgMjAxOSBhdCAwNDo0
NDoyNFBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBJIGhhdmUgYW5vdGhlciB2
ZXJzaW9uIG9mIHRoaXMgc2V0IHRoYXQgSSBjYW4gc2VuZCB0b2RheS4gSXQgaW5jbHVkZXMNCj4g
PiB0aGUgY2hhbmdlcyBmb3IgdGhpcyBwYXRjaCBhbmQgYWxzbyBpbmNsdWRlcyB0aGUgZml4IGZv
ciB0aGUgbG9ja2luZw0KPiA+IGJ1ZyBtZXNzYWdlLg0KPiA+DQo+ID4gU2hvdWxkIEkgc2VuZCBv
dXQgdGhlIG5ldyB2ZXJzaW9uPyBPciBkbyB5b3Ugd2FudCBtZSB0byB3YWl0IGZvciBhbnkNCj4g
PiBmaXhlcyBvbiB0b3Agb2YgdGhlIGN1cnJlbnQgdmVyc2lvbj8NCj4gDQo+IEkgZG9uJ3QgdW5k
ZXJzdGFuZCAtIEkgdGhpbmsgd2Ugc2FpZCB0byBmZWVsIGZyZWUgdG8gcmV3b3JrIGl0IGFsbCBi
eSB1c2luZw0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvYnAvYnAuZ2l0L2xvZy8/aD1yYzAlMmIzLXJhcw0KPiANCj4gYW5kIHJld29ya2luZyB0
aGUgd2hvbGUgYnJhbmNoIHRvIGFjY29tb2RhdGUgdGhlIGNoYW5nZXMgYW5kIHRoZW4NCj4gc2Vu
ZGluZyBhIHdob2xlIG5ldyBzZXJpZXMuLi4NCj4gDQoNClJpZ2h0LCBJIHRvb2sgdGhhdCBicmFu
Y2gsIHNxdWFzaGVkIHRoZSBsb2NraW5nIGZpeCBpbnRvIHBhdGNoIDIsIGZpeGVkIHVwIHRoZSBy
ZW1haW5pbmcgcGF0Y2hlcywgYW5kIHRoZW4gcmVkaWQgdGhlIGxhc3QgcGF0Y2guDQoNCkkgcGxh
biB0byBzZW5kIHRoZSByZXN1bHQgYXMgYSB2NCBvZiB0aGlzIHBhdGNoc2V0IHdpdGggYWxsIHRo
ZSBsaW5rcywgdmVyc2lvbiBoaXN0b3J5LCBldGMuIElzIHRoYXQgd2hhdCB5b3UgbWVhbj8gU29y
cnksIGlmIEkgbWlzdW5kZXJzdG9vZC4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
