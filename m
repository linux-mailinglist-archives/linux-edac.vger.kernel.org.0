Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C56EB349
	for <lists+linux-edac@lfdr.de>; Thu, 31 Oct 2019 15:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfJaO6s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Oct 2019 10:58:48 -0400
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:46305
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728029AbfJaO6s (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 31 Oct 2019 10:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKsK6QWJS9WmUDXE9g76nQFkjfegVW/vVeEAP71vSfgp3rkCdz5DGgO3Z4vlpcXG/GSG1piwj+L5gEN40jtYBNSB8/EFWCiC8yK/FYu4wa1lRrupEm3nbZ+dQgzj/e+xs+hAUi81/tDNNayRk6KbWyWqxcAjUy72CrKw2FR4RqcgYUQ0VD43PBmY28avJPbYkjOMXk4cdNXWDF8t3NsU8ZRPP+ILZf8aj9msLCNpHTQKRbCrtt9KOgtvICNj68txx8Nn2y3mUTjIUJIx8nPBpBhKDqTW0Q57EibKGZ025ppYQydlG6s48EC6kztJdUNKUCBIjEjYniY45jnW/7htnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8iv69vb6pJiJhjUBu+u5EPTr8o5fyXpKcDTmKasnpk=;
 b=NpTJclkgFZkwZx1/sRAA3tqC4wSc/3E/dtONLXtrYV9UDEg/K52+w9bPzsCtK5bE/ujmQdrBXcrySMF57bmVfs4F5XW7PQE/Y9AuBVfA0fra0aknLGt6ygX8jpGiCohLmvBFQi72vpORgebhYGtdacSEqo/dgIQe0SCIWfPZ9A3aL7sXbsn3aBnKGqQ0Ecta1XraOBhBhvx+u5ht2qC7BbvQZXnYApyfhlAmG+DFNu/1yf+uc4NvG5EPy06n9eo5d+ol0KmNrEyYApDH29G6vI6LzGwSR6wLBWIFQw8IVhusAubw0z8hQvGy0LsQVJUaRMRh+wARZpE0qyDminkV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8iv69vb6pJiJhjUBu+u5EPTr8o5fyXpKcDTmKasnpk=;
 b=3F5spoqkzvYzYiApTOXPFoZ9lvsyy7wgFJ10EJq6VTwaOke8WRcBp3pd9z91y/fJI/vxS45LEYSDzFwD6ALtEAennLIoMHxW6GeokNLo78JuRjwUcXwWQNVPGpJuC4/cI+OtbEYFGeOln4CBzpCKVlbCB3dx0iadt0RdipF5qQA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2766.namprd12.prod.outlook.com (52.135.107.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 31 Oct 2019 14:58:45 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 14:58:45 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
CC:     Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/MCE/AMD: fix warning about sleep-in-atomic at early
 boot
Thread-Topic: [PATCH] x86/MCE/AMD: fix warning about sleep-in-atomic at early
 boot
Thread-Index: AQHVj+vKM1/xat6HGkejerE7UOI1HKd0z3yAgAAFsgA=
Date:   Thu, 31 Oct 2019 14:58:45 +0000
Message-ID: <SN6PR12MB2639DBDA3897067733D6C669F8630@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <157252708836.3876.4604398213417262402.stgit@buzz>
 <20191031142955.GA23693@nazgul.tnic>
In-Reply-To: <20191031142955.GA23693@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d996fe8-2cf1-4b5a-f63f-08d75e12d434
x-ms-traffictypediagnostic: SN6PR12MB2766:
x-microsoft-antispam-prvs: <SN6PR12MB2766171892A0B646E2D2F189F8630@SN6PR12MB2766.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(13464003)(189003)(199004)(2906002)(11346002)(76176011)(14454004)(486006)(5660300002)(71200400001)(33656002)(305945005)(7696005)(229853002)(316002)(476003)(99286004)(52536014)(6436002)(7736002)(71190400001)(55016002)(54906003)(14444005)(110136005)(446003)(4326008)(6116002)(6246003)(81156014)(76116006)(86362001)(8676002)(66446008)(66946007)(256004)(25786009)(64756008)(186003)(53546011)(81166006)(9686003)(6506007)(66066001)(478600001)(74316002)(3846002)(26005)(8936002)(66476007)(102836004)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2766;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bI6AKK503RDSeBe8/iA/IFn9AgJ4AIihSnN4DAfZrzqaPYMBodAL9GWcYQ9toS9J04ehOMXeidLOxOhcSh1bHRls4a0CbNt5WYIlMmN852RJxORXcUxK+rTBL+4IrAFU5CV3dX6GaDlrGncArXFrsJIuOo/28JGTFFcMXVefO8/W5Su+XhSjhevD9DPal6awmf0tbhmkedk9syCz3nGugs6F24kMDpLW2W1QJFgX33G1u3PPQRSJn8MjTlvxA3LE8CB6gGMBU/1JHwmdhhuxPOX/T8o+YakhuXrR2hnKUjQiVVUTJj0AbZDEaeCLQyMhp9GTSQopRObS06JrgFcQcu+sYZ3zvuFaXY7YGH+UTdw0acHHz/7DBtMPpaenpT3wSc82UBorkYL5Q+Pj1u2PY8+iR+V+DrJqtbUqg8cZCJhf5V/KDc8c8lma17VYgvm3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d996fe8-2cf1-4b5a-f63f-08d75e12d434
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 14:58:45.7578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qS2F6ryfw9xZITaYB4aiKGU+Y/tu5+HTmZu2bfpjmmj7c9L5Q7jwYFOuisaU6T2SySq0M9oOjmoeb1VuCykpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMzEsIDIwMTkgMTA6MzAgQU0N
Cj4gVG86IEtvbnN0YW50aW4gS2hsZWJuaWtvdiA8a2hsZWJuaWtvdkB5YW5kZXgtdGVhbS5ydT47
IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENjOiBUb255IEx1Y2sg
PHRvbnkubHVja0BpbnRlbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0geDg2L01DRS9BTUQ6IGZpeCB3YXJuaW5nIGFib3V0IHNsZWVwLWluLWF0b21pYyBhdCBl
YXJseSBib290DQo+IA0KPiBPbiBUaHUsIE9jdCAzMSwgMjAxOSBhdCAwNDowNDo0OFBNICswMzAw
LCBLb25zdGFudGluIEtobGVibmlrb3Ygd3JvdGU6DQo+ID4gRnVuY3Rpb24gc21jYV9jb25maWd1
cmUoKSBpcyBjYWxsZWQgb25seSBmb3IgY3VycmVudCBjcHUgdGh1cw0KPiA+IHJkbXNyX3NhZmVf
b25fY3B1KCkgY291bGQgYmUgcmVwbGFjZWQgd2l0aCBhdG9taWMgcmRtc3Jfc2FmZSgpLg0KPiA+
DQo+ID4gIEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0
IGF0IGtlcm5lbC9zY2hlZC9jb21wbGV0aW9uLmM6OTkNCj4gPiAgaW5fYXRvbWljKCk6IDEsIGly
cXNfZGlzYWJsZWQoKTogMSwgcGlkOiAwLCBuYW1lOiBzd2FwcGVyLzENCj4gPiAgQ1BVOiAxIFBJ
RDogMCBDb21tOiBzd2FwcGVyLzEgTm90IHRhaW50ZWQgNC4xOS43OS0xNiAjMQ0KPiAJCQkJCSAg
ICAgXl5eXl5eXl5eXg0KPiANCj4gSSdtIGFzc3VtaW5nIHlvdSBoaXQgdGhpcyBvbiBsYXRlc3Qg
dXBzdHJlYW0gdG9vPw0KPiANCj4gPiAgSGFyZHdhcmUgbmFtZTogR0lHQUJZVEUgUjE4MS1aOTAt
MDAvTVo5MS1GUzAtMDAsIEJJT1MgUjExIDEwLzI1LzIwMTkNCj4gPiAgQ2FsbCBUcmFjZToNCj4g
PiAgIGR1bXBfc3RhY2srMHg1Yy8weDdiDQo+ID4gICBfX19taWdodF9zbGVlcCsweGVjLzB4MTEw
DQo+ID4gICB3YWl0X2Zvcl9jb21wbGV0aW9uKzB4MzkvMHgxNjANCj4gPiAgID8gX19yZG1zcl9z
YWZlX29uX2NwdSsweDQ1LzB4NjANCj4gPiAgIHJkbXNyX3NhZmVfb25fY3B1KzB4YWUvMHhmMA0K
PiA+ICAgPyB3cm1zcl9vbl9jcHVzKzB4MjAvMHgyMA0KPiA+ICAgPyBtYWNoaW5lX2NoZWNrX3Bv
bGwrMHhmZC8weDFmMA0KPiA+ICAgPyBtY2VfYW1kX2ZlYXR1cmVfaW5pdCsweDE5MC8weDJkMA0K
PiA+ICAgbWNlX2FtZF9mZWF0dXJlX2luaXQrMHgxOTAvMHgyZDANCj4gPiAgIG1jaGVja19jcHVf
aW5pdCsweDExYS8weDQ2MA0KPiA+ICAgaWRlbnRpZnlfY3B1KzB4M2UyLzB4NTYwDQo+ID4gICBp
ZGVudGlmeV9zZWNvbmRhcnlfY3B1KzB4MTMvMHg4MA0KPiA+ICAgc21wX3N0b3JlX2NwdV9pbmZv
KzB4NDUvMHg1MA0KPiA+ICAgc3RhcnRfc2Vjb25kYXJ5KzB4YWEvMHgyMDANCj4gPiAgIHNlY29u
ZGFyeV9zdGFydHVwXzY0KzB4YTQvMHhiMA0KPiA+DQo+ID4gRXhjZXB0IHdhcm5pbmcgaW4ga2Vy
bmVsIGxvZyBldmVyeXRoaW5nIHdvcmtzIGZpbmUuDQo+ID4NCj4gPiBGaXhlczogNTg5NjgyMGUw
YWEzICgieDg2L21jZS9BTUQsIEVEQUMvbWNlX2FtZDogRGVmaW5lIGFuZCB1c2UgdGFibGVzIGZv
ciBrbm93biBTTUNBIElQIHR5cGVzIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBLb25zdGFudGluIEto
bGVibmlrb3YgPGtobGVibmlrb3ZAeWFuZGV4LXRlYW0ucnU+DQo+ID4gLS0tDQo+ID4gIGFyY2gv
eDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jIHwgICAgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5j
DQo+ID4gaW5kZXggNmVhN2ZkYzgyZjNjLi5jN2FiMGQzOGFmNzkgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC94ODYva2VybmVsL2NwdS9tY2UvYW1kLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9hbWQuYw0KPiA+IEBAIC0yNjksNyArMjY5LDcgQEAgc3RhdGljIHZvaWQgc21jYV9j
b25maWd1cmUodW5zaWduZWQgaW50IGJhbmssIHVuc2lnbmVkIGludCBjcHUpDQo+ID4gIAlpZiAo
c21jYV9iYW5rc1tiYW5rXS5od2lkKQ0KPiA+ICAJCXJldHVybjsNCj4gPg0KPiA+IC0JaWYgKHJk
bXNyX3NhZmVfb25fY3B1KGNwdSwgTVNSX0FNRDY0X1NNQ0FfTUN4X0lQSUQoYmFuayksICZsb3cs
ICZoaWdoKSkgew0KPiA+ICsJaWYgKHJkbXNyX3NhZmUoTVNSX0FNRDY0X1NNQ0FfTUN4X0lQSUQo
YmFuayksICZsb3csICZoaWdoKSkgew0KPiANCj4gWWF6ZW4sIGFueSBvYmplY3Rpb25zPw0KPiAN
Cg0KVGhpcyBsb29rcyBnb29kIHRvIG1lLg0KDQpXZSBjYW4gZ28gZnVydGhlciBhbmQgcmVtb3Zl
IHRoZSAiY3B1IiBwYXJhbWV0ZXIgZnJvbSB0aGlzIGVudGlyZSBmdW5jdGlvbi4NCkJ1dCB0aGF0
IGNhbiBiZSBhbm90aGVyIHBhdGNoLg0KDQpSZXZpZXdlZC1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6
ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGFua3MsDQpZYXplbg0K
