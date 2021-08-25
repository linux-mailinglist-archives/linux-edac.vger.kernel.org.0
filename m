Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246B93F7144
	for <lists+linux-edac@lfdr.de>; Wed, 25 Aug 2021 10:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhHYItE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Aug 2021 04:49:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:58614 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhHYIsx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 25 Aug 2021 04:48:53 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-7-cZxJurhOOG-McPtL_PvPpQ-1; Wed, 25 Aug 2021 09:48:05 +0100
X-MC-Unique: cZxJurhOOG-McPtL_PvPpQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 25 Aug 2021 09:48:03 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 25 Aug 2021 09:48:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Len Baker <len.baker@gmx.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
Thread-Topic: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
Thread-Index: AQHXmRVyn+L+Io0D10+HJaTYjDNR26uD6Jzg
Date:   Wed, 25 Aug 2021 08:48:03 +0000
Message-ID: <a45274ec2e454323a37cde36bb365e97@AcuMS.aculab.com>
References: <20210814075527.5999-1-len.baker@gmx.com>
 <YSPbOo90alPsv4vL@zn.tnic> <20210824090338.GB7999@titan>
 <YSU5wp/ZpsXuDgmu@zn.tnic>
In-Reply-To: <YSU5wp/ZpsXuDgmu@zn.tnic>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDI0IEF1Z3VzdCAyMDIxIDE5OjI2DQouLg0K
PiBzbyBsb29raW5nIGF0IHRoZSBjb2RlLCB3ZSdyZSBtZXJyaWx5IGRlY3JlbWVudGluZyBsZW4g
YnV0IG5vdGhpbmcncw0KPiBjaGVja2luZyB3aGV0aGVyIGxlbiBjYW4gYmVjb21lIDAuIEJlY2F1
c2UgaWYgaXQgZG9lcywgc3Ryc2NweSgpIHdpbGwNCj4gZG86DQo+IA0KPiAJaWYgKGNvdW50ID09
IDAgfHwgV0FSTl9PTl9PTkNFKGNvdW50ID4gSU5UX01BWCkpDQo+IAkJcmV0dXJuIC1FMkJJRzsN
Cg0KVGhhdCAtRTJCSUcgaXMgZ29pbmcgdG8gYnJlYWsgc29tZXRoaW5nLg0KSXQgbWVhbnMgdGhh
dCB5b3UgYWx3YXlzIGhhdmUgdG8gZG8gYW4gZXJyb3IgY2hlY2sgd2hlbmV2ZXINCnlvdSB1c2Ug
dGhlIHJldHVybiB2YWx1ZSBvZiBzdHJzY3B5KCkuDQoNCkFueXRoaW5nIHRoYXQgZG9lczoNCglv
ZmZzZXQgKz0gc3Ryc2NweSguLi4pDQppcyBicm9rZW4uDQoNCkl0IHJlYWxseSB3YXNuJ3QgYSBn
b29kIGlkZWEgZm9yIHJlcG9ydGluZyAndHJ1bmNhdGVkJy4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

