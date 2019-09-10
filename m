Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A2AE8E2
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfIJLKY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Sep 2019 07:10:24 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:35286 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfIJLKY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Sep 2019 07:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568113823; x=1599649823;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fgDPTEsn7ZWHjFND/LI/Wp/mhnZ31/D6nGDRthZQawY=;
  b=YCiqv1qGPMOtqnBojWNk9JFLwymPYXGNXvIS4PEOHbUyeceA33oYpyU+
   s0dXRe3EDCvga4KIJtqxPHwJyvzhUm//l49b/yyqqXpUv6Gh1G0xsJ0Ub
   AcWt4iNO2KEjT4m+kK4TZ9UIjczM6SGPWhqN3G7KIheLEyGMu4j45wTKZ
   c=;
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="784192521"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Sep 2019 11:10:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id CEDFAA1D54;
        Tue, 10 Sep 2019 11:10:19 +0000 (UTC)
Received: from EX13D21UWA003.ant.amazon.com (10.43.160.184) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 11:10:19 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D21UWA003.ant.amazon.com (10.43.160.184) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 11:10:19 +0000
Received: from [10.125.238.37] (10.125.238.37) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Tue, 10 Sep 2019 11:10:16 +0000
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Subject: Re: [PATCH 1/1] edac: Add an API for edac device to report for
 multiple errors
To:     Borislav Petkov <bp@alien8.de>
CC:     Robert Richter <rrichter@marvell.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
References: <20190905083745.6899-1-hhhawa@amazon.com>
 <20190905095642.ohqkcllm7wufx6sc@rric.localdomain>
 <50f5bc27-98da-ee3e-59dd-7252c3ed7a0a@amazon.com>
 <20190908081602.GC16220@zn.tnic> <20190908083535.GD16220@zn.tnic>
Message-ID: <488b07a8-ce39-d3fe-4e73-5e6f19176f1b@amazon.com>
Date:   Tue, 10 Sep 2019 14:10:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190908083535.GD16220@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi

On 9/8/2019 11:35 AM, Borislav Petkov wrote:
> On Sun, Sep 08, 2019 at 10:16:02AM +0200, Borislav Petkov wrote:
>> On Sun, Sep 08, 2019 at 10:58:31AM +0300, Hawa, Hanna wrote:
>>>> Better use WARN_ON_ONCE() to avoid flooding.
>>>
>>> In case of two drivers using this function with wrong error count, only the
>>> first WARN_ON_ONCE will catch in this case, and other will miss other wrong
>>> usage of other edac device drivers.
>>
>> The idea is to catch any driver using a 0 error count and fix it, not to
>> flood dmesg. You want _ONCE.
> 
> ... and you want to return early too, i.e.,
> 
> 	if (WARN_ON_ONCE(!error_count))
> 		return;
> 
> Frankly, I'd even remove all the warning functionality and simply do
> 
> 	if (!error_count)
> 		return;

I'll keep it simple as you suggest and remove the warning functionality.

> 
> but let's see how much it screams first.
> 

Thanks,
Hanna
