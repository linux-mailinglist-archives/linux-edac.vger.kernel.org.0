Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896235008F9
	for <lists+linux-edac@lfdr.de>; Thu, 14 Apr 2022 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbiDNI7N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Apr 2022 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbiDNI7M (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Apr 2022 04:59:12 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E9B68322;
        Thu, 14 Apr 2022 01:56:45 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae8d7.dynamic.kabel-deutschland.de [95.90.232.215])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 12B9961EA1936;
        Thu, 14 Apr 2022 10:56:44 +0200 (CEST)
Message-ID: <14d07709-07ef-21a8-ad74-0f56447cf6dd@molgen.mpg.de>
Date:   Thu, 14 Apr 2022 10:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Medad Young <medadyoung@gmail.com>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-4-ctcchien@nuvoton.com>
 <a06441fc-85cf-9386-e362-4a90e855aa19@molgen.mpg.de>
 <CAHpyw9fQVbS1Cpv0ULQc2=vK8LsG6n7tgP+J9AboUupDAPT27Q@mail.gmail.com>
 <YlfeXVSkUC2B4xH2@zn.tnic>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YlfeXVSkUC2B4xH2@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Borislav,


Am 14.04.22 um 10:42 schrieb Borislav Petkov:
> On Thu, Apr 14, 2022 at 09:55:05AM +0800, Medad Young wrote:
>>>> +                             if (mtype == MEM_TYPE_DDR4)
>>>> +                                     dimm->mtype = MEM_DDR4;
>>>> +                             else
>>>> +                                     dimm->mtype = MEM_EMPTY;
>>>
>>> Use ternary operator?
>>>
>>>       dimm-mtype = (mtype == MEM_TYPE_DDR4) ? MEM_DDR4 : MEM_EMPTY;
> 
> Ternary operator is less readable than a plain and simple if-else.
> 
>>>> +{
>>>> +     struct priv_data *priv = mci->pvt_info;
>>>> +     const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
>>>> +     u64 err_c_addr = 0x0;
>>>
>>> size_t
>>
>> OK
> 
> Why is size_t? error address doesn't have anything to do with a
> sizeof(), array indexing or loop counting.
> 
> It is an error address and having it in an u64 tells you exactly what
> its quantity is.

Good point. Sorry for missing that.

> So can we stop the silliness pls?

No idea, why you had to ask this question, while you statement before 
already made the point.

>>>> +static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
>>>> +{
>>>> +     struct mem_ctl_info *mci = dev_id;
>>>> +     struct priv_data *priv = mci->pvt_info;
>>>> +     const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
>>>> +     u32 intr_status;
>>>> +     u32 val;
>>>> +
>>>> +     /* Check the intr status and confirm ECC error intr */
>>>> +     intr_status = readl(priv->reg + npcm_chip->ecc_ctl_int_status);
>>>> +
>>>> +     edac_dbg(3, "InterruptStatus : 0x%x\n", intr_status);
>>>
>>> Remove the space before the colon? Maybe use:
>>>
>>> "Interrupt status (intr_status): 0x%x\n"
> 
> And repeat "interrupt status"? Also silly. The question to ask
> yourselves should always be: is this error message helpful enough to its
> intended recipients.
> 
> When I see
> 
>    "Interrupt status (intr_status): 0x%x\n"
> 
> in my code, I go: "hm, where does this message come from?" because it
> ain't helpful enough. So I have to go stare at the code too.
> 
> I hope you're catching my drift.

Sorry I do not get your point. Would you elaborate on the debug message 
so it’s more useful? Or would you keep `InterruptStatus`, or – as it’s a 
debug message – use the variable name? My point was mainly about, why 
not use the variable name directly in the debug message, and the space 
before the colon.


Kind regards,

Paul
