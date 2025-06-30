Return-Path: <linux-edac+bounces-4282-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BDBAED774
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 10:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08D3174EE7
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DD23B63C;
	Mon, 30 Jun 2025 08:37:03 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAEC204C0C;
	Mon, 30 Jun 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272623; cv=none; b=Z4LkyeIn2HxM2TMITIMzwnINkw5/BrfV/ysCSjXEchlAeowIenHqDkgYD5I77L3cpAw33nDtSOnKDykh5r153iUPuDi02ZXE6OYFkk/e913wjRVc7B+2LqNQp8/wtOByFTdeXNC8Z3d0vXcFWj5JFhvGhmrlFveJOM0GqzvfPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272623; c=relaxed/simple;
	bh=hugCzUdA8K0FakHg83KjbSIgdfptm3/HWdSbl5gjyqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jsjVz3Iy+2icPr5XPO9N9Y4d9k9EhkC8GFTSk+4L5WQuuuXpf2JnKDqaTqGr5R/oadRiv5AX0t3f/yxwLgt92NSGzlaTlXHgC6EsgNfNKYhPEr/o9aeJybX6DfIAsmYLBMIuTB/4yltXQ7rtrhMJwjfMbVXe3nCXAC+enKJpeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bVzyR6vYLz6M4xZ;
	Mon, 30 Jun 2025 16:35:59 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 50A6A1402FC;
	Mon, 30 Jun 2025 16:36:52 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 10:36:52 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 10:36:51 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH v2 1/1] EDAC: Fix lockdep splat caused by edac features
 code
Thread-Topic: [PATCH v2 1/1] EDAC: Fix lockdep splat caused by edac features
 code
Thread-Index: AQHb5oMIRVWTBxb+4UCxmchjvCLvcLQYipCAgALbZSA=
Date: Mon, 30 Jun 2025 08:36:51 +0000
Message-ID: <20cced073d9b43ea907c21359bb77304@huawei.com>
References: <20250626101344.1726-1-shiju.jose@huawei.com>
 <20250628145433.GEaGACKVlsfyRegTw6@fat_crate.local>
In-Reply-To: <20250628145433.GEaGACKVlsfyRegTw6@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMjggSnVuZSAyMDI1IDE1OjU1DQo+VG86IFNoaWp1IEpvc2UgPHNo
aWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IHRv
bnkubHVja0BpbnRlbC5jb207IGxlbmJAa2VybmVsLm9yZzsNCj5sZW8uZHVyYW5AYW1kLmNvbTsg
WWF6ZW4uR2hhbm5hbUBhbWQuY29tOyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+ZGF2ZS5qaWFuZ0Bp
bnRlbC5jb207IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47
DQo+bGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5j
b20+OyB0YW54aWFvZmVpDQo+PHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpIDxw
cmltZS56ZW5nQGhpc2lsaWNvbi5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzFdIEVE
QUM6IEZpeCBsb2NrZGVwIHNwbGF0IGNhdXNlZCBieSBlZGFjIGZlYXR1cmVzDQo+Y29kZQ0KPg0K
Pk9uIFRodSwgSnVuIDI2LCAyMDI1IGF0IDExOjEzOjQ0QU0gKzAxMDAsIHNoaWp1Lmpvc2VAaHVh
d2VpLmNvbSB3cm90ZToNCj4+IEZyb206IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNv
bT4NCj4+DQo+PiBGaXggdGhlIGxvY2tkZXAgc3BsYXQgY2F1c2VkIGJ5IG1pc3Npbmcgc3lzZnNf
YXR0cl9pbml0KCkgY2FsbHMgZm9yDQo+PiB0aGUgcmVjZW50bHkgYWRkZWQgRURBQyBmZWF0dXJl
J3Mgc3lzZnMgYXR0cmlidXRlcy4NCj4+DQo+PiBJbiBsb2NrZGVwX2luaXRfbWFwX3R5cGUoKSwg
dGhlIGNoZWNrIGZvciB0aGUgbG9jay1jbGFzcyBrZXkgaWYNCj4+ICghc3RhdGljX29iaihrZXkp
ICYmICFpc19keW5hbWljX2tleShrZXkpKSBjYXVzZXMgdGhlIHNwbGF0Lg0KPj4NCj4+IEJhY2t0
cmFjZToNCj4+IFJJUDogMDAxMDpsb2NrZGVwX2luaXRfbWFwX3R5cGUrMHgxMzEvMHgyNzANCj4+
IENhbGwgVHJhY2U6DQo+PiAgX19rZXJuZnNfY3JlYXRlX2ZpbGUrMHg3Ny8weGYwDQo+PiBzeXNm
c19hZGRfZmlsZV9tb2RlX25zKzB4ODYvMHgxNDANCj4+IGludGVybmFsX2NyZWF0ZV9ncm91cCsw
eDFjYy8weDRiMA0KPj4gaW50ZXJuYWxfY3JlYXRlX2dyb3VwcysweDQyLzB4YTANCj4+IGRldmlj
ZV9hZGQrMHgzMTAvMHg4NjANCj4+ID8gX19pbml0X3dhaXRxdWV1ZV9oZWFkKzB4NGEvMHg2MA0K
Pj4gZWRhY19kZXZfcmVnaXN0ZXIrMHgzZmYvMHg0ODANCj4+IGRldm1fY3hsX21lbWRldl9lZGFj
X3JlZ2lzdGVyKzB4NTA5LzB4NjQwIFtjeGxfY29yZV0gPw0KPj4gbG9ja19hY3F1aXJlKzB4YzQv
MHgyZDAgPyBmaW5kX2hlbGRfbG9jaysweDJiLzB4ODAgPw0KPj4gY3hsX21lbV9wcm9iZSsweDIx
ZS8weDM2MCBbY3hsX21lbV0gPyBjeGxfbWVtX3Byb2JlKzB4MjFlLzB4MzYwDQo+PiBbY3hsX21l
bV0gPyBsb2NrZGVwX2hhcmRpcnFzX29uKzB4NzgvMHgxMDAgPw0KPmN4bF9tZW1fcHJvYmUrMHgy
MjYvMHgzNjANCj4+IFtjeGxfbWVtXQ0KPj4gY3hsX21lbV9wcm9iZSsweDIyNi8weDM2MCBbY3hs
X21lbV0NCj4+DQo+PiBGaXhlczogZjkwYjczODE2NmZlICgiRURBQzogQWRkIHNjcnViIGNvbnRy
b2wgZmVhdHVyZSIpDQo+PiBGaXhlczogYmNiZDA2OWIxMWIwICgiRURBQzogQWRkIGEgRXJyb3Ig
Q2hlY2sgU2NydWIgY29udHJvbCBmZWF0dXJlIikNCj4+IEZpeGVzOiA2OTllYTUyMTljNGIgKCJF
REFDOiBBZGQgYSBtZW1vcnkgcmVwYWlyIGNvbnRyb2wgZmVhdHVyZSIpDQo+PiBSZXBvcnRlZC1i
eTogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IEpv
bmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj4NCj5BcHBsaWVkLCB0
aGFua3MuDQo+DQo+V2hpbGUgeW91J3JlIGhlcmU6IHBsZWFzZSBtYWtlIGFsbCB0aG9zZSBhdHRy
aWJ1dGVzIHN0YXRpYyBsaWtlIGluIHRoaXMgcGF0Y2g6DQo+DQo+aHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MDYyMDExNDEzNS40MDE3MTgzLTEtYXJuZEBrZXJuZWwub3JnDQo+DQo+d2hp
Y2ggSSd2ZSBhbHJlYWR5IGFwcGxpZWQgLSB5b3UgY2FuIGJhc2Ugc3R1ZmYgb250b3Agb2YgZWRh
Yy1mb3ItbmV4dC4NCg0KVGhhbmtzIEJvcmlzLg0KSSB3aWxsIGNoZWNrIGFuZCBtb2RpZnkgdGhl
IGF0dHJpYnV0ZXMgYXMgc3RhdGljLg0KDQpUaGFua3MsDQpTaGlqdQ0KDQo+DQo+VGh4Lg0KPg0K
Pi0tDQo+UmVnYXJkcy9HcnVzcywNCj4gICAgQm9yaXMuDQo+DQo+aHR0cHM6Ly9wZW9wbGUua2Vy
bmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg0K

