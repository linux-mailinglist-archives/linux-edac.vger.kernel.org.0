Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563C8448025
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhKHNWT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 08:22:19 -0500
Received: from m1547.mail.126.com ([220.181.15.47]:14390 "EHLO
        m1547.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhKHNWS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Nov 2021 08:22:18 -0500
X-Greylist: delayed 1871 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 08:22:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Uc0NQ
        Af7xp3eaLtJLiT84Hrb+v4NGgZhHRTyK3iTFj4=; b=c9fXxEMukW+IQVPZ24SpU
        EuFilAgmdelinlahveQoFQgJTTL5DhYUsDttsB3D1iuhTxWhcIuVZ01yUiiRE0Pv
        jxEQgJN6S9S35/Noo5+DeSkMOT/gbCtkILIa/e330LAM2b0rn8gPPwYlCxcr3pTh
        XHZ8Uje8oWmlPWCOJOTboE=
Received: from zhangzl2013$126.com ( [120.244.188.145] ) by
 ajax-webmail-wmsvr47 (Coremail) ; Mon, 8 Nov 2021 20:47:59 +0800 (CST)
X-Originating-IP: [120.244.188.145]
Date:   Mon, 8 Nov 2021 20:47:59 +0800 (CST)
From:   "Zhaolong Zhang" <zhangzl2013@126.com>
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     "Tony Luck" <tony.luck@intel.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 126com
In-Reply-To: <YYj8ir/UYnG/zVK4@zn.tnic>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com> <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: L8qowAAnaumAHIlhg_5PAQ--.9082W
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbiCx9Fz1x5fUS6QgACs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

QXQgMjAyMS0xMS0wOCAxODozMTozOCwgIkJvcmlzbGF2IFBldGtvdiIgPGJwQGFsaWVuOC5kZT4g
d3JvdGU6Cj5PbiBNb24sIE5vdiAwOCwgMjAyMSBhdCAwNjoxMzowNFBNICswODAwLCBaaGFvbG9u
ZyBaaGFuZyB3cm90ZToKPj4gSSB3YXMgY29uY2VybmluZyB0aGF0IGlmIEkgc2ltcGx5IHJlbW92
ZSB0aGUgY3B1X21pc3NpbmcgY29kZSwgd2Ugd2lsbCBsb3NlIHRoZSBsb2cgaW4gdGhlCj4+IHNp
dHVhdGlvbiB3aGVyZSBtY2FfY2ZnLnRvbGVyYW50ID4gMSBhbmQgbm9fd2F5X291dCBpcyBzZXQg
YWZ0ZXJ3YXJkcy4KPj4gCj4+IERvIHlvdSB0aGluayB3ZSBjYW4gc2FmZWx5IGlnbm9yZSB0aGF0
IHNpdHVhdGlvbj8KPgo+V2VsbCwgaG93IGxpa2VseSBpcyB0byBoYXZlIHN1Y2ggYSBzaXR1YXRp
b24gaW4gcHJhY3RpY2U/CgpJdCBpcyBkaWZmaWN1bHQgdG8gYW5zd2VyLi4uCkJ1dCBzaW5jZSBj
dXJyZW50IGNvZGUgaXMgZGVhbGluZyB3aXRoIHRoaXMgc2l0dWF0aW9uLCBJIHRoaW5rIEkgc2hv
dWxkIGNvdmVyIGl0IHRvbywKYWx0aG91Z2ggaXQgaXMgb25seSBhIHBpZWNlIG9mIGxvZy4KClJl
Z2FyZHMsClpoYW9sb25n
