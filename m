Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EAE60E774
	for <lists+linux-edac@lfdr.de>; Wed, 26 Oct 2022 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiJZSb1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Oct 2022 14:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiJZSbJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Oct 2022 14:31:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C0289906;
        Wed, 26 Oct 2022 11:30:09 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6C571EC06A7;
        Wed, 26 Oct 2022 20:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666808995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c14ywI1xdXZdWoFtZUGaNlQ7OSW7CsbDv0TnLHcpulI=;
        b=GP3Uy3esNFrgCaYo+T1RfJ2EKCwPdigLmou+msv7WmmkDBsbwtQSQ7a5koSzq2kn4shbcV
        OtlR1SrKs+9Fwr6HSDaZ1ABzy/oMdf8Em8tK43Ci4Xbsc2pppNRIoGHZe3JQT206xp/1e2
        k5pLcNt0SNIC7naWtPQ3tWkZbTVpUXo=
Date:   Wed, 26 Oct 2022 20:29:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Y1l8nx1KnTFP1xKj@zn.tnic>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <Yql9TqFtebd2h9Z9@kroah.com>
 <Yqnj88FPkZ6kBU7k@yaz-fattaah>
 <Y1kJCHBtatohj/JK@zn.tnic>
 <Y1kiNBh3/XBNe6uv@kroah.com>
 <Y1lUo08UzaqIaI7r@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1lUo08UzaqIaI7r@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 26, 2022 at 03:39:15PM +0000, Yazen Ghannam wrote:
> What's the issue with my original patch?

Do you see it?

> @@ -1258,10 +1258,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
>         struct threshold_block *pos = NULL;
>         struct threshold_block *tmp = NULL;
>  
> -       kobject_del(b->kobj);
> +       kobject_put(b->kobj);
>  
>         list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
> -               kobject_del(&pos->kobj);
> +               kobject_put(b->kobj);

You're basically putting the parent as many times as there are elements
on the ->miscj list.

Basically what Greg doesn't like.

Him and I need to talk it over first whether my gross hack of grafting
the bank4 kobject hierarchy from CPU0 onto the other CPUs on the node is
even viable so stay tuned...

> I think this is the simplest way to fix the current implementation.
> But we should probably get rid of this kobject sharing idea in light
> of Greg's comments.

You said it. :)

Or maybe do a better one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
