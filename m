Return-Path: <linux-edac+bounces-3030-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48150A316DA
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 21:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1153A88F5
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 20:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814DA1E2611;
	Tue, 11 Feb 2025 20:46:20 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B9265602;
	Tue, 11 Feb 2025 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306780; cv=none; b=mLNFAATuTt8WS9207xnXzDHB7NMwEt6YrgBQiGpT0eLjP4d5QxzL/t6fKe6D5q40j36+pTkS7WWjmg09kpBSkaZkXV5XzbTD5oPyREkRgLSLcZd3/YR7W4GHbXLVlGr5n+zWXPi3Ab2/kfov4KSn17ixpKB3ZRQ+Y44fim+Utr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306780; c=relaxed/simple;
	bh=rtYJnuschOu9ZccExP0TzGZGyAr5e3wvA88oRm4xUUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+p/NvC3OGafkO/mYgb2wUfNlWVn1ntlnEcnItH+/EkRjz+8prY52ReeXXPujppsZsU5OZWRqsibpiQFRSTAkfo1IulxqQFWfwnZsoU2qTiaQliX49rU3Etf+HLXSrGv2h9ZwylZ042+D3YjBLxSzBmKEc5x+FNdkLRDODIlQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ystjn5SMhz6K9Hx;
	Wed, 12 Feb 2025 04:45:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E3C51401F1;
	Wed, 12 Feb 2025 04:46:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Feb 2025 21:46:15 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 11 Feb 2025 21:46:15 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
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
	"Roberto Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v19 07/15] cxl: Add helper function to retrieve a feature
 entry
Thread-Topic: [PATCH v19 07/15] cxl: Add helper function to retrieve a feature
 entry
Thread-Index: AQHbeW73p7HBQAni1USkV2PhrmlPmLNBWNGAgAE/cbA=
Date: Tue, 11 Feb 2025 20:46:15 +0000
Message-ID: <f99739cce216404680c60456504d7ed3@huawei.com>
References: <20250207144445.1879-1-shiju.jose@huawei.com>
	<20250207144445.1879-8-shiju.jose@huawei.com>
 <99a80c40-4c1d-4dc6-8b44-397f49460501@intel.com>
In-Reply-To: <99a80c40-4c1d-4dc6-8b44-397f49460501@intel.com>
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFu
Z0BpbnRlbC5jb20+DQo+U2VudDogMTEgRmVicnVhcnkgMjAyNSAwMjo0MA0KPlRvOiBTaGlqdSBK
b3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+Y3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPkNj
OiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBicEBhbGllbjguZGU7IHRvbnkubHVja0BpbnRl
bC5jb207DQo+cmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsgbWNoZWhhYkBrZXJu
ZWwub3JnOw0KPmRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgZGF2ZUBzdGdvbGFicy5uZXQ7IEpv
bmF0aGFuIENhbWVyb24NCj48am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgYWxpc29uLnNj
aG9maWVsZEBpbnRlbC5jb207DQo+dmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBpcmEud2VpbnlA
aW50ZWwuY29tOyBkYXZpZEByZWRoYXQuY29tOw0KPlZpbGFzLlNyaWRoYXJhbkBhbWQuY29tOyBs
ZW8uZHVyYW5AYW1kLmNvbTsgWWF6ZW4uR2hhbm5hbUBhbWQuY29tOw0KPnJpZW50amVzQGdvb2ds
ZS5jb207IGppYXFpeWFuQGdvb2dsZS5jb207IEpvbi5HcmltbUBhbWQuY29tOw0KPmRhdmUuaGFu
c2VuQGxpbnV4LmludGVsLmNvbTsgbmFveWEuaG9yaWd1Y2hpQG5lYy5jb207DQo+amFtZXMubW9y
c2VAYXJtLmNvbTsganRob3VnaHRvbkBnb29nbGUuY29tOyBzb21hc3VuZGFyYW0uYUBocGUuY29t
Ow0KPmVyZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207IGR1ZW53ZW5AZ29v
Z2xlLmNvbTsNCj5ndGhlbGVuQGdvb2dsZS5jb207IHdzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcu
Y29tOw0KPmRmZXJndXNvbkBhbXBlcmVjb21wdXRpbmcuY29tOyB3YnNAb3MuYW1wZXJlY29tcHV0
aW5nLmNvbTsNCj5uaWZhbi5jeGxAZ21haWwuY29tOyB0YW54aWFvZmVpIDx0YW54aWFvZmVpQGh1
YXdlaS5jb20+OyBaZW5ndGFvIChCKQ0KPjxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2Jl
cnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ow0KPmthbmdrYW5nLnNoZW5AZnV0
dXJld2VpLmNvbTsgd2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47DQo+TGlu
dXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MTkgMDcv
MTVdIGN4bDogQWRkIGhlbHBlciBmdW5jdGlvbiB0byByZXRyaWV2ZSBhIGZlYXR1cmUNCj5lbnRy
eQ0KPg0KPg0KPg0KPk9uIDIvNy8yNSA3OjQ0IEFNLCBzaGlqdS5qb3NlQGh1YXdlaS5jb20gd3Jv
dGU6DQo+PiBGcm9tOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Pg0KPj4g
QWRkIGhlbHBlciBmdW5jdGlvbiB0byByZXRyaWV2ZSBhIGZlYXR1cmUgZW50cnkgZnJvbSB0aGUg
c3VwcG9ydGVkDQo+PiBmZWF0dXJlcyBsaXN0LCBpZiBzdXBwb3J0ZWQuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPj4gLS0tDQo+PiAg
ZHJpdmVycy9jeGwvY29yZS9mZWF0dXJlcy5jIHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQo+
PiAgaW5jbHVkZS9jeGwvZmVhdHVyZXMuaCAgICAgIHwgIDIgKysNCj4+ICAyIGZpbGVzIGNoYW5n
ZWQsIDIzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29y
ZS9mZWF0dXJlcy5jIGIvZHJpdmVycy9jeGwvY29yZS9mZWF0dXJlcy5jDQo+PiBpbmRleCA1ZjY0
MTg1YTVjN2EuLmJmMTc1ZTY5Y2RhMSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUv
ZmVhdHVyZXMuYw0KPj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9mZWF0dXJlcy5jDQo+PiBAQCAt
NDMsNiArNDMsMjcgQEAgYm9vbCBpc19jeGxfZmVhdHVyZV9leGNsdXNpdmUoc3RydWN0IGN4bF9m
ZWF0X2VudHJ5DQo+PiAqZW50cnkpICB9ICBFWFBPUlRfU1lNQk9MX05TX0dQTChpc19jeGxfZmVh
dHVyZV9leGNsdXNpdmUsICJDWEwiKTsNCj4+DQo+PiArc3RydWN0IGN4bF9mZWF0X2VudHJ5ICpj
eGxfZ2V0X2ZlYXR1cmVfZW50cnkoc3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kLA0KPj4gKwkJCQkJ
ICAgICBjb25zdCB1dWlkX3QgKmZlYXRfdXVpZCkNCj4+ICt7DQo+PiArCXN0cnVjdCBjeGxfZmVh
dHVyZXNfc3RhdGUgKmN4bGZzID0gY3hsbWQtPmN4bGZzOw0KPj4gKwlzdHJ1Y3QgY3hsX2ZlYXRf
ZW50cnkgKmZlYXRfZW50cnk7DQo+PiArCWludCBjb3VudDsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJ
ICogUmV0cmlldmUgdGhlIGZlYXR1cmUgZW50cnkgZnJvbSB0aGUgc3VwcG9ydGVkIGZlYXR1cmVz
IGxpc3QsDQo+PiArCSAqIGlmIHRoZSBmZWF0dXJlIGlzIHN1cHBvcnRlZC4NCj4+ICsJICovDQo+
PiArCWZlYXRfZW50cnkgPSBjeGxmcy0+ZW50cmllczsNCj4+ICsJZm9yIChjb3VudCA9IDA7IGNv
dW50IDwgY3hsZnMtPm51bV9mZWF0dXJlczsgY291bnQrKywgZmVhdF9lbnRyeSsrKSB7DQo+PiAr
CQlpZiAodXVpZF9lcXVhbCgmZmVhdF9lbnRyeS0+dXVpZCwgZmVhdF91dWlkKSkNCj4+ICsJCQly
ZXR1cm4gZmVhdF9lbnRyeTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlyZXR1cm4gRVJSX1BUUigtRU5P
RU5UKTsNCj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTF9OU19HUEwoY3hsX2dldF9mZWF0dXJlX2Vu
dHJ5LCAiQ1hMIik7DQo+DQo+WW91IHByb2JhYmx5IGRvbid0IG5lZWQgdGhpcyBpZiB0aGUgbWVt
ZmVhdHVyZSBjb2RlIGFyZSBpbiBDWEwgY29yZS4NCg0KSGkgRGF2ZSwNCg0KWW91IGFyZSByaWdo
dC4gQXQgcHJlc2VudCwgRVhQT1JUX1NZTUJPTF9OU19HUEwoY3hsX2dldF9mZWF0dXJlX2VudHJ5
KSAgaXMgbm90IHJlcXVpcmVkLg0KDQo+DQo+REoNCj4NCj4+ICsNCj4+ICBzaXplX3QgY3hsX2dl
dF9mZWF0dXJlKHN0cnVjdCBjeGxfbWFpbGJveCAqY3hsX21ib3gsIGNvbnN0IHV1aWRfdCAqZmVh
dF91dWlkLA0KPj4gIAkJICAgICAgIGVudW0gY3hsX2dldF9mZWF0X3NlbGVjdGlvbiBzZWxlY3Rp
b24sDQo+PiAgCQkgICAgICAgdm9pZCAqZmVhdF9vdXQsIHNpemVfdCBmZWF0X291dF9zaXplLCB1
MTYgb2Zmc2V0LCBkaWZmIC0tZ2l0DQo+PiBhL2luY2x1ZGUvY3hsL2ZlYXR1cmVzLmggYi9pbmNs
dWRlL2N4bC9mZWF0dXJlcy5oIGluZGV4DQo+PiBlNTJkMDU3M2Y1MDQuLjU2M2Q5NjZiZWVlNSAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvY3hsL2ZlYXR1cmVzLmgNCj4+ICsrKyBiL2luY2x1ZGUv
Y3hsL2ZlYXR1cmVzLmgNCj4+IEBAIC02OCw2ICs2OCw4IEBAIHN0cnVjdCBjeGxfZmVhdHVyZXNf
c3RhdGUgeyAgfTsNCj4+DQo+PiAgc3RydWN0IGN4bF9tYWlsYm94Ow0KPj4gK3N0cnVjdCBjeGxf
ZmVhdF9lbnRyeSAqY3hsX2dldF9mZWF0dXJlX2VudHJ5KHN0cnVjdCBjeGxfbWVtZGV2ICpjeGxt
ZCwNCj4+ICsJCQkJCSAgICAgY29uc3QgdXVpZF90ICpmZWF0X3V1aWQpOw0KPj4gIHNpemVfdCBj
eGxfZ2V0X2ZlYXR1cmUoc3RydWN0IGN4bF9tYWlsYm94ICpjeGxfbWJveCwgY29uc3QgdXVpZF90
ICpmZWF0X3V1aWQsDQo+PiAgCQkgICAgICAgZW51bSBjeGxfZ2V0X2ZlYXRfc2VsZWN0aW9uIHNl
bGVjdGlvbiwNCj4+ICAJCSAgICAgICB2b2lkICpmZWF0X291dCwgc2l6ZV90IGZlYXRfb3V0X3Np
emUsIHUxNiBvZmZzZXQsDQo+DQo+DQoNClRoYW5rcywNClNoaWp1DQo=

