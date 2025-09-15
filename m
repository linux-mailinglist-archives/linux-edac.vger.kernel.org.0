Return-Path: <linux-edac+bounces-4801-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF9BB57902
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8367A320A
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36B62FE07D;
	Mon, 15 Sep 2025 11:50:22 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EB2FDC5D;
	Mon, 15 Sep 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937022; cv=none; b=f4/omf2FkyYEwag9NLlW9BYKw0Vg8gazVBAD/S+rMULLxfpb4WHO9mJ/Sfn+w+OsDv+jwCuaJxiSN1BPRurM2/BKJ/i/1HhOg7yTrDM3tzozFjChInYQ/ffhyWJRhRq4whEHmHtg6AXG5Mqevv5FabtQQc0lp8JZwVPJPXZWmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937022; c=relaxed/simple;
	bh=JbEac92sEXrJ/qwkFNWDdO6MpAz8n0Z/6Y4xoea3Djk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DmBb9c25n0QrYRU6/SAFOqGxf5HFtqdFZ07fKVIxBVhOSPBlZtKm7KA1ytZwbYuiESsi5Do0eVkEitAbcGCD24hPbXtgDQ4JVqE2cvAM3XqbALTIG3d7YTRMvXjj+cKCcoUlRDRz2dnOwotrdQJV6emWt9o72fC5PmpkIhhgNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQNYv20tTz6M4w8;
	Mon, 15 Sep 2025 19:47:31 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id C6FBC1400DC;
	Mon, 15 Sep 2025 19:50:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Sep 2025 13:50:16 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 15 Sep 2025 13:50:16 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "rafael@kernel.org" <rafael@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHcHC9WuMPoKRXbY02Oy+WxUZ/jerSMt+SAgAK0t2CAABfigIAEdNLA
Date: Mon, 15 Sep 2025 11:50:16 +0000
Message-ID: <9433067c142b45d583eb96587b929878@huawei.com>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
In-Reply-To: <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMTIgU2VwdGVtYmVyIDIwMjUgMTU6MTINCj5UbzogU2hpanUgSm9z
ZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiByYWZhZWxAa2VybmVsLm9yZzsgYWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZzsgcnBwdEBrZXJuZWwub3JnOw0KPmRmZXJndXNvbkBhbXBlcmVj
b21wdXRpbmcuY29tOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+YWNwaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVs
Lm9yZzsNCj50b255Lmx1Y2tAaW50ZWwuY29tOyBsZW5iQGtlcm5lbC5vcmc7IGxlby5kdXJhbkBh
bWQuY29tOw0KPllhemVuLkdoYW5uYW1AYW1kLmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOyBKb25h
dGhhbiBDYW1lcm9uDQo+PGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IExpbnV4YXJtIDxs
aW51eGFybUBodWF3ZWkuY29tPjsNCj5yaWVudGplc0Bnb29nbGUuY29tOyBqaWFxaXlhbkBnb29n
bGUuY29tOyBKb24uR3JpbW1AYW1kLmNvbTsNCj5kYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207
IG5hb3lhLmhvcmlndWNoaUBuZWMuY29tOw0KPmphbWVzLm1vcnNlQGFybS5jb207IGp0aG91Z2h0
b25AZ29vZ2xlLmNvbTsgc29tYXN1bmRhcmFtLmFAaHBlLmNvbTsNCj5lcmRlbWFrdGFzQGdvb2ds
ZS5jb207IHBnb25kYUBnb29nbGUuY29tOyBkdWVud2VuQGdvb2dsZS5jb207DQo+Z3RoZWxlbkBn
b29nbGUuY29tOyB3c2Nod2FydHpAYW1wZXJlY29tcHV0aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJl
Y29tcHV0aW5nLmNvbTsgbmlmYW4uY3hsQGdtYWlsLmNvbTsgdGFueGlhb2ZlaQ0KPjx0YW54aWFv
ZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsg
Um9iZXJ0bw0KPlNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+OyBrYW5na2FuZy5zaGVu
QGZ1dHVyZXdlaS5jb207DQo+d2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT4N
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHYxMiAxLzJdIEFDUEk6UkFTMjogQWRkIEFDUEkgUkFTMiBk
cml2ZXINCj4NCj5PbiBGcmksIFNlcCAxMiwgMjAyNSBhdCAxMjowNDo1N1BNICswMDAwLCBTaGlq
dSBKb3NlIHdyb3RlOg0KPj4gPldoeSBpcyB0aGlzIHJlcXVpcmVtZW50IGhlcmU/DQo+PiBUaGUg
cGh5c2ljYWwgbWVtb3J5IGFkZHJlc3MgcmFuZ2UgcmV0cmlldmVkIGhlcmUgZm9yIHRoZSBOVU1B
IGRvbWFpbg0KPj4gaXMgdXNlZCBpbiB0aGUgc3Vic2VxdWVudCBwYXRjaCAgW1BBVENIIHYxMiAy
LzJdIHJhczogbWVtOiBBZGQgbWVtb3J5DQo+PiBBQ1BJIFJBUzIgZHJpdmVyLCAxLiB0byBzZXQg
UmVxdWVzdGVkIEFkZHJlc3MgUmFuZ2UoSU5QVVQpIGZpZWxkIG9mDQo+PiBUYWJsZSA1Ljg3OiBQ
YXJhbWV0ZXIgQmxvY2sgU3RydWN0dXJlIGZvciBQQVRST0xfU0NSVUIgd2hlbiBzZW5kDQo+PiBH
RVRfUEFUUk9MX1BBUkFNRVRFUlMgY29tbWFuZCB0byB0aGUgZmlybXdhcmUsIHRvIGdldCBzY3J1
Yg0KPnBhcmFtZXRlcnMsIHJ1bm5pbmcgc3RhdHVzLCBjdXJyZW50IHNjcnViIHJhdGUgZXRjLg0K
Pj4gMi4gZm9yIHRoZSB2YWxpZGl0eSBjaGVjayBvZiB0aGUgdXNlciByZXF1ZXN0ZWQgbWVtb3J5
IGFkZHJlc3MgcmFuZ2UgdG8gc2NydWIuDQo+DQo+QWdhaW4sIHdoeSBkb2VzIGl0IGhhdmUgdG8g
YmUgKmxvd2VzdCogYW5kICpjb250aWd1b3VzKj8NCj4NCj5Zb3VyIGFuc3dlciBkb2Vzbid0IGV4
cGxhaW4gdGhhdC4NClRoaXMgaGFzIGJlZW4gYWRkZWQgYXMgc3VnZ2VzdGVkIGJ5IEpvbmF0aGFu
IGNvbnNpZGVyaW5nIHRoZSBpbnRlcmxlYXZlZCBOVU1BIG5vZGUuDQpMaW5rIHRvIHRoZSByZWxh
dGVkIGRpc2N1c3Npb24gaW4gVjExOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUw
ODIxMTAwNjU1LjAwMDAzOTQyQGh1YXdlaS5jb20vI3QNCg0KfCBub2RlIDAgfCBub2RlIDEgfCBu
b2RlIDAgfCAgIFBBIGFkZHJlc3MgbWFwLg0KQ2FuIHlvdSBnaXZlIHlvdXIgc3VnZ2VzdGlvbiB3
aGF0IHdlIHNob3VsZCBkbyBhYm91dCBpdD8NCg0KPg0KPj4gQWxzbyBpbnRlbmRlZCB0byBleHBv
c2UgdGhpcyBzdXBwb3J0ZWQgbWVtb3J5IGFkZHJlc3MgcmFuZ2UgdG8gdGhlDQo+PiB1c2Vyc3Bh
Y2UgdmlhIEVEQUMgc2NydWIgY29udHJvbCBpbnRlcmZhY2UsIHRob3VnaCBpdCBpcyBub3QgcHJl
c2VudCBub3cuDQo+DQo+V2h5PyBUbyB0aWUgb3Vyc2VsdmVzIHdpdGggZXZlbiBtb3JlIHVzZXIg
QUJJPyENCj4NCj5UaGVyZSBiZXR0ZXIgYmUgYSBnb29kIHJlYXNvbiBhbmQgbm90IGEgYmV0dGVy
IGRlc2lnbiBmb3Igd2hhdCB0aGlzIGlzIHRyeWluZyB0bw0KPmRvLg0KDQpUaGUgImFkZHJlc3Nf
cmFuZ2VfYmFzZSIgYW5kICJhZGRyZXNzX3JhbmdlX3NpemUiIHN5c2ZzIGF0dHJpYnV0ZXMNCih1
bnRpbCB0aGUgdjEzIG9mIEVEQUMgc2NydWIgaW50ZXJmYWNlLCkgd2hpY2ggd2UgY291bGQgYmUg
dXNlZCBmb3IgcHVibGlzaCB0aGlzDQpwaHlzaWNhbCBhZGRyZXNzIHJhbmdlIG9mIHRoZSBtZW1v
cnkgaW4gTlVNQSBkb21haW4gdG8gdGhlIHVzZXJzcGFjZSB3aGVuIHRoZSBkZW1hbmQgc2NydWJi
aW5nDQppcyBub3QgaW4gcHJvZ3Jlc3MsIGJ1dCAiYWRkcmVzc19yYW5nZV9iYXNlIiBoYXMgY2hh
bmdlZCB0byByZWFkIHRoZSBzdGF0dXMgb2YgIG9uLWRlbWFuZA0Kc2NydWJiaW5nIGJhc2VkIG9u
IHRoZSBmZWVkYmFjayBoZXJlLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzRlZTM2ZDAz
YTI4OTQ2MDZhNTcxYjM3ZjQ0MGRhMzZmQGh1YXdlaS5jb20vI3QgICANCkFsc28gdG8gcHJlc2Vu
dCB0aGlzIHJlcXVpcmVtZW50IGZvciB0aGUgUkFTMiwgIHRoZXJlIHdhcyBubyBtZXRob2QgZm91
bmQgdG8gcmV0cmlldmUgdGhlDQptZW1vcnkgcGh5c2ljYWwgYWRkcmVzcyByYW5nZSB1bnRpbCBy
ZWNlbnQgdmVyc2lvbnMgYXMgaXQgaXMgbm90IHN1cHBvcnRlZCBpbiB0aGUgUkFTMi4NCg0KVXNl
IGNhc2UgZm9yIHRoZSBSQVMyIHRvIHB1Ymxpc2ggdGhlIHN1cHBvcnRlZCBQQSByYW5nZSBvZiB0
aGUgbm9kZSBtZW1vcnkgdG8gdGhlIHVzZXJzcGFjZToNClN5c3RlbXMgd2l0aCBtdWx0aXBsZSBO
VU1BIG5vZGUgZG9tYWlucyB3aXRoIHRoZSBzdXBwb3J0IGZvciB0aGUgZGVtYW5kIHNjcnViYmlu
Zw0KZXhwb3NlZCB0byB0aGUgdXNlciB2aWEgdGhlIEVEQUMgc2NydWIgaW50ZXJmYWNlIGFzIGFj
cGlfcmFzX21lbTAvc2NydWIsIGFjcGlfcmFzX21lbTEvc2NydWIsDQphY3BpX3Jhc19tZW0yL3Nj
cnViLCAuLi4gZXRjLiAgIFdoZW4gdGhlIHVzZXJzcGFjZSB0b29sIChGb3IgZS5nLiByYXNkYWVt
b24pICBvciBhbiBhZG1pbiBkZXRlY3RzDQphIGZhdWx0eSBwYWdlIG9yIGZhdWx0eSBhZGRyZXNz
LCBzeXN0ZW0gcG9saWN5IG1heSBkZWNpZGVzIHRvIHNjcnViIHRoZSBjb3JyZXNwb25kaW5nIG1l
bW9yeS4gDQpIb3dldmVyIGl0IGlzIHJlcXVpcmVkIHRvIGZpbmQgb3V0IHRoZSBFREFDIHNjcnVi
IGluc3RhbmNlIG9mICB0aGUgY29ycmVzcG9uZGluZyAgbWVtb3J5IGluIHRoZQ0KTlVNQSBkb21h
aW4sIHNldCBzY3J1YiBwYXJhbWV0ZXJzIGFuZCBpc3N1ZSB0aGUgc2NydWIgcmVxdWVzdC4NClRo
ZXJlIGFyZSB0d28gb3B0aW9ucyBwcmVzZW50LA0KKDEpIFNldCB0aGUgc2NydWIgcGFyYW1ldGVy
cyBhbmQgaXNzdWUgc2NydWIgcmVxdWVzdCBpbiBhbGwgdGhlIEVEQUMgc2NydWIgaW5zdGFuY2Vz
IHByZXNlbnQgZm9yIFJBUzIuIFRoZQ0KIHNjcnViIHJlcXVlc3Qgc2hvdWxkIGZhaWwgZm9yIHRo
ZSBpbnZhbGlkIGNhc2VzLg0KKDIpICBMb2NhdGUgdGhlIGNvcnJlc3BvbmRpbmcgRURBQyBzY3J1
YiBpbnN0YW5jZXMgZm9yIHRoZSBjb3JyZXNwb25kaW5nIE5vZGUgbWVtb3J5DQogICAgICBieSBy
ZWFkIGFuZCBjaGVjayBhZ2FpbnN0IHRoZSBQQSByYW5nZSBwdWJsaXNoZWQuDQoNCkkgdGhpbmsg
T3B0aW9uICgyKSBzZWVtcyBiZXR0ZXI/IA0KSWYgc28sIGNhbiB0aGUgRURBQyBzY3J1YiBpbnRl
cmZhY2UgIGJlIHVwZGF0ZWQgdG8gaW5jbHVkZSBhdHRyaWJ1dGVzIGZvciBwdWJsaXNoaW5nIHRo
ZSBzdXBwb3J0ZWQNClBBIHJhbmdlIGZvciB0aGUgbWVtb3J5IGRldmljZSB0byBzY3J1Yj8NCg0K
Pg0KPj4gPldoYXQgaGFwcGVucyB3aXRoIHRoZSBhdXggZGV2aWNlcyB5b3UgY3JlYXRlZCBzdWNj
ZXNzZnVsbHkgaGVyZT8gVW53aW5kPw0KPj4gUGxlYXNlIHNlZSB0aGUgcHJldmlvdXMgZGlzY3Vz
c2lvbnMgb24gdGhpcyB3ZXJlIGFib3V0IGFsbG93aW5nIHRoZQ0KPj4gc3VjY2Vzc2Z1bGx5IGNy
ZWF0ZWQgYXV4aWxpYXJ5IGRldmljZXMgdG8gZXhpc3QuDQo+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyNTA0MTUyMTA1MDQuR0E4NTQwOThAeWF6LWtoZmYyLmFtZC5jb20vDQo+DQo+
VGhlcmUncyBubyBkaXNjdXNzaW9uIGhlcmUuIEFuZCBub3RoaW5nIGFuc3dlcnMgdGhlIHF1ZXN0
aW9uICJ3aHkiIHRoaXMgaXMgb2sgdG8NCj5kbyB0aGlzIHdheS4NCg0KVGhpcyB3YXMgY2hhbmdl
ZCAgYmFzZWQgb24gdGhlIGZlZWRiYWNrIGZyb20gdGhlIFlhemVuIGluIHYzIG9mIHRoZSBzZXJp
ZXMsDQpDb3B5IG9mIHRoZSBZYXplbidzIGZlZWRiYWNrIGZyb20gdGhlIGFib3ZlIGxpbms6IA0K
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gKwl9DQo+ICsNCj4gKwlwY2NfZGVzY19s
aXN0ID0gKHN0cnVjdCBhY3BpX3JhczJfcGNjX2Rlc2MgKikocmFzMl90YWIgKyAxKTsNCj4gKwlm
b3IgKGkgPSAwOyBpIDwgcmFzMl90YWItPm51bV9wY2NfZGVzY3M7IGkrKywgcGNjX2Rlc2NfbGlz
dCsrKSB7DQo+ICsJCWlmIChwY2NfZGVzY19saXN0LT5mZWF0dXJlX3R5cGUgIT0gUkFTMl9GRUFU
X1RZUEVfTUVNT1JZKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJcmMgPSByYXMyX2FkZF9h
dXhfZGV2aWNlKFJBUzJfTUVNX0RFVl9JRF9OQU1FLCBwY2NfZGVzY19saXN0LT5jaGFubmVsX2lk
KTsNCj4gKwkJaWYgKHJjKQ0KPiArCQkJcmV0dXJuIHJjOw0KDQpUaGlzIHJldHVybnMgZXJyb3Ig
b24gdGhlIGZpcnN0IGZhaWx1cmUuDQoNCldoYXQgaWYgdGhlcmUgd2FzIGEgc3VjY2VzcyBiZWZv
cmU/IERvZXMgdGhhdCBhdXhfZGV2aWNlIG5lZWQgdG8gYmUgcmVtb3ZlZD8NCg0KSWYgbm90LCB0
aGVuIHdoeSByZXR1cm4gZmFpbHVyZSBhdCBhbGw/IFdoeSBub3QganVzdCB0cnkgdG8gYWRkIGFs
bCBkZXZpY2VzPyBTb21lIG1heSBmYWlsIGFuZCBzb21lIG1heSBzdWNjZWVkLg0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0gDQoNCldlIHRob3VnaHQgc2Vjb25kIG9wdGlvbiBpcyBhIGJl
dHRlciBiZWNhdXNlIGEgc3VjY2Vzc2Z1bGx5IGFkZGVkIGF1eCBkZXYgZm9yIGEgbWVtb3J5IGRl
dmljZSBhbmQgY29ycmVzcG9uZGluZw0KRURBQyBpbnRlcmZhY2UgY29udGludWUgZXhpc3QgYW5k
IHN1cHBvcnQgdGhlIHNjcnViL2EgbWVtb3J5IGZlYXR1cmUuIA0KV2UgZG8gbm90IG1pbmQgZG9p
bmcgc3RvcCBvbiBhIGZhaWx1cmUgYWRkaW5nIGFuIGF1eF9kZXZpY2UgYW5kIGZyZWUgcHJldmlv
dXNseSBjcmF0ZWQgYXV4IGRldmljZXMsIHRob3VnaA0KaXQgbWF5IHJlcXVpcmUgc29tZSBhZGRp
dGlvbmFsIGR5bmFtaWNhbGx5IGFsbG9jYXRlZCBtZW1vcnkgc3BhY2UgdG8gc3RvcmUgdGhlIHN1
Y2Nlc3NmdWxseSBjcmVhdGVkIGF1eCBkZXZpY2VzDQpzbyB0aGF0IGZyZWUgdGhlbSBvbiBhIGZh
aWx1cmUgbGF0ZXIuIEhvcGUgdGhhdCBpcyBhY2NlcHRhYmxlPw0KDQpUaGFua3MsDQpTaGlqdSAg
DQoNCj4NCj4tLQ0KPlJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8vcGVv
cGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQoNCg0KDQo=

