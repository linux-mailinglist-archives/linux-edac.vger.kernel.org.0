Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533FE12686A
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2019 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSRti (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Dec 2019 12:49:38 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:60247 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSRti (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Dec 2019 12:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1576777778; x=1608313778;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6M0fsUmFbn5kSFVnpUdTgIDxYPEOQJ+1csuXw9W2yW0=;
  b=m5TiJkCuWM45E7vmDwWPuAcaGnalrEnuQO8Cj3FsVjtRWwEqg5Veoj93
   +LJ/hVOcOw5lT+Wf0VQAoJ8NSDRkTYSEKHHhM6dNlmMEUD3R6W2OYsi64
   2gi3FN2jt6ZbOZmod6rlUoyrMIxLL5yLmR01BiWubDb9jWDt1fcj3Vk75
   M=;
IronPort-SDR: ZLPqT9+dLCF/EgDx53puHn9Ztra/eXcT/eMg4GZlbksZSF+N0YZFehCC6TfmvtRAyfdbHFJpKH
 pduboTKJ6ASA==
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="8376434"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 19 Dec 2019 17:49:36 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 84F36A216B;
        Thu, 19 Dec 2019 17:49:34 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id xBJHnW0d017657;
        Thu, 19 Dec 2019 18:49:32 +0100
Subject: Re: [PATCH 4/6] x86/mce: Fix handling of optional message string
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191210000733.17979-5-jschoenh@amazon.de> <20191216173737.GF17380@zn.tnic>
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <47be6ccd-0387-47c0-6f01-1304ce26780f@amazon.de>
Date:   Thu, 19 Dec 2019 18:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216173737.GF17380@zn.tnic>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMTYvMTIvMjAxOSAxOC4zNywgQm9yaXNsYXYgUGV0a292IHdyb3RlOgo+IE9uIFR1ZSwgRGVj
IDEwLCAyMDE5IGF0IDAxOjA3OjMxQU0gKzAxMDAsIEphbiBILiBTY2jDtm5oZXJyIHdyb3RlOgo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2UvY29yZS5jCj4+IGluZGV4IDZhZmI5ZGUyNTFmMi4uYjExYTc0ZTNmZWE5
IDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMKPj4gKysrIGIv
YXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jCj4+IEBAIC04MDksMTAgKzgwOSwxMiBAQCBz
dGF0aWMgaW50IG1jZV9ub193YXlfb3V0KHN0cnVjdCBtY2UgKm0sIGNoYXIgKiptc2csIHVuc2ln
bmVkIGxvbmcgKnZhbGlkcCwKPj4gIAkJaWYgKHF1aXJrX25vX3dheV9vdXQpCj4+ICAJCQlxdWly
a19ub193YXlfb3V0KGksIG0sIHJlZ3MpOwo+PiAgCj4+ICsJCXRtcCA9IE5VTEw7Cj4+ICAJCW0t
PmJhbmsgPSBpOwo+PiAgCQlpZiAobWNlX3NldmVyaXR5KG0sIG1jYV9jZmcudG9sZXJhbnQsICZ0
bXAsIHRydWUpID49IE1DRV9QQU5JQ19TRVZFUklUWSkgewo+PiAgCQkJbWNlX3JlYWRfYXV4KG0s
IGkpOwo+PiAtCQkJKm1zZyA9IHRtcDsKPj4gKwkJCWlmICh0bXApCj4+ICsJCQkJKm1zZyA9IHRt
cDsKPj4gIAkJCXJldHVybiAxOwo+PiAgCQl9Cj4+ICAJfQo+PiBAQCAtMTMxMyw2ICsxMzE1LDcg
QEAgdm9pZCBkb19tYWNoaW5lX2NoZWNrKHN0cnVjdCBwdF9yZWdzICpyZWdzLCBsb25nIGVycm9y
X2NvZGUpCj4+ICAJCSAqIG1ha2Ugc3VyZSB3ZSBoYXZlIHRoZSByaWdodCAibXNnIi4KPj4gIAkJ
ICovCj4+ICAJCWlmICh3b3JzdCA+PSBNQ0VfUEFOSUNfU0VWRVJJVFkgJiYgbWNhX2NmZy50b2xl
cmFudCA8IDMpIHsKPj4gKwkJCW1zZyA9ICJVbmtub3duIjsKPj4gIAkJCW1jZV9zZXZlcml0eSgm
bSwgY2ZnLT50b2xlcmFudCwgJm1zZywgdHJ1ZSk7Cj4+ICAJCQltY2VfcGFuaWMoIkxvY2FsIGZh
dGFsIG1hY2hpbmUgY2hlY2shIiwgJm0sIG1zZyk7Cj4+ICAJCX0KPj4gLS0gCj4gCj4gQ2FuIHdl
IGdldCByaWQgb2YgYWxsIHRoYXQgc2lsbGluZXNzIG9mIGRlYWxpbmcgd2l0aCBhIHBvc3NpYmx5
Cj4gdW5pbml0aWFsaXplZCBwb2ludGVyIGluIHRoZSBjYWxsZXJzIGFuZCBzaW1wbHkgZG8gYXQg
dGhlIGJlZ2lubmluZyBvZgo+IG1jZV9wYW5pYygpOgo+IAo+IAlpZiAoIW1zZykKPiAJCW1zZyA9
ICJVbmtub3duIjsKPiAKPiA/Cj4gCgpOb3QgcXVpdGUuIG1jZV9wYW5pYygpIGFscmVhZHkgaGFu
ZGxlcyBOVUxMIGFzIGEgdmFsdWUgZm9yICJleHAiIChub3QgIm1zZyIpLgoKV2Ugc3RpbGwgbmVl
ZCB0byBwYXNzIE5VTEwgb3IgYSBwcm9wZXIgcG9pbnRlci4gTm90IHNvbWUgdW5pbml0aWFsaXpl
ZCwgcG90ZW50aWFsbHkKcmFuZG9tIGRhdGEuCgpTbywgYXQgdGhlIHZlcnkgbGVhc3Qgd2UgbmVl
ZCB0byBpbml0aWFsaXplICJ0bXAiIGluIG1jZV9ub193YXlfb3V0KCksIGlmIHlvdSdyZSBsb29r
aW5nCmZvciBhIG1pbmltYWwgcGF0Y2guCgpUaGlzIHdvdWxkIHR1cm4gdGhlIChub24tZXhpc3Rp
bmcpIGRlc2NyaXB0aW9uIG9mIHRoZSAibXNnIiBhcmd1bWVudCBvZiBtY2Vfc2V2ZXJpdHkoKQpm
cm9tIGFuIGFzc3VtZWQ6CiAgImFuIGltcGxlbWVudGF0aW9uIG1heSBvciBtYXkgbm90IHVwZGF0
ZSBhIHByb3ZpZGVkICptc2cgYXJndW1lbnQiCnRvOgogICJhbiBpbXBsZW1lbnRhdGlvbiBtdXN0
IGVpdGhlciBhbHdheXMgdXBkYXRlIGEgcHJvdmlkZWQgKm1zZyBhcmd1bWVudCwgb3IgaXQgbXVz
dCBuZXZlciBkbyBzbyIKClJlZ2FyZHMKSmFuCgotLQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

