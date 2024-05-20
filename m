Return-Path: <linux-edac+bounces-1077-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5128C9BAC
	for <lists+linux-edac@lfdr.de>; Mon, 20 May 2024 12:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D74281CD2
	for <lists+linux-edac@lfdr.de>; Mon, 20 May 2024 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D270524C4;
	Mon, 20 May 2024 10:55:02 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F12182DF;
	Mon, 20 May 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202502; cv=none; b=LgQZYfId5FqEiaD3WYsQkoECJhf5GXMo68AYIRbj1BekmdthJghBezZg0oerkq80ciKb4JJ7d5tRZE2swQO+FMvHtRDwgMIFDqI+++xM1y4/pOTqZbCzA3xgNUbifyCRpT+X7p0SCQKR56nqMCIjwd1N0hv82c3rYzoaCRhFWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202502; c=relaxed/simple;
	bh=TO8EEBnmnSNWOXgO1SQ7F4ImwMsRBUCPeRVobHIZqhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=riaI14l6Kx5ROZ01HGk+UEAK9pY96LDa+LDuqZWVA1KQw0nNu0gdYFsiF1wqDNiAVqgQRmD0BcArOMjpwegPY3+mYD+5zTGEpGk+vJxPOoZYhGL6A58l8dtvG1Af6DLO5Slvy3CIXHdMheNrfjW30PXnwNSnwGUd2903YE+EEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VjZF81Xpbz6K9HH;
	Mon, 20 May 2024 18:54:04 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 15166140C72;
	Mon, 20 May 2024 18:54:51 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 11:54:50 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Mon, 20 May 2024 11:54:50 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: RE: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Thread-Topic: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Thread-Index: AQHaknlLsB7DmyDvA0iAgKJhxeY8vLF4vVgAgABZuhCAEPP6AIADoMIA///2ZwCAABJKUIAAENcAgADo/ICAAG21AIAARhIAgAAV5gCAAAh4gIAAEuqAgACu0oCAAILmgIABHgCAgAmutkA=
Date: Mon, 20 May 2024 10:54:50 +0000
Message-ID: <6645f0738ead48a79f1baf753fc709c6@huawei.com>
References: <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
 <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
 <20240509101939.0000263a@Huawei.com>
 <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
 <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
 <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
 <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
 <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
 <663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
In-Reply-To: <20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBh
bGllbjguZGU+DQo+U2VudDogMTEgTWF5IDIwMjQgMTE6MTcNCj5UbzogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+Q2M6IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbT47IFNoaWp1IEpvc2UNCj48c2hpanUuam9zZUBodWF3ZWkuY29t
PjsgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+YWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgZGF2ZUBzdGdvbGFicy5uZXQ7DQo+ZGF2ZS5qaWFuZ0Bp
bnRlbC5jb207IGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRl
bC5jb207DQo+aXJhLndlaW55QGludGVsLmNvbTsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRhdmlkQHJlZGhhdC5jb207IFZpbGFz
LlNyaWRoYXJhbkBhbWQuY29tOw0KPmxlby5kdXJhbkBhbWQuY29tOyBZYXplbi5HaGFubmFtQGFt
ZC5jb207IHJpZW50amVzQGdvb2dsZS5jb207DQo+amlhcWl5YW5AZ29vZ2xlLmNvbTsgdG9ueS5s
dWNrQGludGVsLmNvbTsgSm9uLkdyaW1tQGFtZC5jb207DQo+ZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tOyByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0KPm5hb3lhLmhvcmln
dWNoaUBuZWMuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOyBqdGhvdWdodG9uQGdvb2dsZS5jb207
DQo+c29tYXN1bmRhcmFtLmFAaHBlLmNvbTsgZXJkZW1ha3Rhc0Bnb29nbGUuY29tOyBwZ29uZGFA
Z29vZ2xlLmNvbTsNCj5kdWVud2VuQGdvb2dsZS5jb207IG1pa2UubWFsdmVzdHV0b0BpbnRlbC5j
b207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJlY29tcHV0aW5nLmNvbTsg
ZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVyZWNvbXB1dGluZy5j
b207IG5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlhb2ZlaUBodWF3ZWku
Y29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47DQo+a2FuZ2thbmcu
c2hlbkBmdXR1cmV3ZWkuY29tOyB3YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29t
PjsNCj5MaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbg0K
PjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEplYW4gRGVsdmFyZSA8amRlbHZhcmVAc3Vz
ZS5jb20+OyBHdWVudGVyDQo+Um9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD47IERtaXRyeSBUb3Jv
a2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1JGQyBQQVRD
SCB2OCAwMS8xMF0gcmFzOiBzY3J1YjogQWRkIHNjcnViIHN1YnN5c3RlbQ0KPg0KPk9uIEZyaSwg
TWF5IDEwLCAyMDI0IGF0IDEwOjEzOjQxQU0gLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4+
IEluIGZhY3QgdGhpcyBxdWVzdGlvbiBtYXRjaGVzIG15IHJlYWN0aW9uIHRvIHRoZSBsYXN0IHBv
c3RpbmcgWzFdLCBhbmQNCj4+IGxlZCB0byBhIG11Y2ggaW1wcm92ZWQgY292ZXIgbGV0dGVyIGFu
ZCB0aGUgIkNvbXBhcmlzb24gb2Ygc2NydWJiaW5nDQo+PiBmZWF0dXJlcyIuIFRvIHlvdXIgcG9p
bnQgdGhlcmUgYXJlIHNjcnViIGNhcGFiaWxpdGllcyBhbHJlYWR5IGluIHRoZQ0KPj4ga2VybmVs
IGFuZCB3ZSB3b3VsZCBuZWVkIHRvIG1ha2UgYSBkZWNpc2lvbiBhYm91dCB3aGF0IHRvIGRvIGFi
b3V0IHRoZW0uDQo+DQo+VGhlIGFuc3dlciB0byB0aGF0IHF1ZXN0aW9uIGlzIHdoZXRoZXIgdGhp
cyBuZXcgdXNlcnNwYWNlIHVzYWdlIGlzIGdvaW5nIHRvDQo+d2FudCB0byBjb250cm9sIHRob3Nl
IHRvby4NCj4NCj5Tbw0KPg0KPiJVc2UgY2FzZSBvZiBzY3J1YiBjb250cm9sIGZlYXR1cmUiDQo+
DQo+ZnJvbSB0aGUgY292ZXIgbGV0dGVyIGlzIGdpdmluZyB0d28gc2hvcnQgc2VudGVuY2VzIGFi
b3V0IHdoYXQgb25lIHdvdWxkIGRvIGJ1dA0KPkknbSBzdGlsbCBtZWguIEEgd2hvbGUgc3Vic3lz
dGVtIG5lZWRpbmcgYSBidW5jaCBvZiBlZmZvcnQgd291bGQgbmVlZCBhIGxvdA0KPm1vcmUganVz
dGlmaWNhdGlvbi4NCj4NCj5TbyBjYW4gYW55b25lIHBsZWFzZSBlbGFib3JhdGUgbW9yZSBvbiB0
aGUgdXNlIGNhc2VzIGFuZCB3aHkgdGhpcyBuZXcgdGhpbmcgaXMNCj5uZWVkZWQ/DQoNCkZvbGxv
d2luZyBhcmUgc29tZSBvZiB0aGUgdXNlIGNhc2VzIG9mIGdlbmVyaWMgc2NydWIgY29udHJvbCBz
dWJzeXN0ZW0gYXMgZ2l2ZW4gaW4gdGhlIGNvdmVyIGxldHRlci4NClJlcXVlc3QgcGxlYXNlIGFk
ZCBhbnkgb3RoZXIgdXNlIGNhc2VzLCB3aGljaCBJIG1pc3NlZC4NCg0KMS4gVGhlcmUgYXJlIHNl
dmVyYWwgdHlwZXMgb2YgaW50ZXJmYWNlcyB0byBIVyBtZW1vcnkgc2NydWJiZXJzIGlkZW50aWZp
ZWQgc3VjaCBhcyBBQ1BJIE5WRElNTSBBUlMoQWRkcmVzcyBSYW5nZSBTY3J1YiksIENYTCBtZW1v
cnkgZGV2aWNlIHBhdHJvbCBzY3J1YiwgQ1hMIEREUjUgRUNTLCBBQ1BJIFJBUzIgbWVtb3J5IHNj
cnViYmluZyBmZWF0dXJlcyBhbmQgc29mdHdhcmUgYmFzZWQgbWVtb3J5IHNjcnViYmVyKGRpc2N1
c3NlZCBpbiB0aGUgY29tbXVuaXR5IFJlZmVyZW5jZSBbNV0gaW4gdGhlIGNvdmVyIGxldHRlciku
IEFsc28gc29tZSBzY3J1YmJlcnMgc3VwcG9ydCBjb250cm9sbGluZyAoYmFja2dyb3VuZCkgcGF0
cm9sIHNjcnViYmluZyhBQ1BJIFJBUzIsIENYTCkgIGFuZC9vciBvbi1kZW1hbmQgc2NydWJiaW5n
KEFDUEkgUkFTMiwgQUNQSSBBUlMpLiAgSG93ZXZlciB0aGUgc2NydWIgY29udHJvbHMgdmFyaWVz
IGJldHdlZW4gbWVtb3J5IHNjcnViYmVycy4gVGh1cyB0aGVyZSBpcyAgYSBuZWVkICBmb3IgYSBz
dGFuZGFyZCBnZW5lcmljIEFCSSBhbmQgc3lzZnMgc2NydWIgY29udHJvbHMgZm9yIHRoZSB1c2Vy
c3BhY2UgdG9vbHMsIHdoaWNoIGNvbnRyb2wgSFcgYW5kIFNXIHNjcnViYmVycyBpbiB0aGUgc3lz
dGVtLCBmb3IgdGhlIGVhc2luZXNzIG9mIHVzZS4NCjIuIFNjcnViIGNvbnRyb2xzIGluIHVzZXIg
c3BhY2UgYWxsb3cgdGhlIHVzZXIgc3BhY2UgdG9vbCB0byBkaXNhYmxlIGFuZCBlbmFibGUgdGhl
IGZlYXR1cmUgaW4gY2FzZSBkaXNhYmxpbmcgb2YgdGhlIGJhY2tncm91bmQgcGF0cm9sICBzY3J1
YmJpbmcgYW5kIGNoYW5naW5nIHRoZSBzY3J1YiByYXRlIGFyZSBuZWVkZWQgZm9yIG90aGVyIHB1
cnBvc2VzIHN1Y2ggYXMgcGVyZm9ybWFuY2UtYXdhcmUgb3BlcmF0aW9ucyB3aGljaCByZXF1aXJl
cyB0aGUgYmFja2dyb3VuZCBvcGVyYXRpb25zIHRvIGJlIHR1cm5lZCBvZmYgb3IgcmVkdWNlZC4N
CjMuIEFsbG93cyB0byBwZXJmb3JtIG9uLWRlbWFuZCBzY3J1YmJpbmcgZm9yIHNwZWNpZmljIGFk
ZHJlc3MgcmFuZ2UgaWYgc3VwcG9ydGVkIGJ5IHRoZSBzY3J1YmJlci4NCjQuIFVzZXIgc3BhY2Ug
dG9vbHMgY29udHJvbHMgc2NydWIgdGhlIG1lbW9yeSBESU1NcyByZWd1bGFybHkgYXQgYSBjb25m
aWd1cmFibGUgc2NydWIgcmF0ZSB1c2luZyB0aGUgc3lzZnMgc2NydWIgY29udHJvbHMgZGlzY3Vz
c2VkIGhlbHAsIA0KICAgIC0gdG8gZGV0ZWN0IHVuY29ycmVjdGFibGUgbWVtb3J5IGVycm9ycyBl
YXJseSBiZWZvcmUgdXNlciBhY2Nlc3NpbmcgbWVtb3J5LCB3aGljaCBoZWxwcyB0byByZWNvdmVy
IHRoZSBkZXRlY3RlZCBtZW1vcnkgZXJyb3JzLg0KICAgIC0gIHJlZHVjZXMgdGhlIGNoYW5jZSBv
ZiBhIGNvcnJlY3RhYmxlIGVycm9yIGJlY29taW5nIHVuY29ycmVjdGFibGUuDQoNClJlZ2FyZHMs
DQpTaGlqdQ0KDQo=

