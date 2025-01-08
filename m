Return-Path: <linux-edac+bounces-2846-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791E1A060BE
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jan 2025 16:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7193AB26E
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jan 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5F91FECBB;
	Wed,  8 Jan 2025 15:47:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D69199E88;
	Wed,  8 Jan 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351243; cv=none; b=Zy2ADWkPibGnFmLnwTv+qTbyT+cDwv43H2S4QBVZMZbzUME5aSR4/7nx0K0ML4sbsVE3KcyF6C7A+pXiQKfwlqCoRq29v4+YLKUQOt7vRCuFDdo45/XV4RuH6v6wbMMjUvpvyufR54bWlGMWaBmSJ3rpDe9MsQMzD0xyguSO8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351243; c=relaxed/simple;
	bh=zDpT+gRVw3ELu9IymByX8B241qWFr6AedVaSCEJOKhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l+nfhTcSyPSqWoGtoOduU0xBC6kT+a1jWNIl34F0bFMM1TIOMKsuR/RKHU2+1sVtRcSjNgmUuEIAV5NP2zCiJG2hFSVQE6/bQFWuZ86Unmn09TLCTwTHe7GEOL4niwq/wTM+fToMReKHn5fwj9UzkfUxJ8o9RoEcU//VuTsPaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YSscX4smRz6HJTY;
	Wed,  8 Jan 2025 23:42:36 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 61C09140C72;
	Wed,  8 Jan 2025 23:47:12 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 Jan 2025 16:47:12 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 8 Jan 2025 16:47:12 +0100
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
Thread-Index: AQHbYDQd8xBjK3PZSkqZdrlJ+rHfL7MJ1jmAgABIhvCAALyTAIACKh5w
Date: Wed, 8 Jan 2025 15:47:12 +0000
Message-ID: <46b4e35b722740a59b946fa1c0562ac6@huawei.com>
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
bGllbjguZGU+DQpbLi4uXQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE4IDAyLzE5XSBFREFDOiBB
ZGQgc2NydWIgY29udHJvbCBmZWF0dXJlDQo+DQo+T24gTW9uLCBKYW4gMDYsIDIwMjUgYXQgMDc6
MzQ6NDFQTSArMDAwMCwgU2hpanUgSm9zZSB3cm90ZToNCj4+IE15IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCB5b3UgbWVhbnQgdGhlIGZvbGxvd2luZyBjaGFuZ2VzIChkaWZmIHRvIHRoaXMNCj4+IHBh
dGNoKSwgZm9yIHNjcnViPyAgKGFuZCBzaW1pbGFyIGZvciBvdGhlciBmZWF0dXJlcykuICBQbGVh
c2UgbGV0IG1lDQo+PiBrbm93IGlmIHlvdSBuZWVkIGFueSBjb3JyZWN0aW9ucy4NCj4NCj5ZZXMs
IHNvbWV0aGluZyBsaWtlIHRoYXQgZXhjZXB0ICJzZWxlY3QiIGlzIGV2aWwgYW5kIHNob3VsZCBi
ZSB1c2VkIG9ubHkgd2hlbiB0aGUNCj5pdGVtcyBpdCBzZWxlY3RzIGRvIG5vdCBwdWxsIGluIG1v
cmUgc3R1ZmYuIEFuZCBzaW5jZSBzY3J1YiBpcyBhbGwgb3B0aW9uYWwsIGl0IHNob3VsZA0KPmFs
bCBiZSBkZXBlbmRzLg0KPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9LY29uZmlnIGIv
ZHJpdmVycy9lZGFjL0tjb25maWcgaW5kZXgNCj4+IDA2ZjdiNDNhNmY3OC4uNzA5YmQ3YWQ4MDE1
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9lZGFjL0tjb25maWcNCj4+ICsrKyBiL2RyaXZlcnMv
ZWRhYy9LY29uZmlnDQo+PiBAQCAtOSw2ICs5LDE0IEBAIGNvbmZpZyBFREFDX0FUT01JQ19TQ1JV
QiAgY29uZmlnIEVEQUNfU1VQUE9SVA0KPj4gIAlib29sDQo+Pg0KPj4gK2NvbmZpZyBFREFDX0ZF
QVRfU0NSVUINCj4NCj5FREFDX1NDUlVCIGlzIHBlcmZlY3RseSBmaW5lLg0KPg0KPj4gKwlib29s
DQo+PiArCWhlbHANCj4+ICsJICBUaGUgRURBQyBzY3J1YiBmZWF0dXJlIGlzIG9wdGlvbmFsIGFu
ZCBpcyBkZXNpZ25lZCB0byBjb250cm9sIHRoZQ0KPj4gKwkgIG1lbW9yeSBzY3J1YmJlcnMgaW4g
dGhlIHN5c3RlbS4gVGhlIGNvbW1vbiBzeXNmcyBzY3J1YiBpbnRlcmZhY2UNCj4+ICsJICBhYnN0
cmFjdHMgdGhlIGNvbnRyb2wgb2YgdmFyaW91cyBhcmJpdHJhcnkgc2NydWJiaW5nIGZ1bmN0aW9u
YWxpdGllcw0KPj4gKwkgIGludG8gYSB1bmlmaWVkIHNldCBvZiBmdW5jdGlvbnMuDQo+DQo+VGhp
cyBzaG91bGQgY29tZS4uLg0KPg0KPj4gKw0KPj4gIG1lbnVjb25maWcgRURBQw0KPj4gIAl0cmlz
dGF0ZSAiRURBQyAoRXJyb3IgRGV0ZWN0aW9uIEFuZCBDb3JyZWN0aW9uKSByZXBvcnRpbmciDQo+
PiAgCWRlcGVuZHMgb24gSEFTX0lPTUVNICYmIEVEQUNfU1VQUE9SVCAmJiBSQVMNCj4NCj4uLi4g
aW4gaGVyZSBhcyBpdCBpcyBwYXJ0IG9mIEVEQUMuDQo+DQo+VGh4Lg0KPg0KSGkgQm9yaXMsDQoN
CkkgIGhhdmUgaW5jb3Jwb3JhdGVkIHlvdXIgc3VnZ2VzdGlvbnMgZm9yIHRoZSBuZXh0IHZlcnNp
b24uICANCkhvd2V2ZXIgYmVmb3JlIHNlbmRpbmcgbmV4dCB2ZXJzaW9uLCBJIGFtIHdvbmRlcmlu
ZyBhcmUgeW91IHBsYW5uaW5nIGZvciBmdXJ0aGVyIHJldmlldyBvbg0KdGhpcyB2MTggc2VyaWVz
IGFuZCBnaXZpbmcgYW55IG90aGVyIGZlZWRiYWNrcz8gICAgIA0KDQpUaGFua3MsDQpTaGlqdQ0K

