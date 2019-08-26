Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939A69C6E1
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2019 02:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfHZAqz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 25 Aug 2019 20:46:55 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56230 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHZAqz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 25 Aug 2019 20:46:55 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CB7D5886BF;
        Mon, 26 Aug 2019 12:46:49 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1566780409;
        bh=TJtgfincaDm7qrXJ9SAhuUGk4llEldCBcfwenl5GlMg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=RR6KEkaIPTqCUFwleHO3gMGa6wW6vS5+Xqri6JSyfCB3ZgvHOry2WcSVcpdEOUhGj
         35khK/zY/UdYbcOK03beeIQPUzwgs+6htHqytIX/4/xdY+GjxC/mbqAk01csGFcRQ5
         gnsAPALDwRSf+8uN75j7XmSqTc+zlBOwqDtTFs1Y6zqNNrD8aGqG5haZS5LnhwLeaV
         w3ZnIjvglFBLRnQdzbL9iJp8zU7dV1AIQ8+9MLbLad11qzD+nWbQ5RX2FTMTKTwcrK
         LWqlvt1jqKSC7Ojk/exAm5x1RQ23DqOrpcYrf8AFxaO4QwnL8BYF/emjLmbclqHFrb
         Aj3u90gshrcQQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d632bf80000>; Mon, 26 Aug 2019 12:46:48 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 26 Aug 2019 12:46:44 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 26 Aug 2019 12:46:44 +1200
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
        "patches@armlinux.org.uk" <patches@armlinux.org.uk>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Thread-Topic: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Thread-Index: AQHVOGTGof7sJp7iK06MfTI7WDVk4qcIBgyAgAABHQCABA5YgA==
Date:   Mon, 26 Aug 2019 00:46:44 +0000
Message-ID: <836653f04f526333e8dbd45361329731f8dfe2ea.camel@alliedtelesis.co.nz>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
         <20190712034904.5747-2-chris.packham@alliedtelesis.co.nz>
         <20190823104621.GY13294@shell.armlinux.org.uk>
         <20190823105020.GZ13294@shell.armlinux.org.uk>
In-Reply-To: <20190823105020.GZ13294@shell.armlinux.org.uk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA9848220D51A84EA5A0DD1FA608AE4E@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KT24gRnJpLCAyMDE5LTA4LTIzIGF0IDExOjUwICswMTAwLCBSdXNzZWxs
IEtpbmcgLSBBUk0gTGludXggYWRtaW4NCndyb3RlOg0KPiBPbiBGcmksIEF1ZyAyMywgMjAxOSBh
dCAxMTo0NjoyMUFNICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXgNCj4gYWRtaW4gd3Jv
dGU6DQo+ID4gT24gRnJpLCBKdWwgMTIsIDIwMTkgYXQgMDM6NDg6NTdQTSArMTIwMCwgQ2hyaXMg
UGFja2hhbSB3cm90ZToNCj4gPiA+IEZyb206IEphbiBMdWViYmUgPGpsdUBwZW5ndXRyb25peC5k
ZT4NCj4gPiA+IA0KPiA+ID4gVGhlIG1hY3JvIG5hbWUgaXMgdG9vIGdlbmVyaWMsIHNvIGFkZCBh
IEFVUk9SQV8gcHJlZml4Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYW4gTHVlYmJl
IDxqbHVAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPiBSZXZpZXdlZC1ieTogR3JlZ29yeSBDTEVNRU5U
IDxncmVnb3J5LmNsZW1lbnRAZnJlZS1lbGVjdHJvbnMuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiA+
ID4gLS0tDQo+ID4gPiAgYXJjaC9hcm0vaW5jbHVkZS9hc20vaGFyZHdhcmUvY2FjaGUtYXVyb3Jh
LWwyLmggfCAyICstDQo+ID4gDQo+ID4gSSBjYW4ndCBhcHBseSB0aGlzIHNlcmllcyAtIHRoaXMg
ZmlsZSBkb2VzIG5vdCBleGlzdCBpbiBteSB0cmVlLA0KPiA+IGFuZA0KPiA+IGZyb20gd2hhdCBn
aXQgdGVsbHMgbWUsIGl0IG5ldmVyIGhhcyBleGlzdGVkLiAgTWF5YmUgaXQncyBpbg0KPiA+IHNv
bWVvbmUNCj4gPiBlbHNlcyB0cmVlPw0KPiANCj4gSSB0aGluayB0aGUgZmlsZSBpcyBpbiBteSB0
cmVlLCBqdXN0IGFzIGFyY2gvYXJtL21tL2NhY2hlLWF1cm9yYS1sMi5oDQo+IHdoaWNoIGlzIHdo
ZXJlIGl0IGhhcyBiZWVuIHNpbmNlIGl0IHdhcyBvcmlnaW5hbGx5IHN1Ym1pdHRlZCBpbiAyMDEy
Lg0KPiANCg0KU29ycnkgdGhlcmUgaXMgYSBtaXNzaW5nIHBhdGNoIHRoYXQgbW92ZXMgaXQgbmV4
dCB0byB0aGUNCmhhcmR3YXJlL2NhY2hlLSouaC4gSSBjYW4gc2VuZCB0aGUgbWlzc2luZyBwYXRj
aCBvciBJIGNhbiByZS1zZW5kIHRoZQ0Kd2hvbGUgc2VyaWVzLiBJZiBJIGRvIHNlbmQgdGhlIHdo
b2xlIHNlcmllcyBkbyB5b3Ugd2FudCBtZSB0byByZWJhc2UgaXQNCmFnYWluc3QgYSBwYXJ0aWN1
bGFyIHRhZy90cmVlPw0KDQo+ID4gDQo+ID4gPiAgYXJjaC9hcm0vbW0vY2FjaGUtbDJ4MC5jICAg
ICAgICAgICAgICAgICAgICAgICAgfCA0ICsrLS0NCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2luY2x1ZGUvYXNtL2hhcmR3YXJlL2NhY2hlLWF1cm9yYS1sMi5oDQo+ID4gPiBi
L2FyY2gvYXJtL2luY2x1ZGUvYXNtL2hhcmR3YXJlL2NhY2hlLWF1cm9yYS1sMi5oDQo+ID4gPiBp
bmRleCBjODYxMjQ3Njk4MzEuLmRjNWM0NzllYzRjMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gv
YXJtL2luY2x1ZGUvYXNtL2hhcmR3YXJlL2NhY2hlLWF1cm9yYS1sMi5oDQo+ID4gPiArKysgYi9h
cmNoL2FybS9pbmNsdWRlL2FzbS9oYXJkd2FyZS9jYWNoZS1hdXJvcmEtbDIuaA0KPiA+ID4gQEAg
LTQxLDcgKzQxLDcgQEANCj4gPiA+ICAjZGVmaW5lIEFVUk9SQV9BQ1JfRk9SQ0VfV1JJVEVfVEhS
T19QT0xJQ1kJXA0KPiA+ID4gIAkoMiA8PCBBVVJPUkFfQUNSX0ZPUkNFX1dSSVRFX1BPTElDWV9P
RkZTRVQpDQo+ID4gPiAgDQo+ID4gPiAtI2RlZmluZSBNQVhfUkFOR0VfU0laRQkJMTAyNA0KPiA+
ID4gKyNkZWZpbmUgQVVST1JBX01BWF9SQU5HRV9TSVpFCTEwMjQNCj4gPiA+ICANCj4gPiA+ICAj
ZGVmaW5lIEFVUk9SQV9XQVlfU0laRV9TSElGVAkyDQo+ID4gPiAgDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vbW0vY2FjaGUtbDJ4MC5jIGIvYXJjaC9hcm0vbW0vY2FjaGUtbDJ4MC5jDQo+
ID4gPiBpbmRleCA0MjhkMDg3MTgxMDcuLjgzYjczM2ExZjFlNiAxMDA2NDQNCj4gPiA+IC0tLSBh
L2FyY2gvYXJtL21tL2NhY2hlLWwyeDAuYw0KPiA+ID4gKysrIGIvYXJjaC9hcm0vbW0vY2FjaGUt
bDJ4MC5jDQo+ID4gPiBAQCAtMTM1Miw4ICsxMzUyLDggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcN
Cj4gPiA+IGF1cm9yYV9yYW5nZV9lbmQodW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9u
ZyBlbmQpDQo+ID4gPiAgCSAqIHNpbmNlIGNhY2hlIHJhbmdlIG9wZXJhdGlvbnMgc3RhbGwgdGhl
IENQVSBwaXBlbGluZQ0KPiA+ID4gIAkgKiB1bnRpbCBjb21wbGV0aW9uLg0KPiA+ID4gIAkgKi8N
Cj4gPiA+IC0JaWYgKGVuZCA+IHN0YXJ0ICsgTUFYX1JBTkdFX1NJWkUpDQo+ID4gPiAtCQllbmQg
PSBzdGFydCArIE1BWF9SQU5HRV9TSVpFOw0KPiA+ID4gKwlpZiAoZW5kID4gc3RhcnQgKyBBVVJP
UkFfTUFYX1JBTkdFX1NJWkUpDQo+ID4gPiArCQllbmQgPSBzdGFydCArIEFVUk9SQV9NQVhfUkFO
R0VfU0laRTsNCj4gPiA+ICANCj4gPiA+ICAJLyoNCj4gPiA+ICAJICogQ2FjaGUgcmFuZ2Ugb3Bl
cmF0aW9ucyBjYW4ndCBzdHJhZGRsZSBhIHBhZ2UgYm91bmRhcnkuDQo+ID4gPiAtLSANCj4gPiA+
IDIuMjIuMA0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiAtLSANCj4gPiBSTUsncyBQYXRjaCBz
eXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8NCj4g
PiBGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5lIGluIHN1YnVyYmlhOiBzeW5jIGF0IDEy
LjFNYnBzIGRvd24NCj4gPiA2MjJrYnBzIHVwDQo+ID4gQWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5u
ZXQ6IDExLjlNYnBzIGRvd24gNTAwa2JwcyB1cA0KPiANCj4gDQo=
