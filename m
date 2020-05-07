Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D064E1C9088
	for <lists+linux-edac@lfdr.de>; Thu,  7 May 2020 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEGOo3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 May 2020 10:44:29 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:43547 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgEGOo2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 7 May 2020 10:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588862668; x=1620398668;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EhmFSjy/EWu4Wg4+Zq15DUvDdCItcyPtF3MIASQ4kuU=;
  b=UonDMcNzKwUN8PLDuLfw+7jCfnD55n/tq6mESHzX9GNcydjowmXjctkI
   Fre9xYsAQUmh2NHKX551NDMtLcDjG4FJaoqR8fC7ouE9g4T9IHug7gdAm
   q4nCAA+5Z/hT5Ts6bAN8vpUWqk8kfRHPPMQDbBGDWD1BLugToVv+rPucu
   Q=;
IronPort-SDR: h8XIeuXXSd7VrbxtHgs+y2tea6p9HPut02kYVn9M57ENgzd7XyGo9x6DVBr7qaCk6mjPAvgIaI
 W815RWpqBTjg==
X-IronPort-AV: E=Sophos;i="5.73,364,1583193600"; 
   d="scan'208";a="33576905"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 May 2020 14:44:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 9C75FA21EF;
        Thu,  7 May 2020 14:44:24 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 May 2020 14:44:24 +0000
Received: from [10.85.103.159] (10.43.161.247) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 May
 2020 14:44:14 +0000
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
From:   "Shenhar, Talel" <talel@amazon.com>
To:     Borislav Petkov <bp@alien8.de>, <robh+dt@kernel.org>
CC:     <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <eitan@amazon.com>, <talel@amazon.com>
References: <20200224134132.23924-1-talel@amazon.com>
 <20200224134132.23924-2-talel@amazon.com> <20200428110659.GA11272@zn.tnic>
 <5e2c5119-52e9-2c3c-e205-e661ba218fcb@amazon.com>
Message-ID: <07f3b407-fa91-f3b4-bc7c-9692a7b3c3c7@amazon.com>
Date:   Thu, 7 May 2020 17:44:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5e2c5119-52e9-2c3c-e205-e661ba218fcb@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.43.161.247]
X-ClientProxiedBy: EX13D10UWA001.ant.amazon.com (10.43.160.216) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 5/5/2020 1:44 PM, Shenhar, Talel wrote:
>
> On 4/28/2020 2:06 PM, Borislav Petkov wrote:
>> On Mon, Feb 24, 2020 at 03:41:31PM +0200, Talel Shenhar wrote:
>>> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
>>>
>>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   .../bindings/edac/amazon,al-mc-edac.yaml      | 52 
>>> +++++++++++++++++++
>>>   1 file changed, 52 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml 
>>> b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>>> new file mode 100644
>>> index 000000000000..20505f37c9f8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>> WARNING: DT binding documents should be licensed (GPL-2.0-only OR 
>> BSD-2-Clause)
>> #36: FILE: 
>> Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml:1:
>> +# SPDX-License-Identifier: GPL-2.0-only
>>
>> Hi Rob, should I listen to checkpatch or ignore it?
>
> Rob and other dt folks,
>
> In continue to disscussion with Boris below, Looking at the checkpatch 
> check:
>
>    if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
>        not $spdx_license =~/GPL-2\.0.*BSD-2-Clause/) {
>
> It wants the whole string "GPL-2.0-only OR BSD-2-Clause" and my oatch 
> has only "GPL-2.0-only".
>
> Now, looking at a bunch of .yaml DT files, there are all kinds of 
> formatting:
>
> $ git grep -h SPDX *.yaml | sort | uniq -c
>       3 1:# SPDX-License-Identifier: (GPL-2.0)
>     313 1:# SPDX-License-Identifier: GPL-2.0
>       9 1:# SPDX-License-Identifier: GPL-2.0+
>       1 1:# SPDX-License-Identifier: (GPL-2.0-only)
>      43 1:# SPDX-License-Identifier: GPL-2.0-only
>       4 1:# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>       1 1:# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>     148 1:# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>      25 1:# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>     104 1:# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>       3 1:# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>       2 1:# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>       1 1:# SPDX-License-Identifier: (GPL-2.0-or-later)
>       5 1:# SPDX-License-Identifier: GPL-2.0-or-later
>       3 1:# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>       2 1:# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
>       3 1:# SPDX-License-Identifier: (GPL-2.0 OR MIT)
>       3 1:# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>       3 1:# SPDX-License-Identifier: (GPL-2.0+ OR X11)
>
> And the patch which did rule is:
>
> commit 50c92900214dd9a55bcecc3c53e90d072aff6560
> Author: Lubomir Rintel<lkundrak@v3.sk>
> Date:   Mon Apr 6 20:11:13 2020 -0700
>
>     checkpatch: check proper licensing of Devicetree bindings
>
>     According to Devicetree maintainers (see Link: below), the Devicetree
>     binding documents are preferrably licensed (GPL-2.0-only OR 
> BSD-2-Clause).
>
>     Let's check that.  The actual check is a bit more relaxed, to 
> allow more
>     liberal but compatible licensing (e.g.  GPL-2.0-or-later OR 
> BSD-2-Clause).
>
>
> Will love your help.
> This patch already have your (Rob) Reviewed-by so Boris and myself are 
> unsure what is the right thing to do now.

Borislav, after internal disscussion, we are good to go with the new 
license.

This shall be part of v7.

>
> Thanks,
> Talel.
>
>>
>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
