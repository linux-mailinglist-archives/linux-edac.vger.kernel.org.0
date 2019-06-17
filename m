Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7F48356
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 15:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFQNA6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 09:00:58 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:11128 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFQNA6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Jun 2019 09:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560776457; x=1592312457;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KnynchamP1yl4uXc3vaUNVtHe8Iw/fDe/Wyl73exxdc=;
  b=Cu8MzXfQZmqppH6Kpru2u9O0Hhe0lCwhVFWhikWS3ou39ezkF6ryo9i8
   zhUfQOw5x+oYjsmivTcds01SfTRoUWQAdqkV+WvVKe1ucYMvPXS3jvNdl
   AV7P7OdWmAkp0Tka3pUANU2zPiZLIotOC2w+YCCaJGFmiUYZLST6od9pJ
   I=;
X-IronPort-AV: E=Sophos;i="5.62,385,1554768000"; 
   d="scan'208";a="680326438"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 17 Jun 2019 13:00:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 085A2240FF7;
        Mon, 17 Jun 2019 13:00:50 +0000 (UTC)
Received: from EX13D08UEE004.ant.amazon.com (10.43.62.182) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Jun 2019 13:00:50 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D08UEE004.ant.amazon.com (10.43.62.182) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Jun 2019 13:00:50 +0000
Received: from [10.107.3.17] (10.107.3.17) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Mon, 17 Jun 2019 13:00:46 +0000
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     James Morse <james.morse@arm.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <3129ed19-0259-d227-0cff-e9f165ce5964@arm.com>
 <4514bfa2-68b2-2074-b817-2f5037650c4e@amazon.com>
 <fdc3b458-96eb-1734-c294-2463f37f2244@arm.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <bbb9b41d-8ffa-d4c5-c199-2400695cce8d@amazon.com>
Date:   Mon, 17 Jun 2019 16:00:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <fdc3b458-96eb-1734-c294-2463f37f2244@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


>>>> +static void al_a57_edac_l2merrsr(void *arg)
>>>> +{
>>>
>>>> +    edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");
>>>
>>> How do we know this is corrected?
> 
>>> If looks like L2CTLR_EL1[20] might force fatal 1/0 to map to uncorrected/corrected. Is
>>> this what you are depending on here?
> 
>> No - not on this. Reporting all the errors as corrected seems to be bad.
>>
>> Can i be depends on fatal field?
> 
> That is described as "set to 1 on the first memory error that caused a Data Abort". I
> assume this is one of the parity-error external-aborts.
> 
> If the repeat counter shows, say, 2, and fatal is set, you only know that at least one of
> these errors caused an abort. But it could have been all three. The repeat counter only
> matches against the RAMID and friends, otherwise the error is counted in 'other'.
> 
> I don't think there is a right thing to do here, (other than increase the scrubbing
> frequency). As you can only feed one error into edac at a time then:
> 
>> if (fatal)
>>      edac_device_handle_ue(edac_dev, 0, 0, "L2 Error");
>> else
>>      edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");
> 
> seems reasonable. You're reporting the most severe, and 'other/repeat' counter values just
> go missing.
I had print the values of 'other/repeat' to be noticed.

> 
> 
>> How can L2CTLR_EL1[20] force fatal?
> 
> I don't think it can, on a second reading, it looks to be even more complicated than I
> thought! That bit is described as disabling forwarding of uncorrected data, but it looks
> like the uncorrected data never actually reaches the other end. (I'm unsure what 'flush'
> means in this context.)
> I was looking for reasons you could 'know' that any reported error was corrected. This was
> just a bad suggestion!
Is there interrupt for un-correctable error?
Does 'asynchronous errors' in L2 used to report UE?

In case no interrupt, can we use die-notifier subsystem to check if any 
error had occur while system shutdown?

>>>> +        cluster = topology_physical_package_id(cpu);
>>>
>>> Hmm, I'm not sure cluster==package is guaranteed to be true forever.
>>>
>>> If you describe the L2MERRSR_EL1 cpu mapping in your DT you could use that. Otherwise
>>> pulling out the DT using something like the arch code's parse_cluster().
> 
>> I rely on that it's alpine SoC specific driver.
> 
> ... and that the topology code hasn't changed to really know what a package is:
> https://lore.kernel.org/lkml/20190529211340.17087-2-atish.patra@wdc.com/T/#u
> 
> As what you really want to know is 'same L2?', and you're holding the cpu_read_lock(),
> would struct cacheinfo's shared_cpu_map be a better fit?
> 
> This would be done by something like a cpu-mask of cache:shared_cpu_map's for the L2's
> you've visited. It removes the dependency on package==L2, and insulates you from the
> cpu-numbering not being exactly as you expect.
I'll add dt property that point to L2-cache node (phandle), then it'll 
be easy to create cpu-mask with all cores that point to same l2 cache.

Thanks,
Hanna


