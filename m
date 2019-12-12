Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD711CD1A
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2019 13:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfLLMZw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Dec 2019 07:25:52 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:50347 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbfLLMZw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Dec 2019 07:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1576153551; x=1607689551;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PVu/JJjOJw+101p+8I6KU/0m6I/cnKMIfnrG8zB9Xh8=;
  b=lEszT3SPvmzSBfB8zXIooJWz9CJwqnE/quJ+xGhGeLRNB1/YRNQYjM0T
   Nj5nH+gp8T3Ppfttar5ylJwZufzx15QhuTnjsi5iVH51xFbZKzhDTFYNI
   K1zrv27BBecB2Aeum9zGHfxXuLTIo6H2sqLwi8HmXPPKeddMbhKS7RIan
   g=;
IronPort-SDR: yznAa+qb94wSbqeUjbjRLBsu/I304LTtbdgIquZtN15vGMjov0T5PsNg+Ym/UMzmqUBc2O5SEH
 5NOu7n95ckCQ==
X-IronPort-AV: E=Sophos;i="5.69,305,1571702400"; 
   d="scan'208";a="13128141"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Dec 2019 12:25:38 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 8B8A2A1892;
        Thu, 12 Dec 2019 12:25:34 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id xBCCPVUZ004059;
        Thu, 12 Dec 2019 13:25:32 +0100
Subject: Re: [PATCH 0/6] x86/mce: Various fixes and cleanups for MCE handling
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191211002519.GA30513@agluck-desk2.amr.corp.intel.com>
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <d8e11387-c84a-f333-7ea5-f9043af6375e@amazon.de>
Date:   Thu, 12 Dec 2019 13:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211002519.GA30513@agluck-desk2.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMTEvMTIvMjAxOSAwMS4yNSwgTHVjaywgVG9ueSB3cm90ZToKPiBPbiBUdWUsIERlYyAxMCwg
MjAxOSBhdCAwMTowNzoyN0FNICswMTAwLCBKYW4gSC4gU2Now7ZuaGVyciB3cm90ZToKPj4gSGku
Cj4+Cj4+IEhlcmUgaXMgYSBzZXJpZXMgb2Ygc21hbGxpc2ggZml4ZXMvY2xlYW51cHMgZm9yIHRo
ZSBoYW5kbGluZyBvZiBNQ0VzLgo+Pgo+PiBOb3RlLCB0aGF0IGV4Y2VwdCBmb3IgcGF0Y2hlcyAy
IGFuZCA0LCB0aGUgcGF0Y2hlcyBhcmUganVzdCBjb21waWxlIHRlc3RlZC4KPiAKPiBJIHRyaWVk
IHNvbWUgVUMgaW5qZWN0aW9ucyB3aXRoIHRoZXNlIHBhdGNoZXMgYXBwbGllZC4gU3R1ZmYKPiBz
dGlsbCB3b3Jrcy4gQnV0IHRoYW5rcyB0byB0aGUgVUNOL0RlZmVycmVkIHBhdGNoIEkgc2VlOgo+
IAo+IAlNZW1vcnkgZmFpbHVyZTogMHg1ZmUzMjg0OiBhbHJlYWR5IGhhcmR3YXJlIHBvaXNvbmVk
Cj4gCj4gd2hpY2ggaXMgZXhwZWN0ZWQgYmVjYXVzZSBvbiBJbnRlbCB3ZSBzZWUgYW4gU1JBUiBl
cnJvciBpbiBiYW5rIDEKPiBhbmQgdGhlIG1hY2hpbmUgY2hlY2sgdGFrZXMgdGhlIHBhZ2Ugb2Zm
bGluZS4gIFRoZW4gd2Ugc2VlIGEgVUNOQQo+IGZyb20gYW5vdGhlciBiYW5rIGZvciB0aGUgc2Ft
ZSBhZGRyZXNzIGFuZCB0cnkgdG8gdGFrZSB0aGUgc2FtZQo+IHBhZ2Ugb2ZmbGluZSBhZ2Fpbi4K
CkFzIEknbSBub3QgYSBzdWJqZWN0IG1hdHRlciBleHBlcnQ6IEJ1dCB0aGVyZSBhcmUgY2FzZXMs
IHdoZXJlIHdlCmdldCBhbiBVQ05BIG9ubHksIHJpZ2h0PyBTbyB0aGUgY2hhbmdlIG1ha2VzIHN0
aWxsIHNlbnNlPwoKPiBUaGlzIGlzIGEgcmV0dXJuIHRvIHRoZSBvbGQgYmVoYXZpb3IsIGJ1dCBt
aWdodCBzdXJwcmlzZSBzb21lIGZvbGtzLgoKSSdsbCBhZGQgdGhpcyBhcyBhIG5vdGUgdG8gdGhl
IGNvbW1pdCBtZXNzYWdlLgoKPiBPbmUgbml0LXBpY2sgLSBJIHRoaW5rIHdlIHNob3VsZCByZW5h
bWUgdGhlIHNyYW9fZGVjb2RlX25vdGlmaWVyKCkKPiBmdW5jdGlvbiBzaW5jZSBpdCBub3cgaGFu
ZGxlcyBib3RoIFNSQU8gYW5kIFVDTkEuIE5vdCBzdXJlIHdoYXQgYQo+IGdvb2QgbmFtZSBpcyAu
Li4gc29tZXRoaW5nIGxpa2UgInVjX2RlY29kZV9ub3RpZmllcigpIiBzaW5jZSBpdCB0YWtlcwo+
IGFjdGlvbiBmb3IgbXVsdGlwbGUgY2xhc3NlcyBvZiB1bmNvcnJlY3RlZCBlcnJvcnM/CgpUaGlz
IGFuZCBuYW1lcyBsaWtlICJ1bmNvcnJlY3RlZF9tZW1vcnlfZXJyb3Jfbm90aWZpZXIoKSIgc2Vl
bSB0byBpbXBseQphIHdpZGVyIHNjb3BlIHRoYW4gdGhlIGZ1bmN0aW9uIGFjdHVhbGx5IGhhcy4g
VGhhdCBicmluZ3MgbWUgdG8gYW5vdGhlcgpxdWVzdGlvbjogc2hvdWxkIHRoZSBzY29wZSBiZSB3
aWRlcj8KCkluc3RlYWQgb2YgZmlsdGVyaW5nIGZvciB1c2FibGUgYWRkcmVzc2VzIGFuZCBzcGVj
aWZpYyBzZXZlcml0aWVzLCB3ZQpjb3VsZCBmb3IgZXhhbXBsZSBmaWx0ZXIgZm9yIChzaW1pbGFy
IHRvIGNlY19hZGRfbWNlKCkpOgoKICBtY2VfaXNfbWVtb3J5X2Vycm9yKG0pICYmCiAgIW1jZV9p
c19jb3JyZWN0YWJsZShtKSAmJgogIG1jZV91c2FibGVfYWRkcmVzcyhtKQoKV291bGQgdGhhdCBt
YWtlIHNlbnNlPyBPciBkb2VzIHRoYXQgdmlvbGF0ZSBhbnl0aGluZywgdGhhdCBJJ20gbm90IGF3
YXJlIG9mPwoKPiBBbGwgdGhlIHBhdGNoZXMgbG9vayBPSyB0byBtZSAobW9kdWxvIHRoZSBhYm92
ZSByZW5hbWUgc3VnZ2VzdGlvbikuCj4gU28gY29uc2lkZXIgdGhpcyBhICJSZXZpZXdlZC1ieSIg
Zm9yIGFsbCBzaXguCgpUaGFuayB5b3UgZm9yIHJldmlld2luZy4gOikKClJlZ2FyZHMKSmFuCgot
LQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAz
OAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBS
YWxmIEhlcmJyaWNoCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVu
dGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

