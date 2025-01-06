Return-Path: <linux-edac+bounces-2817-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44AA030C5
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 20:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A5218860A5
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9341DFE18;
	Mon,  6 Jan 2025 19:34:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315211DFE1E;
	Mon,  6 Jan 2025 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192087; cv=none; b=FrxK522WDqRPlCvrT1I2aCSBT5jwUJHpkOIhZrgFVvyWZ8SJcDcGkR7MkzPDFL/boiSpLmQb9aJ65d36y1UNwfsqnsbXyKlgtELsZKm7JS6FB3HY+tRbacpfIq64mY7lwBnmBoX4OAyVNVMt88KHDbc7kPGxsQ2zE9vSGpN2g98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192087; c=relaxed/simple;
	bh=vdpye+LKq96Nf2Fi3BtWeto4gqAogyIqiCrq//WLkxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dJ+K1OsViFKeBUNoQhV4blh5an1xTxn9ESmjpudcVvzQ5PuRksm7YxfCEVrZjkJV3Nh5o6kAVR8C6+whM1fgUpmhha/jMsuB6/p2VF56dyVI97ruu5W3PCsqxkiQ3lce3A/9Be0fyOaLpSFZYzHGj0V9XSGT2GKZ1/niMpzet6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRkm30fJWz6K60m;
	Tue,  7 Jan 2025 03:30:11 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 81746140A90;
	Tue,  7 Jan 2025 03:34:41 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 20:34:41 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 6 Jan 2025 20:34:41 +0100
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
Thread-Index: AQHbYDQd8xBjK3PZSkqZdrlJ+rHfL7MJ1jmAgABIhvA=
Date: Mon, 6 Jan 2025 19:34:41 +0000
Message-ID: <36665b7bf4974020a34d08a7ddf6d554@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-3-shiju.jose@huawei.com>
 <20250106155733.GAZ3v9bQspKvdi3lZE@fat_crate.local>
In-Reply-To: <20250106155733.GAZ3v9bQspKvdi3lZE@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMDYgSmFudWFyeSAyMDI1IDE1OjU4DQo+VG86IFNoaWp1IEpvc2Ug
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
cm9sIGZlYXR1cmUNCj4NCj5PbiBNb24sIEphbiAwNiwgMjAyNSBhdCAxMjowOTo1OFBNICswMDAw
LCBzaGlqdS5qb3NlQGh1YXdlaS5jb20gd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9l
ZGFjL01ha2VmaWxlIGIvZHJpdmVycy9lZGFjL01ha2VmaWxlIGluZGV4DQo+PiBmOWNmMTlkOGQx
M2QuLmExNjI3MjZjYzZiOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZWRhYy9NYWtlZmlsZQ0K
Pj4gKysrIGIvZHJpdmVycy9lZGFjL01ha2VmaWxlDQo+PiBAQCAtMTAsNiArMTAsNyBAQCBvYmot
JChDT05GSUdfRURBQykJCQk6PSBlZGFjX2NvcmUubw0KPj4NCj4+ICBlZGFjX2NvcmUteQk6PSBl
ZGFjX21jLm8gZWRhY19kZXZpY2UubyBlZGFjX21jX3N5c2ZzLm8NCj4+ICBlZGFjX2NvcmUteQkr
PSBlZGFjX21vZHVsZS5vIGVkYWNfZGV2aWNlX3N5c2ZzLm8gd3Eubw0KPj4gK2VkYWNfY29yZS15
CSs9IHNjcnViLm8NCj4NCj5Zb3UncmUgbm90IGJlaW5nIHNlcmlvdXMgaGVyZSAtIHRoaXMgc2Ny
dWIgZ3VuayBpcyBlbmFibGVkIGJ5IGRlZmF1bHQgb24NCj4qZXZlcnl0aGluZyo/DQo+DQo+U28g
dGhlIG1haW4gdXNlciBvZiB0aGlzIGlzIGdvaW5nIHRvIGJlIENYTCwgQUZBSUNULCBzbyB0aGUg
c2NydWJiaW5nIGd1bmsgc2hvdWxkDQo+ZGVwZW5kIGF0IGxlYXN0IG9uIGl0IG9yIHNvLiBEZWZp
bml0ZWx5IG5vdCB1bmNvbmRpdGlvbmFsbHkgZW5hYmxlZCBvbiBldmVyeSBidWlsZC4NClRoYW5r
cyBmb3IgdGhlIGNvbW1lbnQuDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgeW91IG1lYW50IHRo
ZSBmb2xsb3dpbmcgY2hhbmdlcyAoZGlmZiB0byB0aGlzIHBhdGNoKSwgZm9yIHNjcnViPw0KKGFu
ZCBzaW1pbGFyIGZvciBvdGhlciBmZWF0dXJlcykuIA0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlv
dSBuZWVkIGFueSBjb3JyZWN0aW9ucy4NCiAgICANCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9LY29uZmlnIGIvZHJpdmVy
cy9jeGwvS2NvbmZpZw0KaW5kZXggNjA3OGYwMmU4ODNiLi43ODg2MDk3Zjk5OGYgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2N4bC9LY29uZmlnDQorKysgYi9kcml2ZXJzL2N4bC9LY29uZmlnDQpAQCAt
MTU4LDcgKzE1OCw3IEBAIGNvbmZpZyBDWExfUkFTX0ZFQVRVUkVTDQogCXRyaXN0YXRlICJDWEw6
IE1lbW9yeSBSQVMgZmVhdHVyZXMiDQogCWRlcGVuZHMgb24gQ1hMX1BDSQ0KIAlkZXBlbmRzIG9u
IENYTF9NRU0NCi0JZGVwZW5kcyBvbiBFREFDDQorCXNlbGVjdCBFREFDX0ZFQVRfU0NSVUINCiAJ
aGVscA0KIAkgIFRoZSBDWEwgbWVtb3J5IFJBUyBmZWF0dXJlIGNvbnRyb2wgaXMgb3B0aW9uYWwg
YW5kIGFsbG93cyBob3N0IHRvDQogCSAgY29udHJvbCB0aGUgUkFTIGZlYXR1cmVzIGNvbmZpZ3Vy
YXRpb25zIG9mIENYTCBUeXBlIDMgZGV2aWNlcy4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMv
S2NvbmZpZyBiL2RyaXZlcnMvZWRhYy9LY29uZmlnDQppbmRleCAwNmY3YjQzYTZmNzguLjcwOWJk
N2FkODAxNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9LY29uZmlnDQorKysgYi9kcml2ZXJz
L2VkYWMvS2NvbmZpZw0KQEAgLTksNiArOSwxNCBAQCBjb25maWcgRURBQ19BVE9NSUNfU0NSVUIN
CiBjb25maWcgRURBQ19TVVBQT1JUDQogCWJvb2wNCiANCitjb25maWcgRURBQ19GRUFUX1NDUlVC
DQorCWJvb2wNCisJaGVscA0KKwkgIFRoZSBFREFDIHNjcnViIGZlYXR1cmUgaXMgb3B0aW9uYWwg
YW5kIGlzIGRlc2lnbmVkIHRvIGNvbnRyb2wgdGhlDQorCSAgbWVtb3J5IHNjcnViYmVycyBpbiB0
aGUgc3lzdGVtLiBUaGUgY29tbW9uIHN5c2ZzIHNjcnViIGludGVyZmFjZQ0KKwkgIGFic3RyYWN0
cyB0aGUgY29udHJvbCBvZiB2YXJpb3VzIGFyYml0cmFyeSBzY3J1YmJpbmcgZnVuY3Rpb25hbGl0
aWVzDQorCSAgaW50byBhIHVuaWZpZWQgc2V0IG9mIGZ1bmN0aW9ucy4NCisNCiBtZW51Y29uZmln
IEVEQUMNCiAJdHJpc3RhdGUgIkVEQUMgKEVycm9yIERldGVjdGlvbiBBbmQgQ29ycmVjdGlvbikg
cmVwb3J0aW5nIg0KIAlkZXBlbmRzIG9uIEhBU19JT01FTSAmJiBFREFDX1NVUFBPUlQgJiYgUkFT
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL01ha2VmaWxlIGIvZHJpdmVycy9lZGFjL01ha2Vm
aWxlDQppbmRleCAxZGU5ZmU2NmFjNmIuLjcxYTUyMjI3MjIxNSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZWRhYy9NYWtlZmlsZQ0KKysrIGIvZHJpdmVycy9lZGFjL01ha2VmaWxlDQpAQCAtMTAsNyAr
MTAsOSBAQCBvYmotJChDT05GSUdfRURBQykJCQk6PSBlZGFjX2NvcmUubw0KIA0KIGVkYWNfY29y
ZS15CTo9IGVkYWNfbWMubyBlZGFjX2RldmljZS5vIGVkYWNfbWNfc3lzZnMubw0KIGVkYWNfY29y
ZS15CSs9IGVkYWNfbW9kdWxlLm8gZWRhY19kZXZpY2Vfc3lzZnMubyB3cS5vDQotZWRhY19jb3Jl
LXkJKz0gc2NydWIubyBlY3MubyBtZW1fcmVwYWlyLm8NCisNCitlZGFjX2NvcmUtJChDT05GSUdf
RURBQ19GRUFUX1NDUlVCKQkrPSBzY3J1Yi5vDQoNCiBlZGFjX2NvcmUtJChDT05GSUdfRURBQ19E
RUJVRykJCSs9IGRlYnVnZnMubw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmFzL0tjb25maWcg
Yi9kcml2ZXJzL3Jhcy9LY29uZmlnDQppbmRleCBiNzc3OTBiZGM3M2EuLjg3MGYzNDY2YzJmNyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvcmFzL0tjb25maWcNCisrKyBiL2RyaXZlcnMvcmFzL0tjb25m
aWcNCkBAIC00OSw3ICs0OSw3IEBAIGNvbmZpZyBSQVNfRk1QTQ0KIGNvbmZpZyBNRU1fQUNQSV9S
QVMyDQogCXRyaXN0YXRlICJNZW1vcnkgQUNQSSBSQVMyIGRyaXZlciINCiAJZGVwZW5kcyBvbiBB
Q1BJX1JBUzINCi0JZGVwZW5kcyBvbiBFREFDDQorCXNlbGVjdCBFREFDX0ZFQVRfU0NSVUINCiAJ
aGVscA0KIAkgIFRoZSBkcml2ZXIgYmluZHMgdG8gdGhlIHBsYXRmb3JtIGRldmljZSBhZGRlZCBi
eSB0aGUgQUNQSSBSQVMyDQogCSAgdGFibGUgcGFyc2VyLiBVc2UgYSBQQ0MgY2hhbm5lbCBzdWJz
cGFjZSBmb3IgY29tbXVuaWNhdGluZyB3aXRoDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9l
ZGFjLmggYi9pbmNsdWRlL2xpbnV4L2VkYWMuaA0KaW5kZXggNWQwNzE5MmJmMWE3Li4wZjZjN2Yz
NTgyYzMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2VkYWMuaA0KKysrIGIvaW5jbHVkZS9s
aW51eC9lZGFjLmgNCkBAIC02OTgsOSArNjk4LDE2IEBAIHN0cnVjdCBlZGFjX3NjcnViX29wcyB7
DQogCWludCAoKnNldF9jeWNsZV9kdXJhdGlvbikoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpk
cnZfZGF0YSwgdTMyIGN5Y2xlKTsNCiB9Ow0KIA0KKyNpZiBJU19FTkFCTEVEKENPTkZJR19FREFD
X0ZFQVRfU0NSVUIpDQogaW50IGVkYWNfc2NydWJfZ2V0X2Rlc2Moc3RydWN0IGRldmljZSAqc2Ny
dWJfZGV2LA0KIAkJCWNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKiphdHRyX2dyb3VwcywN
CiAJCQl1OCBpbnN0YW5jZSk7DQorI2Vsc2UNCitzdGF0aWMgaW5saW5lIGludCBlZGFjX3NjcnVi
X2dldF9kZXNjKHN0cnVjdCBkZXZpY2UgKnNjcnViX2RldiwNCisJCQkJICAgICAgY29uc3Qgc3Ry
dWN0IGF0dHJpYnV0ZV9ncm91cCAqKmF0dHJfZ3JvdXBzLA0KKwkJCQkgICAgICB1OCBpbnN0YW5j
ZSkNCit7IHJldHVybiAtRU9QTk9UU1VQUDsgfQ0KKyNlbmRpZg0KIA0KIC4uLg0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+DQo+LS0NCj5SZWdhcmRzL0dy
dXNzLA0KPiAgICBCb3Jpcy4NCj4NCj5odHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90
ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KPg0KDQpUaGFua3MsDQpTaGlqdQ0K

