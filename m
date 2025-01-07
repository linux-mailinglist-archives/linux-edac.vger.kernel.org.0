Return-Path: <linux-edac+bounces-2824-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0746FA03AF1
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2025 10:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF8188316A
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952E1DE894;
	Tue,  7 Jan 2025 09:23:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB07647;
	Tue,  7 Jan 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241806; cv=none; b=KXDJPOdxXGyvaQzc/U+XuPIp8ty4Trw08Bh4ljMq4mh/gpea1FQpfgFSpsVCqDXKfmdXV8Fw5TAQrUxwnaG3wLbAHRw7XH8Zb5lu02Xss6LdeqrAxxdrJakeKndVESnVjPAiT/9kxRIzdsFj8B1+2/dZCo4ALsEkNcuyrXVfDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241806; c=relaxed/simple;
	bh=PIZYC/3Ty+YjyfGidIWLDZXYkQdxxNH49WPDSunZ9ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j8uRqMQCgAdqfeJoTiFE4YQehmQSq5forEfWJdZLraaT3IcWI2DhhL8m4JyZIvsFMkWkvEmk6mywVveIdAUICRuZF73K6c0weJ/xnnZ9vx8irrRse66vyms9sivGtkClzfHwwWgUhkn8IF00aGH4C+frgd/UBfqmz7bbLaB2BDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YS5CZ6q8lz6M4Lm;
	Tue,  7 Jan 2025 17:21:46 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 11C9E1403A8;
	Tue,  7 Jan 2025 17:23:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 Jan 2025 10:23:19 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 7 Jan 2025 10:23:19 +0100
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
Subject: RE: [PATCH v18 02/19] EDAC: Add scrub control feature
Thread-Topic: [PATCH v18 02/19] EDAC: Add scrub control feature
Thread-Index: AQHbYDQd8xBjK3PZSkqZdrlJ+rHfL7MJ1jmAgABIhvCAALyTAIAALgLg
Date: Tue, 7 Jan 2025 09:23:19 +0000
Message-ID: <bb8154e6c78d440bb807ff9b6bfd7a0f@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-3-shiju.jose@huawei.com>
 <20250106155733.GAZ3v9bQspKvdi3lZE@fat_crate.local>
 <36665b7bf4974020a34d08a7ddf6d554@huawei.com>
 <20250107073204.GBZ3zYdOtWEbieKXiU@fat_crate.local>
In-Reply-To: <20250107073204.GBZ3zYdOtWEbieKXiU@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMDcgSmFudWFyeSAyMDI1IDA3OjMyDQo+VG86IFNoaWp1IEpvc2Ug
PHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmFjcGlAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+dG9u
eS5sdWNrQGludGVsLmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsNCj5t
Y2hlaGFiQGtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgZGF2ZUBzdGdvbGFi
cy5uZXQ7IEpvbmF0aGFuDQo+Q2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsg
ZGF2ZS5qaWFuZ0BpbnRlbC5jb207DQo+YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbTsgaXJhLndlaW55QGludGVsLmNvbTsNCj5kYXZpZEByZWRoYXQu
Y29tOyBWaWxhcy5TcmlkaGFyYW5AYW1kLmNvbTsgbGVvLmR1cmFuQGFtZC5jb207DQo+WWF6ZW4u
R2hhbm5hbUBhbWQuY29tOyByaWVudGplc0Bnb29nbGUuY29tOyBqaWFxaXlhbkBnb29nbGUuY29t
Ow0KPkpvbi5HcmltbUBhbWQuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207DQo+bmFv
eWEuaG9yaWd1Y2hpQG5lYy5jb207IGphbWVzLm1vcnNlQGFybS5jb207IGp0aG91Z2h0b25AZ29v
Z2xlLmNvbTsNCj5zb21hc3VuZGFyYW0uYUBocGUuY29tOyBlcmRlbWFrdGFzQGdvb2dsZS5jb207
IHBnb25kYUBnb29nbGUuY29tOw0KPmR1ZW53ZW5AZ29vZ2xlLmNvbTsgZ3RoZWxlbkBnb29nbGUu
Y29tOw0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcuY29tOyBkZmVyZ3Vzb25AYW1wZXJlY29t
cHV0aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgbmlmYW4uY3hsQGdtYWls
LmNvbTsgdGFueGlhb2ZlaQ0KPjx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8
cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgUm9iZXJ0bw0KPlNhc3N1IDxyb2JlcnRvLnNhc3N1
QGh1YXdlaS5jb20+OyBrYW5na2FuZy5zaGVuQGZ1dHVyZXdlaS5jb207DQo+d2FuZ2h1aXFpYW5n
IDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IExpbnV4YXJtDQo+PGxpbnV4YXJtQGh1YXdlaS5j
b20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MTggMDIvMTldIEVEQUM6IEFkZCBzY3J1YiBjb250
cm9sIGZlYXR1cmUNCj4NCj5PbiBNb24sIEphbiAwNiwgMjAyNSBhdCAwNzozNDo0MVBNICswMDAw
LCBTaGlqdSBKb3NlIHdyb3RlOg0KPj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHlvdSBtZWFu
dCB0aGUgZm9sbG93aW5nIGNoYW5nZXMgKGRpZmYgdG8gdGhpcw0KPj4gcGF0Y2gpLCBmb3Igc2Ny
dWI/ICAoYW5kIHNpbWlsYXIgZm9yIG90aGVyIGZlYXR1cmVzKS4gIFBsZWFzZSBsZXQgbWUNCj4+
IGtub3cgaWYgeW91IG5lZWQgYW55IGNvcnJlY3Rpb25zLg0KPg0KPlllcywgc29tZXRoaW5nIGxp
a2UgdGhhdCBleGNlcHQgInNlbGVjdCIgaXMgZXZpbCBhbmQgc2hvdWxkIGJlIHVzZWQgb25seSB3
aGVuIHRoZQ0KPml0ZW1zIGl0IHNlbGVjdHMgZG8gbm90IHB1bGwgaW4gbW9yZSBzdHVmZi4gQW5k
IHNpbmNlIHNjcnViIGlzIGFsbCBvcHRpb25hbCwgaXQgc2hvdWxkDQo+YWxsIGJlIGRlcGVuZHMu
DQoNClN1cmUuDQo+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL0tjb25maWcgYi9kcml2
ZXJzL2VkYWMvS2NvbmZpZyBpbmRleA0KPj4gMDZmN2I0M2E2Zjc4Li43MDliZDdhZDgwMTUgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2VkYWMvS2NvbmZpZw0KPj4gKysrIGIvZHJpdmVycy9lZGFj
L0tjb25maWcNCj4+IEBAIC05LDYgKzksMTQgQEAgY29uZmlnIEVEQUNfQVRPTUlDX1NDUlVCICBj
b25maWcgRURBQ19TVVBQT1JUDQo+PiAgCWJvb2wNCj4+DQo+PiArY29uZmlnIEVEQUNfRkVBVF9T
Q1JVQg0KPg0KPkVEQUNfU0NSVUIgaXMgcGVyZmVjdGx5IGZpbmUuDQoNClN1cmUuIEkgd2lsbCBj
aGFuZ2UuDQo+DQo+PiArCWJvb2wNCj4+ICsJaGVscA0KPj4gKwkgIFRoZSBFREFDIHNjcnViIGZl
YXR1cmUgaXMgb3B0aW9uYWwgYW5kIGlzIGRlc2lnbmVkIHRvIGNvbnRyb2wgdGhlDQo+PiArCSAg
bWVtb3J5IHNjcnViYmVycyBpbiB0aGUgc3lzdGVtLiBUaGUgY29tbW9uIHN5c2ZzIHNjcnViIGlu
dGVyZmFjZQ0KPj4gKwkgIGFic3RyYWN0cyB0aGUgY29udHJvbCBvZiB2YXJpb3VzIGFyYml0cmFy
eSBzY3J1YmJpbmcgZnVuY3Rpb25hbGl0aWVzDQo+PiArCSAgaW50byBhIHVuaWZpZWQgc2V0IG9m
IGZ1bmN0aW9ucy4NCj4NCj5UaGlzIHNob3VsZCBjb21lLi4uDQo+DQo+PiArDQo+PiAgbWVudWNv
bmZpZyBFREFDDQo+PiAgCXRyaXN0YXRlICJFREFDIChFcnJvciBEZXRlY3Rpb24gQW5kIENvcnJl
Y3Rpb24pIHJlcG9ydGluZyINCj4+ICAJZGVwZW5kcyBvbiBIQVNfSU9NRU0gJiYgRURBQ19TVVBQ
T1JUICYmIFJBUw0KPg0KPi4uLiBpbiBoZXJlIGFzIGl0IGlzIHBhcnQgb2YgRURBQy4NCg0KSSB3
aWxsIG1vdmUgaW4gaGVyZS4gDQo+DQo+VGh4Lg0KPg0KPi0tDQo+UmVnYXJkcy9HcnVzcywNCj4g
ICAgQm9yaXMuDQo+DQo+aHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0
LW5ldGlxdWV0dGUNCg0KVGhhbmtzLA0KU2hpanUNCg0K

