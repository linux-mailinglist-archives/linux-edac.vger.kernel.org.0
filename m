Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E347A44A860
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 09:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbhKIIeY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 03:34:24 -0500
Received: from m1510.mail.126.com ([220.181.15.10]:17221 "EHLO
        m1510.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244095AbhKIIeX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Nov 2021 03:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=dLzp2
        hWh/AXLN2eszbgtSNzCV7q6sPVEhGOup8/b82U=; b=ge2eLYwvmU+LDQ5vYMYQN
        Pd0kF9qDubWsw+cklAzMAOQFrw9GHqAfZg/Fg2Ynp1RdtJ4Ra+E5WcjMlk92U/TT
        HnLPdZdYqS6g6qIxauHCXO4pdJPAjKmY/55BmheRF+gRnjeZMTAzsxRUvksXGhBU
        OeFevefu8w7BIthXKdJBVs=
Received: from zhangzl2013$126.com ( [60.247.85.82] ) by
 ajax-webmail-wmsvr10 (Coremail) ; Tue, 9 Nov 2021 16:31:23 +0800 (CST)
X-Originating-IP: [60.247.85.82]
Date:   Tue, 9 Nov 2021 16:31:23 +0800 (CST)
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
In-Reply-To: <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com> <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CsqowABnf1fcMYphXOxQAQ--.40801W
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbi4wZGz1pD-fwU9QABsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

QXQgMjAyMS0xMS0wOCAyMDo0Nzo1OSwgIlpoYW9sb25nIFpoYW5nIiA8emhhbmd6bDIwMTNAMTI2
LmNvbT4gd3JvdGU6Cj5BdCAyMDIxLTExLTA4IDE4OjMxOjM4LCAiQm9yaXNsYXYgUGV0a292IiA8
YnBAYWxpZW44LmRlPiB3cm90ZToKPj5PbiBNb24sIE5vdiAwOCwgMjAyMSBhdCAwNjoxMzowNFBN
ICswODAwLCBaaGFvbG9uZyBaaGFuZyB3cm90ZToKPj4+IEkgd2FzIGNvbmNlcm5pbmcgdGhhdCBp
ZiBJIHNpbXBseSByZW1vdmUgdGhlIGNwdV9taXNzaW5nIGNvZGUsIHdlIHdpbGwgbG9zZSB0aGUg
bG9nIGluIHRoZQo+Pj4gc2l0dWF0aW9uIHdoZXJlIG1jYV9jZmcudG9sZXJhbnQgPiAxIGFuZCBu
b193YXlfb3V0IGlzIHNldCBhZnRlcndhcmRzLgo+Pj4gCj4+PiBEbyB5b3UgdGhpbmsgd2UgY2Fu
IHNhZmVseSBpZ25vcmUgdGhhdCBzaXR1YXRpb24/Cj4+Cj4+V2VsbCwgaG93IGxpa2VseSBpcyB0
byBoYXZlIHN1Y2ggYSBzaXR1YXRpb24gaW4gcHJhY3RpY2U/Cj4KPkl0IGlzIGRpZmZpY3VsdCB0
byBhbnN3ZXIuLi4KPkJ1dCBzaW5jZSBjdXJyZW50IGNvZGUgaXMgZGVhbGluZyB3aXRoIHRoaXMg
c2l0dWF0aW9uLCBJIHRoaW5rIEkgc2hvdWxkIGNvdmVyIGl0IHRvbywKPmFsdGhvdWdoIGl0IGlz
IG9ubHkgYSBwaWVjZSBvZiBsb2cuCgpIaSBCb3JpcywKCkkgcmVjb25zaWRlcmVkIHRoZSBzaXR1
YXRpb24uCklmIHRoZXJlIGlzIGEgbm9uLXJlY292ZXJhYmxlIG1jZSBhcyB3ZWxsLCBqdXN0IGxl
dCBpdCBwcmludCB0aGF0IHJlYXNvbi4gTm8gbmVlZCB0byBicmluZyB0aGUKdGltZW91dCBtZXNz
YWdlIGluZGVlZC4gQmVjYXVzZSBzaW5jZSB0aGUgdG9sZXJhbnQgd2FzIHNldCB0byBhIGhpZ2gg
bGV2ZWwgdG8gaWdub3JlIHRoZSB0aW1lb3V0LAp3ZSBjYW4gZXZlbnR1YWxseSBpZ25vcmUgdGhl
bS4KClNvIHNpbXBseSBkcm9wIGNwdV9taXNzaW5nIHZhcmlhYmxlIGFzIHlvdSBtZW50aW9uZWQg
c2hvdWxkIHdvcmsuCgpJIGFtIG5vdCBzdXJlIHdoZXRoZXIgaXQgc2hvdWxkIGJlIGF1dGhvcmVk
IGJ5IHlvdSBvciBzdWdnZXN0ZWQgYnkgeW91LgpBbnl3YXksIEkgd2lsbCBwb3N0IGEgbmV3IHBh
dGNoIGV4YWN0bHkgYXMgeW91IHN1Z2dlc3RlZC4gUGxlYXNlIHBpY2sgaXQgb3IgaWdub3JlIGl0
IGFzIGFwcHJvcHJpYXRlIDopCgpUaGFua3MsClpoYW9sb25nCg==
