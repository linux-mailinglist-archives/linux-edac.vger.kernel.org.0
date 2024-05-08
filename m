Return-Path: <linux-edac+bounces-1017-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A608C0382
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7011C2193D
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD6312A17D;
	Wed,  8 May 2024 17:44:10 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCC38F9A;
	Wed,  8 May 2024 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190250; cv=none; b=GpaS2xeXk5S4l7neu4IYflMxlUJZgOCaNc3K5B/qSTVWkrvCg1KmqDyzTErulNLAkVeNEdt0dwFJS7l6oLXKKgtemHH5ScsHrH4dHXbOu3Wst2u+Y8sm1VCDM9eYS0oCNsP6Ygpk6oXex0se6551S3fp53VNt6Mie5sZdEQqO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190250; c=relaxed/simple;
	bh=Gz4wEJwjFRJax85gYAY8xR9FHpxogME+xjyKzzRa+14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NVJ5hqUBVpBlRLU/48K1ff8y5YEnRSeEh5O1gJsfTocyCOQi4qR4ZwCmQsbuyHerKWDGIsyK6Hy9zZam6eh86wSF+2jAqPX5N5rHQV7YHD6vZySGQ+iKstCPlrlhdUEpQCLhu5OC7BcjiD5iXetx+1oCAKobg2Ji9c9sfvgpAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZMvB0lN4z6K7GH;
	Thu,  9 May 2024 01:43:34 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A4F42140AB8;
	Thu,  9 May 2024 01:44:03 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 May 2024 18:44:03 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Wed, 8 May 2024 18:44:03 +0100
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
Thread-Index: AQHaknlLsB7DmyDvA0iAgKJhxeY8vLF4vVgAgABZuhCAEPP6AIADoMIA///2ZwCAABJKUA==
Date: Wed, 8 May 2024 17:44:03 +0000
Message-ID: <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com>
 <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
 <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
 <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
 <e0ce36eb80054440ab877ccee4e606de@huawei.com>
 <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
In-Reply-To: <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMDggTWF5IDIwMjQgMTg6MjANCj5UbzogU2hpanUgSm9zZSA8c2hp
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
YXM6IHNjcnViOiBBZGQgc2NydWIgc3Vic3lzdGVtDQo+DQo+T24gV2VkLCBNYXkgMDgsIDIwMjQg
YXQgMDQ6NTk6MThQTSArMDAwMCwgU2hpanUgSm9zZSB3cm90ZToNCj4+ID4+IEkgdGhpbmsgaXQg
aGFwcGVucyBvbmx5IHdoZW4gYSBkZXBlbmRlbnQgbW9kdWxlIGFzIGF1dG9sb2FkZWQgYmFzZWQN
Cj4+ID4+IG9uIGEgc2NydWIgZGV2aWNlIGV4aXN0aW5nIHdpdGggZXhjZXB0aW9uIG9mIG1lbW9y
eSBzY3J1YiBjb250cm9sDQo+PiA+PiBidWlsdCBpbiBhbmQgd2hvIHdvdWxkIGJ1aWxkIHRoaXMg
aW4/DQo+PiA+DQo+PiA+WW91IHRoaW5rIG9yIHlvdSBrbm93Pw0KPj4gV2Uga25vdyBhcyBJIGhh
ZCB0ZXN0ZWQuDQo+DQo+RG9lcyB0aGlzIHRoaW5nIHJlZ2lzdGVyIHN1Y2Nlc3NmdWxseSBvbiBh
IG1hY2hpbmUgd2hpY2ggZG9lc24ndCBoYXZlIHRob3NlDQo+ZGV2aWNlcz8NCj4NCkkgbWVhbiBz
Y3J1YiBzdWJzeXN0ZW0gbW9kdWxlIGlzIG5vdCBsb2FkZWQgYW5kIGluaXRpYWx6ZWQgdW50aWwg
YSBkZXBlbmRlbnQgIGRldmljZSBtb2R1bGUgaXMgbG9hZGVkIGFuZCBhIGRldmljZSBkb2VzIG5v
dCBnZXQgcmVnaXN0ZXJlZCB3aXRoIHRoZSBzY3J1YiBzdWJzeXN0ZW0gb24gYSBtYWNoaW5lIHdo
aWNoIGRvZXNuJ3QgaGF2ZSB0aGUgY29ycmVzcG9uZGluZyBzY3J1YiBmZWF0dXJlcy4NCj4tLQ0K
PlJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8vcGVvcGxlLmtlcm5lbC5v
cmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQoNClRoYW5rcywNClNoaWp1DQo=

