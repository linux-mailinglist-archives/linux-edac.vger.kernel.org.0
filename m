Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B571C5390
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgEEKpI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 06:45:08 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:10192 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEKpI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 May 2020 06:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588675507; x=1620211507;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XBSflEuWAde/CeVgwd1MVyCQIVmkLdJKa2kWwWmS9Qc=;
  b=k2jJfmbmOkUbhT+mX2cFVJ5jz8ZF0aECN+rQqC912s44US6ISTlwOIjJ
   4H+JM8LuXl8JelavGP9FEA8YblZDM9bPNg5BFB5fWmxItMazrQSG8k4EF
   0SL937on4Ax9fUN+3r21+GiM5YewKyJqvZbD30SDzInHitFPh3RWjUuW+
   M=;
IronPort-SDR: /zcmW88pk2aPTxCJdquuhy1OAS8pv2KZcoSP/u09BnfoQaUg8JxdjY2lqJSRaREoBcNIJ3WsQF
 +6613ajzi/Cw==
X-IronPort-AV: E=Sophos;i="5.73,354,1583193600"; 
   d="scan'208";a="42749270"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 May 2020 10:45:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id C2F85A26F7;
        Tue,  5 May 2020 10:44:58 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 10:44:58 +0000
Received: from [192.168.13.172] (10.43.162.38) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 May
 2020 10:44:48 +0000
Subject: [PATCH v6 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs
 Memory Controller EDAC
To:     Borislav Petkov <bp@alien8.de>, <robh+dt@kernel.org>
CC:     <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <eitan@amazon.com>
References: <20200224134132.23924-1-talel@amazon.com>
 <20200224134132.23924-2-talel@amazon.com> <20200428110659.GA11272@zn.tnic>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <5e2c5119-52e9-2c3c-e205-e661ba218fcb@amazon.com>
Date:   Tue, 5 May 2020 13:44:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200428110659.GA11272@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D37UWC004.ant.amazon.com (10.43.162.212) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Rob and other DT folks,

Can you please help with below query?


On 4/28/2020 2:06 PM, Borislav Petkov wrote:
> On Mon, Feb 24, 2020 at 03:41:31PM +0200, Talel Shenhar wrote:
>> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../bindings/edac/amazon,al-mc-edac.yaml      | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>> new file mode 100644
>> index 000000000000..20505f37c9f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
> WARNING: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)
> #36: FILE: Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml:1:
> +# SPDX-License-Identifier: GPL-2.0-only
>
> Hi Rob, should I listen to checkpatch or ignore it?

Rob and other dt folks,

In continue to disscussion with Boris below, Looking at the checkpatch 
check:

    if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
        not $spdx_license =~/GPL-2\.0.*BSD-2-Clause/) {

It wants the whole string "GPL-2.0-only OR BSD-2-Clause" and my oatch has only "GPL-2.0-only".

Now, looking at a bunch of .yaml DT files, there are all kinds of formatting:

$ git grep -h SPDX *.yaml | sort | uniq -c
       3 1:# SPDX-License-Identifier: (GPL-2.0)
     313 1:# SPDX-License-Identifier: GPL-2.0
       9 1:# SPDX-License-Identifier: GPL-2.0+
       1 1:# SPDX-License-Identifier: (GPL-2.0-only)
      43 1:# SPDX-License-Identifier: GPL-2.0-only
       4 1:# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
       1 1:# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
     148 1:# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
      25 1:# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
     104 1:# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
       3 1:# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
       2 1:# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
       1 1:# SPDX-License-Identifier: (GPL-2.0-or-later)
       5 1:# SPDX-License-Identifier: GPL-2.0-or-later
       3 1:# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
       2 1:# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
       3 1:# SPDX-License-Identifier: (GPL-2.0 OR MIT)
       3 1:# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
       3 1:# SPDX-License-Identifier: (GPL-2.0+ OR X11)

And the patch which did rule is:

commit 50c92900214dd9a55bcecc3c53e90d072aff6560
Author: Lubomir Rintel<lkundrak@v3.sk>
Date:   Mon Apr 6 20:11:13 2020 -0700

     checkpatch: check proper licensing of Devicetree bindings

     According to Devicetree maintainers (see Link: below), the Devicetree
     binding documents are preferrably licensed (GPL-2.0-only OR BSD-2-Clause).

     Let's check that.  The actual check is a bit more relaxed, to allow more
     liberal but compatible licensing (e.g.  GPL-2.0-or-later OR BSD-2-Clause).


Will love your help.
This patch already have your (Rob) Reviewed-by so Boris and myself are unsure what is the right thing to do now.

Thanks,
Talel.

>
> --
> Regards/Gruss,
>      Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
