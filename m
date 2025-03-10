Return-Path: <linux-edac+bounces-3338-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACECA597CE
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 15:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4914D188FA1D
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A722D7B9;
	Mon, 10 Mar 2025 14:36:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94019004A;
	Mon, 10 Mar 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617381; cv=none; b=jCQIdHCM96vry13nZ1i3v7kSPH4doC1qu6QJTQwfYPe5+UgJ7dUvZGQGp9itD6OTKxJ8MyvFZga+h/o4V4RxIJXzY7obTIoTOu98o9uqnsvTYQl1pxzyple0SuFbDMseLKWnxXW+2APA5tAJg3K6m+jxFffdvlec4gNsDzQDeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617381; c=relaxed/simple;
	bh=PPUAW324s9FnCWnqHp2rvkUmA0he9McwMTCRN9udlbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVuKrjla/JnjiC7qwXK/yHsXI3yPO7EBFxj7DqCO6e15y4EYbRPY0gKUDzqPolYCNUw0f9UWjagZ6Wjlech5jJJdJioHkwlGI+G/qKxeOtriwi/7QWIbtuIpeN6b8Ry9wdXq7arm3QSqLoyNTkOvK9U4kaTRYvwFbEYYOHGdto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBKBF0Zcqz6H7Ym;
	Mon, 10 Mar 2025 22:33:09 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 763A5140CB9;
	Mon, 10 Mar 2025 22:36:14 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Mar 2025 15:36:14 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 10 Mar 2025 15:36:14 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: RE: [PATCH v2 3/3] ras: mem: Add memory ACPI RAS2 driver
Thread-Topic: [PATCH v2 3/3] ras: mem: Add memory ACPI RAS2 driver
Thread-Index: AQHbjfjWvkdDRJ1spk2t3VxaCsibfrNoKYKAgAQFsPCAAEZGcA==
Date: Mon, 10 Mar 2025 14:36:14 +0000
Message-ID: <b6be7c698cd04f7d8a93f74693e9436a@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
 <20250305180225.1226-4-shiju.jose@huawei.com>
 <0d9066de-769a-44d0-bece-26f1313ce006@os.amperecomputing.com>
 <85e788be5df3483082744a8904560979@huawei.com>
In-Reply-To: <85e788be5df3483082744a8904560979@huawei.com>
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU2hpanUgSm9zZQ0KPlNlbnQ6IDEw
IE1hcmNoIDIwMjUgMTE6MTINCj5UbzogJ0RhbmllbCBGZXJndXNvbicgPGRhbmllbGZAb3MuYW1w
ZXJlY29tcHV0aW5nLmNvbT47IGxpbnV4LQ0KPmVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
Y3BpQHZnZXIua2VybmVsLm9yZzsgYnBAYWxpZW44LmRlOw0KPnRvbnkubHVja0BpbnRlbC5jb207
IHJhZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7DQo+bWNoZWhhYkBrZXJuZWwub3Jn
OyBsZW8uZHVyYW5AYW1kLmNvbTsgWWF6ZW4uR2hhbm5hbUBhbWQuY29tDQo+Q2M6IGxpbnV4LWN4
bEB2Z2VyLmtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgZGF2ZUBzdGdvbGFi
cy5uZXQ7DQo+Sm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsg
ZGF2ZS5qaWFuZ0BpbnRlbC5jb207DQo+YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbTsgaXJhLndlaW55QGludGVsLmNvbTsNCj5kYXZpZEByZWRoYXQu
Y29tOyBWaWxhcy5TcmlkaGFyYW5AYW1kLmNvbTsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC0N
Cj5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyByaWVudGplc0Bnb29nbGUuY29tOyBqaWFxaXlhbkBn
b29nbGUuY29tOw0KPkpvbi5HcmltbUBhbWQuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5j
b207DQo+bmFveWEuaG9yaWd1Y2hpQG5lYy5jb207IGphbWVzLm1vcnNlQGFybS5jb207IGp0aG91
Z2h0b25AZ29vZ2xlLmNvbTsNCj5zb21hc3VuZGFyYW0uYUBocGUuY29tOyBlcmRlbWFrdGFzQGdv
b2dsZS5jb207IHBnb25kYUBnb29nbGUuY29tOw0KPmR1ZW53ZW5AZ29vZ2xlLmNvbTsgZ3RoZWxl
bkBnb29nbGUuY29tOw0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcuY29tOyBkZmVyZ3Vzb25A
YW1wZXJlY29tcHV0aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgbmlmYW4u
Y3hsQGdtYWlsLmNvbTsgdGFueGlhb2ZlaQ0KPjx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5n
dGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgUm9iZXJ0bw0KPlNhc3N1IDxyb2Jl
cnRvLnNhc3N1QGh1YXdlaS5jb20+OyBrYW5na2FuZy5zaGVuQGZ1dHVyZXdlaS5jb207DQo+d2Fu
Z2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IExpbnV4YXJtDQo+PGxpbnV4YXJt
QGh1YXdlaS5jb20+DQo+U3ViamVjdDogUkU6IFtQQVRDSCB2MiAzLzNdIHJhczogbWVtOiBBZGQg
bWVtb3J5IEFDUEkgUkFTMiBkcml2ZXINCj4NCj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4+RnJvbTogRGFuaWVsIEZlcmd1c29uIDxkYW5pZWxmQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+
DQo+PlNlbnQ6IDA3IE1hcmNoIDIwMjUgMjE6NTINCj4+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpv
c2VAaHVhd2VpLmNvbT47IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOw0KPj5saW51eC0gYWNw
aUB2Z2VyLmtlcm5lbC5vcmc7IGJwQGFsaWVuOC5kZTsgdG9ueS5sdWNrQGludGVsLmNvbTsNCj4+
cmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsgbWNoZWhhYkBrZXJuZWwub3JnOw0K
Pj5sZW8uZHVyYW5AYW1kLmNvbTsgWWF6ZW4uR2hhbm5hbUBhbWQuY29tDQo+PkNjOiBsaW51eC1j
eGxAdmdlci5rZXJuZWwub3JnOyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207DQo+PmRhdmVAc3Rn
b2xhYnMubmV0OyBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
Ow0KPj5kYXZlLmppYW5nQGludGVsLmNvbTsgYWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207DQo+
PnZpc2hhbC5sLnZlcm1hQGludGVsLmNvbTsgaXJhLndlaW55QGludGVsLmNvbTsgZGF2aWRAcmVk
aGF0LmNvbTsNCj4+VmlsYXMuU3JpZGhhcmFuQGFtZC5jb207IGxpbnV4LW1tQGt2YWNrLm9yZzsg
bGludXgtDQo+Pmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJpZW50amVzQGdvb2dsZS5jb207IGpp
YXFpeWFuQGdvb2dsZS5jb207DQo+Pkpvbi5HcmltbUBhbWQuY29tOyBkYXZlLmhhbnNlbkBsaW51
eC5pbnRlbC5jb207DQo+Pm5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1lcy5tb3JzZUBhcm0u
Y29tOyBqdGhvdWdodG9uQGdvb2dsZS5jb207DQo+PnNvbWFzdW5kYXJhbS5hQGhwZS5jb207IGVy
ZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207DQo+PmR1ZW53ZW5AZ29vZ2xl
LmNvbTsgZ3RoZWxlbkBnb29nbGUuY29tOw0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcuY29t
Ow0KPj5kZmVyZ3Vzb25AYW1wZXJlY29tcHV0aW5nLmNvbTsgd2JzQG9zLmFtcGVyZWNvbXB1dGlu
Zy5jb207DQo+Pm5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkgPHRhbnhpYW9mZWlAaHVh
d2VpLmNvbT47IFplbmd0YW8gKEIpDQo+PjxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2Jl
cnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ow0KPj5rYW5na2FuZy5zaGVuQGZ1
dHVyZXdlaS5jb207IHdhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+Ow0KPj5M
aW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAz
LzNdIHJhczogbWVtOiBBZGQgbWVtb3J5IEFDUEkgUkFTMiBkcml2ZXINCj4+DQo+Pg0KPj4+ICtz
dGF0aWMgaW50IHJhczJfaHdfc2NydWJfcmVhZF9zaXplKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9p
ZA0KPj4+ICsqZHJ2X2RhdGEsIHU2NCAqc2l6ZSkgew0KPj4+ICsJc3RydWN0IHJhczJfbWVtX2N0
eCAqcmFzMl9jdHggPSBkcnZfZGF0YTsNCj4+PiArCWludCByZXQ7DQo+Pj4gKw0KPj4+ICsJaWYg
KHJhczJfY3R4LT5iZ19zY3J1YikNCj4+PiArCQlyZXR1cm4gLUVCVVNZOw0KPj4+ICsNCj4+PiAr
CXJldCA9IHJhczJfdXBkYXRlX3BhdHJvbF9zY3J1Yl9wYXJhbXNfY2FjaGUocmFzMl9jdHgpOw0K
Pj4+ICsJaWYgKHJldCkNCj4+PiArCQlyZXR1cm4gcmV0Ow0KPj4+ICsNCj4+PiArCSpzaXplID0g
cmFzMl9jdHgtPnNpemU7DQo+Pj4gKw0KPj4+ICsJcmV0dXJuIDA7DQo+Pj4gK30NCj4+DQo+PkNh
bGxpbmcgcmFzMl91cGRhdGVfcGF0cm9sX3NjcnViX3BhcmFtc19jYWNoZSBoZXJlIGlzIHByb2Js
ZW1hdGljLg0KPj4NCj4+SW1hZ2luZToNCj4+ICBlY2hvIDB4MTAwMCA+IHNpemUNCj4+ICBjYXQg
c2l6ZQ0KPj4gIGVjaG8gMHgyMDAwMDAwMDAwID4gYWRkcg0KPj4NCj4+V2hhdCBoYXBwZW5zIGhl
cmU/IFdoYXQgaGFwcGVucyBpcyB0aGUgc2NydWIgcmFuZ2UgaXMgbm90IHdoYXQgeW91DQo+PmV4
cGVjdCBpdCB0byBiZS4gIE9uY2UgeW91IGNhdCBzaXplLCB5b3UgcmVzZXQgdGhlIHNpemUgZnJv
bSB3aGF0IHlvdSBpbml0aWFsbHkgc2V0DQo+aXQgdG8uDQo+PkkgZG9uJ3QgdGhpbmsgdGhhdCBp
cyB3aGF0IGFueW9uZSB3aWxsIGV4cGVjdC4gSXQgY2VydGFpbmx5IGNhdXNlZCB1cw0KPj50byBz
dHVtYmxlIHdoaWxlIHRlc3RpbmcuDQo+DQo+VGhpcyBpcyBhbiBleHBlY3RlZCBiZWhhdmlvciBh
bmQgdGhpcyBleHRyYSBjYWxsIHdhcyBhZGRlZCBoZXJlIHdoZW4gY2hhbmdlZA0KPnVzaW5nIGF0
dHJpYnV0ZSAnYWRkcicgdG8gc3RhcnQgdGhlIG9uLWRlbWFuZCAgc2NydWIgb3BlcmF0aW9uIGlu
c3RlYWQgb2YNCj5wcmV2aW91cyBzZXBhcmF0ZSBhdHRyaWJ1dGUgJyBlbmFibGVfb25fZGVtYW5k
JyB0byBzdGFydCB0aGUgb24tZGVtYW5kIHNjcnViDQo+b3BlcmF0aW9uLCBhY2NvcmRpbmcgdG8g
Qm9yaXNsYXYncyBzdWdnZXN0aW9uIGluIHYxMy4NCj4NCj4gUGxlYXNlIHNlZSB0aGUgZm9sbG93
aW5nIGNvbW1lbnQgaW4gdGhlIHJhczJfaHdfc2NydWJfcmVhZF9hZGRyKCkgZm5jdGlvbiwNCj4i
VXNlcnNwYWNlIHdpbGwgZ2V0IHRoZSBzdGF0dXMgb2YgdGhlIGRlbWFuZCBzY3J1YmJpbmcgdGhy
b3VnaCB0aGUgYWRkcmVzcw0KPnJhbmdlIHJlYWQgZnJvbSB0aGUgZmlybXdhcmUuIFdoZW4gdGhl
IGRlbWFuZCBzY3J1YmJpbmcgaXMgZmluaXNoZWQNCj5maXJtd2FyZSBtdXN0IHJlc2V0IGFjdHVh
bCBhZGRyZXNzIHJhbmdlIHRvIDAuIE90aGVyd2lzZSB1c2Vyc3BhY2UgYXNzdW1lcw0KPmRlbWFu
ZCBzY3J1YmJpbmcgaXMgaW4gcHJvZ3Jlc3MuIg0KPg0KPkhlcmUgc3lzZnMgYXR0cmlidXRlcyAn
YWRkcicgYW5kICdzaXplJyBpcyByZWFkaW5nIHRoZSBmaWVsZDogQWN0dWFsIEFkZHJlc3MgUmFu
Z2UNCj5vZiBUYWJsZSA1Ljg3OiBQYXJhbWV0ZXIgQmxvY2sgU3RydWN0dXJlIGZvciBQQVRST0xf
U0NSVUIsIHdyaXR0ZW4gYnkgdGhlDQo+ZmlybXdhcmUuDQo+DQo+SW4gbXkgb3BpbmlvbiwgcmVh
ZGluZyBiYWNrIHRoZSBhZGRyZXNzIHJhbmdlIHNpemUgc2V0IGluIHRoZSBzeXNmcyBiZWZvcmUN
Cj5hY3R1YWxseSB3cml0aW5nIHRoZSBhZGRyZXNzIHJhbmdlIHRvIHRoZSBmaXJtd2FyZSBhbmQg
c3RhcnRpbmcgdGhlIG9uLWRlbWFuZA0KPnNjcnViIG9wZXJhdGlvbiBkb2Vzbid0IGhvbGQgbXVj
aCBzaWduaWZpY2FuY2U/DQoNCkFmdGVyIGZ1cnRoZXIgZGlzY3Vzc2lvbiwgSSB3aWxsIGFkZCBh
IGZpeCBmb3IgdGhpcyBjYXNlIHRvIHJldHVybiB0aGUgJ3NpemUnIHdoaWNoIHRoZSB1c2VyIHNl
dCBpbiB0aGUgc3lzZnMNCnVudGlsIHRoZSBzY3J1YmJpbmcgaXMgc3RhcnRlZC4NCg0KVGhhbmtz
LA0KU2hpanUgDQo+DQoNCg==

