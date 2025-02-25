Return-Path: <linux-edac+bounces-3198-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42278A43D5D
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2025 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563217A3C92
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2025 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9882638AE;
	Tue, 25 Feb 2025 11:20:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153DB1C84B1;
	Tue, 25 Feb 2025 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482424; cv=none; b=uLLHbbONFX9GQq2RuEFfVSzFW8Crd/MzQ1HBzSaQIxxCtPkSY4dzP8FUMVMjjk335a7u/pK5oIF46qd4ioV6RFRDAmMSCsrw7y+BJ9vO0ADjKJKyML1rQ3NzQhxHn9XWXHUIKy54KjB5CjtiXLeY42+CActOMigRXPnpZ/tD5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482424; c=relaxed/simple;
	bh=Od450IydMzW8qE+mpsF8wntCssGOb9fT65QOadyMYxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+fYiBwyYDV5Pli8rXKO+14Fr75T6J3tqOQdDIC4KUdT7vBD0+SN7ZotgJ4C3qFgTouxoQ9kxCCD+E+zzehe71R/EcrUyeOuHkNG48nSvbL8vnAw7jqGiczpVxht9inwV64dHtYg7lk6eKdo2qyU1TCam2YgNNd13rfosEJ06Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z2FRS3X0Bz6L52F;
	Tue, 25 Feb 2025 19:16:36 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 99025140257;
	Tue, 25 Feb 2025 19:20:17 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Feb 2025 12:20:17 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 25 Feb 2025 12:20:17 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
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
Thread-Index: AQHbfVuaekLsP7SN9UOZsd1dS/TdhbNWWP4AgAB+X0CAAAPbAIABFe0g
Date: Tue, 25 Feb 2025 11:20:17 +0000
Message-ID: <3a7ab8e887c2496faf18bfb8d7442fab@huawei.com>
References: <20250212143654.1893-1-shiju.jose@huawei.com>
 <20250224115002.GCZ7xc6o3yA1Q2j85i@fat_crate.local>
 <71ad0c8c6a304b2d9a62f49983c3d787@huawei.com>
 <20250224193608.GBZ7zKKAumB312YZnA@fat_crate.local>
In-Reply-To: <20250224193608.GBZ7zKKAumB312YZnA@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMjQgRmVicnVhcnkgMjAyNSAxOTozNg0KPlRvOiBTaGlqdSBKb3Nl
IDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPmxp
bnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IHRvbnkubHVja0BpbnRlbC5jb207IHJhZmFlbEBrZXJu
ZWwub3JnOw0KPmxlbmJAa2VybmVsLm9yZzsgbWNoZWhhYkBrZXJuZWwub3JnOyBkYW4uai53aWxs
aWFtc0BpbnRlbC5jb207DQo+ZGF2ZUBzdGdvbGFicy5uZXQ7IEpvbmF0aGFuIENhbWVyb24gPGpv
bmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+ZGF2ZS5qaWFuZ0BpbnRlbC5jb207IGFsaXNv
bi5zY2hvZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207DQo+aXJhLndl
aW55QGludGVsLmNvbTsgZGF2aWRAcmVkaGF0LmNvbTsgVmlsYXMuU3JpZGhhcmFuQGFtZC5jb207
DQo+bGVvLmR1cmFuQGFtZC5jb207IFlhemVuLkdoYW5uYW1AYW1kLmNvbTsgcmllbnRqZXNAZ29v
Z2xlLmNvbTsNCj5qaWFxaXlhbkBnb29nbGUuY29tOyBKb24uR3JpbW1AYW1kLmNvbTsgZGF2ZS5o
YW5zZW5AbGludXguaW50ZWwuY29tOw0KPm5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1lcy5t
b3JzZUBhcm0uY29tOyBqdGhvdWdodG9uQGdvb2dsZS5jb207DQo+c29tYXN1bmRhcmFtLmFAaHBl
LmNvbTsgZXJkZW1ha3Rhc0Bnb29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsNCj5kdWVud2Vu
QGdvb2dsZS5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJlY29tcHV0
aW5nLmNvbTsgZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVyZWNv
bXB1dGluZy5jb207IG5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlhb2Zl
aUBodWF3ZWkuY29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJv
YmVydG8NCj5TYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2thbmcuc2hlbkBm
dXR1cmV3ZWkuY29tOw0KPndhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyBM
aW51eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIw
IDAwLzE1XSBFREFDOiBTY3J1YjogaW50cm9kdWNlIGdlbmVyaWMgRURBQyBSQVMNCj5jb250cm9s
IGZlYXR1cmUgZHJpdmVyICsgQ1hML0FDUEktUkFTMiBkcml2ZXJzDQo+DQo+T24gTW9uLCBGZWIg
MjQsIDIwMjUgYXQgMDY6MzA6NDhQTSArMDAwMCwgU2hpanUgSm9zZSB3cm90ZToNCj4+IFRlc3Rp
bmcgcmVzdCBvZiB0aGUgcGF0Y2hlcyBmb3IgQ1hMIFJBUyBmZWF0dXJlcyBhbmQgQUNQSSBSQVMy
IHNjcnViDQo+PiBmZWF0dXJlIGluIHRoaXMgYnJhbmNoIGFyZSB3b3JrZWQgZmluZS4NCj4NCj5U
aGFua3MuDQo+DQo+VW5mb3J0dW5hdGVseSwgbXkgcmFuZGJ1aWxkIHRlc3RzIHRyaWdnZXIgaXNz
dWVzOg0KDQpIaSBCb3Jpc2xhdiwNCg0KVGhhbmtzIGZvciBzcG90dGluZyB0aGlzIGJ1Zy4NCg0K
RG8geW91IHdhbnQgbWUgdG8gc2VuZCB0aGUgZml4IGluIHRoZSBuZXh0IHZlcnNpb24/DQoNClBs
ZWFzZSBmaW5kIHRoZSBmaXggYmVsb3c6DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvbWVt
X3JlcGFpci5jIGIvZHJpdmVycy9lZGFjL21lbV9yZXBhaXIuYyBpbmRleCBjYmU1YTcyMjcxNWQu
LjNiMWE4NDU0NTdiMCAxMDA3NTUNCi0tLSBhL2RyaXZlcnMvZWRhYy9tZW1fcmVwYWlyLmMNCisr
KyBiL2RyaXZlcnMvZWRhYy9tZW1fcmVwYWlyLmMNCkBAIC0zMjIsNyArMzIyLDcgQEAgc3RhdGlj
IGludCBtZW1fcmVwYWlyX2NyZWF0ZV9kZXNjKHN0cnVjdCBkZXZpY2UgKmRldiwNCiAgICAgICAg
ICAgICAgICByZXR1cm4gLUVOT01FTTsNCiANCiAgICAgICAgZm9yIChpID0gMDsgaSA8IE1SX01B
WF9BVFRSUzsgaSsrKSB7DQotICAgICAgICAgICAgICAgbWVtY3B5KCZjdHgtPm1lbV9yZXBhaXJf
ZGV2X2F0dHJbaV0uZGV2X2F0dHIsDQorICAgICAgICAgICAgICAgbWVtY3B5KCZjdHgtPm1lbV9y
ZXBhaXJfZGV2X2F0dHJbaV0sDQogICAgICAgICAgICAgICAgICAgICAgICZkZXZfYXR0cltpXSwg
c2l6ZW9mKGRldl9hdHRyW2ldKSk7DQogICAgICAgICAgICAgICAgY3R4LT5tZW1fcmVwYWlyX2F0
dHJzW2ldID0NCiAgICAgICAgICAgICAgICAgICAgICAgICZjdHgtPm1lbV9yZXBhaXJfZGV2X2F0
dHJbaV0uZGV2X2F0dHIuYXR0cjsNCg0KVGhhbmtzLA0KU2hpanUNCg0KPg0KPkluIGZpbGUgaW5j
bHVkZWQgZnJvbSBkcml2ZXJzL2VkYWMvbWVtX3JlcGFpci5jOjEyOg0KPkluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvZWRhYy5oOjE2Og0KPkluIGZpbGUgaW5jbHVkZWQgZnJv
bSAuL2luY2x1ZGUvbGludXgvZGV2aWNlLmg6MTU6DQo+SW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4v
aW5jbHVkZS9saW51eC9kZXZfcHJpbnRrLmg6MTY6DQo+SW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4v
aW5jbHVkZS9saW51eC9yYXRlbGltaXQuaDo2Og0KPkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2lu
Y2x1ZGUvbGludXgvc2NoZWQuaDoxMzoNCj5JbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaDoxOToNCj5JbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVpZC5oOjcxOg0KPkluIGZpbGUgaW5jbHVkZWQgZnJvbSAu
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0Lmg6MjE6DQo+SW4gZmlsZSBpbmNsdWRlZCBm
cm9tIC4vaW5jbHVkZS9saW51eC9jcHVtYXNrLmg6MTI6DQo+SW4gZmlsZSBpbmNsdWRlZCBmcm9t
IC4vaW5jbHVkZS9saW51eC9iaXRtYXAuaDoxMzoNCj5JbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9p
bmNsdWRlL2xpbnV4L3N0cmluZy5oOjM5MjoNCj4uL2luY2x1ZGUvbGludXgvZm9ydGlmeS1zdHJp
bmcuaDo1NzE6NDogZXJyb3I6IGNhbGwgdG8gJ19fd3JpdGVfb3ZlcmZsb3dfZmllbGQnDQo+ZGVj
bGFyZWQgd2l0aCAnd2FybmluZycgYXR0cmlidXRlOiBkZXRlY3RlZCB3cml0ZSBiZXlvbmQgc2l6
ZSBvZiBmaWVsZCAoMXN0DQo+cGFyYW1ldGVyKTsgbWF5YmUgdXNlIHN0cnVjdF9ncm91cCgpPyBb
LVdlcnJvciwtV2F0dHJpYnV0ZS13YXJuaW5nXQ0KPiAgNTcxIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgX193cml0ZV9vdmVyZmxvd19maWVsZChwX3NpemVfZmllbGQsIHNpemUpOw0KPiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPjEgZXJyb3IgZ2VuZXJhdGVkLg0KPm1ha2Vb
NF06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyMDc6IGRyaXZlcnMvZWRhYy9tZW1fcmVw
YWlyLm9dIEVycm9yIDENCj5tYWtlWzRdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLg0KPm1ha2VbM106ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMv
ZWRhY10gRXJyb3IgMg0KPm1ha2VbM106ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uDQo+bWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ2NTogZHJpdmVyc10g
RXJyb3IgMg0KPm1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQo+
bWFrZVsxXTogKioqIFsvaG9tZS9hbWQva2VybmVsL2xpbnV4L01ha2VmaWxlOjE5ODk6IC5dIEVy
cm9yIDINCj5tYWtlOiAqKiogW01ha2VmaWxlOjI1MTogX19zdWItbWFrZV0gRXJyb3IgMg0KPg0K
PlRoYXQncyBhIGFsbG1vZGNvbmZpZy14ODZfNjQtY2xhbmcgYnVpbGQuDQo+DQo+Z2NjIHRyaWdn
ZXJzIGl0IHRvbzoNCj4NCj5JbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9pbmNsdWRlL2xpbnV4L3N0
cmluZy5oOjM5MiwNCj4gICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2JpdG1h
cC5oOjEzLA0KPiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvY3B1bWFzay5o
OjEyLA0KPiAgICAgICAgICAgICAgICAgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2
aXJ0Lmg6MjEsDQo+ICAgICAgICAgICAgICAgICBmcm9tIC4vYXJjaC94ODYvaW5jbHVkZS9hc20v
Y3B1aWQuaDo3MSwNCj4gICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9wcm9jZXNzb3IuaDoxOSwNCj4gICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4
L3NjaGVkLmg6MTMsDQo+ICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9yYXRl
bGltaXQuaDo2LA0KPiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvZGV2X3By
aW50ay5oOjE2LA0KPiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvZGV2aWNl
Lmg6MTUsDQo+ICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9lZGFjLmg6MTYs
DQo+ICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvZWRhYy9tZW1fcmVwYWlyLmM6MTI6DQo+
SW4gZnVuY3Rpb24g4oCYZm9ydGlmeV9tZW1jcHlfY2hr4oCZLA0KPiAgICBpbmxpbmVkIGZyb20g
4oCYbWVtX3JlcGFpcl9jcmVhdGVfZGVzY+KAmSBhdCBkcml2ZXJzL2VkYWMvbWVtX3JlcGFpci5j
OjMyNTozOg0KPi4vaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oOjU3MToyNTogZXJyb3I6
IGNhbGwgdG8g4oCYX193cml0ZV9vdmVyZmxvd19maWVsZOKAmQ0KPmRlY2xhcmVkIHdpdGggYXR0
cmlidXRlIHdhcm5pbmc6IGRldGVjdGVkIHdyaXRlIGJleW9uZCBzaXplIG9mIGZpZWxkICgxc3QN
Cj5wYXJhbWV0ZXIpOyBtYXliZSB1c2Ugc3RydWN0X2dyb3VwKCk/IFstV2Vycm9yPWF0dHJpYnV0
ZS13YXJuaW5nXQ0KPiAgNTcxIHwgICAgICAgICAgICAgICAgICAgICAgICAgX193cml0ZV9vdmVy
Zmxvd19maWVsZChwX3NpemVfZmllbGQsIHNpemUpOw0KPiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+Y2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj5tYWtlWzRdOiAqKiogW3Nj
cmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjA3OiBkcml2ZXJzL2VkYWMvbWVtX3JlcGFpci5vXSBFcnJv
ciAxDQo+bWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ2NTogZHJpdmVycy9l
ZGFjXSBFcnJvciAyDQo+bWFrZVszXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4NCj5tYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBkcml2ZXJzXSBF
cnJvciAyDQo+bWFrZVsxXTogKioqIFsvaG9tZS9hbWQva2VybmVsL2xpbnV4L01ha2VmaWxlOjE5
ODk6IC5dIEVycm9yIDINCj5tYWtlOiAqKiogW01ha2VmaWxlOjI1MTogX19zdWItbWFrZV0gRXJy
b3IgMiAxMS0yMi0wOS1hbGxtb2Rjb25maWcteDg2XzY0LQ0KPjIwODQ5LmxvZyAoRU5EKQ0KPg0K
Pi0tDQo+UmVnYXJkcy9HcnVzcywNCj4gICAgQm9yaXMuDQo+DQo+aHR0cHM6Ly9wZW9wbGUua2Vy
bmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg0K

