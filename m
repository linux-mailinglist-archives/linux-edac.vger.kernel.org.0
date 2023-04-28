Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC56F1F32
	for <lists+linux-edac@lfdr.de>; Fri, 28 Apr 2023 22:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjD1US5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Apr 2023 16:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjD1US4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Apr 2023 16:18:56 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE865F1
        for <linux-edac@vger.kernel.org>; Fri, 28 Apr 2023 13:18:54 -0700 (PDT)
Message-ID: <d33f0103-b281-55c5-42fc-4d6eea215763@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1682713131;
        bh=nIfhgEhP/2S+qTVEh3UqzNrI4aH5Uuq9+UxSzIjH+NU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UrOpTCMn2UBW9STBJFfL6hPwxvJGdsLZ7QTWZyz5mXpKeqScA0C+z1o6qVe5yHm5E
         p17HWV0JZGj9osdNJr0UR/rxwpyz6FDYLIWXgXjSArDqYOz4naVlRlAdoTmfCULVxT
         cjwLAh5ETvk4Z2VSzgSHowgKGIAwaAEvIqFOJBiA=
Date:   Fri, 28 Apr 2023 22:18:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: ECC DDR5 ram with i9-12950HX
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac@vger.kernel.org
References: <b14a8fd2-4c11-1d76-f27d-e9d10c94ca9d@wetzel-home.de>
 <ZEvsamYDRi7wZr/b@agluck-desk3.sc.intel.com>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <ZEvsamYDRi7wZr/b@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 28.04.23 17:55, Tony Luck wrote:
> On Sat, Apr 15, 2023 at 10:21:07PM +0200, Alexander Wetzel wrote:
>> Hello,
>>
>> I've problems getting ECC ram working in a Thinkpad P16.
>>
>> The processor is a i9-12950HX with ECC ram but at least a 6.2.11 kernel is
>> not detecting the memory controller:
>>
>> # edac-util
>> edac-util: Error: No memory controller data found.
>>
>> The only reference to edac on kernel boot is that here:
>> [    1.237414] EDAC MC: Ver: 3.0.0
>>
>> For my understanding this here looks like the memory controller:
>> 0000:00:14.2 RAM memory: Intel Corporation Alder Lake-S PCH Shared SRAM (rev
>> 11)
>>
>> But there is no driver for the device (8086:7aa7) in 6.2.11 I can find.
>> I was assuming that igen6_edac is supporting Alder Lake CPUs but even when
>> loaded manually it's not working...
>>
>> Is there a way to get ECC working with linux? Are there any patches I could
>> apply?
> 
> Alexander
> 
> You don't need an EDAC driver to turn on ECC. Your BIOS should have
> done all the necessary memory controller and chipset magic to enable
> ECC. So you should already be getting the extra reliability that
> ECC memory provides.
> 
I would just have like to have a way to see it's working:-)

In the meantime I also checked with Win11 and the official drivers 
installed. Even Windows claims, that only single bit errors are fixed.
Now since that seems to be the new default with DDR5 ram I was wondering 
if I really have benefit by using "real" ECC ram or if something if 
wrong. Looks like I have to "trust" the vendors here...

> EDAC driver serve two purposes:
> 
> 1) To provide an accurate enumeration of which size/type DIMMs are in
> each slot. This is required by large HPC clusters to check that the
> DIMM configuration on every node of the thousands in their cluster
> without having to physically open each machine.
> 
> 2) When there are memory errors, translate the physical address recorded
> by the CPU to the specific DIMM that was the source of the error (to
> speed up diagnosis of the problem and fixing it in one try).
> 
> I'm sorry that there isn't an EDAC driver for your system. Most > of the effort here goes to EDAC for server systems.

Thanks for the explanation.

Alexander

> 
> -Tony

