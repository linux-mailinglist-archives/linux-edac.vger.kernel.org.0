Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7320D4FB5AC
	for <lists+linux-edac@lfdr.de>; Mon, 11 Apr 2022 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbiDKIOt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Apr 2022 04:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiDKIOs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Apr 2022 04:14:48 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0BB3DDFA;
        Mon, 11 Apr 2022 01:12:34 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae91f.dynamic.kabel-deutschland.de [95.90.233.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7A71061EA1923;
        Mon, 11 Apr 2022 10:12:32 +0200 (CEST)
Message-ID: <ccf4d29e-9efb-23ea-b706-f00cde7ead4b@molgen.mpg.de>
Date:   Mon, 11 Apr 2022 10:12:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 1/3] ARM: dts: nuvoton: Add memory controller node
Content-Language: en-US
To:     Medad Young <medadyoung@gmail.com>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-2-ctcchien@nuvoton.com>
 <c73bf178-f5bd-01c6-209d-051706112877@molgen.mpg.de>
 <CAHpyw9ckLUNe8biEFSjHBndG_WD-7O-QsHO8Rr0eoXbROH0dUQ@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAHpyw9ckLUNe8biEFSjHBndG_WD-7O-QsHO8Rr0eoXbROH0dUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Medad,


Thank you for your reply.

Am 11.04.22 um 09:56 schrieb Medad Young:

[…]

> Paul Menzel 於 2022年4月9日 週六 下午1:57寫道：

>> Thank you for the patch.
>>
>> Am 22.03.22 um 04:01 schrieb Medad CChien:
>>> ECC must be configured in the BootBlock header.
>>
>> bootblock
>>
>> I search for *bootblock* in Linux and the git commit messages, and does
>> not seem to be a common term. Is that term used in the datasheet?
> 
> Yes, bootblock is a bootloader of our SOC

Nice. Never heard of it before. Maybe add the project URL as reference 
for the ignorant like me.

>>> Then, you can read error counts via
>>> the EDAC kernel framework.
>>
>> Please reflow for 75 characters per line. (Also, there is no need to
>> break lines after a sentence, unless 75 characters are reached or a new
>> paragraph starts.)
>>
>> Tested on what board?
> 
> I tested this on Nuvoton's BMC board

It would be nice to have that with the model number documented in the 
commit message.

>>> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
>>
>> Out of curiosity, is the first C in CChien the letter of your middle
>> name, or the last name really spelled with two capital letters in the
>> beginning?
> 
> this is a special last name in chinese.
> my last name does really spell with two capital letters in the beginning.

Interesting. Thank you for teaching me new things.


Kind regards,

Paul
