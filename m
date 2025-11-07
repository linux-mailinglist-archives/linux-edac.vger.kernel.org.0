Return-Path: <linux-edac+bounces-5410-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD3C3F1F7
	for <lists+linux-edac@lfdr.de>; Fri, 07 Nov 2025 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCCB3AF9B5
	for <lists+linux-edac@lfdr.de>; Fri,  7 Nov 2025 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1A29DB99;
	Fri,  7 Nov 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mtcfQRpI"
X-Original-To: linux-edac@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9F1EE033;
	Fri,  7 Nov 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507339; cv=none; b=OAnsTk9iUeJMhg4BHbfZ1QdkyiGqyBGfn7xxPv7rBG0ZfJyrumPDHTMdRbgj05eSbAU/eEtNG5r+01gp9Pe2ax/LjQd0PMa/Uh84hoZapmmhykdGDtCL/vmOSkeQ7Yw+tEoaNaqMgbQo5BDew3ZZtKkdMa+hpMSEl+OXZi4iJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507339; c=relaxed/simple;
	bh=zDaFC6X698MOtUdXRf84Rze+BfgR+MdLhQQxxraiKe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KqMb/POmrRiPkTLOCc5G0VMPKeRAmBAZa07YpWTNhoVKpXylAjDLlUTrsLO987QMeoJtp+vE2X4Ay1FiPA1RR9XZwTyppYLxbcufKLA3CMGJEKHa4PRvjZtxDTEonixp/A2itsGFwyZR1pH5ejdJYqAXDPqhoLQsdtKYjN6f4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mtcfQRpI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A79GKawC362169, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762506980; bh=zDaFC6X698MOtUdXRf84Rze+BfgR+MdLhQQxxraiKe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mtcfQRpIhXa3IGIUSTdgpbLVK2pS958DLDtoxChnJqoBMVIjP7+j1FmAAkkkSdABW
	 /zKvBrLSDhR5LG1K6YUOIIdSpoIPiLqepC71CPu3Jjxc2UUZY+KZFNx4LiRq55VUFU
	 qHu+KOtiJ51H0Ap0xpTcapZH2+oaO0cvfM6Z873QFalnjHbbDlZeT9LDxBX2yPtF8L
	 miAyhub5fBp7p1ZWJsZG7A1g1mUgugzxlWQ2Ezfr89ToVkmLIszXFuFILqNAnVLOwy
	 aov/l+6S60bRF1Ps1zkEe6Vqz7xzfEE77usAqMuA5SoX25aZ83B1gWTdIdTtWsFBvo
	 W/dmV93AAhmVA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A79GKawC362169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 17:16:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 7 Nov 2025 17:16:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 7 Nov 2025 17:16:20 +0800
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
Thread-Index: AQHcTzpEEEZZM/7p4kSHE1AyVJF587TmYVZQ///87ICAAIzmQA==
Date: Fri, 7 Nov 2025 09:16:20 +0000
Message-ID: <6cc1efe7771a41919ec9b2cb1eb977ac@realtek.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
 <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com>
 <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
 <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
 <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com>
In-Reply-To: <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com>
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

R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+IEhpIFBp
bmctS2UsDQo+IA0KPiBPbiBGcmksIDcgTm92IDIwMjUgYXQgMDI6MTYsIFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
QGxpbnV4LW02OGsub3JnPiB3cm90ZToNCj4gPiA+IFRoZSBleHRyYSBjaGVja2luZyBpbiBmaWVs
ZF9wcmVwKCkgaW4gY2FzZSB0aGUgY29tcGlsZXIgY2FuDQo+ID4gPiBkZXRlcm1pbmUgdGhhdCB0
aGUgbWFzayBpcyBhIGNvbnN0YW50IGFscmVhZHkgZm91bmQgYSBwb3NzaWJsZSBidWcNCj4gPiA+
IGluIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5jOnJ0dzg5X3JvY19l
bmQoKToNCj4gPiA+DQo+ID4gPiAgICAgcnR3ODlfd3JpdGUzMl9tYXNrKHJ0d2RldiwgcmVnLCBC
X0FYX1JYX0ZMVFJfQ0ZHX01BU0ssIHJ0d2Rldi0+aGFsLnJ4X2ZsdHIpOw0KPiA+ID4NCj4gPiA+
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcmVnLmg6DQo+ID4gPg0KPiA+ID4g
ICAgICNkZWZpbmUgQl9BWF9SWF9NUERVX01BWF9MRU5fTUFTSyBHRU5NQVNLKDIxLCAxNikNCj4g
PiA+ICAgICAjZGVmaW5lIEJfQVhfUlhfRkxUUl9DRkdfTUFTSyAoKHUzMil+Ql9BWF9SWF9NUERV
X01BWF9MRU5fTUFTSykNCj4gPiA+DQo+ID4gPiBzbyBpdCBsb29rcyBsaWtlIEJfQVhfUlhfRkxU
Ul9DRkdfTUFTSyBpcyBub3QgdGhlIHByb3BlciBtYXNrIGZvcg0KPiA+ID4gdGhpcyBvcGVyYXRp
b24uLi4NCj4gPg0KPiA+IFRoZSBwdXJwb3NlIG9mIHRoZSBzdGF0ZW1lbnRzIGlzIHRvIHVwZGF0
ZSB2YWx1ZXMgZXhjbHVkaW5nIGJpdHMgb2YNCj4gPiBCX0FYX1JYX01QRFVfTUFYX0xFTl9NQVNL
LiBUaGUgdXNlIG9mIEJfQVhfUlhfRkxUUl9DRkdfTUFTSyBpcyB0cmlja3ksIGJ1dA0KPiA+IHRo
ZSBvcGVyYXRpb24gaXMgY29ycmVjdCBiZWNhdXNlIGJpdCAwIGlzIHNldCwgc28gX19mZnMobWFz
aykgcmV0dXJucyAwIGluDQo+ID4gcnR3ODlfd3JpdGUzMl9tYXNrKCkuIFRoZW4sIG9wZXJhdGlv
biBsb29rcyBsaWtlDQo+ID4NCj4gPiAgICBvcmlnID0gcmVhZChyZWcpOw0KPiA+ICAgIG5ldyA9
IChvcmlnICYgfm1hc2spIHwgKGRhdGEgJiBtYXNrKTsNCj4gPiAgICB3cml0ZShuZXcpOw0KPiAN
Cj4gVGhhbmtzIGZvciB5b3VyIHF1aWNrIGNvbmZpcm1hdGlvbiENCj4gU28gdGhlIGludGVudGlv
biByZWFsbHkgaXMgdG8gY2xlYXIgYml0cyAyMi0zMSwgYW5kIHdyaXRlIHRoZSByeF9mbHRyDQo+
IHZhbHVlIHRvIGJpdHMgMC0xNT8NCj4gDQo+IGlmIHRoZSBjbGVhcmluZyBpcyBub3QgbmVlZGVk
LCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdXNlDQo+ICNkZWZpbmUgQl9BWF9SWF9GTFRSX0NGR19N
QVNLIEdFTk1BU0soMTUsIDApDQoNCkJ1dCBpdCBzaG91bGQgYmUgDQojZGVmaW5lIEJfQVhfUlhf
RkxUUl9DRkdfTUFTSyAoR0VOTUFTSygzMSwgMjIpIHwgR0VOTUFTSygxNSwgMCkpDQoNCk9yaWdp
bmFsbHkgKHdpdGggYnVnKSB3ZSBqdXN0IGJhY2t1cCByeF9mbHRyIGFuZCB3cml0ZSB3aG9sZSAz
Mi1iaXRzIGJhY2ssDQpidXQgaXQncyBpbmNvcnJlY3QgdG8gbW9kaWZ5IEdFTk1BU0soMjEsIDE2
KSB3aGljaCBpcyB3cml0dGVuIGJ5IGFub3RoZXINCmNvZGUuDQoNCk9uZSB3YXkgaXMgdG8gaW1w
bGVtZW50IGEgc3BlY2lhbCBmdW5jdGlvbiB0byByZXBsYWNlDQogIHJ0dzg5X3dyaXRlMzJfbWFz
ayhydHdkZXYsIHJlZywgQl9BWF9SWF9GTFRSX0NGR19NQVNLLCBydHdkZXYtPmhhbC5yeF9mbHRy
KTsNClN1Y2ggYXMNCiAgcnR3ODlfd3JpdGVfcnhfZmx0ZXIocnR3ZGV2LCBydHdkZXYtPmhhbC5y
eF9mbHRyKQ0KICB7DQogICAgb3JpZyA9IHJlYWQocmVnKTsNCiAgICBuZXcgPSAob3JpZyAmIH5t
YXNrKSB8IChkYXRhICYgbWFzayk7DQogICAgd3JpdGUobmV3KTsNCiAgfQ0KDQpBbm90aGVyIHdh
eSBpcyB0aGF0IEkgYWRkIHZhbHVlIG9mIEJfQVhfUlhfTVBEVV9NQVhfTEVOX01BU0sgaW50bw0K
cnR3ZGV2LT5oYWwucnhfZmx0ci4gVGhlbiwganVzdCB3cml0ZSB3aG9sZSAzMi1iaXQsIG5vIG5l
ZWQgbWFzay4NCg0KPiANCj4gSWYgdGhlIGNsZWFyaW5nIGlzIG5lZWRlZCwgSSBzdGlsbCB0aGlu
ayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8NCj4gY2hhbmdlIEJfQVhfUlhfRkxUUl9DRkdfTUFTSywg
YW5kIHNwbGl0IHRoZSBjbGVhcmluZyBvZmYgaW4gYSBzZXBhcmF0ZQ0KPiBvcGVyYXRpb24sIHRv
IG1ha2UgaXQgbW9yZSBleHBsaWNpdCBhbmQgb2J2aW91cyBmb3IgdGhlIGNhc3VhbCByZWFkZXIu
DQo+IA0KPiA+IFNpbmNlIHdlIGRvbid0IHVzZSBGSUVMRF97R0VULFBSRVB9IG1hY3JvcyB3aXRo
IEJfQVhfUlhfRkxUUl9DRkdfTUFTSywgaG93DQo+ID4gY2FuIHlvdSBmaW5kIHRoZSBwcm9ibGVt
PyBQbGVhc2UgZ3VpZGUgdXMuIFRoYW5rcy4NCj4gDQo+IEkgc3RpbGwgaGF2ZSAiW1BBVENIL1JG
QyAxNy8xN10gcnR3ODk6IFVzZSBiaXRmaWVsZCBoZWxwZXJzIg0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvZjdiODExMjJmNzU5NmZhMDA0MTg4YmZhZTY4ZjI1YTY4YzJkMjM5Mi4xNjM3
NTkyMTMzLmdpdC5nZWVydCtyZW5lc2FzQGdsaWQNCj4gZXIuYmUvDQo+IGluIG15IGxvY2FsIHRy
ZWUsIHdoaWNoIHN0YXJ0ZWQgZmxhZ2dpbmcgdGhlIHVzZSBvZiBhIGRpc2NvbnRpZ3VvdXMNCj4g
bWFzayB3aXRoIHRoZSBpbXByb3ZlZCBjaGVja2luZyBpbiBmaWVsZF9wcmVwKCkuDQoNCkdvdCBp
dC4gWW91IGFyZSBkb2luZyAiTm9uLWNvbnN0IGJpdGZpZWxkIGhlbHBlciBjb252ZXJzaW9ucyIu
IA0KDQpQaW5nLUtlDQoNCg==

