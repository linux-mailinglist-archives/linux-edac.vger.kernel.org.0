Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 849D29F4CE
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 23:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfH0VNW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 17:13:22 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60240 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0VNW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Aug 2019 17:13:22 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 07B4A886BF;
        Wed, 28 Aug 2019 09:13:18 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1566940398;
        bh=nYYXFIfdeFGOegAOI6d+a0Qaz5wLVRVTNwVY6Zzetno=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=uksEVjX7i9s0JobNxb1eSSxfMp7699m2RJi4cNfKjSKLBZZkGHOnLw8MxulxT5MkC
         ORtXEOmBNavQ6Qifmp3SYOrvM4C+NvrYmCQpzKRti6iqaaOletJL5yJnKgU2wS0GAj
         1SN2Ld8g1EXK5JrpZ3I13YEUURtLqvtsMbFipArYX7mDgb1hN8oFTVZLhcsR32BDET
         16sWu0JbA5v6dRS5rTPx+TDINdb26rSj+36r1d482pDBHQp5J4CmE5L2ryOHLk8TxK
         Xmkks4a1x0YWnbvqfqJdgbx7IEzAXiUspVAkD7Ueqi3SBxfvMSFvIAgaHeFxPT+Y9S
         JjyxOLV8Ltwqw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d659cee0000>; Wed, 28 Aug 2019 09:13:18 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Wed, 28 Aug 2019 09:13:12 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 28 Aug 2019 09:13:12 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "gregory.clement@free-electrons.com" 
        <gregory.clement@free-electrons.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "patches@armlinux.org.uk" <patches@armlinux.org.uk>
Subject: Re: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Thread-Topic: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Thread-Index: AQHVOGTGof7sJp7iK06MfTI7WDVk4qcIBgyAgAABHQCABA5YgIACH/QAgADERoCAAAMcgIAAAauA
Date:   Tue, 27 Aug 2019 21:13:11 +0000
Message-ID: <0e9c7c7cb17b6fdea8d49b06925badb0b3d2ff8b.camel@alliedtelesis.co.nz>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
         <20190712034904.5747-2-chris.packham@alliedtelesis.co.nz>
         <20190823104621.GY13294@shell.armlinux.org.uk>
         <20190823105020.GZ13294@shell.armlinux.org.uk>
         <836653f04f526333e8dbd45361329731f8dfe2ea.camel@alliedtelesis.co.nz>
         <20190827091336.GI13294@shell.armlinux.org.uk>
         <b1e2e5b325b3c4453e2ed63c17e1e11d6b24f099.camel@alliedtelesis.co.nz>
         <20190827210713.GO13294@shell.armlinux.org.uk>
In-Reply-To: <20190827210713.GO13294@shell.armlinux.org.uk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:2872:a49:e4e9:7214]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4419FE1761C1324BB3ED319618247254@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDIyOjA3ICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4NCndyb3RlOg0KPiBPbiBUdWUsIEF1ZyAyNywgMjAxOSBhdCAwODo1NjowNVBNICsw
MDAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOS0wOC0yNyBhdCAxMDox
MyArMDEwMCwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IGFkbWluDQo+ID4gd3JvdGU6DQo+ID4g
PiBKdXN0IHNlbmQgdGhlIHNpbmdsZSBwYXRjaCB0byB0aGUgcGF0Y2ggdHJhY2tlciAtIGhhdmlu
ZyBpdCBhZ2FpbnN0DQo+ID4gPiA1LjMtcmMgaXMgZmluZSAoSSBkb24ndCB0aGluayBhbnl0aGlu
ZyBoYXMgY2hhbmdlZCBmb3IgYSBsb25nIHRpbWUNCj4gPiA+IHdpdGggdGhhdCBmaWxlLikNCj4g
PiANCj4gPiBEb25lIA0KPiA+IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIv
cGF0Y2hlcy92aWV3cGF0Y2gucGhwP2lkPTg5MDIvMQ0KPiA+IA0KPiA+IEknbSBzdGlsbCBub3Qg
ZW50aXJlbHkgc3VyZSB3aGF0IHRvIHB1dCBmb3IgdGhlIEtlcm5lbFZlcnNpb24gdGFnLiBJbg0K
PiA+IGhpbmRzaWdodCB0aGluayBJIG1pc2ludGVycHJldGVkIHlvdXIgY29tbWVudCBhYm92ZSBh
bmQgc2V0IGl0IHRvIDUuM3JjDQo+ID4gKHdoZXJlIHlvdSBtZWFudCBhIHNlcmllcyBiYXNlZCBv
biA1LjMtcmNYIHNob3VsZCBhcHBseSBjbGVhbmx5KS4gSXQNCj4gPiBwcm9iYWJseSBzaG91bGQg
aGF2ZSBiZWVuIG5leHQgb3IgbWFzdGVyIGJlY2F1c2UgaXQncyB3YXkgcGFzdCB0aGUNCj4gPiBt
ZXJnZSB3aW5kb3cgZm9yIDUuMy4NCj4gDQo+IFRoaW5rIGFib3V0IGl0IGFzICJ3aGljaCBrZXJu
ZWwgdmVyc2lvbiB3YXMgX3RoaXNfIHBhdGNoIGdlbmVyYXRlZA0KPiBhZ2FpbnN0IiAtIGl0J3Mg
YSBndWlkZSBmb3IgbWUgdG8ga25vdyB3aGljaCBrZXJuZWwgdmVyc2lvbiBpdA0KPiBzaG91bGQg
YmUgYXBwbGllZCB0by4gIFRoZSBuZWFyZXN0IExpbnVzIHJlbGVhc2UgKHJjIG9yIGZpbmFsKSBp
cw0KPiBnZW5lcmFsbHkgc3VmZmljaWVudC4NCj4gDQo+IElmIGl0IGRvZXNuJ3QgYXBwbHkgdG8g
bXkgY3VycmVudCBiYXNlLCB0aGVuIEkgbWlnaHQgY2hlY2sgb3V0IHRoYXQNCj4gdmVyc2lvbiwg
YXBwbHkgaXQgdGhlcmUsIGFuZCB0aGVuIG1lcmdlIGl0IGluLCByZXNvbHZpbmcgYW55DQo+IGNv
bmZsaWN0cyBkdXJpbmcgdGhlIG1lcmdlLg0KPiANCj4gSXQgc3RhcnRlZCBvZmYgd2l0aCBhIGRp
ZmZlcmVudCBwdXJwb3NlOiB3aGVuIHdlIGhhZCB0aGUgb2xkZXINCj4gZGV2ZWxvcG1lbnQgc3lz
dGVtLCBzdWNoIGFzIHRoZSAyLnggc2VyaWVzIGtlcm5lbHMsIHdlIHdvdWxkIGhhdmUNCj4gZXZl
biB4IGJlaW5nIHRoZSBjdXJyZW50IHN0YWJsZSBrZXJuZWxzLCBhbmQgY29uY3VycmVudGx5IHdl
J2QNCj4gYWxzbyBoYXZlIHgrMSBhcyB0aGUgZGV2ZWxvcG1lbnQgc2VyaWVzLiAgV2hlbiBzb21l
b25lIHNlbnQgbWUgYQ0KPiBwYXRjaCBiYWNrIHRoZW4sIGl0IHdhcyBpbXBvcnRhbnQgdG8ga25v
dyB3aGljaCBrZXJuZWwgc2VyaWVzIGl0DQo+IHdhcyBtZWFudCBmb3IuDQo+IA0KPiBJIGRlY2lk
ZWQgbm90IHRvIGdldCByaWQgb2YgaXQgYmVjYXVzZSBpdCBwcm92aWRlcyB1c2VmdWwNCj4gaW5m
b3JtYXRpb24gd2hlbiBwYXRjaGVzIGRvbid0IGFwcGx5LCBhbmQgZ2l2ZXMgbW9yZSBvcHRpb25z
DQo+IHRoYW4gbWUganVzdCBkaXNjYXJkaW5nIHRoZSBwYXRjaCB3aXRoIGEgY29tbWVudCBzYXlp
bmcgaXQNCj4gZG9lc24ndCBhcHBseS4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIGluZm8uIFNvIDUu
My1yYyBpcyBub3QgYXMgd3JvbmcgYXMgSSB0aG91Z2h0IGl0IHdhcy4NCg0KT25lIGNvdWxkIGV2
ZW4gc3VtbWFyaXplIHRoZSBhYm92ZSBhcy4NCg0KICBnaXQgZm9ybWF0LXBhdGNoIC0tYWRkLWhl
YWRlciBcDQogICAgICAiS2VybmVsVmVyc2lvbjogJChnaXQgZGVzY3JpYmUgLS1hYmJyZXY9MCBI
RUFEKSINCg0K
