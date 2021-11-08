Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82365447E33
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 11:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbhKHKrW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 05:47:22 -0500
Received: from m1510.mail.126.com ([220.181.15.10]:5577 "EHLO
        m1510.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKHKrW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Nov 2021 05:47:22 -0500
X-Greylist: delayed 1804 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 05:47:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=IyVu3
        XYccGCV5UTXZ530PuD4VxBr6WGr7wfMZBkKTVk=; b=XakJDYec4/niQf6E3SJps
        IHV7Ek5Q+AKFLQeWGgkZmwaQ6h+Q7BpD+W5OiV4kOScz7gPinsud054urK0TCgBf
        /e4TBM+4Z5zM95ugrW607L1TikDJx+hAQxgNLXMu4BXeqyQM2RYT4A9KIIiBr1Dv
        btS4KyQyKozug7Anmif9cM=
Received: from zhangzl2013$126.com ( [60.247.85.82] ) by
 ajax-webmail-wmsvr10 (Coremail) ; Mon, 8 Nov 2021 18:13:04 +0800 (CST)
X-Originating-IP: [60.247.85.82]
Date:   Mon, 8 Nov 2021 18:13:04 +0800 (CST)
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
In-Reply-To: <YYjuiHN1wKt82fjs@zn.tnic>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com> <YYjuiHN1wKt82fjs@zn.tnic>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CsqowAC3vxMx+IhhzppQAQ--.35594W
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbiCxZFz1x5fUO7-AABsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

QXQgMjAyMS0xMS0wOCAxNzozMTo1MiwgIkJvcmlzbGF2IFBldGtvdiIgPGJwQGFsaWVuOC5kZT4g
d3JvdGU6Cj5PbiBNb24sIE5vdiAwOCwgMjAyMSBhdCAwNDoyODozMlBNICswODAwLCBaaGFvbG9u
ZyBaaGFuZyB3cm90ZToKPj4gbW92ZSBtY2VfbWlzc2luZ19jcHVzIGNoZWNraW5nIGludG8gbWNl
X3BhbmljKCkgYXMgd2VsbCwgYmVjYXVzZSB3ZSBkb24ndCB3YW50Cj4+IHRvIGxvc2UgdGhlIGNw
dSBtaXNzaW5nIGluZm9ybWF0aW9uIGluIGNhc2UgbWNhX2NmZy50b2xlcmFudCA+IDEgYW5kIHRo
ZXJlIGlzCj4+IG5vX3dheV9vdXQuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBaaGFvbG9uZyBaaGFu
ZyA8emhhbmd6bDIwMTNAMTI2LmNvbT4KPj4gLS0tCj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21j
ZS9jb3JlLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4KPkkgd2FzIGFj
dHVhbGx5IGV4cGVjdGluZyB0byBzZWUgc29tZXRoaW5nIGxpa2UgdGhpczoKCkhpIEJvcmlzLAoK
SSB3YXMgY29uY2VybmluZyB0aGF0IGlmIEkgc2ltcGx5IHJlbW92ZSB0aGUgY3B1X21pc3Npbmcg
Y29kZSwgd2Ugd2lsbCBsb3NlIHRoZSBsb2cgaW4gdGhlCnNpdHVhdGlvbiB3aGVyZSBtY2FfY2Zn
LnRvbGVyYW50ID4gMSBhbmQgbm9fd2F5X291dCBpcyBzZXQgYWZ0ZXJ3YXJkcy4KCkRvIHlvdSB0
aGluayB3ZSBjYW4gc2FmZWx5IGlnbm9yZSB0aGF0IHNpdHVhdGlvbj8KClJlZ2FyZHMsClpoYW9s
b25nCgoKPgo+ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYwo+aW5kZXggNmVkMzY1MzM3YTNiLi4zMGRlMDBm
ZTBkN2EgMTAwNjQ0Cj4tLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMKPisrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYwo+QEAgLTk5LDcgKzk5LDYgQEAgc3RydWN0
IG1jYV9jb25maWcgbWNhX2NmZyBfX3JlYWRfbW9zdGx5ID0gewo+IAo+IHN0YXRpYyBERUZJTkVf
UEVSX0NQVShzdHJ1Y3QgbWNlLCBtY2VzX3NlZW4pOwo+IHN0YXRpYyB1bnNpZ25lZCBsb25nIG1j
ZV9uZWVkX25vdGlmeTsKPi1zdGF0aWMgaW50IGNwdV9taXNzaW5nOwo+IAo+IC8qCj4gICogTUNB
IGJhbmtzIHBvbGxlZCBieSB0aGUgcGVyaW9kIHBvbGxpbmcgdGltZXIgZm9yIGNvcnJlY3RlZCBl
dmVudHMuCj5AQCAtMzE0LDggKzMxMyw2IEBAIHN0YXRpYyB2b2lkIG1jZV9wYW5pYyhjb25zdCBj
aGFyICptc2csIHN0cnVjdCBtY2UgKmZpbmFsLCBjaGFyICpleHApCj4gCQlpZiAoIWFwZWlfZXJy
KQo+IAkJCWFwZWlfZXJyID0gYXBlaV93cml0ZV9tY2UoZmluYWwpOwo+IAl9Cj4tCWlmIChjcHVf
bWlzc2luZykKPi0JCXByX2VtZXJnKEhXX0VSUiAiU29tZSBDUFVzIGRpZG4ndCBhbnN3ZXIgaW4g
c3luY2hyb25pemF0aW9uXG4iKTsKPiAJaWYgKGV4cCkKPiAJCXByX2VtZXJnKEhXX0VSUiAiTWFj
aGluZSBjaGVjazogJXNcbiIsIGV4cCk7Cj4gCWlmICghZmFrZV9wYW5pYykgewo+QEAgLTg5MSw3
ICs4ODgsNiBAQCBzdGF0aWMgaW50IG1jZV90aW1lZF9vdXQodTY0ICp0LCBjb25zdCBjaGFyICpt
c2cpCj4gCQkJCQkgY3B1bWFza19wcl9hcmdzKCZtY2VfbWlzc2luZ19jcHVzKSk7Cj4gCQkJbWNl
X3BhbmljKG1zZywgTlVMTCwgTlVMTCk7Cj4gCQl9Cj4tCQljcHVfbWlzc2luZyA9IDE7Cj4gCQly
ZXR1cm4gMTsKPiAJfQo+IAkqdCAtPSBTUElOVU5JVDsKPkBAIC0yNzAyLDcgKzI2OTgsNiBAQCBz
dHJ1Y3QgZGVudHJ5ICptY2VfZ2V0X2RlYnVnZnNfZGlyKHZvaWQpCj4gCj4gc3RhdGljIHZvaWQg
bWNlX3Jlc2V0KHZvaWQpCj4gewo+LQljcHVfbWlzc2luZyA9IDA7Cj4gCWF0b21pY19zZXQoJm1j
ZV9mYWtlX3Bhbmlja2VkLCAwKTsKPiAJYXRvbWljX3NldCgmbWNlX2V4ZWN1dGluZywgMCk7Cj4g
CWF0b21pY19zZXQoJm1jZV9jYWxsaW4sIDApOwo+Cj4tLSAKPlJlZ2FyZHMvR3J1c3MsCj4gICAg
Qm9yaXMuCj4KPmh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRp
cXVldHRlCg==
