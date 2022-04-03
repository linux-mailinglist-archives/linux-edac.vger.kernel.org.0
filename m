Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C52A4F0B9E
	for <lists+linux-edac@lfdr.de>; Sun,  3 Apr 2022 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiDCRrh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 Apr 2022 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359696AbiDCRrM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 Apr 2022 13:47:12 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421525C53;
        Sun,  3 Apr 2022 10:45:13 -0700 (PDT)
Received: from [192.168.148.80] (unknown [182.2.43.220])
        by gnuweeb.org (Postfix) with ESMTPSA id 1096C7E30F;
        Sun,  3 Apr 2022 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1649007913;
        bh=73TtLUw4DMylpMnfdYjiHvwOPxWp4Ddhn2xsApM4pHY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=JIem0cRa6smJjTsFZjUZ5ywj/sp72EIdsY358XtLHseBib1dle2GzNDg7iVxCFpl0
         x/OBIfSeQ001TSB0FrqHggdlKP9j30+x9EbLkyQMkU96Axycxny1LThAFGa2WGPdQ9
         6SqbealykMctFwzU7P6XifBZF8PYeoafW2zL1s63qEu6C5T0A9iblu+DenoI4Zt9Kg
         jogjeiWimu4KkRoZCAEaK5gSudBYlHo7VOBaxa+1IRkQkYT802/q5xyFxdVHMGVSmE
         3Z+3yi0rFQImP9H3w4HjVKvZK+arjWFgppUFM1Aa57cHYErHgrGyo6l89lFZW1u3Ye
         ODujbkfH9uwAQ==
Message-ID: <00347b4a-e719-9dac-b42b-05a3f117fd46@gnuweeb.org>
Date:   Mon, 4 Apr 2022 00:45:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 2/2] x86/MCE/AMD: Fix memory leak when
 `threshold_create_bank()` fails
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable Kernel <stable@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        x86 Mailing List <x86@kernel.org>
References: <20220329104705.65256-1-ammarfaizi2@gnuweeb.org>
 <20220329104705.65256-3-ammarfaizi2@gnuweeb.org> <87wng6ksjl.ffs@tglx>
 <215ca9e7-b719-d5b8-c6db-1d71544d47be@gnuweeb.org>
In-Reply-To: <215ca9e7-b719-d5b8-c6db-1d71544d47be@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/4/22 12:43 AM, Ammar Faizi wrote:
> On 4/4/22 12:03 AM, Thomas Gleixner wrote:
>> On Tue, Mar 29 2022 at 17:47, Ammar Faizi wrote:
>>
>>> In mce_threshold_create_device(), if threshold_create_bank() fails, the
>>> @bp will be leaked, because the call to mce_threshold_remove_device()
>>> will not free the @bp. mce_threshold_remove_device() frees
>>> @threshold_banks. At that point, the @bp has not been written to
>>> @threshold_banks, @threshold_banks is NULL, so the call is just a nop.
>>>
>>> Fix this by extracting the cleanup part into a new static function
>>> __threshold_remove_device(), then call it from create/remove device
>>> functions.
>>
>> The way simpler fix is to move
>>
>>>       }
>>>       this_cpu_write(threshold_banks, bp);
>>
>> before the loop. That's safe because the banks cannot yet be reached via
>> an MCE as the vector is not yet enabled:
>>>       if (thresholding_irq_en)
>>>           mce_threshold_vector = amd_threshold_interrupt;
> Thomas,
> 
> I did like what you said (in the patch v4), but after Yazen and Borislav
> reviewed it, we got a conclusion that it's not safe.
> 
> See [1] and [2] for the full message.
> 
> [1]: https://lore.kernel.org/lkml/YkFsQhpGGXIFTMyp@zn.tnic/
> [2]: https://lore.kernel.org/lkml/Yh+oyD%2F5M3TW5ZMM@yaz-ubuntu/
> 
> Yazen, Borislav, please take a deeper look on this again. I will send
> a v7 revision to really make it simpler by moving that "per-CPU var write"
> before the loop.

(only if it's really safe)

-- 
Ammar Faizi
