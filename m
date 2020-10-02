Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73202281259
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgJBMXO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:23:14 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2941 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387945AbgJBMXL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:23:11 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 337293E6E24ECF53ACB4;
        Fri,  2 Oct 2020 13:23:09 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:23:08 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Fri, 2 Oct 2020 13:23:08 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate
 an erroneous CPU core
Thread-Topic: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate
 an erroneous CPU core
Thread-Index: AQHWgG1JK3/pxs0Hy0WMoA7NPJGN4qlT2awAgAxWxYCAAaMi4IAKtz4AgBaQpYCAAAQkAIABOIsA
Date:   Fri, 2 Oct 2020 12:23:08 +0000
Message-ID: <c18db7e0738d4895a4893ded1e6cd99a@huawei.com>
References: <20200901140140.1772-1-shiju.jose@huawei.com>
 <20200901143539.GC8392@zn.tnic> <512b7b8e6cb846aabaf5a2191cd9b5d4@huawei.com>
 <20200909120203.GB12237@zn.tnic>
 <50714e083d55491a8ccf5ad847682d1e@huawei.com>
 <20200917084038.GE31960@zn.tnic>
 <91e71fe9-b002-0f1f-3237-62cea49e083a@arm.com>
 <20201001173052.GH17683@zn.tnic>
In-Reply-To: <20201001173052.GH17683@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.84.119]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsIEhpIEphbWVzLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9t
OiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+U2VudDogMDEgT2N0b2Jl
ciAyMDIwIDE4OjMxDQo+VG86IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBhcm0uY29tPg0KPkNj
OiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBsaW51eC1lZGFjQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+YWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHRvbnkubHVja0BpbnRlbC5jb207DQo+cmp3QHJqd3lzb2NraS5uZXQ7IGxl
bmJAa2VybmVsLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+U3ViamVjdDog
UmU6IFtQQVRDSCAxLzFdIFJBUzogQWRkIENQVSBDb3JyZWN0YWJsZSBFcnJvciBDb2xsZWN0b3Ig
dG8gaXNvbGF0ZQ0KPmFuIGVycm9uZW91cyBDUFUgY29yZQ0KPg0KPk9uIFRodSwgT2N0IDAxLCAy
MDIwIGF0IDA2OjE2OjAzUE0gKzAxMDAsIEphbWVzIE1vcnNlIHdyb3RlOg0KPj4gSWYgdGhlIGNv
cnJlY3RlZC1jb3VudCBpcyBhdmFpbGFibGUgc29tZXdoZXJlLCBjYW4ndCB0aGlzIHBvbGljeSBi
ZQ0KPj4gbWFkZSBpbiB1c2VyLXNwYWNlPw0KPg0KPllvdSBtZWFuIHJhc2RhZW1vbiBnb2VzIGFu
ZCBvZmZsaW5lcyBDUFVzIHdoZW4gY2VydGFpbiB0aHJlc2hvbGRzIGFyZQ0KPnJlYWNoZWQ/IFN1
cmUuIEl0IHdvdWxkIGJlIG11Y2ggbW9yZSBmbGV4aWJsZSB0b28uDQoNCkkgd2lsbCBzZW5kIHRo
ZSBrZXJuZWwgY2hhbmdlcyBmb3IgZXhpc3RpbmcgQ0VDIHRvIHN1cHBvcnQgdGhlIENQVSBDRSBl
cnJvcnMuIA0KQ2FuIHlvdSBwbGVhc2UgaGF2ZSBhIGxvb2s/DQoNClRoYW5rcywNClNoaWp1DQoN
Cj4NCj4tLQ0KPlJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8vcGVvcGxl
Lmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=
