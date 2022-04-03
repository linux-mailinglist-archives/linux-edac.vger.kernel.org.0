Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FABB4F0C6B
	for <lists+linux-edac@lfdr.de>; Sun,  3 Apr 2022 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376404AbiDCUAE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 Apr 2022 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiDCUAE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 Apr 2022 16:00:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B5919C26;
        Sun,  3 Apr 2022 12:58:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649015888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=av8yvivek0sS1bVVJeA7riLf6nNCr09H3YfL5nGaxqw=;
        b=UDL//1yyhruhR2hAWZVZIq9/BhCV9Au3rqmaIdCofA/7gYFNBox7q/SI1HpP6bzhNJkppo
        r8jB3QYS7Y9Hdl7kLRYrmRDfFZBFE0mWKYiCBauIvd+SdeV0m1bFLGmj0quQvfIu78RZcy
        UyQfzxDnYZDditswed3XmVHwwXmoTvGIMERXMtu68n/rW/LjulLzjkrILrMCbj+9b6kkb6
        26j/nOAZdmOBdSVSQ7ZVcHcpZwPHwfEBaEnIRkaQ089Q/R1K4DgWSwKk7rQc3aqNlkkhVr
        KcLBYElMDmJs80FHVyUFPc3+5N765UnYxHBpFbD8fnJTl+XZODoegqQnU9lORA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649015888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=av8yvivek0sS1bVVJeA7riLf6nNCr09H3YfL5nGaxqw=;
        b=MQCkBJToyoEqrvoG6+pa+DB9M8iWiY5vkL5SA+xDa6FDpDLHRwFBW+b1EL90XWVcXeFkBd
        Y2S4n+lsocKVsoAw==
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 2/3] x86/mce: Define function to extract ErrorAddr
 from MCA_ADDR
In-Reply-To: <Yknsbp+zMh8Uev8+@zn.tnic>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
 <YkWrlTIK/ZxsQekX@zn.tnic> <YkmeJFXXbu3aLzzw@zn.tnic>
 <Yknsbp+zMh8Uev8+@zn.tnic>
Date:   Sun, 03 Apr 2022 21:58:07 +0200
Message-ID: <87mth2kkhc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Apr 03 2022 at 20:50, Borislav Petkov wrote:
> On Sun, Apr 03, 2022 at 03:16:20PM +0200, Borislav Petkov wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index 9ccc2ea0ea00..4acc7959be6e 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -723,7 +723,7 @@ bool amd_mce_is_memory_error(struct mce *m)
>>  }
>>  
>>  /* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
>> -void smca_extract_err_addr(struct mce *m)
>> +void __always_inline smca_extract_err_addr(struct mce *m)
>
> Ok, flip those - the pedantic bot is not happy:
>
>>> arch/x86/kernel/cpu/mce/amd.c:726:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
>      726 | void __always_inline smca_extract_err_addr(struct mce *m)
>          | ^~~~
>
> Needs to be
>
> __always_inline void
>
> whateva...

How is __always_inline supposed to work across compilation units w/o
LTO? The callsite is in core.c ...

Thanks,

        tglx
