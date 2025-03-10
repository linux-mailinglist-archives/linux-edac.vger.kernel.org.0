Return-Path: <linux-edac+bounces-3336-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B68A59261
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 12:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E5E16C063
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A9227586;
	Mon, 10 Mar 2025 11:12:07 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC66226D0A;
	Mon, 10 Mar 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605127; cv=none; b=bNDr4LIOIk+ibu1YYM/pp7AG6hZYT48VzhBEoeZwsmO8NQHSFoai7tcCyCt0WxTpv4Vm2Hbgm4MStrvRE0B+tQtRdW6mOC/KpS8FZLgz/cFZA7bkrKKi4maFhYBHHkEs0jcBgSE6cXxRLQl7AT+YALhzBUE7DQqWRMEvaQ+KcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605127; c=relaxed/simple;
	bh=TXUoktJdyf6ivHZnEYLZuYpDFxsN2x7ZsoaDsXfSzfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4BVL7+K+QtP4QabHYZxtvsTBzm88yMy66qRnX7t2irotO8Uwkh1qJCC46FGRGVqXgkzSEH2ztqa3+3zl0NrAGNoh+M1jTlkf0zJCbwbH8M2aQKy4VBTnqUdGGbkMs1ilDlVEYyrApDndjz7au/BS+kwQKG+JPl6wGI0Qxp0bos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBDgJ1Z38z6K94v;
	Mon, 10 Mar 2025 19:09:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9545A140516;
	Mon, 10 Mar 2025 19:12:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Mar 2025 12:12:01 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 10 Mar 2025 12:12:01 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 3/3] ras: mem: Add memory ACPI RAS2 driver
Thread-Topic: [PATCH v2 3/3] ras: mem: Add memory ACPI RAS2 driver
Thread-Index: AQHbjfjWvkdDRJ1spk2t3VxaCsibfrNoKYKAgAQFsPA=
Date: Mon, 10 Mar 2025 11:12:01 +0000
Message-ID: <85e788be5df3483082744a8904560979@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
 <20250305180225.1226-4-shiju.jose@huawei.com>
 <0d9066de-769a-44d0-bece-26f1313ce006@os.amperecomputing.com>
In-Reply-To: <0d9066de-769a-44d0-bece-26f1313ce006@os.amperecomputing.com>
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
ZWxmQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+U2VudDogMDcgTWFyY2ggMjAyNSAyMTo1Mg0K
PlRvOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBsaW51eC1lZGFjQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+YWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGJwQGFsaWVuOC5kZTsg
dG9ueS5sdWNrQGludGVsLmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+bGVuYkBrZXJuZWwub3Jn
OyBtY2hlaGFiQGtlcm5lbC5vcmc7IGxlby5kdXJhbkBhbWQuY29tOw0KPllhemVuLkdoYW5uYW1A
YW1kLmNvbQ0KPkNjOiBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb207IGRhdmVAc3Rnb2xhYnMubmV0Ow0KPkpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbT47IGRhdmUuamlhbmdAaW50ZWwuY29tOw0KPmFsaXNvbi5zY2hv
ZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlueUBpbnRl
bC5jb207DQo+ZGF2aWRAcmVkaGF0LmNvbTsgVmlsYXMuU3JpZGhhcmFuQGFtZC5jb207IGxpbnV4
LW1tQGt2YWNrLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgcmllbnRqZXNA
Z29vZ2xlLmNvbTsgamlhcWl5YW5AZ29vZ2xlLmNvbTsNCj5Kb24uR3JpbW1AYW1kLmNvbTsgZGF2
ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOw0KPm5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1l
cy5tb3JzZUBhcm0uY29tOyBqdGhvdWdodG9uQGdvb2dsZS5jb207DQo+c29tYXN1bmRhcmFtLmFA
aHBlLmNvbTsgZXJkZW1ha3Rhc0Bnb29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsNCj5kdWVu
d2VuQGdvb2dsZS5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJlY29t
cHV0aW5nLmNvbTsgZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVy
ZWNvbXB1dGluZy5jb207IG5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlh
b2ZlaUBodWF3ZWkuY29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47
IFJvYmVydG8NCj5TYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2thbmcuc2hl
bkBmdXR1cmV3ZWkuY29tOw0KPndhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+
OyBMaW51eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMy8zXSByYXM6IG1lbTogQWRkIG1lbW9yeSBBQ1BJIFJBUzIgZHJpdmVyDQo+DQo+DQo+PiAr
c3RhdGljIGludCByYXMyX2h3X3NjcnViX3JlYWRfc2l6ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZv
aWQNCj4+ICsqZHJ2X2RhdGEsIHU2NCAqc2l6ZSkgew0KPj4gKwlzdHJ1Y3QgcmFzMl9tZW1fY3R4
ICpyYXMyX2N0eCA9IGRydl9kYXRhOw0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlpZiAocmFz
Ml9jdHgtPmJnX3NjcnViKQ0KPj4gKwkJcmV0dXJuIC1FQlVTWTsNCj4+ICsNCj4+ICsJcmV0ID0g
cmFzMl91cGRhdGVfcGF0cm9sX3NjcnViX3BhcmFtc19jYWNoZShyYXMyX2N0eCk7DQo+PiArCWlm
IChyZXQpDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwkqc2l6ZSA9IHJhczJfY3R4LT5z
aXplOw0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+DQo+Q2FsbGluZyByYXMyX3VwZGF0
ZV9wYXRyb2xfc2NydWJfcGFyYW1zX2NhY2hlIGhlcmUgaXMgcHJvYmxlbWF0aWMuDQo+DQo+SW1h
Z2luZToNCj4gIGVjaG8gMHgxMDAwID4gc2l6ZQ0KPiAgY2F0IHNpemUNCj4gIGVjaG8gMHgyMDAw
MDAwMDAwID4gYWRkcg0KPg0KPldoYXQgaGFwcGVucyBoZXJlPyBXaGF0IGhhcHBlbnMgaXMgdGhl
IHNjcnViIHJhbmdlIGlzIG5vdCB3aGF0IHlvdSBleHBlY3QgaXQNCj50byBiZS4gIE9uY2UgeW91
IGNhdCBzaXplLCB5b3UgcmVzZXQgdGhlIHNpemUgZnJvbSB3aGF0IHlvdSBpbml0aWFsbHkgc2V0
IGl0IHRvLg0KPkkgZG9uJ3QgdGhpbmsgdGhhdCBpcyB3aGF0IGFueW9uZSB3aWxsIGV4cGVjdC4g
SXQgY2VydGFpbmx5IGNhdXNlZCB1cyB0byBzdHVtYmxlDQo+d2hpbGUgdGVzdGluZy4NCg0KVGhp
cyBpcyBhbiBleHBlY3RlZCBiZWhhdmlvciBhbmQgdGhpcyBleHRyYSBjYWxsIHdhcyBhZGRlZCBo
ZXJlIHdoZW4gY2hhbmdlZCB1c2luZyBhdHRyaWJ1dGUgJ2FkZHInIHRvIHN0YXJ0DQp0aGUgb24t
ZGVtYW5kICBzY3J1YiBvcGVyYXRpb24gaW5zdGVhZCBvZiBwcmV2aW91cyBzZXBhcmF0ZSBhdHRy
aWJ1dGUgJyBlbmFibGVfb25fZGVtYW5kJyB0byBzdGFydA0KdGhlIG9uLWRlbWFuZCBzY3J1YiBv
cGVyYXRpb24sIGFjY29yZGluZyB0byBCb3Jpc2xhdidzIHN1Z2dlc3Rpb24gaW4gdjEzLg0KDQog
UGxlYXNlIHNlZSB0aGUgZm9sbG93aW5nIGNvbW1lbnQgaW4gdGhlIHJhczJfaHdfc2NydWJfcmVh
ZF9hZGRyKCkgZm5jdGlvbiwNCiJVc2Vyc3BhY2Ugd2lsbCBnZXQgdGhlIHN0YXR1cyBvZiB0aGUg
ZGVtYW5kIHNjcnViYmluZyB0aHJvdWdoIHRoZSBhZGRyZXNzIHJhbmdlDQpyZWFkIGZyb20gdGhl
IGZpcm13YXJlLiBXaGVuIHRoZSBkZW1hbmQgc2NydWJiaW5nIGlzIGZpbmlzaGVkIGZpcm13YXJl
IG11c3QgcmVzZXQgYWN0dWFsIA0KYWRkcmVzcyByYW5nZSB0byAwLiBPdGhlcndpc2UgdXNlcnNw
YWNlIGFzc3VtZXMgZGVtYW5kIHNjcnViYmluZyBpcyBpbiBwcm9ncmVzcy4iDQoNCkhlcmUgc3lz
ZnMgYXR0cmlidXRlcyAnYWRkcicgYW5kICdzaXplJyBpcyByZWFkaW5nIHRoZSBmaWVsZDogQWN0
dWFsIEFkZHJlc3MgUmFuZ2Ugb2YgDQpUYWJsZSA1Ljg3OiBQYXJhbWV0ZXIgQmxvY2sgU3RydWN0
dXJlIGZvciBQQVRST0xfU0NSVUIsIHdyaXR0ZW4gYnkgdGhlIGZpcm13YXJlLg0KICANCkluIG15
IG9waW5pb24sIHJlYWRpbmcgYmFjayB0aGUgYWRkcmVzcyByYW5nZSBzaXplIHNldCBpbiB0aGUg
c3lzZnMgYmVmb3JlIGFjdHVhbGx5IHdyaXRpbmcNCnRoZSBhZGRyZXNzIHJhbmdlIHRvIHRoZSBm
aXJtd2FyZSBhbmQgc3RhcnRpbmcgdGhlIG9uLWRlbWFuZCBzY3J1YiBvcGVyYXRpb24gZG9lc24n
dCANCmhvbGQgbXVjaCBzaWduaWZpY2FuY2U/DQoNCj4NCj5SZWdhcmRzLA0KPn5EYW5pZWwNCg0K
VGhhbmtzLA0KU2hpanUNCg==

