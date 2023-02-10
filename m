Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76E691EE3
	for <lists+linux-edac@lfdr.de>; Fri, 10 Feb 2023 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjBJMQi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Feb 2023 07:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJMQh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Feb 2023 07:16:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BA5FE59;
        Fri, 10 Feb 2023 04:16:36 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CA841EC068E;
        Fri, 10 Feb 2023 13:16:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676031395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VjBuongz7TJEyYHKrgtVCdpTP0D6Op4JfT9l+oKjcv0=;
        b=DQM7rOPkw9Hq03B3vCEVVNMa6+oPDtcsGmfn7gWKKD+t/h9rlMgCB1JnKvfY2qhTtT9gF7
        BiNZjk/ah1YOuB3FgW6kmVujPDElAaktiwWXrSlUH7GCao44Baxe3t7I79ARPfRUmlOCkC
        2SolUUP2S+5rEGn66S83xmaLf1ABWrk=
Date:   Fri, 10 Feb 2023 13:16:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 05/22] EDAC/amd64: Remove early_channel_count()
Message-ID: <Y+Y1nfLOG20n+zi3@zn.tnic>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
 <20230127170419.1824692-6-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127170419.1824692-6-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 27, 2023 at 05:04:02PM +0000, Yazen Ghannam wrote:
> The early_channel_count() function seems to have been useful in the past
> for knowing how many EDAC mci structures to populate. However, this is no
> longer needed as the maximum channel count for a system is used instead.
> 
> Remove the early_channel_count() helper functions and related code. Use the
> size of the channel layer when iterating over channel structures.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lore.kernel.org/r/20220509145534.44912-1-yazen.ghannam@amd.com
> 
> v1->v2:
> * New in v2.
> 
>  drivers/edac/amd64_edac.c | 116 +-------------------------------------
>  drivers/edac/amd64_edac.h |   2 -
>  2 files changed, 2 insertions(+), 116 deletions(-)

First 5 patches: applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
