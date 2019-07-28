Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65F78195
	for <lists+linux-edac@lfdr.de>; Sun, 28 Jul 2019 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfG1UwP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 28 Jul 2019 16:52:15 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36696 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfG1UwP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 28 Jul 2019 16:52:15 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EF9A8886BF;
        Mon, 29 Jul 2019 08:52:11 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1564347131;
        bh=zwcgDTpzh+QcJgMzqiOYrkpXMbDm/2Rj+UICFKBXGYI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=vdssij1lGMNVqERnpgnOgrBybm8AtMbCqEulQ1a59R8cy+Yrfz672WyCs4RXlfN8e
         wpodem2Vwf+Dzk+Vot96G4UgV3KGJVqTFvDdggDXKX/rTmVsk0xuo+RRIErrbzwfHX
         Xvqst9+gE+rZvAr2Xvs2c5FS3p/EaYd2ykhDXEMQC0wsPRCCJSoGnmRqTHvkmT407z
         LAJxGoL2cmpKPFyIdzekVaXfyac5lkVeDKfwQlKRibp4gSFbkoOUa9U2C8tO2HvfRj
         SrRkqJ2G3iVdA/nPUrfTxqYzVgRTKwvo901b9wdg8lrW+1dqiOJ8pXkWernAPf1ZTH
         Z8fgrSDU9Q6vg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d3e0afb0000>; Mon, 29 Jul 2019 08:52:11 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Mon, 29 Jul 2019 08:52:10 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 29 Jul 2019 08:52:10 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "james.morse@arm.com" <james.morse@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "patches@armlinux.org.uk" <patches@armlinux.org.uk>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v9 8/8] EDAC: armada_xp: Add support for more SoCs
Thread-Topic: [PATCH v9 8/8] EDAC: armada_xp: Add support for more SoCs
Thread-Index: AQHVOGTG3p6deoTr9Ump3in5VXqHLabcSTGAgAOJgIA=
Date:   Sun, 28 Jul 2019 20:52:09 +0000
Message-ID: <1564347129.9737.19.camel@alliedtelesis.co.nz>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
         <20190712034904.5747-9-chris.packham@alliedtelesis.co.nz>
         <128016c1-380f-70c4-3a89-2d3b0edf9f88@arm.com>
In-Reply-To: <128016c1-380f-70c4-3a89-2d3b0edf9f88@arm.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B786D49858CCE48BDD511B9984E1BFD@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTI2IGF0IDE1OjUxICswMTAwLCBKYW1lcyBNb3JzZSB3cm90ZToNCj4g
SGkgQ2hyaXMsDQo+IA0KPiBPbiAxMi8wNy8yMDE5IDA0OjQ5LCBDaHJpcyBQYWNraGFtIHdyb3Rl
Og0KPiA+IA0KPiA+IFRoZSBBcm1hZGEgMzh4IGFuZCBvdGhlciBpbnRlZ3JhdGVkIFNvQ3MgdXNl
IGEgcmVkdWNlZCBwaW4gY291bnQgc28NCj4gPiB0aGUNCj4gPiB3aWR0aCBvZiB0aGUgU0RSQU0g
aW50ZXJmYWNlIGlzIHNtYWxsZXIgdGhhbiB0aGUgQXJtYWRhIFhQIFNvQ3MuDQo+ID4gVGhpcw0K
PiA+IG1lYW5zIHRoYXQgdGhlIGRlZmluaXRpb24gb2YgImZ1bGwiIGFuZCAiaGFsZiIgd2lkdGgg
aXMgcmVkdWNlZA0KPiA+IGZyb20NCj4gPiA2NC8zMiB0byAzMi8xNi4NCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9lZGFjL2FybWFkYV94cF9lZGFjLmMNCj4gPiBiL2RyaXZlcnMvZWRh
Yy9hcm1hZGFfeHBfZWRhYy5jDQo+ID4gaW5kZXggMzc1OWE0ZmJiZGVlLi43ZjIyN2JkY2JjODQg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL2FybWFkYV94cF9lZGFjLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2VkYWMvYXJtYWRhX3hwX2VkYWMuYw0KPiA+IEBAIC0zMzIsNiArMzMyLDExIEBA
IHN0YXRpYyBpbnQgYXhwX21jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPiAqcGRl
dikNCj4gPiDCoA0KPiA+IMKgCWF4cF9tY19yZWFkX2NvbmZpZyhtY2kpOw0KPiA+IMKgDQo+ID4g
KwkvKiBUaGVzZSBTb0NzIGhhdmUgYSByZWR1Y2VkIHdpZHRoIGJ1cyAqLw0KPiA+ICsJaWYgKG9m
X21hY2hpbmVfaXNfY29tcGF0aWJsZSgibWFydmVsbCxhcm1hZGEzODAiKSB8fA0KPiA+ICsJwqDC
oMKgwqBvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUoIm1hcnZlbGwsYXJtYWRheHAtOThkeDMyMzYi
KSkNCj4gPiArCQlkcnZkYXRhLT53aWR0aCAvPSAyOw0KPiBTbyB0aGUgaGFyZHdhcmUncyBTRFJB
TV9DT05GSUdfQlVTX1dJRFRIIHZhbHVlIGlzIHdyb25nPyBZdWNrLg0KPiANCg0KVGhlIG1heGlt
dW0gd2lkdGggZGlmZmVycyBiZXR3ZWVuIEFybWFkYS1YUCAoNjQtYml0KSBhbmQgQXJtYWRhLTM4
eA0KKDMyLWJpdCkuIFRoZXJlIGlzIHN0aWxsIHN0cmFwcGluZyB0byBjb250cm9sIGhhbGYtd2lk
dGggdnMgZnVsbC13aWR0aC4NCg0KPiBJcyBpdCB0b28gbGF0ZSBmb3IgdGhlIERUcyBvbiB0aGVz
ZSB0d28gc3lzdGVtcyB0byBwcm92aWRlIGEgRFQNCj4gdmVyc2lvbiBvZiB0aGUgJ2J1c193aWR0
aCcNCj4gdG8gb3ZlcnJpZGUgdGhlIGhhcmR3YXJlJ3MgbWlzLWFkdmVydGlzZWQgdmFsdWU/DQoN
CkluIGFuIGVhcmxpZXIgaXRlcmF0aW9uIEkgZGlkIGhhdmUgYSBEVCBwcm9wZXJ0eSBhcyB5b3Ug
c3VnZ2VzdC4gVGhlDQpwcm9ibGVtIGlzIHRoYXQgc29tZXRoaW5nIGxpa2UgImJ1cy13aWR0aCA9
IDwzMj4iIGlzIGFtYmlndW91cy4gT24NCkFybWFkYS1YUCB0aGlzIG1lYW5zIHRoZSBzdHJhcHBp
bmcgaXMgZm9yIGhhbGYtd2lkdGggYnV0IG9uIEFybWFkYS0zOHgNCnlvdSdkIG5lZWQgdG8gc3Ry
YXAgdG8gZnVsbC13aWR0aC4gVGhhdCdzIHdoeSB3ZSBzZXR0bGVkIG9uIHRoZSBtb2RlDQppbnRl
cnByZXRpbmcgdGhlIHN0cmFwcGluZyBhZ2FpbnN0IFNvQ1sxXS4NCg0KWzFdwqBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzE1MDI0NDQwNjcuMTMzMy43LmNhbWVsQHBl
DQpuZ3V0cm9uaXguZGUvDQoNCj4gDQo+IFRoaXMgd2F5IHlvdSBkb24ndCBuZWVkIHRvIGdyb3cg
dGhpcyBsaXN0Lg0KPiANCj4gQWNrZWQtYnk6IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBhcm0u
Y29tPg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEphbWVz
