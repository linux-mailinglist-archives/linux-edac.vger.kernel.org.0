Return-Path: <linux-edac+bounces-5422-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932DC44CC9
	for <lists+linux-edac@lfdr.de>; Mon, 10 Nov 2025 03:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7419D3AF706
	for <lists+linux-edac@lfdr.de>; Mon, 10 Nov 2025 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE24233707;
	Mon, 10 Nov 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NXeu6m4w"
X-Original-To: linux-edac@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E220330;
	Mon, 10 Nov 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743004; cv=none; b=fDJj3yv66ygPC+MRFUzaMyUuvi5F/W185SNHrKkDTgACucZrEfIpzyK241ao8KsTRTkF1STL4Rsz92QL8BkaJi1NjpHNlydha+EsN+elI4MDWnGWWFh7W8arHtxqKQrVoePs9tKaYjXhE6LylqFWUdi7SuEILLJZsyhyvL819CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743004; c=relaxed/simple;
	bh=1cIL7/KPl3K5v0wQHaJ0tGfwMgE5xx/pMZWjRm2tfIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=hrkByD+UQ92iphiCNpB9AkVhN+x/5m7aLpvZdHKV0xGC6Ip8DYEAz/Yq2BkU82I00yCyUKCOyTaKqnfrp4JvrJH4/5FPPjkbTnrrBwUSvLHhuOockGBuCZ9bGdY1g1EwmRFHwqLKV2WEX44Tz7FSXXDzNYpmiJnWBIVTxM8cO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NXeu6m4w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA2hbGwB716235, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762742617; bh=1cIL7/KPl3K5v0wQHaJ0tGfwMgE5xx/pMZWjRm2tfIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=NXeu6m4w8KSIT/e89NQIAhnT0TTUgnu/lICYnlmDLN6lG+JAS5BBSg4pfyHxOZ+3G
	 MzKwilsYGhtBNzZkD7rUNJCT3VNQl98gZXpKjgSPPQiuTxDdeIuzegB6cC4M5XsTJS
	 AV7e9bElud20xerYcARWvseFofGg25WQqasBBRr5eZAnHJU18VeEzJYtSPiNV8xEjE
	 78GOeYXYKc+5Kjgu9vL26BGNE5uua7vNEW7kgceGHaDh/qy5GivYAfodqfyMvlq2ap
	 9zwrtSw2nup/b6fBieuy1tiYv1l7lLfGHKxd1nnqQcgtG3k9Hw7RTQVM7B8bAUUUrb
	 a5rLbIXf8JWcA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5AA2hbGwB716235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 10:43:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 10:43:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 10:43:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 10 Nov 2025 10:43:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Yury Norov
	<yury.norov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea
	<claudiu.beznea@tuxon.dev>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery
	<andrew@codeconstruct.com.au>,
        Crt Mori <cmo@melexis.com>, Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jacky Huang
	<ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski
	<kuba@kernel.org>, Alex Elder <elder@ieee.org>,
        David Laight
	<david.laight.linux@gmail.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck
	<tony.luck@intel.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Kim
 Seer Paller" <kimseer.paller@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Richard Genoud <richard.genoud@bootlin.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Biju Das
	<biju.das.jz@bp.renesas.com>,
        Jianping Shen <Jianping.Shen@de.bosch.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>,
        "qat-linux@intel.com" <qat-linux@intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
Thread-Topic: [PATCH v6 12/26] bitfield: Add less-checking
 __FIELD_{GET,PREP}()
Thread-Index: AQHcTzpEEEZZM/7p4kSHE1AyVJF587TmYVZQ///87ICAAIzmQIAETHKg
Date: Mon, 10 Nov 2025 02:43:37 +0000
Message-ID: <5cc8a69c155948078bd14e5f031e4468@realtek.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
 <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com>
 <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
 <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
 <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com> 
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgR2VlcnQsDQoNClBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4g
R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+ID4gSGkg
UGluZy1LZSwNCj4gPg0KPiA+IE9uIEZyaSwgNyBOb3YgMjAyNSBhdCAwMjoxNiwgUGluZy1LZSBT
aGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+ID4gR2VlcnQgVXl0dGVyaG9ldmVu
IDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+ID4gPiA+IFRoZSBleHRyYSBjaGVja2lu
ZyBpbiBmaWVsZF9wcmVwKCkgaW4gY2FzZSB0aGUgY29tcGlsZXIgY2FuDQo+ID4gPiA+IGRldGVy
bWluZSB0aGF0IHRoZSBtYXNrIGlzIGEgY29uc3RhbnQgYWxyZWFkeSBmb3VuZCBhIHBvc3NpYmxl
IGJ1Zw0KPiA+ID4gPiBpbiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUu
YzpydHc4OV9yb2NfZW5kKCk6DQo+ID4gPiA+DQo+ID4gPiA+ICAgICBydHc4OV93cml0ZTMyX21h
c2socnR3ZGV2LCByZWcsIEJfQVhfUlhfRkxUUl9DRkdfTUFTSywgcnR3ZGV2LT5oYWwucnhfZmx0
cik7DQo+ID4gPiA+DQo+ID4gPiA+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
cmVnLmg6DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAjZGVmaW5lIEJfQVhfUlhfTVBEVV9NQVhfTEVO
X01BU0sgR0VOTUFTSygyMSwgMTYpDQo+ID4gPiA+ICAgICAjZGVmaW5lIEJfQVhfUlhfRkxUUl9D
RkdfTUFTSyAoKHUzMil+Ql9BWF9SWF9NUERVX01BWF9MRU5fTUFTSykNCj4gPiA+ID4NCj4gPiA+
ID4gc28gaXQgbG9va3MgbGlrZSBCX0FYX1JYX0ZMVFJfQ0ZHX01BU0sgaXMgbm90IHRoZSBwcm9w
ZXIgbWFzayBmb3INCj4gPiA+ID4gdGhpcyBvcGVyYXRpb24uLi4NCj4gPiA+DQo+ID4gPiBUaGUg
cHVycG9zZSBvZiB0aGUgc3RhdGVtZW50cyBpcyB0byB1cGRhdGUgdmFsdWVzIGV4Y2x1ZGluZyBi
aXRzIG9mDQo+ID4gPiBCX0FYX1JYX01QRFVfTUFYX0xFTl9NQVNLLiBUaGUgdXNlIG9mIEJfQVhf
UlhfRkxUUl9DRkdfTUFTSyBpcyB0cmlja3ksIGJ1dA0KPiA+ID4gdGhlIG9wZXJhdGlvbiBpcyBj
b3JyZWN0IGJlY2F1c2UgYml0IDAgaXMgc2V0LCBzbyBfX2ZmcyhtYXNrKSByZXR1cm5zIDAgaW4N
Cj4gPiA+IHJ0dzg5X3dyaXRlMzJfbWFzaygpLiBUaGVuLCBvcGVyYXRpb24gbG9va3MgbGlrZQ0K
PiA+ID4NCj4gPiA+ICAgIG9yaWcgPSByZWFkKHJlZyk7DQo+ID4gPiAgICBuZXcgPSAob3JpZyAm
IH5tYXNrKSB8IChkYXRhICYgbWFzayk7DQo+ID4gPiAgICB3cml0ZShuZXcpOw0KPiA+DQo+ID4g
VGhhbmtzIGZvciB5b3VyIHF1aWNrIGNvbmZpcm1hdGlvbiENCj4gPiBTbyB0aGUgaW50ZW50aW9u
IHJlYWxseSBpcyB0byBjbGVhciBiaXRzIDIyLTMxLCBhbmQgd3JpdGUgdGhlIHJ4X2ZsdHINCj4g
PiB2YWx1ZSB0byBiaXRzIDAtMTU/DQo+ID4NCj4gPiBpZiB0aGUgY2xlYXJpbmcgaXMgbm90IG5l
ZWRlZCwgaXQgd291bGQgYmUgYmV0dGVyIHRvIHVzZQ0KPiA+ICNkZWZpbmUgQl9BWF9SWF9GTFRS
X0NGR19NQVNLIEdFTk1BU0soMTUsIDApDQo+IA0KPiBCdXQgaXQgc2hvdWxkIGJlDQo+ICNkZWZp
bmUgQl9BWF9SWF9GTFRSX0NGR19NQVNLIChHRU5NQVNLKDMxLCAyMikgfCBHRU5NQVNLKDE1LCAw
KSkNCj4gDQo+IE9yaWdpbmFsbHkgKHdpdGggYnVnKSB3ZSBqdXN0IGJhY2t1cCByeF9mbHRyIGFu
ZCB3cml0ZSB3aG9sZSAzMi1iaXRzIGJhY2ssDQo+IGJ1dCBpdCdzIGluY29ycmVjdCB0byBtb2Rp
ZnkgR0VOTUFTSygyMSwgMTYpIHdoaWNoIGlzIHdyaXR0ZW4gYnkgYW5vdGhlcg0KPiBjb2RlLg0K
PiANCj4gT25lIHdheSBpcyB0byBpbXBsZW1lbnQgYSBzcGVjaWFsIGZ1bmN0aW9uIHRvIHJlcGxh
Y2UNCj4gICBydHc4OV93cml0ZTMyX21hc2socnR3ZGV2LCByZWcsIEJfQVhfUlhfRkxUUl9DRkdf
TUFTSywgcnR3ZGV2LT5oYWwucnhfZmx0cik7DQo+IFN1Y2ggYXMNCj4gICBydHc4OV93cml0ZV9y
eF9mbHRlcihydHdkZXYsIHJ0d2Rldi0+aGFsLnJ4X2ZsdHIpDQo+ICAgew0KPiAgICAgb3JpZyA9
IHJlYWQocmVnKTsNCj4gICAgIG5ldyA9IChvcmlnICYgfm1hc2spIHwgKGRhdGEgJiBtYXNrKTsN
Cj4gICAgIHdyaXRlKG5ldyk7DQo+ICAgfQ0KPiANCj4gQW5vdGhlciB3YXkgaXMgdGhhdCBJIGFk
ZCB2YWx1ZSBvZiBCX0FYX1JYX01QRFVfTUFYX0xFTl9NQVNLIGludG8NCj4gcnR3ZGV2LT5oYWwu
cnhfZmx0ci4gVGhlbiwganVzdCB3cml0ZSB3aG9sZSAzMi1iaXQsIG5vIG5lZWQgbWFzay4NCj4g
DQo+ID4NCj4gPiBJZiB0aGUgY2xlYXJpbmcgaXMgbmVlZGVkLCBJIHN0aWxsIHRoaW5rIGl0IHdv
dWxkIGJlIGJldHRlciB0bw0KPiA+IGNoYW5nZSBCX0FYX1JYX0ZMVFJfQ0ZHX01BU0ssIGFuZCBz
cGxpdCB0aGUgY2xlYXJpbmcgb2ZmIGluIGEgc2VwYXJhdGUNCj4gPiBvcGVyYXRpb24sIHRvIG1h
a2UgaXQgbW9yZSBleHBsaWNpdCBhbmQgb2J2aW91cyBmb3IgdGhlIGNhc3VhbCByZWFkZXIuDQoN
CkkgbWlzc2VkIHRoaXMgcGFyYWdyYXBoIGxhc3Qgd2VlaywgYnV0IHRoYXQgaXMgbGlrZSBteSB0
aG91Z2h0Lg0KVGhlbiBJIHNwaW4gYSBSRlQgWzFdLiBQbGVhc2UgdHJ5IGlmIGl0IGNhbiB3b3Jr
IHdpdGggeW91ciBjaGFuZ2VzLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
d2lyZWxlc3MvMjAyNTExMTAwMjM3MDcuNjI3Mi0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1DQoN
Cj4gPg0KPiA+ID4gU2luY2Ugd2UgZG9uJ3QgdXNlIEZJRUxEX3tHRVQsUFJFUH0gbWFjcm9zIHdp
dGggQl9BWF9SWF9GTFRSX0NGR19NQVNLLCBob3cNCj4gPiA+IGNhbiB5b3UgZmluZCB0aGUgcHJv
YmxlbT8gUGxlYXNlIGd1aWRlIHVzLiBUaGFua3MuDQo+ID4NCj4gPiBJIHN0aWxsIGhhdmUgIltQ
QVRDSC9SRkMgMTcvMTddIHJ0dzg5OiBVc2UgYml0ZmllbGQgaGVscGVycyINCj4gPg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvZjdiODExMjJmNzU5NmZhMDA0MTg4YmZhZTY4ZjI1YTY4
YzJkMjM5Mi4xNjM3NTkyMTMzLmdpdC5nZWVydCtyZW5lc2FzQGdsaWQNCj4gPiBlci5iZS8NCj4g
PiBpbiBteSBsb2NhbCB0cmVlLCB3aGljaCBzdGFydGVkIGZsYWdnaW5nIHRoZSB1c2Ugb2YgYSBk
aXNjb250aWd1b3VzDQo+ID4gbWFzayB3aXRoIHRoZSBpbXByb3ZlZCBjaGVja2luZyBpbiBmaWVs
ZF9wcmVwKCkuDQo+IA0KPiBHb3QgaXQuIFlvdSBhcmUgZG9pbmcgIk5vbi1jb25zdCBiaXRmaWVs
ZCBoZWxwZXIgY29udmVyc2lvbnMiLg0KPiANCj4gUGluZy1LZQ0KDQo=

