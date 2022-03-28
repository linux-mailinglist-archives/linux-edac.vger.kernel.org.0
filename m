Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAE4E98C8
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbiC1N5L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbiC1N5L (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 09:57:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA703ED34;
        Mon, 28 Mar 2022 06:55:29 -0700 (PDT)
Received: from zn.tnic (p200300ea9715611f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:611f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7A231EC0554;
        Mon, 28 Mar 2022 15:55:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648475723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v51/GA7qGzQ9pEDxulVsXavuYki3f2Nh9mBUVfXscDQ=;
        b=EJYuO70oMB74afi/VhOKs3Os/UKuh5Ke/fpt2BbU1Hqz86S0oZ+YDfQDLcWl5TDw3tOWnL
        EQhUEdjzXppadaI4tAcyCSi/nVN3b8YiAeZ0OpHGGz/LPIjPtk28gB1Sp0WLDd6pGlpP8l
        PRpOqsHwz1O/xp+kB1EwHPLQRFoBFhs=
Date:   Mon, 28 Mar 2022 15:55:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH 0/2] x86/mce: Grade new machine errors for AMD MCEs and
 include messages for panic cases
Message-ID: <YkG+SFCYMoAXrqJ3@zn.tnic>
References: <20220328134131.736572-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220328134131.736572-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 28, 2022 at 08:41:30AM -0500, Carlos Bilbao wrote:
> This patchset includes grading of new types of machine errors on AMD's MCE
> grading logic mce_severity_amd(), which helps the MCE handler determine
> what actions to take. If the error is graded as a PANIC, the EDAC driver
> will not decode; so we also include new error messages to describe the MCE
> and help debugging critical errors.
> 
> Carlos Bilbao (2):
>   x86/mce: Extend AMD severity grading function with new types of errors
>   x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
>  
>  arch/x86/include/asm/mce.h         |   6 +
>  arch/x86/kernel/cpu/mce/severity.c | 203 ++++++++++++++++++++++++-----
>  2 files changed, 174 insertions(+), 35 deletions(-)

How is this submission different from

https://lore.kernel.org/r/20220311165114.482074-1-carlos.bilbao@amd.com

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
