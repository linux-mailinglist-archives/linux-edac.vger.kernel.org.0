Return-Path: <linux-edac+bounces-2851-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7FCA07417
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 12:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B7F3A570C
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809F215F58;
	Thu,  9 Jan 2025 11:00:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CD1A8F8F;
	Thu,  9 Jan 2025 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420450; cv=none; b=ZpdisdG3Jqkopt4Jf044urdG3plgexQm7Ctga64qJzwrlfelcEb174m/J4kEGNydP99WAKffdf+cz4JuDhYpFqx/it1ckfgfFT1lJt/RrAnS+QmBuNfibtX7xYjRCmoItc8pGZHXyUUb1AbOvAb3uXjJ45zyT09Z1eTRSfXmiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420450; c=relaxed/simple;
	bh=5d2ubSzJHcX+qxEMJNt8TBpdtmppnskA8J6h11p1HvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/xyyrsh63hAoaBuawkEPoKmR9+vJv7ppsQJUxa3P/UyX8KZf32+0gtuD6rKoUNTqMxXXfH1A0GVWwi0qRc9cNg4DPcVyegu2kOpYEWP3HH9+VMrGGuShjQ2jyabBVTZXYa0kuCt0CTXelU3zzgFONlIbZux4Ol4Gl2KxXt5FPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YTMHS53YCz6L5Jc;
	Thu,  9 Jan 2025 18:59:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BB16140A34;
	Thu,  9 Jan 2025 19:00:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 9 Jan 2025 12:00:43 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 9 Jan 2025 12:00:43 +0100
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
Subject: RE: [PATCH v18 04/19] EDAC: Add memory repair control feature
Thread-Topic: [PATCH v18 04/19] EDAC: Add memory repair control feature
Thread-Index: AQHbYDQgB18e2Mzm30SSjInW5UV51bMOHe6AgAAV/KA=
Date: Thu, 9 Jan 2025 11:00:43 +0000
Message-ID: <3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-5-shiju.jose@huawei.com>
 <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
In-Reply-To: <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMDkgSmFudWFyeSAyMDI1IDA5OjE5DQo+VG86IFNoaWp1IEpvc2Ug
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
b20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MTggMDQvMTldIEVEQUM6IEFkZCBtZW1vcnkgcmVw
YWlyIGNvbnRyb2wgZmVhdHVyZQ0KPg0KPk9uIE1vbiwgSmFuIDA2LCAyMDI1IGF0IDEyOjEwOjAw
UE0gKzAwMDAsIHNoaWp1Lmpvc2VAaHVhd2VpLmNvbSB3cm90ZToNCj4+ICtXaGF0OgkJL3N5cy9i
dXMvZWRhYy9kZXZpY2VzLzxkZXYtDQo+bmFtZT4vbWVtX3JlcGFpclgvbWluX2hwYQ0KPj4gK1do
YXQ6CQkvc3lzL2J1cy9lZGFjL2RldmljZXMvPGRldi0NCj5uYW1lPi9tZW1fcmVwYWlyWC9taW5f
ZHBhDQo+PiArV2hhdDoJCS9zeXMvYnVzL2VkYWMvZGV2aWNlcy88ZGV2LQ0KPm5hbWU+L21lbV9y
ZXBhaXJYL21pbl9uaWJibGVfbWFzaw0KPj4gK1doYXQ6CQkvc3lzL2J1cy9lZGFjL2RldmljZXMv
PGRldi0NCj5uYW1lPi9tZW1fcmVwYWlyWC9taW5fYmFua19ncm91cA0KPj4gK1doYXQ6CQkvc3lz
L2J1cy9lZGFjL2RldmljZXMvPGRldi0NCj5uYW1lPi9tZW1fcmVwYWlyWC9taW5fYmFuaw0KPj4g
K1doYXQ6CQkvc3lzL2J1cy9lZGFjL2RldmljZXMvPGRldi0NCj5uYW1lPi9tZW1fcmVwYWlyWC9t
aW5fcmFuaw0KPj4gK1doYXQ6CQkvc3lzL2J1cy9lZGFjL2RldmljZXMvPGRldi0NCj5uYW1lPi9t
ZW1fcmVwYWlyWC9taW5fcm93DQo+PiArV2hhdDoJCS9zeXMvYnVzL2VkYWMvZGV2aWNlcy88ZGV2
LQ0KPm5hbWU+L21lbV9yZXBhaXJYL21pbl9jb2x1bW4NCj4+ICtXaGF0OgkJL3N5cy9idXMvZWRh
Yy9kZXZpY2VzLzxkZXYtDQo+bmFtZT4vbWVtX3JlcGFpclgvbWluX2NoYW5uZWwNCj4+ICtXaGF0
OgkJL3N5cy9idXMvZWRhYy9kZXZpY2VzLzxkZXYtDQo+bmFtZT4vbWVtX3JlcGFpclgvbWluX3N1
Yl9jaGFubmVsDQo+PiArV2hhdDoJCS9zeXMvYnVzL2VkYWMvZGV2aWNlcy88ZGV2LQ0KPm5hbWU+
L21lbV9yZXBhaXJYL21heF9ocGENCj4+ICtXaGF0OgkJL3N5cy9idXMvZWRhYy9kZXZpY2VzLzxk
ZXYtDQo+bmFtZT4vbWVtX3JlcGFpclgvbWF4X2RwYQ0KPj4gK1doYXQ6CQkvc3lzL2J1cy9lZGFj
L2RldmljZXMvPGRldi0NCj5uYW1lPi9tZW1fcmVwYWlyWC9tYXhfbmliYmxlX21hc2sNCj4+ICtX
aGF0OgkJL3N5cy9idXMvZWRhYy9kZXZpY2VzLzxkZXYtDQo+bmFtZT4vbWVtX3JlcGFpclgvbWF4
X2JhbmtfZ3JvdXANCj4+ICtXaGF0OgkJL3N5cy9idXMvZWRhYy9kZXZpY2VzLzxkZXYtDQo+bmFt
ZT4vbWVtX3JlcGFpclgvbWF4X2JhbmsNCj4+ICtXaGF0OgkJL3N5cy9idXMvZWRhYy9kZXZpY2Vz
LzxkZXYtDQo+bmFtZT4vbWVtX3JlcGFpclgvbWF4X3JhbmsNCj4+ICtXaGF0OgkJL3N5cy9idXMv
ZWRhYy9kZXZpY2VzLzxkZXYtDQo+bmFtZT4vbWVtX3JlcGFpclgvbWF4X3Jvdw0KPj4gK1doYXQ6
CQkvc3lzL2J1cy9lZGFjL2RldmljZXMvPGRldi0NCj5uYW1lPi9tZW1fcmVwYWlyWC9tYXhfY29s
dW1uDQo+PiArV2hhdDoJCS9zeXMvYnVzL2VkYWMvZGV2aWNlcy88ZGV2LQ0KPm5hbWU+L21lbV9y
ZXBhaXJYL21heF9jaGFubmVsDQo+PiArV2hhdDoJCS9zeXMvYnVzL2VkYWMvZGV2aWNlcy88ZGV2
LQ0KPm5hbWU+L21lbV9yZXBhaXJYL21heF9zdWJfY2hhbm5lbA0KPg0KPlNvIHRoaXMgaXMgbmV3
LiBJIGRvbid0IHJlbWVtYmVyIHNlZWluZyB0aGF0IHdoZW4gSSBsb29rZWQgYXQgeW91ciBwYXRj
aGVzIHRoZQ0KPmxhc3QgdGltZS4NCj4NCj5Mb29rcyBsaWtlIHlvdSBoYXZlIGFsbCB0aG9zZSBh
dHRyaWJ1dGVzIGFuZCBub3cgeW91J3ZlIGRlY2lkZWQgdG8gYWRkIGEgbWluIGFuZA0KPm1heCBm
b3IgZWFjaCBvbmUsIGluIGFkZGl0aW9uLiBBbmQgVUktd2lzZSBpdCBpcyBhIG1hZG5lc3MgYXMg
dGhlcmUgYXJlIGdhemlsbGlvbg0KPnNpbmdsZS12YWx1ZSBmaWxlcyBub3cuDQo+DQoNClRoYW5r
cyBmb3IgdGhlIGZlZWRiYWNrcy4NCg0KVGhlIG1pbl8gYW5kIG1heF8gYXR0cmlidXRlcyBvZiB0
aGUgY29udHJvbCBhdHRyaWJ1dGVzIGFyZSBhZGRlZCAgZm9yIHlvdXINCmZlZWRiYWNrIG9uIFYx
NSB0byBleHBvc2Ugc3VwcG9ydGVkIHJhbmdlcyBvZiB0aGVzZSBjb250cm9sIGF0dHJpYnV0ZXMg
dG8gdGhlIHVzZXIsIA0KaW4gdGhlIGZvbGxvd2luZyBsaW5rcy4gICANCkhvd2V2ZXIgdGhlc2Ug
bWluXyBhbmQgbWF4XyBhdHRyaWJ1dGVzIGFyZSAnUk8nIGluc3RlYWQgb2YgJ1JXJyBhcyBzcGVj
aWZpZWQgaW4gdGhlIGRvYywgDQp3aGljaCB0byBiZSBmaXhlZCBpbiB0aGUgZG9jLg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MTExNDEzMzI0OS5HRVp6WDhBVE55Y19YdzFMNTJA
ZmF0X2NyYXRlLmxvY2FsLw0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9mYTVkNmJkZDA4
MTA0Y2YxYTA5YzQ5NjBhMGY5YmM0NkBodWF3ZWkuY29tLw0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDI0MTExOTEyMzY1Ny5HQ1p6eUdhWklFeHZVSFBMS0xAZmF0X2NyYXRlLmxvY2Fs
Lw0KDQo+IkF0dHJpYnV0ZXMgc2hvdWxkIGJlIEFTQ0lJIHRleHQgZmlsZXMsIHByZWZlcmFibHkg
d2l0aCBvbmx5IG9uZSB2YWx1ZSBwZXIgZmlsZS4gSXQgaXMNCj5ub3RlZCB0aGF0IGl0IG1heSBu
b3QgYmUgZWZmaWNpZW50IHRvIGNvbnRhaW4gb25seSBvbmUgdmFsdWUgcGVyIGZpbGUsIHNvIGl0
IGlzDQo+c29jaWFsbHkgYWNjZXB0YWJsZSB0byBleHByZXNzIGFuIGFycmF5IG9mIHZhbHVlcyBv
ZiB0aGUgc2FtZSB0eXBlLiINCj4NCj5TbyB5b3UgZG9uJ3QgbmVlZCB0aG9zZSAtIHlvdSBjYW4g
c2ltcGx5IGV4cHJlc3MgZWFjaCBhdHRyaWJ1dGUgYXMgYSByYW5nZToNCj4NCj5lY2hvICIxOjIi
ID4gL3N5cy9idXMvZWRhYy9kZXZpY2VzLzxkZXYtbmFtZT4vbWVtX3JlcGFpclgvYmFuaw0KPg0K
Pm9yIGlmIHlvdSB3YW5uYSBzY3J1YiBvbmx5IG9uZSBiYW5rOg0KDQpBZnRlciBpbnRlcm5hbCBk
aXNjdXNzaW9uLCB3ZSB0aGluayB0aGlzIGlzIHRoZSBzb3VyY2Ugb2YgdGhlIGNvbmZ1c2lvbi4g
DQpUaGlzIGlzIG5vdCBzY3J1YiB3aGVyZSBhIHJhbmdlIHdvdWxkIGluZGVlZCBtYWtlIHNlbnNl
LiBJdCBpcyByZXBhaXIuIA0KV2UgYXJlIG5vdCBhd2FyZSBvZiBhIGZhaWx1cmUgbWVjaGFuaXNt
IHdoZXJlIGEgc2V0IG9mIG1lbW9yeSBiYW5rcw0Kd291bGQgZmFpbCB0b2dldGhlciBidXQgbm90
IHRoZSB3aG9sZSBvZiB0aGUgbmV4dCBsZXZlbCB1cCBpbiB0aGUgbWVtb3J5IHRvcG9sb2d5LiAN
Cg0KSW4gdGhlb3J5IHdlIG1pZ2h0IGdldCBhIHN0dXBpZCBkZXZpY2UgZGVzaWduIHdoZXJlIGl0
IHJlcG9ydHMgY29hcnNlIGxldmVsDQplcnJvcnMgYnV0IGNhbiBvbmx5IHJlcGFpciBhdCBmaW5l
IGxldmVscyB3aGVyZSBhIHJhbmdlIG1pZ2h0IGJlIGFwcHJvcHJpYXRlLg0KV2UgYXJlIG5vdCBz
dXJlIHRoYXQgbWFrZXMgc2Vuc2UgaW4gcHJhY3RpY2UgYW5kIHdpdGggYSByYW5nZSBpbnRlcmZh
Y2Ugd2Ugd2lsbA0KZ2V0IG1lc3MgbGlrZSBydW5uaW5nIG91dCBvZiByZXBhaXIgcmVzb3VyY2Vz
IGhhbGYgd2F5IHRocm91Z2ggYSBsaXN0IHdpdGgNCm5vIHZpc2liaWxpdHkgb2Ygd2hhdCBpcyBy
ZXBhaXJlZC4NCg0KSG93ZXZlciwgZ2l2ZW4gdGhlIHJlcGFpciBmbG93IGlzIGRyaXZlbiBieSB1
c2Vyc3BhY2UgcmVjZWl2aW5nIGVycm9yIHJlY29yZHMNCnRoYXQgd2lsbCBvbmx5IHBvc3NpYmxl
IHZhbHVlcyB0byByZXBhaXIsIHdlIHRoaW5rIHRoZXNlIGJvdW5kcyBvbiB3aGF0IGNhbiBiZQ0K
cmVwYWlyZWQgYXJlIGEgbmljZSB0byBoYXZlIHJhdGhlciB0aGFuIG5lY2Vzc2FyeSBzbyB3ZSB3
b3VsZCBwcm9wb3NlIHdlIGRvIG5vdA0KYWRkIG1heF8gYW5kIG1pbl8gZm9yIG5vdyBhbmQgc2Vl
IGhvdyB0aGUgdXNlIGNhc2VzIGV2b2x2ZS4NCj4NCj5lY2hvICIxOjEiID4gL3N5cy9idXMvZWRh
Yy9kZXZpY2VzLzxkZXYtbmFtZT4vbWVtX3JlcGFpclgvYmFuaw0KPg0KPldoYXQgaXMgdGhlIHVz
ZSBjYXNlIG9mIHRoYXQgdGhpbmc/DQo+DQo+U29tZW9uZSBtaWdodCBmaW5kIGl0IHVzZWZ1bCBz
byBsZXQncyBhZGQgaXQgcHJlZW1wdGl2ZWx5Pw0KPg0KPlBmZmYuDQo+DQo+LS0NCj5SZWdhcmRz
L0dydXNzLA0KPiAgICBCb3Jpcy4NCj4NCj5odHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgv
bm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KDQpUaGFua3MsDQpTaGlqdQ0K

