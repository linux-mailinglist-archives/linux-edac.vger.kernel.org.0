Return-Path: <linux-edac+bounces-1015-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8068C026B
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 18:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2BB1C21E20
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01CCDDD9;
	Wed,  8 May 2024 16:59:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218EC1A2C2D;
	Wed,  8 May 2024 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187571; cv=none; b=p0uGCls7UmBr6dFCyYllMv00tq1hwwwU2Zl52c0X1HGNtMcxxIBoZzBizsb1eudxkPwRCxhnDZ21JTo2qSwiGrtUIUfWtTP1YKzerL4qT0TEbhB73Pqbc448FlAdUYs8xNe1PTV48wBzrR8XtJuGZGZvLBtmhO09MmtjltVHAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187571; c=relaxed/simple;
	bh=T9HhyAw9QuVfcCAa1mYsk+ruI8SHCojPcVW1pJa4PN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cp4/9An9lHwgSjHz0peLTe9tK8zNsiFr/Xu1KEixYZqAP70k4d4HSPKrjHBKozdfzwuR/0xBfCEqmEeo3Oo0F0IKM6i/6aY8kcRhbgFOo4kZOOwVctPCtQ2ah++SE+E7wFJn9tdMILsKx+s/txVk8o0JvFdCEU/rEJk6/ZdHhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZLrf6JsWz6K6J7;
	Thu,  9 May 2024 00:56:18 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 171ED1404F4;
	Thu,  9 May 2024 00:59:25 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 May 2024 17:59:18 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Wed, 8 May 2024 17:59:18 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
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
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Thread-Topic: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Thread-Index: AQHaknlLsB7DmyDvA0iAgKJhxeY8vLF4vVgAgABZuhCAEPP6AIADoMIA
Date: Wed, 8 May 2024 16:59:18 +0000
Message-ID: <e0ce36eb80054440ab877ccee4e606de@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com>
 <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
 <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
 <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
In-Reply-To: <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMDYgTWF5IDIwMjQgMTE6MzANCj5UbzogU2hpanUgSm9zZSA8c2hp
anUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+bW1Aa3ZhY2sub3JnOyBkYW4uai53aWxs
aWFtc0BpbnRlbC5jb207IGRhdmVAc3Rnb2xhYnMubmV0OyBKb25hdGhhbg0KPkNhbWVyb24gPGpv
bmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IGRhdmUuamlhbmdAaW50ZWwuY29tOw0KPmFsaXNv
bi5zY2hvZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlu
eUBpbnRlbC5jb207DQo+bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRhdmlkQHJlZGhhdC5jb207DQo+VmlsYXMuU3JpZGhhcmFuQGFtZC5j
b207IGxlby5kdXJhbkBhbWQuY29tOyBZYXplbi5HaGFubmFtQGFtZC5jb207DQo+cmllbnRqZXNA
Z29vZ2xlLmNvbTsgamlhcWl5YW5AZ29vZ2xlLmNvbTsgdG9ueS5sdWNrQGludGVsLmNvbTsNCj5K
b24uR3JpbW1AYW1kLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyByYWZhZWxAa2Vy
bmVsLm9yZzsNCj5sZW5iQGtlcm5lbC5vcmc7IG5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1l
cy5tb3JzZUBhcm0uY29tOw0KPmp0aG91Z2h0b25AZ29vZ2xlLmNvbTsgc29tYXN1bmRhcmFtLmFA
aHBlLmNvbTsNCj5lcmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25kYUBnb29nbGUuY29tOyBkdWVu
d2VuQGdvb2dsZS5jb207DQo+bWlrZS5tYWx2ZXN0dXRvQGludGVsLmNvbTsgZ3RoZWxlbkBnb29n
bGUuY29tOw0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcuY29tOyBkZmVyZ3Vzb25AYW1wZXJl
Y29tcHV0aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgbmlmYW4uY3hsQGdt
YWlsLmNvbTsgdGFueGlhb2ZlaQ0KPjx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvIChC
KSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsNCj5rYW5na2FuZy5zaGVuQGZ1dHVyZXdlaS5j
b207IHdhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+Ow0KPkxpbnV4YXJtIDxs
aW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY4IDAxLzEwXSBy
YXM6IHNjcnViOiBBZGQgc2NydWIgc3Vic3lzdGVtDQo+DQo+T24gVGh1LCBBcHIgMjUsIDIwMjQg
YXQgMDY6MTE6MTNQTSArMDAwMCwgU2hpanUgSm9zZSB3cm90ZToNCj4+IEl0IGlzIGV4cGVjdGVk
IHRvIGhhdmUgbXVsdGlwbGUgUkFTLXNwZWNpZmljIGZ1bmN0aW9uYWxpdGllcyBvdGhlcg0KPj4g
dGhhbiBzY3J1YmJpbmcgIGluIGxvbmcgcnVuLiAgTW9zdCBvZiB0aGUgY2xhc3NlcyBpbiB0aGUg
a2VybmVsIGZvdW5kDQo+PiBhcyAgL3N5cy9jbGFzcy88Y2xhc3MtbmFtZT4vPGNsYXNzLW5hbWU+
WC8NCj4+DQo+PiBJZiBub3QsIGhvd2V2ZXIgL3N5cy9jbGFzcy9yYXMvPG1vZHVsZSAtbmFtZT5Y
LzxmZWF0dXJlPiBpcyBtb3JlDQo+PiBzdWl0YWJsZSBiZWNhdXNlIHRoZXJlIGFyZSBtdWx0aXBs
ZSBkZXZpY2UgaW5zdGFuY2VzIHN1Y2ggYXMgY3hsDQo+PiBkZXZpY2VzIHdpdGggc2NydWIgY29u
dHJvbCBmZWF0dXJlLiAgRm9yIGV4YW1wbGUsDQo+PiAvc3lzL2NsYXNzL3Jhcy9jeGxYL3NjcnVi
DQo+DQo+TWFrZSBpdCBhcyB1c2VyLWZyaWVuZGx5IGFzIHBvc3NpYmxlLiBjeGxYIGlzIG5vdCBh
cyB1c2VyLWZyaWVuZGx5IGFzDQo+DQo+L3N5cy9jbGFzcy9yYXMvY3hsLzxtZW1fYWNjZWxlcmF0
b3I+DQo+CQkgIC88ZmFuY3lfYmxhX3RoaW5nPg0KPg0KPmFuZCBzbyBvbi4NCj4NCj5ZZXMsIHlv
dSBjYW4gaW50cm9kdWNlIGEgc3BlY2lhbCBjYXRlZ29yeSAuLi4vcmFzL2N4bC8gaWYgdGhlcmUg
YXJlIG11bHRpcGxlIGN4bA0KPmRldmljZXMgd2hpY2ggaGF2ZSBSQVMgZnVuY3Rpb25hbGl0eSBv
biB0aGVtLg0KU3VyZS4NCg0KPg0KPj4gUHJlc2VudGx5IHVuZGVybHlpbmcgaHcgZHJpdmVyIGRv
ZXMgdGhlIGNoZWNrLiBJIHRoaW5rIHRoaXMgd2lsbA0KPj4gYmVjb21lIG1vcmUgY29tcGxleCBp
ZiBkb2VzIGluIHRoZSBjb21tb24gcmF0ZV9zdG9yZSgpIGlmIHdlIGhhdmUgdG8NCj4+IGNoZWNr
IGFnYWluc3QgZWl0aGVyIGEgbGlzdCBvZiBwb3NzaWJsZSByYXRlcyBvciBtaW4gYW5kIG1heCBy
YXRlcy4NCj4NCj5Pay4NCj4NCj4+ID4+ICtERVZJQ0VfQVRUUl9SVyhlbmFibGVfYmFja2dyb3Vu
ZCk7DQo+PiA+PiArREVWSUNFX0FUVFJfUk8obmFtZSk7DQo+PiA+PiArREVWSUNFX0FUVFJfUlco
cmF0ZSk7DQo+PiA+PiArREVWSUNFX0FUVFJfUk8ocmF0ZV9hdmFpbGFibGUpOw0KPj4gPg0KPj4g
PnN0YXRpYw0KPg0KPkZvcmdvdCBvbmUuDQpXaWxsIGNvcnJlY3QuDQoNCj4NCj4+IFRoaXMgaXMg
dGhlIHJhcyBpbnN0YW5jZSBpZCAoWCkgdXNlZCBmb3Igc2NydWIgY29udHJvbCBmZWF0dXJlLA0K
Pj4gL3N5cy9jbGFzcy9yYXMvcmFzWC9zY3J1Yi8NCj4NCj5ZZWFoLCBhcyBkaXNjdXNzZWQgIGFi
b3ZlLg0KT0suDQo+DQo+PiA+PiArc3RhdGljIGludCBfX2luaXQgbWVtb3J5X3NjcnViX2NvbnRy
b2xfaW5pdCh2b2lkKSB7DQo+PiA+PiArCXJldHVybiBjbGFzc19yZWdpc3Rlcigmc2NydWJfY2xh
c3MpOyB9DQo+PiA+PiArc3Vic3lzX2luaXRjYWxsKG1lbW9yeV9zY3J1Yl9jb250cm9sX2luaXQp
Ow0KPj4gPg0KPj4gPllvdSBjYW4ndCBqdXN0IGJsaW5kbHkgcmVnaXN0ZXIgdGhpcyB0aGluZyB3
aXRob3V0IGNoZWNraW5nIHdoZXRoZXINCj4+ID50aGVyZSBhcmUgZXZlbiBhbnkgaHcgc2NydWJi
ZXIgZGV2aWNlcyBvbiB0aGUgc3lzdGVtLg0KPj4NCj4+IEkgdGhpbmsgaXQgaGFwcGVucyBvbmx5
IHdoZW4gYSBkZXBlbmRlbnQgbW9kdWxlIGFzIGF1dG9sb2FkZWQgYmFzZWQgb24NCj4+IGEgc2Ny
dWIgZGV2aWNlIGV4aXN0aW5nIHdpdGggZXhjZXB0aW9uIG9mIG1lbW9yeSBzY3J1YiBjb250cm9s
IGJ1aWx0DQo+PiBpbiBhbmQgd2hvIHdvdWxkIGJ1aWxkIHRoaXMgaW4/DQo+DQo+WW91IHRoaW5r
IG9yIHlvdSBrbm93Pw0KV2Uga25vdyBhcyBJIGhhZCB0ZXN0ZWQuDQoNCj4NCj4tLQ0KPlJlZ2Fy
ZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGds
eC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQoNClRoYW5rcywNClNoaWp1DQo=

