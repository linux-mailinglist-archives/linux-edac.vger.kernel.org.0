Return-Path: <linux-edac+bounces-4318-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062DBAF8EB9
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 11:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F45D1C42753
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610628BA9A;
	Fri,  4 Jul 2025 09:34:10 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEA19F43A
	for <linux-edac@vger.kernel.org>; Fri,  4 Jul 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621650; cv=none; b=umfhYnbWcKv0MauZ05PAIKeXHlGw7veLka3nI0L4qy2HzDsvoNtEeDr89yCtucJd4eKVe7qfU7mb2YOIx2OETeXhgeYjRJ5XjQjo6r6tJwulh6A/xMu0OacGRhyAaFUvWBCO0dZYz8tf17UPKQKxPEep3eDo0q8FPE04bimTKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621650; c=relaxed/simple;
	bh=4upNmiCKB5XehtmOcVD53p54lEA+IB0O/97j6lvY0xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9bsD/cxtSP0kwt07g/dTeALOKjkZecZkLdd1uFrb1g0g4thPe3TTr7pj0yY/mVt6yFwIouZN9I6nqA27cBuWJjLu6+gS0jHXzpdMls9dEg8fMiVhPCnoOr98C3y096WUtxgqH8WlCNqyCoOd6QxsiDm6opevw+tTZd5XWG2FNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYT0C4PCyz6L4sh;
	Fri,  4 Jul 2025 17:31:07 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
	by mail.maildlp.com (Postfix) with ESMTPS id 118601400D4;
	Fri,  4 Jul 2025 17:34:06 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Jul 2025 11:34:05 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 4 Jul 2025 11:34:05 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "arnd@kernel.org"
	<arnd@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>
Subject: RE: [RESEND PATCH v2 0/2] EDAC/features:  Reduce stack usage in
 create_desc functions
Thread-Topic: [RESEND PATCH v2 0/2] EDAC/features:  Reduce stack usage in
 create_desc functions
Thread-Index: AQHb7Kz4+s8ifLl3BU6SMA9VAIcTerQhkDkAgAAh6zA=
Date: Fri, 4 Jul 2025 09:34:05 +0000
Message-ID: <f98138d5f902423a8b1da2c230c38fac@huawei.com>
References: <20250704062911.1882-1-shiju.jose@huawei.com>
 <20250704092516.GAaGed_PnbpW5s1a5C@fat_crate.local>
In-Reply-To: <20250704092516.GAaGed_PnbpW5s1a5C@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMDQgSnVseSAyMDI1IDEwOjI1DQo+VG86IFNoaWp1IEpvc2UgPHNo
aWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IHRv
bnkubHVja0BpbnRlbC5jb207IGFybmRAa2VybmVsLm9yZzsNCj5tY2hlaGFiQGtlcm5lbC5vcmc7
IHJyaWNAa2VybmVsLm9yZzsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207IEpvbmF0aGFuDQo+Q2FtZXJv
biA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgTGludXhhcm0NCj48bGludXhhcm1AaHVh
d2VpLmNvbT47IHRhbnhpYW9mZWkgPHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIp
DQo+PHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT4NCj5TdWJqZWN0OiBSZTogW1JFU0VORCBQQVRD
SCB2MiAwLzJdIEVEQUMvZmVhdHVyZXM6IFJlZHVjZSBzdGFjayB1c2FnZSBpbg0KPmNyZWF0ZV9k
ZXNjIGZ1bmN0aW9ucw0KPg0KPk9uIEZyaSwgSnVsIDA0LCAyMDI1IGF0IDA3OjI5OjA5QU0gKzAx
MDAsIHNoaWp1Lmpvc2VAaHVhd2VpLmNvbSB3cm90ZToNCj4+IEZyb206IFNoaWp1IEpvc2UgPHNo
aWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj4+DQo+PiBDb25zdHJ1Y3RpbmcgYW4gYXJyYXkgb24gdGhl
IHN0YWNrIGNhbiBleGNlZWQgdGhlIHdhcm5pbmcgbGltaXQgZm9yDQo+PiBwZXItZnVuY3Rpb24g
c3RhY2sgdXNhZ2UuIFJlZHVjZSBwZXItZnVuY3Rpb24gc3RhY2sgdXNhZ2UgYnkgY2hhbmdpbmcN
Cj4+IHRvIGFuIGFjdHVhbCBhdHRyaWJ1dGUgYXJyYXkgYWxsb2NhdGVkIHN0YXRpY2FsbHkuDQo+
Pg0KPj4gQ2hhbmdlcw0KPj4gPT09PT09PQ0KPj4gdjEgLT4gdjI6DQo+PiAxLiBGaXggZm9yIHRo
ZSBlcnJvciByZXBvcnRlZCBieSB0aGUga2VybmVsIHRlc3Qgcm9ib3QuDQo+PiAgIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC0NCj5lZGFjL3BhdGNoLzIwMjUwNjMw
MTYyMDM0LjE3ODgtMy1zaGlqdS5qb3NlQGh1YXdlaS5jb20vIzI2NDUwNzM4Lg0KPg0KPldoeSBh
cmUgeW91IHJlc2VuZGluZyB0aGUgc2FtZSB0aGluZyAzIGRheXMgbGF0ZXI/DQoNCkFwb2xvZ2ll
cy4gRm91bmQgIHYyIG9mIHRoaXMgc2VyaWVzIGhhZCBjcmVhdGVkIGEgc2VwYXJhdGUgdGhyZWFk
IGJlY2F1c2Ugb2Ygc29tZSBwYXJ0IG9mIHRoZSBzdWJqZWN0IGluIHRoZSB2MiBjb3ZlciBsZXR0
ZXIgZ290IGRlbGV0ZWQgYnkgYWNjaWRlbnQuDQoNClRoYW5rcywNClNoaWp1DQo+DQo+LS0NCj5S
ZWdhcmRzL0dydXNzLA0KPiAgICBCb3Jpcy4NCj4NCj5odHRwczovL3Blb3BsZS5rZXJuZWwub3Jn
L3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0K

