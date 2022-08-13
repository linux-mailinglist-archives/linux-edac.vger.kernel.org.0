Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3A5919C7
	for <lists+linux-edac@lfdr.de>; Sat, 13 Aug 2022 12:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbiHMKKE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 13 Aug 2022 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiHMKKD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 13 Aug 2022 06:10:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E18FDFE0;
        Sat, 13 Aug 2022 03:10:02 -0700 (PDT)
Received: from zn.tnic (p2e55d27b.dip0.t-ipconnect.de [46.85.210.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BB1E1EC042D;
        Sat, 13 Aug 2022 12:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660385396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cN3EiT+fEaKP7OaJj1ZSByutugxIw61q8WkMnaotHS8=;
        b=C1Z9dyGXgnylJzqRJBge3xZySP8pJ6ZA+K3iuW97Eg7OkScz40l1+68Usso37VmyY0A2dZ
        XuGU0JeXMC5xE1ilcAHvXT/yRgxR3cqXk+mcrw4xdLk8DDsyibHBT4S/mJrd/kpmNSoras
        bSbu3MaSHrGtkDHoLqOp+hG2zjcRYnA=
Date:   Sat, 13 Aug 2022 12:09:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Yvd4cCW4ng2cG96p@zn.tnic>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <7c8e34c8-f12d-e7e4-b6bc-4867824865ea@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c8e34c8-f12d-e7e4-b6bc-4867824865ea@o2.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 12, 2022 at 11:14:44PM +0200, Mateusz Jończyk wrote:
> Shouldn't there be "kobject_put(&pos->kobj)" here instead?

Yes, it should.

> Also, it seems to me that "kobject_put(b->kobj);" before the loop
> may be relocated after the loop - so that the refcounts on the child
> objects are decreased first, then the refcount on the parent object.

Yes, I guess we can do that.

> Additionally, shouldn't there be a call to
> "kobject_put(&b->blocks->kobj);" in __threshold_remove_blocks()?

Makes sense, we do

	kobject_add(&b->blocks->kobj, ...

in __threshold_add_blocks().

> From what I understand, b->blocks is a list head, so we need to
> decrease the refcount on it too.

Not list_heads - we modify the refcount of kobjects. See what the arg of
kobject_put() is.

> After these changes, the __threshold_remove_blocks() function looks
> very similar to deallocate_threshold_blocks() function just above it.

Yes, minus the list_del(&pos->miscj); But that can be made conditional
with a bool arg to deallocate_threshold_blocks() and then remove
__threshold_remove_blocks().

Care to take Yazen's patch, fix it up, test it thoroughly (you should
enable KASAN to catch any potential memory leaks) and send it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
