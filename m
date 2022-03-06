Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60454CEC36
	for <lists+linux-edac@lfdr.de>; Sun,  6 Mar 2022 17:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiCFQTa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Mar 2022 11:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiCFQTa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Mar 2022 11:19:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638426AF9;
        Sun,  6 Mar 2022 08:18:37 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-254-159.2.247.pool.telefonica.de [2.247.254.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B35D11EC03EA;
        Sun,  6 Mar 2022 17:18:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646583510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GHrftsko6o7ywdr7kHv1WL65OJ0Akz2CAgOo/zvybAc=;
        b=BVquDaj4RfD5jJNHLd9PL/IfZlK3Kf9C0SBp129+PVh0UaqWUQEmmrb+selSKaLUPUFcGO
        pHFMeUv3JNOhIzMFo40kdllo8KTYdZmTQ4hCpfiMG0UV6F4yn3sEH2ZGVPcZpfBC0YCNma
        /9OBH6Cavsut284Gocix5X6SjeWccP8=
Date:   Sun, 6 Mar 2022 17:18:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v4 0/2] AMD Family 19h Models 10h-1Fh Updates
Message-ID: <YiTezZBrQ8PVu80E@nazgul.tnic>
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220202144307.2678405-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Feb 02, 2022 at 02:43:05PM +0000, Yazen Ghannam wrote:
> Hi all,
> 
> This set adds support for AMD Family 19h Models 10h-1Fh and A0h-AFh.
> 
> Patch 1 sets the "memory type" per DIMM. 
> 
> Patch 2 adds register offset and other minor changes introduced with
> these new models.
> 
> Thanks,
> Yazen
> 
> Link:
> https://lore.kernel.org/r/20211228200615.412999-1-yazen.ghannam@amd.com
> 
> v3->v4:
> * Updated patch 1 to cache dram_type in struct umc.
> * Fixed uninitiliazed variable warning in patch 2.
> * Switched to a single register helper function.
> 
> v2->v3:
> * Patch 1 completely reworked.
> * Patch 2 updated based on comments from William.
> 
> Yazen Ghannam (2):
>   EDAC/amd64: Set memory type per DIMM
>   EDAC/amd64: Add new register offset support and related changes
> 
>  drivers/edac/amd64_edac.c | 113 +++++++++++++++++++++++++++++++-------
>  drivers/edac/amd64_edac.h |  17 ++++++
>  2 files changed, 109 insertions(+), 21 deletions(-)

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
