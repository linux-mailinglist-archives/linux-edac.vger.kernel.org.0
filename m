Return-Path: <linux-edac+bounces-3335-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 028CEA590DE
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 11:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B9188F673
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6071022578E;
	Mon, 10 Mar 2025 10:16:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975215B543;
	Mon, 10 Mar 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601796; cv=none; b=EiwEthtbFpTKfWQG184G5gS5tIzp3ASWevV3Wmu25MIA2eBemMTNZGzZths/a3R+AR4H09awH8x+ePE6o616WhBgaP2Vi0b807qEt649/R+o9NX4Qbte5b8N3EHUibIQ9T9kb+4/1+KoD21gGnnKRafUUDtZg4FsdRhwRZ5OhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601796; c=relaxed/simple;
	bh=Pp92InC5gFyJ7GuSjZ4HIOHep6belOTPM6GU5HEuFBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mL+vAg61vLNaslRznTnwYPGrroubOfTrell/Wq0vvQGxaRrqo52xn7cy5iJrh4vlyxTYI8r3uotolraM9vQZJyFGE1+4od47hyC+5nW015EkpAoMxrcMRmfcBCfzkF6yfqVrU0E+5klQkJp8HhimPFepcM+mXJyjF5cKe8d0qC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBCQR60Gpz6M4mh;
	Mon, 10 Mar 2025 18:13:19 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id EF6C8140B55;
	Mon, 10 Mar 2025 18:16:24 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Mar 2025 11:16:24 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 10 Mar 2025 11:16:24 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v20 00/15] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
Thread-Topic: [PATCH v20 00/15] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Thread-Index: AQHbfVuaekLsP7SN9UOZsd1dS/TdhbNmfMuAgAXLMYA=
Date: Mon, 10 Mar 2025 10:16:24 +0000
Message-ID: <b954cf71abee477193b5a877d7f93542@huawei.com>
References: <20250212143654.1893-1-shiju.jose@huawei.com>
 <6d8e89d4-e0b8-4e89-8a18-6f9d4f2989ee@os.amperecomputing.com>
In-Reply-To: <6d8e89d4-e0b8-4e89-8a18-6f9d4f2989ee@os.amperecomputing.com>
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGFuaWVsIEZlcmd1c29uIDxkYW5p
ZWxmQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+U2VudDogMDYgTWFyY2ggMjAyNSAxODoxOA0K
PlRvOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBsaW51eC1lZGFjQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+Y3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPkNjOiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBicEBhbGllbjguZGU7IHRv
bnkubHVja0BpbnRlbC5jb207DQo+cmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsg
bWNoZWhhYkBrZXJuZWwub3JnOw0KPmRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgZGF2ZUBzdGdv
bGFicy5uZXQ7IEpvbmF0aGFuIENhbWVyb24NCj48am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
PjsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207DQo+YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IHZp
c2hhbC5sLnZlcm1hQGludGVsLmNvbTsgaXJhLndlaW55QGludGVsLmNvbTsNCj5kYXZpZEByZWRo
YXQuY29tOyBWaWxhcy5TcmlkaGFyYW5AYW1kLmNvbTsgbGVvLmR1cmFuQGFtZC5jb207DQo+WWF6
ZW4uR2hhbm5hbUBhbWQuY29tOyByaWVudGplc0Bnb29nbGUuY29tOyBqaWFxaXlhbkBnb29nbGUu
Y29tOw0KPkpvbi5HcmltbUBhbWQuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207DQo+
bmFveWEuaG9yaWd1Y2hpQG5lYy5jb207IGphbWVzLm1vcnNlQGFybS5jb207IGp0aG91Z2h0b25A
Z29vZ2xlLmNvbTsNCj5zb21hc3VuZGFyYW0uYUBocGUuY29tOyBlcmRlbWFrdGFzQGdvb2dsZS5j
b207IHBnb25kYUBnb29nbGUuY29tOw0KPmR1ZW53ZW5AZ29vZ2xlLmNvbTsgZ3RoZWxlbkBnb29n
bGUuY29tOw0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcuY29tOyBkZmVyZ3Vzb25AYW1wZXJl
Y29tcHV0aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgbmlmYW4uY3hsQGdt
YWlsLmNvbTsgdGFueGlhb2ZlaQ0KPjx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvIChC
KSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgUm9iZXJ0bw0KPlNhc3N1IDxyb2JlcnRvLnNh
c3N1QGh1YXdlaS5jb20+OyBrYW5na2FuZy5zaGVuQGZ1dHVyZXdlaS5jb207DQo+d2FuZ2h1aXFp
YW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IExpbnV4YXJtDQo+PGxpbnV4YXJtQGh1YXdl
aS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MjAgMDAvMTVdIEVEQUM6IFNjcnViOiBpbnRy
b2R1Y2UgZ2VuZXJpYyBFREFDIFJBUw0KPmNvbnRyb2wgZmVhdHVyZSBkcml2ZXIgKyBDWEwvQUNQ
SS1SQVMyIGRyaXZlcnMNCj4NCj4+ICArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0t
LS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rDQo+PiAgfCAgICAgICAgICAgICAgfCAgICAg
ICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAgfA0KPj4gIHwgU2V0dGlu
ZyAgICAgIHwgU3VwcG9ydGVkIHwgU3VwcG9ydGVkIHwgTm8gICAgICAgIHwgTm8gICAgICAgIHwN
Cj4+ICB8IHNjcnViIHJhdGUgICB8ICAgICAgICAgICB8ICAgICAgICAgICB8ICAgICAgICAgICB8
ICAgICAgICAgICB8DQo+PiAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgfCAgICAgICAgICAg
fCAgICAgICAgICAgfCAgICAgICAgICAgfA0KPj4gICstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LSstLS0tLS0tLS0tLSstLS0tLS0tLS0tLSstLS0tLS0tLS0tLSsNCj4+ICB8ICAgICAgICAgICAg
ICB8ICAgICAgICAgICB8ICAgICAgICAgICB8ICAgICAgICAgICB8ICAgICAgICAgICB8DQo+PiAg
fCBVbml0IGZvciAgICAgfCBOb3QgICAgICAgfCBpbiBob3VycyAgfCBObyAgICAgICAgfCBObyAg
ICAgICAgfA0KPj4gIHwgc2NydWIgcmF0ZSAgIHwgRGVmaW5lZCAgIHwgICAgICAgICAgIHwgICAg
ICAgICAgIHwgICAgICAgICAgIHwNCj4+ICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICB8ICAg
ICAgICAgICB8ICAgICAgICAgICB8ICAgICAgICAgICB8DQo+DQo+SXQgaXMgb3VyIG9waW5pb24g
dGhhdCB0aGUgVW5pdCBmb3Igc2NydWIgcmF0ZSBzaG91bGQgYmUgdW5pdCBhZ25vc3RpYw0KPihp
bXBsZW1lbnRhdGlvbiBkZWZpbmVkKSwgYW5kIGRlZmluaXRlbHkgbm90IHNwZWNpZmllZCBpbiBI
b3Vycy4gV2UgYmVsaWV2ZSB0aGF0DQo+dGhlIHNwaXJpdCBvZiB0aGUgUkFTMiBzY3J1YiByYXRl
IHdhcyBpbnRlbmRlZCB0byBiZSBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkLg0KPg0KPkl0IHRha2Vz
IG91ciBoYXJkd2FyZSBsZXNzIHRoYW4gYSBmZXcgc2Vjb25kcyB0byBzY3J1YiBhIHRvbiBvZiBt
ZW1vcnkuDQpIaSBEYW5pZWwsIA0KDQpUaGUgdGFibGUgaWxsdXN0cmF0ZXMgdGhlIHVuaXQgZm9y
IHRoZSBzY3J1YiByYXRlIG9mIHRoZSBBQ1BJIFJBUzIgc2NydWIgZmVhdHVyZSBhcyAiTm90IERl
ZmluZWQiIGFjY29yZGluZyB0byB0aGUgQUNQSSA2LjUgc3BlY2lmaWNhdGlvbiwgYW5kIGZvciB0
aGUgQ1hMIHNjcnViIGZlYXR1cmUsIGl0IGlzIGRlZmluZWQgYXMgImluIGhvdXJzIiBhY2NvcmRp
bmcgdG8gdGhlIENYTCBzcGVjIHJldiAzLjIuDQoNCkN1cnJlbnRseSwgdGhlIFJBUzIgZHJpdmVy
IGNvbnZlcnRzIHRoZSBzY3J1YiByYXRlIHNldCBpbiBzZWNvbmRzIHZpYSB0aGUgRURBQyBzY3J1
YiBzeXNmcyB0byBob3VycyBhbmQgcGFzc2VzIGl0IHRvIHRoZSBmaXJtd2FyZSBpbiB0aGUgIGZp
ZWxkOiBDb25maWd1cmUgU2NydWIgUGFyYW1ldGVycyAoSU5QVVQpIC0gQml0cyBbMTU6OF06IFJl
cXVlc3RlZCBzY3J1YiByYXRlIG9mIFRhYmxlIDUuODc6IFBhcmFtZXRlciBCbG9jayBTdHJ1Y3R1
cmUgZm9yIFBBVFJPTF9TQ1JVQi4NCg0KRGlkIHlvdSBtZWFuIHRoYXQgdGhlIFJBUzIgZHJpdmVy
IG5lZWRzIHRvIHBhc3MgdGhlIHNjcnViIHJhdGUgaW4gc2Vjb25kcyB0byB0aGUgZmlybXdhcmU/
ICB0aGVuIEkgdGhpbmsgdGhlIG1heCBzY3J1YiByYXRlIHN1cHBvcnRlZCBpcyBsaW1pdGVkIHRv
IDI1NiBzZWNvbmRzPw0KDQpUaGFua3MsDQpTaGlqdQ0K

