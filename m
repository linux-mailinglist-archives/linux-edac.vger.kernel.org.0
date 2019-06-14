Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88941451D1
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 04:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfFNCTA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 22:19:00 -0400
Received: from spam01.hygon.cn ([110.188.70.11]:6781 "EHLO spam1.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfFNCTA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 22:19:00 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id x5E2IEx0019126;
        Fri, 14 Jun 2019 10:18:14 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
        by MK-FE.hygon.cn with ESMTP id x5E2I4gY029431;
        Fri, 14 Jun 2019 10:18:04 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn (172.23.18.10) by cncheex02.Hygon.cn
 (172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Fri, 14 Jun
 2019 10:18:11 +0800
Received: from cncheex01.Hygon.cn ([172.23.18.10]) by cncheex01.Hygon.cn
 ([172.23.18.10]) with mapi id 15.01.1466.003; Fri, 14 Jun 2019 10:18:11 +0800
From:   Wen Pu <puwen@hygon.cn>
To:     "mchehab@infradead.org" <mchehab@infradead.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] ras-mce-handler: Add support for Hygon Dhyana family 18h
 processor
Thread-Topic: [PATCH] ras-mce-handler: Add support for Hygon Dhyana family 18h
 processor
Thread-Index: AQHVEWeOgRtTd508eE2bfIzHStq9g6aaBeQA
Date:   Fri, 14 Jun 2019 02:18:10 +0000
Message-ID: <bdb9763a-b111-1927-9fd2-3fd933b3981d@hygon.cn>
References: <1558616422-22997-1-git-send-email-puwen@hygon.cn>
In-Reply-To: <1558616422-22997-1-git-send-email-puwen@hygon.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.18.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <648E66CB9E56B241A5E4276877D2714D@Hygon.cn>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: spam1.hygon.cn x5E2IEx0019126
X-DNSRBL: 
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJpZW5kbHkgcGluZy4uLg0KDQpPbiAyMDE5LzUvMjMgMjE6MDAsIFB1IFdlbiB3cm90ZToNCj4g
VGhlIEh5Z29uIERoeWFuYSBmYW1pbHkgMThoIHByb2Nlc3NvciBpcyBkZXJpdmVkIGZyb20gQU1E
IGZhbWlseSAxN2guDQo+IFRoZSBIeWdvbiBEaHlhbmEgc3VwcG9ydCB0byBMaW51eCBpcyBhbHJl
YWR5IGFjY2VwdGVkIHVwc3RyZWFtWzFdLg0KPiANCj4gQWRkIEh5Z29uIERoeWFuYSBzdXBwb3J0
IHRvIG1jZSBoYW5kbGVyIG9mIHJhc2RhZW1vbiBpbiBvcmRlciB0byBoYW5kbGUNCj4gTUNFIGV2
ZW50cyBvbiBIeWdvbiBEaHlhbmEgcGxhdGZvcm1zLg0KPiANCj4gUmVmZXJlbmNlOg0KPiBbMV0g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy90aXAvZmVjOTgwNjlmYjcyZmI2NTYzMDRhM2U1MjI2NWUw
YzJmYzlhZGY4Nw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHUgV2VuIDxwdXdlbkBoeWdvbi5jbj4N
Cj4gLS0tDQo+ICAgcmFzLW1jZS1oYW5kbGVyLmMgfCA5ICsrKysrKysrLQ0KPiAgIHJhcy1tY2Ut
aGFuZGxlci5oIHwgMSArDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9yYXMtbWNlLWhhbmRsZXIuYyBiL3Jhcy1t
Y2UtaGFuZGxlci5jDQo+IGluZGV4IGMxMWQ0ODkuLmViNTQ4YzYgMTAwNjQ0DQo+IC0tLSBhL3Jh
cy1tY2UtaGFuZGxlci5jDQo+ICsrKyBiL3Jhcy1tY2UtaGFuZGxlci5jDQo+IEBAIC01NSw3ICs1
NSw4IEBAIHN0YXRpYyBjaGFyICpjcHV0eXBlX25hbWVbXSA9IHsNCj4gICAJW0NQVV9LTklHSFRT
X0xBTkRJTkddID0gIktuaWdodHMgTGFuZGluZyIsDQo+ICAgCVtDUFVfS05JR0hUU19NSUxMXSA9
ICJLbmlnaHRzIE1pbGwiLA0KPiAgIAlbQ1BVX1NLWUxBS0VfWEVPTl0gPSAiU2t5bGFrZSBzZXJ2
ZXIiLA0KPiAtCVtDUFVfTkFQTEVTXSA9ICJBTUQgRmFtaWx5IDE3aCBaZW4xIg0KPiArCVtDUFVf
TkFQTEVTXSA9ICJBTUQgRmFtaWx5IDE3aCBaZW4xIiwNCj4gKwlbQ1BVX0RIWUFOQV0gPSAiSHln
b24gRmFtaWx5IDE4aCBNb2tzaGEiDQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgZW51bSBjcHV0
eXBlIHNlbGVjdF9pbnRlbF9jcHV0eXBlKHN0cnVjdCByYXNfZXZlbnRzICpyYXMpDQo+IEBAIC0y
MDAsNiArMjAxLDExIEBAIHN0YXRpYyBpbnQgZGV0ZWN0X2NwdShzdHJ1Y3QgcmFzX2V2ZW50cyAq
cmFzKQ0KPiAgIAkJCXJldCA9IEVJTlZBTDsNCj4gICAJCX0NCj4gICAJCWdvdG8gcmV0Ow0KPiAr
CX0gZWxzZSBpZiAoIXN0cmNtcChtY2UtPnZlbmRvciwiSHlnb25HZW51aW5lIikpIHsNCj4gKwkJ
aWYgKG1jZS0+ZmFtaWx5ID09IDI0KSB7DQo+ICsJCQltY2UtPmNwdXR5cGUgPSBDUFVfREhZQU5B
Ow0KPiArCQl9DQo+ICsJCWdvdG8gcmV0Ow0KPiAgIAl9IGVsc2UgaWYgKCFzdHJjbXAobWNlLT52
ZW5kb3IsIkdlbnVpbmVJbnRlbCIpKSB7DQo+ICAgCQltY2UtPmNwdXR5cGUgPSBzZWxlY3RfaW50
ZWxfY3B1dHlwZShyYXMpOw0KPiAgIAl9IGVsc2Ugew0KPiBAQCAtNDM2LDYgKzQ0Miw3IEBAIGlu
dCByYXNfbWNlX2V2ZW50X2hhbmRsZXIoc3RydWN0IHRyYWNlX3NlcSAqcywNCj4gICAJCXJjID0g
cGFyc2VfYW1kX2s4X2V2ZW50KHJhcywgJmUpOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWNhc2UgQ1BV
X05BUExFUzoNCj4gKwljYXNlIENQVV9ESFlBTkE6DQo+ICAgCQlyYyA9IHBhcnNlX2FtZF9zbWNh
X2V2ZW50KHJhcywgJmUpOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWRlZmF1bHQ6CQkJLyogQWxsIG90
aGVyIENQVSB0eXBlcyBhcmUgSW50ZWwgKi8NCj4gZGlmZiAtLWdpdCBhL3Jhcy1tY2UtaGFuZGxl
ci5oIGIvcmFzLW1jZS1oYW5kbGVyLmgNCj4gaW5kZXggOGFhZWNkMS4uOTQzOTVlYiAxMDA2NDQN
Cj4gLS0tIGEvcmFzLW1jZS1oYW5kbGVyLmgNCj4gKysrIGIvcmFzLW1jZS1oYW5kbGVyLmgNCj4g
QEAgLTUxLDYgKzUxLDcgQEAgZW51bSBjcHV0eXBlIHsNCj4gICAJQ1BVX0tOSUdIVFNfTUlMTCwN
Cj4gICAJQ1BVX1NLWUxBS0VfWEVPTiwNCj4gICAJQ1BVX05BUExFUywNCj4gKwlDUFVfREhZQU5B
LA0KPiAgIH07DQo+ICAgDQo+ICAgc3RydWN0IG1jZV9ldmVudCB7DQo+IA0K
