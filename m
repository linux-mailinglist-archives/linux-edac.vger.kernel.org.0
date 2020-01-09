Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564D913633E
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2020 23:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgAIWa2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 17:30:28 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:3325 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgAIWa2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Jan 2020 17:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1578609028; x=1610145028;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RuLoT9A3DAM3IkZnDbtF36Y2f35bM6CNGlDRtI3vq2Q=;
  b=q4Kn4PmAHVNn4W7QLIa1BfAacJfERUSlJsnGm0LiPIP32Xak3c1yweA7
   8zkFurQLxaaWVOsnpNzncz3EECWKI0BrFRCyZlfR+4EMKUnO8lSm9qYak
   uTDkIbTX9MTLtT5i6TuvGoZWV2rBSjCkJzjyos48UtZBM0fH3zlaBf+//
   c=;
IronPort-SDR: K9JMWlMYJ9TN9S5SSjomQu2+ZhVU9Cqj7QJ7IFeyzYYHq/9G3N1jvxRTwB7kOM+TnnS6S5LcB0
 /HL7rB/PNoYQ==
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="11729569"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Jan 2020 22:30:25 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 5E1E8A23C2;
        Thu,  9 Jan 2020 22:30:22 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 009MUIhK021788;
        Thu, 9 Jan 2020 23:30:18 +0100
Subject: Re: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-7-jschoenh@amazon.de> <20200103220328.GF5099@zn.tnic>
 <BN6PR12MB16670832D78F2799730FB95FF83E0@BN6PR12MB1667.namprd12.prod.outlook.com>
 <20200108100356.GA27363@zn.tnic>
 <BN6PR12MB166720AEED7FE086308BC4ABF8390@BN6PR12MB1667.namprd12.prod.outlook.com>
 <3908561D78D1C84285E8C5FCA982C28F7F5202EC@ORSMSX115.amr.corp.intel.com>
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <1161eb84-4ebc-f938-f0ef-82ff6440dbd5@amazon.de>
Date:   Thu, 9 Jan 2020 23:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5202EC@ORSMSX115.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMDkvMDEvMjAyMCAyMi41NCwgTHVjaywgVG9ueSB3cm90ZToKPj4gSXQgc2VlbXMgdG8gbWUg
dGhhdCB0aGUgaXNzdWUgaXMgdGhlIG1jZWxvZyBub3RpZmllciBjb3VudHMgdG93YXJkIHRoZSBu
dW1iZXIKPj4gb2Ygbm90aWZpZXJzLCBzbyB0aGUgZGVmYXVsdCBub3RpZmllciBkb2Vzbid0IHBy
aW50IGFueXRoaW5nLgo+IAo+IElmIHdlIGdhdmUgYSBBUEkgdG8gdGhlIG5vdGlmaWVycyB0byBz
YXkgd2hldGhlciB0byBzdXBwcmVzcyBwcmludGluZywgdGhlbiB0aGUKPiBkZXZfbWNlbG9nKCkg
Y29kZSBjb3VsZCBkbyB0aGUgc3VwcHJlc3Npb24gb25seSBpZiBzb21lIHByb2Nlc3MgaGFkCj4g
L2Rldi9tY2Vsb2cgb3Blbi4gU28gaWYgbWNlbG9nKDgpIHdhc24ndCBydW5uaW5nLCB5b3UnZCBz
dGlsbCBzZWUgdGhlIGNvbnNvbGUKPiBtZXNzYWdlLgoKSSBicmllZmx5IGxvb2tlZCBpbnRvIHRo
YXQuCgpUaGVyZSBpcyB0aGUgaXNzdWUgdGhhdCBtY2Vsb2cgY29kZSBidWZmZXJzIE1DRXMgdW5j
b25kaXRpb25hbGx5LiBBbmQgd2UgcHJvYmFibHkKZG9uJ3Qgd2FudCB0byBkZWFjdGl2YXRlIHRo
YXQsIHNvIHRoYXQgTUNFcyBkdXJpbmcgYm9vdCBjYW4gYmUgcXVlcmllZAphIGJpdCBsYXRlciB2
aWEgL2Rldi9tY2Vsb2cuCgpXZSB3b3VsZCBnZXQgYSBiaXQgb2YgZHVwbGljYXRlIGxvZ2dpbmcs
IGlmIHdlIGxldCBtY2Vsb2cgcmVwb3J0ICJzdXByZXNzCnByaW50aW5nIiBvbmx5IGlmIHRoZXJl
IGlzIGFuIGFjdHVhbCBjb25zdW1lci4gKE9yIGlmIHRoZXJlIHdhcyBhIGNvbnN1bWVyCm9uY2Us
IGluIGNhc2UgdGhlcmUgYXJlIHBlcmlvZGljYWxseSBwb2xsaW5nIGNvbnN1bWVycy4pCgpSZWdh
cmRzCkphbgoKLS0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAy
MzcgODc5CgoK

