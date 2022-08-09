Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FDD58D3F5
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 08:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbiHIGmg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiHIGmf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 02:42:35 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F9201AC;
        Mon,  8 Aug 2022 23:42:33 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aecbd.dynamic.kabel-deutschland.de [95.90.236.189])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D747D61EA192A;
        Tue,  9 Aug 2022 08:42:29 +0200 (CEST)
Message-ID: <6d1576c9-f105-2aff-4497-2c2e7bed2f3b@molgen.mpg.de>
Date:   Tue, 9 Aug 2022 08:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Referencing non-public datasheets in commit messages (was: [PATCH v12
 3/3] EDAC: nuvoton: Add NPCM memory controller driver)
To:     Borislav Petkov <bp@alien8.de>
Cc:     medadyoung@gmail.com, KWLIU@nuvoton.com, tony.luck@intel.com,
        rric@kernel.org, benjaminfair@google.com,
        linux-edac@vger.kernel.org, KFTING@nuvoton.com,
        avifishman70@gmail.com, venture@google.com,
        openbmc@lists.ozlabs.org, JJLIU0@nuvoton.com, ctcchien@nuvoton.com,
        tali.perry1@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, james.morse@arm.com, YSCHU@nuvoton.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        tmaimon77@gmail.com
References: <20220610084340.2268-1-ctcchien@nuvoton.com>
 <20220610084340.2268-4-ctcchien@nuvoton.com> <YrDIimW0gW1j03WG@zn.tnic>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YrDIimW0gW1j03WG@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Borislav,


Am 20.06.22 um 21:20 schrieb Borislav Petkov:
> On Fri, Jun 10, 2022 at 04:43:40PM +0800, medadyoung@gmail.com wrote:

[…]

>> Datasheet:
>>      Cadence DDR Controller Register Reference Manual For DDR4 Memories
>>      Chapter 2: Detailed Register Map
> 
> If that datasheet is not public, no need to mention it here. At least a
> quick web search cannot find something relevant.

Maybe it could be denoted, that is not public (and also the version), 
but even mentioning non-public datasheets is useful, as they could be 
made public in the future, and allows everyone to contact people with 
access to these datasheets to take a look into the specific datasheet.


Kind regards,

Paul
