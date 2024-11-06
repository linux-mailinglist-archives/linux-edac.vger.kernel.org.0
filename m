Return-Path: <linux-edac+bounces-2463-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6089BF444
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B821F24313
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A820651F;
	Wed,  6 Nov 2024 17:28:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704713541B;
	Wed,  6 Nov 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914131; cv=none; b=np1XuhGngVNj4Zo+PY1fhmOLUKGq0GyWUTt+jQbiEmstTG9TtiyDKraugk0j57FkSClwRy4y7JoHxuliXb/G3sSnbZ1KsKQgIeoYYasvCogtcn0aEtuKNWn1p/UU9eB0HDueEfrqRrsMBdtz7t4G0+HVXOsZnwnf4fsxLDtAHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914131; c=relaxed/simple;
	bh=665+N82pws8qPypIy9h7Aefyz4JxCj/33OeQ/iQlk68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KVC9ks95VTeK8qKrejM/v4BpKEk2vNFzwgHIuIT/YogH5eVrbNf0ZCkP0WYoFyuMymZP5RY1pgGcTBVCL1u3MT15oG0XyFhJANvAR9HM0FmvdBVvQbKpGsyAdLid0G+59gXChPgNv6w513xDIRB8rusmjCUtnk/tomg95xCZxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XkBts0XcVz6K7Hy;
	Thu,  7 Nov 2024 01:25:57 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id E3E71140B33;
	Thu,  7 Nov 2024 01:28:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 18:28:44 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 6 Nov 2024 18:28:44 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
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
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v15 13/15] cxl/memfeature: Add CXL memory device sPPR
 control feature
Thread-Topic: [PATCH v15 13/15] cxl/memfeature: Add CXL memory device sPPR
 control feature
Thread-Index: AQHbLD8E5jWI1EDDu0C0+SJpWS5APLKpGmUAgAFvVgA=
Date: Wed, 6 Nov 2024 17:28:44 +0000
Message-ID: <987130b3079d4afcbe67b04627e619a1@huawei.com>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-14-shiju.jose@huawei.com>
 <827fe047-a456-48b4-9db1-d28c184b9cb3@intel.com>
In-Reply-To: <827fe047-a456-48b4-9db1-d28c184b9cb3@intel.com>
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

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBEYXZlIEppYW5nIDxkYXZlLmpp
YW5nQGludGVsLmNvbT4NCj5TZW50OiAwNSBOb3ZlbWJlciAyMDI0IDIwOjMyDQo+VG86IFNoaWp1
IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT47IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj5jeGxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
Q2M6IGJwQGFsaWVuOC5kZTsgdG9ueS5sdWNrQGludGVsLmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7
IGxlbmJAa2VybmVsLm9yZzsNCj5tY2hlaGFiQGtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGlu
dGVsLmNvbTsgZGF2ZUBzdGdvbGFicy5uZXQ7IEpvbmF0aGFuDQo+Q2FtZXJvbiA8am9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+c3VkZWVw
LmhvbGxhQGFybS5jb207IGphc3Npc2luZ2hicmFyQGdtYWlsLmNvbTsgYWxpc29uLnNjaG9maWVs
ZEBpbnRlbC5jb207DQo+dmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBpcmEud2VpbnlAaW50ZWwu
Y29tOyBkYXZpZEByZWRoYXQuY29tOw0KPlZpbGFzLlNyaWRoYXJhbkBhbWQuY29tOyBsZW8uZHVy
YW5AYW1kLmNvbTsgWWF6ZW4uR2hhbm5hbUBhbWQuY29tOw0KPnJpZW50amVzQGdvb2dsZS5jb207
IGppYXFpeWFuQGdvb2dsZS5jb207IEpvbi5HcmltbUBhbWQuY29tOw0KPmRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbTsgbmFveWEuaG9yaWd1Y2hpQG5lYy5jb207DQo+amFtZXMubW9yc2VAYXJt
LmNvbTsganRob3VnaHRvbkBnb29nbGUuY29tOyBzb21hc3VuZGFyYW0uYUBocGUuY29tOw0KPmVy
ZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207IGR1ZW53ZW5AZ29vZ2xlLmNv
bTsNCj5ndGhlbGVuQGdvb2dsZS5jb207IHdzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcuY29tOw0K
PmRmZXJndXNvbkBhbXBlcmVjb21wdXRpbmcuY29tOyB3YnNAb3MuYW1wZXJlY29tcHV0aW5nLmNv
bTsNCj5uaWZhbi5jeGxAZ21haWwuY29tOyB0YW54aWFvZmVpIDx0YW54aWFvZmVpQGh1YXdlaS5j
b20+OyBaZW5ndGFvIChCKQ0KPjxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2JlcnRvIFNh
c3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ow0KPmthbmdrYW5nLnNoZW5AZnV0dXJld2Vp
LmNvbTsgd2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47DQo+TGludXhhcm0g
PGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MTUgMTMvMTVdIGN4
bC9tZW1mZWF0dXJlOiBBZGQgQ1hMIG1lbW9yeSBkZXZpY2Ugc1BQUg0KPmNvbnRyb2wgZmVhdHVy
ZQ0KPg0KPg0KPg0KPk9uIDExLzEvMjQgMjoxNyBBTSwgc2hpanUuam9zZUBodWF3ZWkuY29tIHdy
b3RlOg0KPj4gRnJvbTogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPj4NCj4+
IFBvc3QgUGFja2FnZSBSZXBhaXIgKFBQUikgbWFpbnRlbmFuY2Ugb3BlcmF0aW9ucyBtYXkgYmUg
c3VwcG9ydGVkIGJ5DQo+PiBDWEwgZGV2aWNlcyB0aGF0IGltcGxlbWVudCBDWEwubWVtIHByb3Rv
Y29sLiBBIFBQUiBtYWludGVuYW5jZQ0KPj4gb3BlcmF0aW9uIHJlcXVlc3RzIHRoZSBDWEwgZGV2
aWNlIHRvIHBlcmZvcm0gYSByZXBhaXIgb3BlcmF0aW9uIG9uIGl0cyBtZWRpYS4NCj4+IEZvciBl
eGFtcGxlLCBhIENYTCBkZXZpY2Ugd2l0aCBEUkFNIGNvbXBvbmVudHMgdGhhdCBzdXBwb3J0IFBQ
Ug0KPj4gZmVhdHVyZXMgbWF5IGltcGxlbWVudCBQUFIgTWFpbnRlbmFuY2Ugb3BlcmF0aW9ucy4g
RFJBTSBjb21wb25lbnRzDQo+bWF5DQo+PiBzdXBwb3J0IHR3byB0eXBlcyBvZiBQUFI6IEhhcmQg
UFBSIChoUFBSKSwgZm9yIGEgcGVybWFuZW50IHJvdyByZXBhaXIsDQo+PiBhbmQgU29mdCBQUFIg
KHNQUFIpLCBmb3IgYSB0ZW1wb3Jhcnkgcm93IHJlcGFpci4gc1BQUiBpcyBtdWNoIGZhc3Rlcg0K
Pj4gdGhhbiBoUFBSLCBidXQgdGhlIHJlcGFpciBpcyBsb3N0IHdpdGggYSBwb3dlciBjeWNsZS4N
Cj4+DQpbLi4uXQ0KPj4gK2VudW0gY3hsX3Bwcl9wYXJhbSB7DQo+PiArCUNYTF9QUFJfUEFSQU1f
RE9fUVVFUlksDQo+PiArCUNYTF9QUFJfUEFSQU1fRE9fUFBSLA0KPj4gK307DQo+PiArDQo+PiAr
LyogU2VlIENYTCByZXYgMy4xIEA4LjIuOS43LjIuMSBUYWJsZSA4LTExMyBzUFBSIEZlYXR1cmUg
UmVhZGFibGUNCj4+ICtBdHRyaWJ1dGVzICovDQo+PiArLyogU2VlIENYTCByZXYgMy4xIEA4LjIu
OS43LjIuMiBUYWJsZSA4LTExNiBoUFBSIEZlYXR1cmUgUmVhZGFibGUNCj5BdHRyaWJ1dGVzICov
DQo+PiArI2RlZmluZQlDWExfTUVNREVWX1BQUl9RVUVSWV9SRVNPVVJDRV9GTEFHIEJJVCgwKQ0K
Pg0KPkFyZSBhbGwgdGhlIGV4dHJhIHNwYWNlcyBhZnRlciAjZGVmaW5lIGludGVuZGVkPw0KDQpG
aXhlZC4NCj4NCj5ESg0KPg0KPj4gKw0KPj4gKyNkZWZpbmUgQ1hMX01FTURFVl9QUFJfREVWSUNF
X0lOSVRJQVRFRF9NQVNLIEJJVCgwKSAjZGVmaW5lDQpbLi4uXQ0KPj4gK2ZlYXRfc3Bwcl9kb25l
Og0KPj4gIAlyZXR1cm4gZWRhY19kZXZfcmVnaXN0ZXIoJmN4bG1kLT5kZXYsIGN4bF9kZXZfbmFt
ZSwgTlVMTCwNCj4+ICAJCQkJIG51bV9yYXNfZmVhdHVyZXMsIHJhc19mZWF0dXJlcyk7ICB9DQo+
DQoNClRoYW5rcywNClNoaWp1DQo=

