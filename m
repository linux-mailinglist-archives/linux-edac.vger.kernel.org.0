Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16151C2D01
	for <lists+linux-edac@lfdr.de>; Sun,  3 May 2020 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgECOVn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 May 2020 10:21:43 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:55622 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgECOVm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 May 2020 10:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588515702; x=1620051702;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZxYVmPuuA2zr6UpwhDSq7R3lJgKncnOeJeAf3v7KJHY=;
  b=wE8SaUDxh7OZ9NmBlvoY57LRaoKZ9rA0UvifVjUVL4/wqXveJGy3JpSn
   ++/xpRr9zVwquxE1SFq6qb49OMWlkvTLxj9I3ouUyROFA/GZ/UsUvCRkF
   EFIcJVvXjWX9L2xp7QGvantYxpqMsRNLB6UlhbvegLfpzHQHJzCxgiU3F
   E=;
IronPort-SDR: 7qyAQDUnU+bcCnQFJvC2pIBx8dUR+S2UUtK7lgyQLm9YPKIfPF7m9JI3fBitvnA4A8Gd2obW0w
 G83Qk/vzbktA==
X-IronPort-AV: E=Sophos;i="5.73,347,1583193600"; 
   d="scan'208";a="28326231"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 May 2020 14:21:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 1F696A25FD;
        Sun,  3 May 2020 14:21:23 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 3 May 2020 14:21:22 +0000
Received: from [10.95.73.94] (10.43.161.34) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 3 May
 2020 14:21:13 +0000
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
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
Message-ID: <0b34f059-5abb-2e30-ec6e-6052efc91d91@amazon.com>
Date:   Sun, 3 May 2020 17:21:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200428110659.GA11272@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D11UWC004.ant.amazon.com (10.43.162.101) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


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

Thank you Boris for the review,

I now see this recent  addition in checkpatch - 
https://lore.kernel.org/lkml/20200309215153.38824-1-lkundrak@v3.sk/

Will add that license as part of v7.

>
> --
> Regards/Gruss,
>      Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette


Thanks,

Talel.

