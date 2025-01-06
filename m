Return-Path: <linux-edac+bounces-2813-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19636A0287A
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 15:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0408F160EFC
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD7786353;
	Mon,  6 Jan 2025 14:48:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999286323;
	Mon,  6 Jan 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174898; cv=none; b=GDh0Nr5UyaHoWQo8RPBhjUOR02Onw7trnj7DyL7NBfTyO0iM+6X+lGRICo16zr4UbXdFY8NWCzTO250Rri0aie89hnyhF2368PFPw01uVHFWXlvtZLpS1BlVwImjis08P8AkFRXlZBgFQK0R+ZLP9jQiAZjExyBDDhk0DXx5qP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174898; c=relaxed/simple;
	bh=DTRXv9ZerDho46tzA6hKyLXYv/6LhgDpHLe6fjmjJT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVwNj4bmW+74hVFEN0XbxPA6YZJ+hMiEnJYAjDJVZ2BdROxz9QlgYn3cnElNfwt33zji/9icBLRQAgFAtzCNusD/1ZpK66yZIXu7XPOk+2ScbzUKnShKNHMgTP6dBv040ShNXjE24iZXQMXuOR6rAhyFTYJkscYQe/6TkJgsAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRcPW3dhFz6K5cC;
	Mon,  6 Jan 2025 22:43:43 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E06214022E;
	Mon,  6 Jan 2025 22:48:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 15:48:12 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 6 Jan 2025 15:48:12 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
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
Subject: RE: [PATCH v18 01/19] EDAC: Add support for EDAC device features
 control
Thread-Topic: [PATCH v18 01/19] EDAC: Add support for EDAC device features
 control
Thread-Index: AQHbYDQbvBfnsLyISku/NcTTFtbfhrMJrx8AgAAi3FA=
Date: Mon, 6 Jan 2025 14:48:12 +0000
Message-ID: <072a03a818d94c6abd606ab5e0833002@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-2-shiju.jose@huawei.com>
 <20250106133736.GDZ3vcoEBa-lJwqAxL@fat_crate.local>
In-Reply-To: <20250106133736.GDZ3vcoEBa-lJwqAxL@fat_crate.local>
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

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj5TZW50OiAwNiBKYW51YXJ5IDIwMjUgMTM6MzgNCj5UbzogU2hpanUgSm9z
ZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+YWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj50
b255Lmx1Y2tAaW50ZWwuY29tOyByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0K
Pm1jaGVoYWJAa2VybmVsLm9yZzsgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBkYXZlQHN0Z29s
YWJzLm5ldDsgSm9uYXRoYW4NCj5DYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
OyBkYXZlLmppYW5nQGludGVsLmNvbTsNCj5hbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbTsgdmlz
aGFsLmwudmVybWFAaW50ZWwuY29tOyBpcmEud2VpbnlAaW50ZWwuY29tOw0KPmRhdmlkQHJlZGhh
dC5jb207IFZpbGFzLlNyaWRoYXJhbkBhbWQuY29tOyBsZW8uZHVyYW5AYW1kLmNvbTsNCj5ZYXpl
bi5HaGFubmFtQGFtZC5jb207IHJpZW50amVzQGdvb2dsZS5jb207IGppYXFpeWFuQGdvb2dsZS5j
b207DQo+Sm9uLkdyaW1tQGFtZC5jb207IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj5u
YW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsganRob3VnaHRvbkBn
b29nbGUuY29tOw0KPnNvbWFzdW5kYXJhbS5hQGhwZS5jb207IGVyZGVtYWt0YXNAZ29vZ2xlLmNv
bTsgcGdvbmRhQGdvb2dsZS5jb207DQo+ZHVlbndlbkBnb29nbGUuY29tOyBndGhlbGVuQGdvb2ds
ZS5jb207DQo+d3NjaHdhcnR6QGFtcGVyZWNvbXB1dGluZy5jb207IGRmZXJndXNvbkBhbXBlcmVj
b21wdXRpbmcuY29tOw0KPndic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBuaWZhbi5jeGxAZ21h
aWwuY29tOyB0YW54aWFvZmVpDQo+PHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIp
IDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2JlcnRvDQo+U2Fzc3UgPHJvYmVydG8uc2Fz
c3VAaHVhd2VpLmNvbT47IGthbmdrYW5nLnNoZW5AZnV0dXJld2VpLmNvbTsNCj53YW5naHVpcWlh
bmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsgTGludXhhcm0NCj48bGludXhhcm1AaHVhd2Vp
LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxOCAwMS8xOV0gRURBQzogQWRkIHN1cHBvcnQg
Zm9yIEVEQUMgZGV2aWNlIGZlYXR1cmVzDQo+Y29udHJvbA0KPg0KPk9uIE1vbiwgSmFuIDA2LCAy
MDI1IGF0IDEyOjA5OjU3UE0gKzAwMDAsIHNoaWp1Lmpvc2VAaHVhd2VpLmNvbSB3cm90ZToNCj4+
ICtpbnQgZWRhY19kZXZfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqcGFyZW50LCBjaGFyICpuYW1l
LA0KPj4gKwkJICAgICAgdm9pZCAqcHJpdmF0ZSwgaW50IG51bV9mZWF0dXJlcywNCj4+ICsJCSAg
ICAgIGNvbnN0IHN0cnVjdCBlZGFjX2Rldl9mZWF0dXJlICpyYXNfZmVhdHVyZXMpIHsNCj4+ICsJ
Y29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqKnJhc19hdHRyX2dyb3VwczsNCj4+ICsJc3Ry
dWN0IGVkYWNfZGV2X2ZlYXRfY3R4ICpjdHg7DQo+PiArCWludCBhdHRyX2djbnQgPSAwOw0KPj4g
KwlpbnQgcmV0LCBmZWF0Ow0KPj4gKw0KPj4gKwlpZiAoIXBhcmVudCB8fCAhbmFtZSB8fCAhbnVt
X2ZlYXR1cmVzIHx8ICFyYXNfZmVhdHVyZXMpDQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsN
Cj4+ICsJLyogRG91YmxlIHBhcnNlIHRvIG1ha2Ugc3BhY2UgZm9yIGF0dHJpYnV0ZXMgKi8NCj4+
ICsJZm9yIChmZWF0ID0gMDsgZmVhdCA8IG51bV9mZWF0dXJlczsgZmVhdCsrKSB7DQo+PiArCQlz
d2l0Y2ggKHJhc19mZWF0dXJlc1tmZWF0XS5mdF90eXBlKSB7DQo+PiArCQkvKiBBZGQgZmVhdHVy
ZSBzcGVjaWZpYyBjb2RlICovDQo+PiArCQlkZWZhdWx0Og0KPj4gKwkJCXJldHVybiAtRUlOVkFM
Ow0KPj4gKwkJfQ0KPj4gKwl9DQo+PiArDQo+PiArCWN0eCA9IGt6YWxsb2Moc2l6ZW9mKCpjdHgp
LCBHRlBfS0VSTkVMKTsNCj4+ICsJaWYgKCFjdHgpDQo+PiArCQlyZXR1cm4gLUVOT01FTTsNCj4+
ICsNCj4+ICsJcmFzX2F0dHJfZ3JvdXBzID0ga2NhbGxvYyhhdHRyX2djbnQgKyAxLCBzaXplb2Yo
KnJhc19hdHRyX2dyb3VwcyksDQo+R0ZQX0tFUk5FTCk7DQo+PiArCWlmICghcmFzX2F0dHJfZ3Jv
dXBzKSB7DQo+PiArCQlyZXQgPSAtRU5PTUVNOw0KPj4gKwkJZ290byBjdHhfZnJlZTsNCj4+ICsJ
fQ0KPj4gKw0KPj4gKwlhdHRyX2djbnQgPSAwOw0KPj4gKwlmb3IgKGZlYXQgPSAwOyBmZWF0IDwg
bnVtX2ZlYXR1cmVzOyBmZWF0KyssIHJhc19mZWF0dXJlcysrKSB7DQo+PiArCQlzd2l0Y2ggKHJh
c19mZWF0dXJlcy0+ZnRfdHlwZSkgew0KPj4gKwkJLyogQWRkIGZlYXR1cmUgc3BlY2lmaWMgY29k
ZSAqLw0KPj4gKwkJZGVmYXVsdDoNCj4+ICsJCQlyZXQgPSAtRUlOVkFMOw0KPj4gKwkJCWdvdG8g
Z3JvdXBzX2ZyZWU7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsNCj4+ICsJY3R4LT5kZXYucGFyZW50
ID0gcGFyZW50Ow0KPj4gKwljdHgtPmRldi5idXMgPSBlZGFjX2dldF9zeXNmc19zdWJzeXMoKTsN
Cj4+ICsJY3R4LT5kZXYudHlwZSA9ICZlZGFjX2Rldl90eXBlOw0KPj4gKwljdHgtPmRldi5ncm91
cHMgPSByYXNfYXR0cl9ncm91cHM7DQo+PiArCWN0eC0+cHJpdmF0ZSA9IHByaXZhdGU7DQo+PiAr
CWRldl9zZXRfZHJ2ZGF0YSgmY3R4LT5kZXYsIGN0eCk7DQo+PiArDQo+PiArCXJldCA9IGRldl9z
ZXRfbmFtZSgmY3R4LT5kZXYsIG5hbWUpOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJZ290byBncm91
cHNfZnJlZTsNCj4+ICsNCj4+ICsJcmV0ID0gZGV2aWNlX3JlZ2lzdGVyKCZjdHgtPmRldik7DQo+
PiArCWlmIChyZXQpIHsNCj4+ICsJCXB1dF9kZXZpY2UoJmN0eC0+ZGV2KTsNCj4+ICsJCXJldHVy
biByZXQ7DQo+DQo+V2hvIGlzIGZyZWVpbmcgY3R4IGFuZCByYXNfYXR0cl9ncm91cHMgd2hlbiB5
b3UgcmV0dXJuIGhlcmU/DQoNCkhpIEJvcmlzLA0KDQpjdHggYW5kIHJhc19hdHRyX2dyb3VwcyBh
cmUgZnJlZWQgaW4gdGhlIGNhbGxiYWNrDQpmdW5jdGlvbiAgZm9yIHJlbGVhc2UgIGVkYWNfZGV2
X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KS4NCg0KVGhhbmtzLA0KU2hpanUNCg0KPg0KPi0t
DQo+UmVnYXJkcy9HcnVzcywNCj4gICAgQm9yaXMuDQo+DQo+aHR0cHM6Ly9wZW9wbGUua2VybmVs
Lm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg0K

