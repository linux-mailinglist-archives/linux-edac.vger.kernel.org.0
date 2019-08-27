Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE29F496
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfH0U4K (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 16:56:10 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60189 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfH0U4K (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Aug 2019 16:56:10 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 35CF2886BF;
        Wed, 28 Aug 2019 08:56:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1566939366;
        bh=Qkj1mG0wHsGHa/gKm5/x9q0JZlgBpJKgAE+1iQkqh2Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=iN/lZg2JjWlXXd7voA+WGY6nUBTzOuOMmdO6MEpyAcO5ls/YCOx4rTVA4nDNs7r9H
         aLJ9wjk8ZPdg6LYkDaNWao/pkECE2/NEzyil5tR2jNFXWfpmAq0vnqycnZD8N3uPZL
         qV/5p3eBVw29pmpXD79jKWyqrGMF4J3GMa9b8i6IH5gZwdrMi3KKvoGgzhHdHMG6N6
         dlfUOmPEOlsGdPgkbab4LlF3wi5cd2mIeYxoZpcwaVhlWt71E707/1aCVeneqMv8+R
         3oByeNDpbuVz2Nv/Z2/zHNIJEa8aKFSFbt0S2dpIkJlZiM2ROO9Q+GojJZqV2xL9uV
         8AFUJX/3Bxm8w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d6598e60001>; Wed, 28 Aug 2019 08:56:06 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Wed, 28 Aug 2019 08:56:05 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 28 Aug 2019 08:56:05 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregory.clement@free-electrons.com" 
        <gregory.clement@free-electrons.com>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "patches@armlinux.org.uk" <patches@armlinux.org.uk>
Subject: Re: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Thread-Topic: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Thread-Index: AQHVOGTGof7sJp7iK06MfTI7WDVk4qcIBgyAgAABHQCABA5YgIACH/QAgADERoA=
Date:   Tue, 27 Aug 2019 20:56:05 +0000
Message-ID: <b1e2e5b325b3c4453e2ed63c17e1e11d6b24f099.camel@alliedtelesis.co.nz>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
         <20190712034904.5747-2-chris.packham@alliedtelesis.co.nz>
         <20190823104621.GY13294@shell.armlinux.org.uk>
         <20190823105020.GZ13294@shell.armlinux.org.uk>
         <836653f04f526333e8dbd45361329731f8dfe2ea.camel@alliedtelesis.co.nz>
         <20190827091336.GI13294@shell.armlinux.org.uk>
In-Reply-To: <20190827091336.GI13294@shell.armlinux.org.uk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:2872:a49:e4e9:7214]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB7AD1FE2BCAAD49A227E6CDD248BBBA@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDEwOjEzICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4NCndyb3RlOg0KPiBPbiBNb24sIEF1ZyAyNiwgMjAxOSBhdCAxMjo0Njo0NEFNICsw
MDAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiA+IEhpIFJ1c3NlbGwsDQo+ID4gDQo+ID4gT24g
RnJpLCAyMDE5LTA4LTIzIGF0IDExOjUwICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXgg
YWRtaW4NCj4gPiB3cm90ZToNCj4gPiA+IE9uIEZyaSwgQXVnIDIzLCAyMDE5IGF0IDExOjQ2OjIx
QU0gKzAxMDAsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eA0KPiA+ID4gYWRtaW4gd3JvdGU6DQo+
ID4gPiA+IEkgY2FuJ3QgYXBwbHkgdGhpcyBzZXJpZXMgLSB0aGlzIGZpbGUgZG9lcyBub3QgZXhp
c3QgaW4gbXkgdHJlZSwNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IGZyb20gd2hhdCBnaXQgdGVsbHMg
bWUsIGl0IG5ldmVyIGhhcyBleGlzdGVkLiAgTWF5YmUgaXQncyBpbg0KPiA+ID4gPiBzb21lb25l
DQo+ID4gPiA+IGVsc2VzIHRyZWU/DQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgdGhlIGZpbGUgaXMg
aW4gbXkgdHJlZSwganVzdCBhcyBhcmNoL2FybS9tbS9jYWNoZS1hdXJvcmEtbDIuaA0KPiA+ID4g
d2hpY2ggaXMgd2hlcmUgaXQgaGFzIGJlZW4gc2luY2UgaXQgd2FzIG9yaWdpbmFsbHkgc3VibWl0
dGVkIGluIDIwMTIuDQo+ID4gDQo+ID4gU29ycnkgdGhlcmUgaXMgYSBtaXNzaW5nIHBhdGNoIHRo
YXQgbW92ZXMgaXQgbmV4dCB0byB0aGUNCj4gPiBoYXJkd2FyZS9jYWNoZS0qLmguIEkgY2FuIHNl
bmQgdGhlIG1pc3NpbmcgcGF0Y2ggb3IgSSBjYW4gcmUtc2VuZCB0aGUNCj4gPiB3aG9sZSBzZXJp
ZXMuIElmIEkgZG8gc2VuZCB0aGUgd2hvbGUgc2VyaWVzIGRvIHlvdSB3YW50IG1lIHRvIHJlYmFz
ZSBpdA0KPiA+IGFnYWluc3QgYSBwYXJ0aWN1bGFyIHRhZy90cmVlPw0KPiANCj4gSnVzdCBzZW5k
IHRoZSBzaW5nbGUgcGF0Y2ggdG8gdGhlIHBhdGNoIHRyYWNrZXIgLSBoYXZpbmcgaXQgYWdhaW5z
dA0KPiA1LjMtcmMgaXMgZmluZSAoSSBkb24ndCB0aGluayBhbnl0aGluZyBoYXMgY2hhbmdlZCBm
b3IgYSBsb25nIHRpbWUNCj4gd2l0aCB0aGF0IGZpbGUuKQ0KDQpEb25lIA0KaHR0cHM6Ly93d3cu
YXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzL3ZpZXdwYXRjaC5waHA/aWQ9ODkwMi8x
DQoNCkknbSBzdGlsbCBub3QgZW50aXJlbHkgc3VyZSB3aGF0IHRvIHB1dCBmb3IgdGhlIEtlcm5l
bFZlcnNpb24gdGFnLiBJbg0KaGluZHNpZ2h0IHRoaW5rIEkgbWlzaW50ZXJwcmV0ZWQgeW91ciBj
b21tZW50IGFib3ZlIGFuZCBzZXQgaXQgdG8gNS4zcmMNCih3aGVyZSB5b3UgbWVhbnQgYSBzZXJp
ZXMgYmFzZWQgb24gNS4zLXJjWCBzaG91bGQgYXBwbHkgY2xlYW5seSkuIEl0DQpwcm9iYWJseSBz
aG91bGQgaGF2ZSBiZWVuIG5leHQgb3IgbWFzdGVyIGJlY2F1c2UgaXQncyB3YXkgcGFzdCB0aGUN
Cm1lcmdlIHdpbmRvdyBmb3IgNS4zLg0KDQo=
