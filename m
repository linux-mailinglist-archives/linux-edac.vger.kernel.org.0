Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8305C703024
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 16:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbjEOOja (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 10:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOOja (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 10:39:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE41FD
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 07:39:29 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC62E1EC04CC;
        Mon, 15 May 2023 16:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684161567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fQ3aEeM2Ba6wG2pMK4X/Y4B9sVI+teSGbp7tru9K1P4=;
        b=sU2XSIdnVdlTQe7kA3vDi05dUC/bjpFPuHKAyGMDejQ9PAtaGY6FC1ZBS39/K8biAAAvmX
        SQq5EkLE/YO9xRZqjSGakwY7m1afe1UzbxRdVuck4jnQCNFBMnFq4JM1O6CoXb82I7e/ry
        Dd6jgDaYp+hY7b2+fpuVe3U52+jsQ/s=
Date:   Mon, 15 May 2023 16:39:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hristo Venev <hristo@venev.name>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/amd64: Add support for ECC on family 19h model
 60h-7Fh
Message-ID: <20230515143923.GFZGJEGxTlnuWttZTe@fat_crate.local>
References: <d619252e-35c7-814b-acdb-74714619d62a@amd.com>
 <20230511174506.875153-2-hristo@venev.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230511174506.875153-2-hristo@venev.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 11, 2023 at 08:45:07PM +0300, Hristo Venev wrote:
> Ryzen 9 7950X uses model 61h. Treat it as Epyc 9004, but with 2 channels
> instead of 12.
> 
> I tested this with two 32GB dual-rank DIMMs. The sizes appear to be
> reported correctly:
> 
>     [    2.122750] EDAC MC0: Giving out device to module amd64_edac controller F19h_M60h: DEV 0000:00:18.3 (INTERRUPT)
>     [    2.122751] EDAC amd64: F19h_M60h detected (node 0).
>     [    2.122754] EDAC MC: UMC0 chip selects:
>     [    2.122754] EDAC amd64: MC: 0:     0MB 1:     0MB
>     [    2.122755] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>     [    2.122757] EDAC MC: UMC1 chip selects:
>     [    2.122757] EDAC amd64: MC: 0:     0MB 1:     0MB
>     [    2.122758] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>     [    2.122759] AMD64 EDAC driver v3.5.0
> 
> ECC errors can also be detected:
> 
>     [  313.747594] mce: [Hardware Error]: Machine check events logged
>     [  313.747597] [Hardware Error]: Corrected error, no action required.
>     [  313.747613] [Hardware Error]: CPU:0 (19:61:2) MC21_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000400011b
>     [  313.747632] [Hardware Error]: Error Addr: 0x00000007ff7e93c0
>     [  313.747639] [Hardware Error]: IPID: 0x0000009600050f00, Syndrome: 0x000100010a801203
>     [  313.747652] [Hardware Error]: Unified Memory Controller Ext. Error Code: 0, DRAM ECC error.
>     [  313.747669] EDAC MC0: 1 CE Cannot decode normalized address on mc#0csrow#3channel#0 (csrow:3 channel:0 page:0x0 offset:0x0 grain:64 syndrome:0x1)
>     [  313.747672] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD
> 
> According to Mario Limonciello, the same code should also work for
> models 70h-7Fh [1].
> 
> Link: https://lore.kernel.org/linux-edac/d619252e-35c7-814b-acdb-74714619d62a@amd.com/T/#m9fc20d5dc36074048ec5f1c0a5b01b7f972a1cc7 [1]
> Signed-off-by: Hristo Venev <hristo@venev.name>
> ---
>  drivers/edac/amd64_edac.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
