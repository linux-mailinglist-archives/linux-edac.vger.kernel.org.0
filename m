Return-Path: <linux-edac+bounces-5407-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1630C3E1CB
	for <lists+linux-edac@lfdr.de>; Fri, 07 Nov 2025 02:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFAA188B69A
	for <lists+linux-edac@lfdr.de>; Fri,  7 Nov 2025 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B352F549E;
	Fri,  7 Nov 2025 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FjYtJuer"
X-Original-To: linux-edac@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E90258EC1;
	Fri,  7 Nov 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478397; cv=none; b=tH7DlqE5rDC/ZZEiDxdaKkbrE5n8Pe6f7fiUFbs8U9vAtqKVe2z/9cGROvAw+nXXwXw6rRMGzAW43/sqO1Y1HJTfMbqKaYBkRNYRfyyMfK2nTHksHqzZLqjlkpM2Z29u1mmMobUPXRZPcenmOAEvBhRJ5V/oJCL+rXI6tYsmRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478397; c=relaxed/simple;
	bh=Nm5aMpud/BwEyTnT0c68VLPBz2VGNEgyWcHAjm32KTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kr/8JEooxJKAIiNJN9twd47UqByUmi5ZKA7pkfxLVQ6IW6HnNhd+NWZevMltuv3bOJzE/qMmGKjGPBTpluSjhPkRQKwBQJGfne9FMiD+iuEWrRy9dAw4snbepNHR2EK1U9c/BurC/BHHs1uTFcOwIZpPIDL2AAf3mrexA+N6mek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FjYtJuer; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A71DE0O03948483, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762477994; bh=Nm5aMpud/BwEyTnT0c68VLPBz2VGNEgyWcHAjm32KTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FjYtJuer4hRCLimOXncXlZIQxrDIaJOzVIlyF/XR+2h07rMUryx0of4RxIvpnWYjQ
	 7CeWbPiqMjRIThwIdvIfHVndwI62Q2G/4Ev1pMTbRkBH1z2sS/+XMeyYoTUkBUviQ+
	 0g91XR4antu5YKqHLja9I6+xY8OcEgKObAEJ0REFrKD52eWs4fZ0MxIWFPT9lb9Hfn
	 4dF7jFfR4j2q5+TTYChrRdYCkECjVqqmQZLpcq+ffADMpD6XYAjUIFwzRrOvgbj8FW
	 /uX6VKcx87UIUR27N3Qud+rxr5tUk90eTGOyvjTdYsGBScC7CFLZdC23drT0pq4k7B
	 HoF3ZSJ5AXsgg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A71DE0O03948483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 09:13:14 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 7 Nov 2025 09:13:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 7 Nov 2025 09:13:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 7 Nov 2025 09:13:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: Yury Norov <yury.norov@gmail.com>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre
	<nicolas.ferre@microchip.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu
	<herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Linus
 Walleij" <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung
	<schung@nuvoton.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>, Alex Elder
	<elder@ieee.org>,
        David Laight <david.laight.linux@gmail.com>,
        Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>,
        Jason Baron <jbaron@akamai.com>, "Borislav Petkov" <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        Kim Seer Paller
	<kimseer.paller@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Richard Genoud <richard.genoud@bootlin.com>,
        Cosmin
 Tanislav <demonsingur@gmail.com>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        Jianping Shen <Jianping.Shen@de.bosch.com>,
        Nathan Chancellor
	<nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
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
Thread-Index: AQHcTzpEEEZZM/7p4kSHE1AyVJF587TmYVZQ
Date: Fri, 7 Nov 2025 01:13:14 +0000
Message-ID: <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
 <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com>
 <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
In-Reply-To: <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
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

R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+IEhpIEFu
ZHksDQo+IA0KPiBPbiBUaHUsIDYgTm92IDIwMjUgYXQgMTc6MDksIEFuZHkgU2hldmNoZW5rbw0K
PiA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPiB3cm90ZToNCj4gPiBPbiBUaHUsIE5vdiAw
NiwgMjAyNSBhdCAwMzo0OTowM1BNICswMTAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+
ID4gPiBPbiBUaHUsIDYgTm92IDIwMjUgYXQgMTU6NDQsIEFuZHkgU2hldmNoZW5rbw0KPiA+ID4g
PGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwgTm92
IDA2LCAyMDI1IGF0IDAyOjM0OjAwUE0gKzAxMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToN
Cj4gPiA+ID4gPiBUaGUgQlVJTERfQlVHX09OX01TRygpIGNoZWNrIGFnYWluc3QgIn4wdWxsIiB3
b3JrcyBvbmx5IHdpdGggInVuc2lnbmVkDQo+ID4gPiA+ID4gKGxvbmcpIGxvbmciIF9tYXNrIHR5
cGVzLiAgRm9yIGNvbnN0YW50IG1hc2tzLCB0aGF0IGNvbmRpdGlvbiBpcyB1c3VhbGx5DQo+ID4g
PiA+ID4gbWV0LCBhcyBHRU5NQVNLKCkgeWllbGRzIGFuIFVMIHZhbHVlLiAgVGhlIGZldyBwbGFj
ZXMgd2hlcmUgdGhlDQo+ID4gPiA+ID4gY29uc3RhbnQgbWFzayBpcyBzdG9yZWQgaW4gYW4gaW50
ZXJtZWRpYXRlIHZhcmlhYmxlIHdlcmUgZml4ZWQgYnkNCj4gPiA+ID4gPiBjaGFuZ2luZyB0aGUg
dmFyaWFibGUgdHlwZSB0byB1NjQgKHNlZSBlLmcuIFsxXSBhbmQgWzJdKS4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEhvd2V2ZXIsIGZvciBub24tY29uc3RhbnQgbWFza3MsIHNtYWxsZXIgdW5zaWdu
ZWQgdHlwZXMgc2hvdWxkIGJlIHZhbGlkLA0KPiA+ID4gPiA+IHRvbywgYnV0IGN1cnJlbnRseSBs
ZWFkIHRvICJyZXN1bHQgb2YgY29tcGFyaXNvbiBvZiBjb25zdGFudA0KPiA+ID4gPiA+IDE4NDQ2
NzQ0MDczNzA5NTUxNjE1IHdpdGggZXhwcmVzc2lvbiBvZiB0eXBlIC4uLiBpcyBhbHdheXMNCj4g
PiA+ID4gPiBmYWxzZSItd2FybmluZ3Mgd2l0aCBjbGFuZyBhbmQgVz0xLg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gSGVuY2UgcmVmYWN0b3IgdGhlIF9fQkZfRklFTERfQ0hFQ0soKSBoZWxwZXIsIGFu
ZCBmYWN0b3Igb3V0DQo+ID4gPiA+ID4gX19GSUVMRF97R0VULFBSRVB9KCkuICBUaGUgbGF0ZXIg
bGFjayB0aGUgc2luZ2xlIHByb2JsZW1hdGljIGNoZWNrLCBidXQNCj4gPiA+ID4gPiBhcmUgb3Ro
ZXJ3aXNlIGlkZW50aWNhbCB0byBGSUVMRF97R0VULFBSRVB9KCksIGFuZCBhcmUgaW50ZW5kZWQg
dG8gYmUNCj4gPiA+ID4gPiB1c2VkIGluIHRoZSBmdWxseSBub24tY29uc3QgdmFyaWFudHMgbGF0
ZXIuDQo+IA0KPiA+ID4gPiA+ICsgICAgIEJVSUxEX0JVR19PTl9NU0coX19iZl9jYXN0X3Vuc2ln
bmVkKG1hc2ssIG1hc2spID4gICAgICAgICAgICAgICBcDQo+ID4gPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICBfX2JmX2Nhc3RfdW5zaWduZWQocmVnLCB+MHVsbCksICAgICAgICAgICAgICAg
IFwNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgIHBmeCAidHlwZSBvZiByZWcgdG9v
IHNtYWxsIGZvciBtYXNrIikNCj4gPiA+ID4NCj4gPiA+ID4gUGVyaGFwcyB3ZSBtYXkgY29udmVy
dCB0aGlzIChhbmQgb3RoZXJzPykgdG8gc3RhdGljX2Fzc2VydCgpOnMgYXQgc29tZSBwb2ludD8N
Cj4gPiA+DQo+ID4gPiBOaWNrIHRyaWVkIHRoYXQgYmVmb3JlLCB3aXRob3V0IHN1Y2Nlc3M6DQo+
ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FLd3ZPZG1fcHJ0azFVUU5KUUdpZFpt
NDRMazU4MlMzcD1vZjB5NDYrclZqblNnWEpnQG1haWwuZ21haWwuY29tDQo+ID4NCj4gPiBBaCwg
dGhpcyBpcyB1bmZvcnR1bmF0ZS4NCj4gDQo+IE9mIGNvdXJzZSwgaXQgbWlnaHQgYmUgYW4gYWN0
dWFsIGJ1ZyBpbiB0aGUgaTkxNSBkcml2ZXIuLi4NCj4gDQo+IFRoZSBleHRyYSBjaGVja2luZyBp
biBmaWVsZF9wcmVwKCkgaW4gY2FzZSB0aGUgY29tcGlsZXIgY2FuDQo+IGRldGVybWluZSB0aGF0
IHRoZSBtYXNrIGlzIGEgY29uc3RhbnQgYWxyZWFkeSBmb3VuZCBhIHBvc3NpYmxlIGJ1Zw0KPiBp
biBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuYzpydHc4OV9yb2NfZW5k
KCk6DQo+IA0KPiAgICAgcnR3ODlfd3JpdGUzMl9tYXNrKHJ0d2RldiwgcmVnLCBCX0FYX1JYX0ZM
VFJfQ0ZHX01BU0ssIHJ0d2Rldi0+aGFsLnJ4X2ZsdHIpOw0KPiANCj4gZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9yZWcuaDoNCj4gDQo+ICAgICAjZGVmaW5lIEJfQVhfUlhfTVBE
VV9NQVhfTEVOX01BU0sgR0VOTUFTSygyMSwgMTYpDQo+ICAgICAjZGVmaW5lIEJfQVhfUlhfRkxU
Ul9DRkdfTUFTSyAoKHUzMil+Ql9BWF9SWF9NUERVX01BWF9MRU5fTUFTSykNCj4gDQo+IHNvIGl0
IGxvb2tzIGxpa2UgQl9BWF9SWF9GTFRSX0NGR19NQVNLIGlzIG5vdCB0aGUgcHJvcGVyIG1hc2sg
Zm9yDQo+IHRoaXMgb3BlcmF0aW9uLi4uDQoNClRoZSBwdXJwb3NlIG9mIHRoZSBzdGF0ZW1lbnRz
IGlzIHRvIHVwZGF0ZSB2YWx1ZXMgZXhjbHVkaW5nIGJpdHMgb2YNCkJfQVhfUlhfTVBEVV9NQVhf
TEVOX01BU0suIFRoZSB1c2Ugb2YgQl9BWF9SWF9GTFRSX0NGR19NQVNLIGlzIHRyaWNreSwgYnV0
DQp0aGUgb3BlcmF0aW9uIGlzIGNvcnJlY3QgYmVjYXVzZSBiaXQgMCBpcyBzZXQsIHNvIF9fZmZz
KG1hc2spIHJldHVybnMgMCBpbg0KcnR3ODlfd3JpdGUzMl9tYXNrKCkuIFRoZW4sIG9wZXJhdGlv
biBsb29rcyBsaWtlDQoNCiAgIG9yaWcgPSByZWFkKHJlZyk7DQogICBuZXcgPSAob3JpZyAmIH5t
YXNrKSB8IChkYXRhICYgbWFzayk7DQogICB3cml0ZShuZXcpOw0KDQpTaW5jZSB3ZSBkb24ndCB1
c2UgRklFTERfe0dFVCxQUkVQfSBtYWNyb3Mgd2l0aCBCX0FYX1JYX0ZMVFJfQ0ZHX01BU0ssIGhv
dw0KY2FuIHlvdSBmaW5kIHRoZSBwcm9ibGVtPyBQbGVhc2UgZ3VpZGUgdXMuIFRoYW5rcy4gDQoN
ClBpbmctS2UNCg0K

