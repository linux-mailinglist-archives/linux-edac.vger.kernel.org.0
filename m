Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12E1445E0F
	for <lists+linux-edac@lfdr.de>; Fri,  5 Nov 2021 03:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhKECxD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 22:53:03 -0400
Received: from m1557.mail.126.com ([220.181.15.57]:56317 "EHLO
        m1557.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhKECxD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 4 Nov 2021 22:53:03 -0400
X-Greylist: delayed 1838 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 22:53:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=qpDs8
        hIs1kRyl/8h2qiuF+WKeIphxLBkUPQUEf69qNE=; b=Pv3nrjEQFOSjSfT6tlR+P
        keaeLJvucBs/uG6iOU13YYiZmPtRmKfLvb5vv1aO7yKlmubDuP+h+yqIZvsaLHDN
        +WfSxiX8YB9zKQlDjLoyNZOxhWjcmfK8w1ZQshKy/O6oEzsTqyfCGZoNmP68yGbn
        ue0chXJ28yyGm5sn2LCauk=
Received: from zhangzl2013$126.com ( [223.72.68.57] ) by
 ajax-webmail-wmsvr57 (Coremail) ; Fri, 5 Nov 2021 10:19:27 +0800 (CST)
X-Originating-IP: [223.72.68.57]
Date:   Fri, 5 Nov 2021 10:19:27 +0800 (CST)
From:   "Zhaolong Zhang" <zhangzl2013@126.com>
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH] x86/mce: correct cpu_missing reporting in
 mce_timed_out
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 126com
In-Reply-To: <YYQgPGVxP0R9hfYx@zn.tnic>
References: <20211104074431.1091525-1-zhangzl2013@126.com>
 <YYOkKm8UmmIxSdXF@zn.tnic> <442373b1384e4607ba743de4c09df670@intel.com>
 <YYQgPGVxP0R9hfYx@zn.tnic>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: OcqowACXFo6wlIRh3UkZAA--.41596W
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbiYwlCz1x5eCWxMAABsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

CkF0IDIwMjEtMTEtMDUgMDI6MDI6MzYsICJCb3Jpc2xhdiBQZXRrb3YiIDxicEBhbGllbjguZGU+
IHdyb3RlOgo+T24gVGh1LCBOb3YgMDQsIDIwMjEgYXQgMDM6NDc6MzZQTSArMDAwMCwgTHVjaywg
VG9ueSB3cm90ZToKPj4gPiBGcmFua2x5LCB3ZSBtaWdodCBqdXN0IGFzIHdlbGwga2lsbCB0aGF0
IGNwdV9taXNzaW5nIHRoaW5nIGJlY2F1c2Ugd2UKPj4gPiBhbHJlYWR5IHNheSB0aGF0IHNvbWUg
Q1BVcyBhcmUgbm90IHJlc3BvbmRpbmcuCj4+IAo+PiBZZXMuIFRoZSBtb3JlIHJlY2VudCBjb21t
aXQ6Cj4+IAo+PiA3YmIzOTMxM2NkNjIgKCJ4ODYvbWNlOiBNYWtlIG1jZV90aW1lZF9vdXQoKSBp
ZGVudGlmeSBob2xkb3V0IENQVXMiKQo+PiAKPj4gdHJpZXMgdG8gcHJvdmlkZSB0aGUgbW9yZSBk
ZXRhaWxlZCBtZXNzYWdlIGFib3V0ICp3aGljaCogQ1BVcyBhcmUgbWlzc2luZwo+Cj5FeGFjdGx5
Lgo+Cj4+IEkgdGhpbmsgY3B1X21pc3NpbmcgY2FuIGJlIGRyb3BwZWQuCj4KPlpoYW9sb25nLCB5
b3UgY291bGQgc2VuZCBhIHBhdGNoIGRvaW5nIHRoYXQsIGluc3RlYWQuCgpUaGFua3MgZm9yIHRo
ZSByZXBseS4gTGV0IG1lIHNlZSBob3cgdG8gZG8gaXQgcHJvcGVybHkuCgpSZWdhcmRzLApaaGFv
bG9uZwoKPgo+VGh4Lgo+Cj4tLSAKPlJlZ2FyZHMvR3J1c3MsCj4gICAgQm9yaXMuCj4KPmh0dHBz
Oi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlCg==
