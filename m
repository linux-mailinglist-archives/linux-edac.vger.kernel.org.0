Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8030744AF57
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 15:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhKIOWu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 09:22:50 -0500
Received: from m1547.mail.126.com ([220.181.15.47]:42541 "EHLO
        m1547.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhKIOWt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Nov 2021 09:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=mMFuL
        ZrvmYEvdeDVWzFznmoNMEL1hSaZQJnGg0467PM=; b=dlbnri1ZNikGe0yBkcg5O
        uvZx6Hl7yw2WNyWgrolbUdVVdW2GAgQ6pSK+rAQXur+kS++y3/bj2BdsnYIPqWm3
        RK2wgYIAfe6lfFJnuKgYAQBY7+A08osWJc4aLUKEZNslLWvdJkeI8ge04Qidr/4l
        CmTMzKFEwks6hN9NoqJGLE=
Received: from zhangzl2013$126.com ( [120.244.188.145] ) by
 ajax-webmail-wmsvr47 (Coremail) ; Tue, 9 Nov 2021 22:19:10 +0800 (CST)
X-Originating-IP: [120.244.188.145]
Date:   Tue, 9 Nov 2021 22:19:10 +0800 (CST)
From:   "Zhaolong Zhang" <zhangzl2013@126.com>
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     "Tony Luck" <tony.luck@intel.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: Get rid of cpu_missing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 126com
In-Reply-To: <YYo8H34W8xPafdnH@zn.tnic>
References: <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <20211109083547.3546963-1-zhangzl2013@126.com> <YYo8H34W8xPafdnH@zn.tnic>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7fe8edf3.412c.17d051128cd.Coremail.zhangzl2013@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: L8qowABHg+pfg4phsVtQAQ--.33248W
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbiYwZGz1x5eEukjwABsQ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

QXQgMjAyMS0xMS0wOSAxNzoxNToxMSwgIkJvcmlzbGF2IFBldGtvdiIgPGJwQGFsaWVuOC5kZT4g
d3JvdGU6Cj5PbiBUdWUsIE5vdiAwOSwgMjAyMSBhdCAwNDozNTo0N1BNICswODAwLCBaaGFvbG9u
ZyBaaGFuZyB3cm90ZToKPj4gRHJvcCBjcHVfbWlzc2luZyBzaW5jZSB3ZSBoYXZlIG1vcmUgY2Fw
YWJsZSBtY2VfbWlzc2luZ19jcHVzLgo+Cj5XaG8gaXMgIndlIj8KPgo+QWxzbywgeW91IG5lZWQg
dG8gdHJ5IGhhcmRlciB3aXRoIHRoYXQgY29tbWl0IG1lc3NhZ2UgLSBtY2VfbWlzc2luZ19jcHVz
Cj5pcyBhIGNwdW1hc2sgYW5kIEkgZG9uJ3Qgc2VlIGhvdyBhIGNwdW1hc2sgY2FuIGJlICJtb3Jl
IGNhcGFibGUiLi4uCj4KPlNvbWUgbW9yZSBoaW50cyBvbiBhIHBvc3NpYmxlIHdheSB0byBzdHJ1
Y3R1cmUgYSBjb21taXQgbWVzc2FnZSAtIHRob3NlCj5hcmUganVzdCBoaW50cyAtIG5vdCBuZWNl
c3NhcmlseSBydWxlcyAtIGJ1dCBpdCBzaG91bGQgaGVscCB5b3UgZ2V0IGFuCj5pZGVhOgo+Cj5Q
cm9ibGVtIGlzIEEuCj4KPkl0IGhhcHBlbnMgYmVjYXVzZSBvZiBCLgo+Cj5GaXggaXQgYnkgZG9p
bmcgQy4KPgo+KFBvdGVudGlhbGx5IGRvIEQpLgo+Cj5Gb3IgbW9yZSBkZXRhaWxlZCBpbmZvLCBz
ZWUKPkRvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0LCBTZWN0aW9u
ICIyKSBEZXNjcmliZSB5b3VyCj5jaGFuZ2VzIi4KPgo+QWxzbywgdG8gdGhlIHRvbmUsIGZyb20g
RG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q6Cj4KPiAiRGVzY3Jp
YmUgeW91ciBjaGFuZ2VzIGluIGltcGVyYXRpdmUgbW9vZCwgZS5nLiAibWFrZSB4eXp6eSBkbyBm
cm90eiIKPiAgaW5zdGVhZCBvZiAiW1RoaXMgcGF0Y2hdIG1ha2VzIHh5enp5IGRvIGZyb3R6IiBv
ciAiW0ldIGNoYW5nZWQgeHl6enkKPiAgdG8gZG8gZnJvdHoiLCBhcyBpZiB5b3UgYXJlIGdpdmlu
ZyBvcmRlcnMgdG8gdGhlIGNvZGViYXNlIHRvIGNoYW5nZQo+ICBpdHMgYmVoYXZpb3VyLiIKPgo+
QWxzbywgZG8gbm90IHRhbGsgYWJvdXQgd2hhdCB5b3VyIHBhdGNoIGRvZXMgLSB0aGF0IHNob3Vs
ZCBob3BlZnVsbHkgYmUKPnZpc2libGUgaW4gdGhlIGRpZmYgaXRzZWxmLiBSYXRoZXIsIHRhbGsg
YWJvdXQgKndoeSogeW91J3JlIGRvaW5nIHdoYXQKPnlvdSdyZSBkb2luZy4KPgo+QWxzbywgcGxl
YXNlIHVzZSBwYXNzaXZlIHZvaWNlIGluIHlvdXIgY29tbWl0IG1lc3NhZ2U6IG5vICJ3ZSIgb3Ig
IkkiLCBldGMsCj5hbmQgZGVzY3JpYmUgeW91ciBjaGFuZ2VzIGluIGltcGVyYXRpdmUgbW9vZC4K
Pgo+Qm90dG9tIGxpbmUgaXM6IHBlcnNvbmFsIHByb25vdW5zIGFyZSBhbWJpZ3VvdXMgaW4gdGV4
dCwgZXNwZWNpYWxseSB3aXRoCj5zbyBtYW55IHBhcnRpZXMvY29tcGFuaWVzL2V0YyBkZXZlbG9w
aW5nIHRoZSBrZXJuZWwgc28gbGV0J3MgYXZvaWQgdGhlbQo+cGxlYXNlLgoKSGkgQm9yaXMsCgpU
aGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciBraW5kIHJlcGx5LiBJIHJlYWxseSBhcHByZWNpYXRl
IHlvdXIgZGV0YWlsZWQgZ3VpZGFuY2UuCkkndmUgc2VudCBhIHYyIHBhdGNoIHdpdGggbmV3IGRl
c2NyaXB0aW9ucywgdHJ5aW5nIHRvIGJlIHVzZWZ1bCBhbmQgYnJpZWYuCkhvcGUgaXQgaXMgcXVh
bGlmaWVkLi4uCgpSZWdhcmRzLApaaGFvbG9uZwo=
