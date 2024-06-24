Return-Path: <linux-edac+bounces-1354-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B9C91510F
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0547C1F25E75
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57019ADB5;
	Mon, 24 Jun 2024 14:52:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9AC19CCEB
	for <linux-edac@vger.kernel.org>; Mon, 24 Jun 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240749; cv=none; b=jJ3aFjyiiAZEDsaS/zYjHTr+K2aPJrdOOVpm8xhkekrqdGw9kmnlO5yVjThdzbWQiNmDfjbM6h3kzbGf1NDDY6rgYSWFnHOKcXAyrW3Gfn+f6vY7XVkyT4m6w4dNappc14dk77N9mYwLzW87MjBfGsq/4o3pwSHIBWMis7sNuy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240749; c=relaxed/simple;
	bh=gXxfR+/uiA/s4zu2qUqd9iJ4u93k4jbuIY1Aum8FWas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JroXPjglu81dAlR3vEUEgx/A22xiE9VF6XRUZWR2QZucGzZGQKD25F7jBXxb4wki1j4wPTlDRqCkbVQACJDADbs5mfyar1OPwlwmiNrDptBQhStIR4G4NpPBFDwVCk5/vXI7fqYX5FcRwK4Cm+BYgAbYDbTpFyzFwJoGfEF2J/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W79qy1gFmz6K9c9;
	Mon, 24 Jun 2024 22:50:38 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 40935140517;
	Mon, 24 Jun 2024 22:52:17 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 15:52:16 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Mon, 24 Jun 2024 15:52:16 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "mchehab+huawei@kernel.org"
	<mchehab+huawei@kernel.org>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
Thread-Topic: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
Thread-Index: AQHaw/tJLIq1TYj6SUerz3Wdqaz/XbHW4WwAgAAhxoA=
Date: Mon, 24 Jun 2024 14:52:16 +0000
Message-ID: <3becac0608344c9d853f0658902f1753@huawei.com>
References: <20240621165115.336-1-shiju.jose@huawei.com>
 <CAFEAcA9CQ_D168MmD+VbQsegUVsJuiXBP64oH0SgL=bD8EDJOA@mail.gmail.com>
In-Reply-To: <CAFEAcA9CQ_D168MmD+VbQsegUVsJuiXBP64oH0SgL=bD8EDJOA@mail.gmail.com>
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

VGhhbmtzIFBldGVyIGZvciB0aGUgdmFsdWFibGUgY29tbWVudHMuIA0KDQo+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+DQo+U2VudDogMjQgSnVuZSAyMDI0IDE0OjQ4DQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1
Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBsaW51eC1lZGFj
QHZnZXIua2VybmVsLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPjxqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb20+OyBtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnOyB0YW54aWFvZmVpDQo+PHRhbnhp
YW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+
OyBMaW51eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUkZDIFBB
VENIIDEvMV0gaHcvYXJtOiBGVyBmaXJzdCBBUk0gcHJvY2Vzc29yIGVycm9yIGluamVjdGlvbi4N
Cj4NCj5PbiBGcmksIDIxIEp1biAyMDI0IGF0IDE3OjUyLCBzaGlqdS5qb3NlLS0tIHZpYSA8cWVt
dS1kZXZlbEBub25nbnUub3JnPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBTaGlqdSBKb3NlIDxzaGlq
dS5qb3NlQGh1YXdlaS5jb20+DQo+Pg0KPg0KPg0KPg0KPj4gZGlmZiAtLWdpdCBhL2h3L2FybS9h
cm1fZXJyb3JfaW5qZWN0LmMgYi9ody9hcm0vYXJtX2Vycm9yX2luamVjdC5jIG5ldw0KPj4gZmls
ZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwLi45NTNhOWQ2NzA1DQo+PiAtLS0gL2Rldi9u
dWxsDQo+PiArKysgYi9ody9hcm0vYXJtX2Vycm9yX2luamVjdC5jDQo+PiBAQCAtMCwwICsxLDQ5
IEBADQo+PiArLyoNCj4+ICsgKiBDWEwgVHlwZSAzIChtZW1vcnkgZXhwYW5kZXIpIGRldmljZQ0K
Pg0KPlRoaXMgZG9lc24ndCBzZWVtIHRvIG1hdGNoIHdoYXQgdGhlIGZpbGUgYWN0dWFsbHkgZG9l
cy4NCg0KSSB3aWxsIHVwZGF0ZS4gDQo+DQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQoQykgMjAy
MCBJbnRlbCBDb3Jwb3JhdGlvbi4NCj4+ICsgKg0KPj4gKyAqIFRoaXMgd29yayBpcyBsaWNlbnNl
ZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHUEwsIHZlcnNpb24gMi4NCj4+ICsgU2VlIHRo
ZQ0KPj4gKyAqIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4+ICsg
Kg0KPj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtdjItb25seQ0KPg0KPldoeSBh
cmUgdGhlc2UgbmV3IGZpbGVzIEdQTC12Mi1vbmx5PyBPdXIgZ2VuZXJhbCBwcmVmZXJlbmNlIChz
ZWUgdGhlIExJQ0VOU0UpDQo+ZmlsZSBpcyBmb3IgR1BMLXYyLW9yLWFueS1sYXRlci12ZXJzaW9u
Lg0KPg0KPkkgYWxzbyBub3RpY2UgdGhhdCB0aGlzIGZpbGUgaXMgbWFya2VkIGFzIGNvcHlyaWdo
dCBJbnRlbCwgYnV0IHlvdSdyZSBzdWJtaXR0aW5nDQo+ZnJvbSBhIEh1YXdlaSBlbWFpbCBhZGRy
ZXNzLiAgV2hhdCdzIHRoZSBoaXN0b3J5IG9mIHRoaXMgY29kZT8NClRoYW5rcyBmb3IgcG9pbnRp
bmcgdGhpcyBlcnJvci4gDQpTdXJlIEkgd2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lvbi4gDQo+
DQo+PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+ICsjaW5jbHVk
ZSAicWVtdS91bml0cy5oIg0KPj4gKyNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPj4g
KyNpbmNsdWRlICJxYXBpLWNvbW1hbmRzLWFybS1lcnJvci1pbmplY3QuaCINCj4+ICsjaW5jbHVk
ZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQo+PiArI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4+
ICsjaW5jbHVkZSAicWVtdS9sb2cuaCINCj4+ICsjaW5jbHVkZSAicWVtdS9tb2R1bGUuaCINCj4+
ICsjaW5jbHVkZSAicWVtdS9wbWVtLmgiDQo+PiArI2luY2x1ZGUgInFlbXUvcmFuZ2UuaCINCj4+
ICsjaW5jbHVkZSAicWVtdS9yY3UuaCINCj4+ICsjaW5jbHVkZSAicWVtdS9ndWVzdC1yYW5kb20u
aCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2hvc3RtZW0uaCINCj4+ICsjaW5jbHVkZSAic3lzZW11
L251bWEuaCINCj4+ICsjaW5jbHVkZSAiaHcvYm9hcmRzLmgiDQo+PiArI2luY2x1ZGUgImh3L2Fj
cGkvZ2hlcy5oIg0KPg0KPkxvb2tpbmcgYXQgdGhlIGNvZGUgaGVyZSBJJ20gcHJldHR5IHN1cmUg
eW91IGRvbid0IG5lZWQgYW55d2hlcmUgbmVhciBhbGwgb2YNCj50aGVzZSBpbmNsdWRlIGxpbmVz
Lg0KSSB3aWxsIGNoZWNrIHRoaXMgYW5kIGZpeC4NCj4NCj4+ICsNCj4+ICsjZGVmaW5lIERXT1JE
X0JZVEUgNA0KPg0KPlRoaXMgc2VlbXMgdG8gYmUgdW51c2VkLg0KTm90IHVzZWQuIEkgd2lsbCBk
ZWxldGUgdGhpcy4NCj4NCj50aGFua3MNCj4tLSBQTU0NCg0KVGhhbmtzLA0KU2hpanUNCg==

