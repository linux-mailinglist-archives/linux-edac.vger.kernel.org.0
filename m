Return-Path: <linux-edac+bounces-3946-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3DAABC9FD
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 23:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293BD7A41ED
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D256821E082;
	Mon, 19 May 2025 21:34:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621377104;
	Mon, 19 May 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690461; cv=none; b=hKu6Ghxr3uJZhiUxFMiFZEbHe8wPVRQKmOvvY6L+82IeOzUTZdR+89yLuiuit3VfYpeSpmj1E+ReAku0ZZCkuMy2d6zzsUWInkSqNkzHnpJSTccwWiJ4k5TdIa0eLdCrd61vQN+7t2yqtVYHsM1wk1770eqos7zYaBFT2NjzYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690461; c=relaxed/simple;
	bh=yOn5n3bqLp4P2nGPgfuCcY+cXv8UrFJk24JwgT6CwoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wc3VuZMO+4xWLCbnRSLPK1DXpfCLJM/g4Smy3HAYTK/CqGV+xMjMTX3daEITnZvmb789hWpbF9G2Lh1RJtwzsMzClBoUBmUdEi7/5WrU+jCAAxHLqnyvS2/TAEqFq4fHxMk6lGf1pOYLQ3Wli4yOEmmurEISVBJMQKcnAmxGLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1WBs2bCyz6K9qy;
	Tue, 20 May 2025 05:33:25 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C572214010C;
	Tue, 20 May 2025 05:34:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 May 2025 23:34:13 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 19 May 2025 23:34:13 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "nifan.cxl@gmail.com"
	<nifan.cxl@gmail.com>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v5 7/8] cxl/edac: Add CXL memory device memory sparing
 control feature
Thread-Topic: [PATCH v5 7/8] cxl/edac: Add CXL memory device memory sparing
 control feature
Thread-Index: AQHbxZDhUCMGzgandE+3fZ/ERQvSs7PaVbGAgAAD9ACAACKbkA==
Date: Mon, 19 May 2025 21:34:13 +0000
Message-ID: <a4d67defc88a4c03b88a1a5e9c7f9954@huawei.com>
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-8-shiju.jose@huawei.com>
 <aCucI3TPynSycGug@aschofie-mobl2.lan>
 <43de25e8-cbce-43f5-931d-3b9edc3f45eb@intel.com>
In-Reply-To: <43de25e8-cbce-43f5-931d-3b9edc3f45eb@intel.com>
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
Z0BpbnRlbC5jb20+DQo+U2VudDogMTkgTWF5IDIwMjUgMjI6MTYNCj5UbzogQWxpc29uIFNjaG9m
aWVsZCA8YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb20+OyBTaGlqdSBKb3NlDQo+PHNoaWp1Lmpv
c2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tOyBKb25hdGhhbiBDYW1lcm9uDQo+PGpvbmF0aGFuLmNhbWVyb25AaHVh
d2VpLmNvbT47IGRhdmVAc3Rnb2xhYnMubmV0Ow0KPnZpc2hhbC5sLnZlcm1hQGludGVsLmNvbTsg
aXJhLndlaW55QGludGVsLmNvbTsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgt
ZG9jQHZnZXIua2VybmVsLm9yZzsgYnBAYWxpZW44LmRlOyB0b255Lmx1Y2tAaW50ZWwuY29tOw0K
PmxlbmJAa2VybmVsLm9yZzsgWWF6ZW4uR2hhbm5hbUBhbWQuY29tOyBtY2hlaGFiQGtlcm5lbC5v
cmc7DQo+bmlmYW4uY3hsQGdtYWlsLmNvbTsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+
OyB0YW54aWFvZmVpDQo+PHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpIDxwcmlt
ZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2JlcnRvDQo+U2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVh
d2VpLmNvbT47IGthbmdrYW5nLnNoZW5AZnV0dXJld2VpLmNvbTsNCj53YW5naHVpcWlhbmcgPHdh
bmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNy84XSBjeGwv
ZWRhYzogQWRkIENYTCBtZW1vcnkgZGV2aWNlIG1lbW9yeSBzcGFyaW5nDQo+Y29udHJvbCBmZWF0
dXJlDQo+DQo+DQo+DQo+T24gNS8xOS8yNSAyOjAxIFBNLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPj4gT24gVGh1LCBNYXkgMTUsIDIwMjUgYXQgMTI6NTk6MjNQTSArMDEwMCwgc2hpanUuam9z
ZUBodWF3ZWkuY29tIHdyb3RlOg0KPj4+IEZyb206IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVh
d2VpLmNvbT4NCj4+Pg0KPj4NCj4+IHNuaXANCj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3hsL2NvcmUvZWRhYy5jIGIvZHJpdmVycy9jeGwvY29yZS9lZGFjLmMgaW5kZXgNCj4+PiA0ODlj
OTk5NmJmYmMuLjM5NWQ1NjQ1NzkzMSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2N4bC9jb3Jl
L2VkYWMuYw0KPj4+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvZWRhYy5jDQo+Pj4gQEAgLTIxLDcg
KzIxLDE3IEBADQo+Pj4gICNpbmNsdWRlICJjb3JlLmgiDQo+Pj4gICNpbmNsdWRlICJ0cmFjZS5o
Ig0KPj4+DQo+Pj4gLSNkZWZpbmUgQ1hMX05SX0VEQUNfREVWX0ZFQVRVUkVTIDINCj4+PiArI2Rl
ZmluZSBDWExfTlJfRURBQ19ERVZfRkVBVFVSRVMgNg0KPj4+ICsNCj4+PiArc3RhdGljIGJvb2wg
Y3hsX2lzX21lbWRldl9tZW1vcnlfb25saW5lKGNvbnN0IHN0cnVjdCBjeGxfbWVtZGV2DQo+Pj4g
KypjeGxtZCkgew0KPj4+ICsJc3RydWN0IGN4bF9wb3J0ICpwb3J0ID0gY3hsbWQtPmVuZHBvaW50
Ow0KPj4+ICsNCj4+PiArCWlmIChwb3J0ICYmIGN4bF9udW1fZGVjb2RlcnNfY29tbWl0dGVkKHBv
cnQpKQ0KPj4+ICsJCXJldHVybiB0cnVlOw0KPj4+ICsNCj4+PiArCXJldHVybiBmYWxzZTsNCj4+
PiArfQ0KPj4+DQo+Pg0KPj4gTG9va3MgbGlrZSBhYm92ZSBmY24gbmVlZHMgdG8gYmUgaW5zaWRl
IHRoZSBiZWxvdyAjaWZkZWYuDQo+PiBTbWF0Y2ggaXMgd2FybmluZyB0aGlzIHdoZW4gRURBQ19T
Q1JVQiBpcyBvZmYNClRoaXMgd2FybmluZyBpcyB3aXRoICdFREFDX01FTV9SRVBBSVInIGlzIG9m
Zi4NCiAgDQo+Pg0KPj4gZHJpdmVycy9jeGwvY29yZS9lZGFjLmM6Mjc6MTM6IHdhcm5pbmc6IOKA
mGN4bF9pc19tZW1kZXZfbWVtb3J5X29ubGluZeKAmQ0KPmRlZmluZWQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1mdW5jdGlvbl0NCj4+ICAgIDI3IHwgc3RhdGljIGJvb2wgY3hsX2lzX21lbWRldl9t
ZW1vcnlfb25saW5lKGNvbnN0IHN0cnVjdA0KPj4gY3hsX21lbWRldiAqY3hsbWQpDQo+Pg0KPj4N
Cj4+PiAgI2lmZGVmIENPTkZJR19DWExfRURBQ19TQ1JVQg0KPg0KPkkgdGhpbmsgdGhlIGZ1bmN0
aW9uIGNhbiBiZSBtb3ZlZCB0byBhYm92ZSBjeGxfbWVtX3BlcmZvcm1fc3BhcmluZygpIGFzIHRo
YXQNCj5pcyB0aGUgb25seSBmdW5jdGlvbiB0aGF0IGNhbGxzIGl0LiBJJ2xsIGRvIHRoYXQgd2hl
biBJIGFwcGx5IGlmIHRoZXJlJ3Mgbm90aGluZyBlbHNlDQo+bWFqb3IgbmVlZCB0byBiZSBjaGFu
Z2VkLg0KDQpZZXMuIE1vdmluZyB1bmRlciAgIiNpZmRlZiBDT05GSUdfQ1hMX0VEQUNfTUVNX1JF
UEFJUiIgd2hpY2ggaXMgcHJlc2VudA0KYXQgdGhlIHN0YXJ0IG9mIG1lbW9yeSByZXBhaXIgZmVh
dHVyZXMsIHNvbHZlZCAgdGhpcyB3YXJuaW5nLiANClByZXNlbnRseSAnY3hsX2lzX21lbWRldl9t
ZW1vcnlfb25saW5lJyBpcyB1c2VkIGluICBjeGxfbWVtX3BlcmZvcm1fc3BhcmluZygpIGFuZCAN
CmN4bF9tZW1fcGVyZm9ybV9wcHIoKSBvbmx5IHRob3VnaCBJIHRob3VnaHQgaXQgd2lsbCBiZSB1
c2VkIGluIG90aGVyIHBhcnRzIG9mIHRoZSBDWEwgY29kZS4NCg0KPg0KPkRKDQo+DQo+DQo+Pg0K
Pj4gc25pcCB0byBlbmQuDQo+Pg0KPg0KDQpUaGFua3MsDQpTaGlqdQ0K

