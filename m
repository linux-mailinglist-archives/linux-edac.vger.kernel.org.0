Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12CB7120AD
	for <lists+linux-edac@lfdr.de>; Fri, 26 May 2023 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjEZHKC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 May 2023 03:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbjEZHKB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 May 2023 03:10:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D219E;
        Fri, 26 May 2023 00:09:59 -0700 (PDT)
Received: from nazgul.tnic (dynamic-002-247-249-230.2.247.pool.telefonica.de [2.247.249.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D6791EC0657;
        Fri, 26 May 2023 09:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685084998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=X0HHCOKK04/WfityQLFv+JuVRYYiZi/UhC8LKgTBpNY=;
        b=EANCxojIMfk+AAnld7m3n8Ja/AKbU02hdMkccAVhxEqzvAeUXPhyvo1G0Nf78LGcTEADaQ
        6OOQKSpr7YkmvyuzhOv4hp64XVntYHlFsjR2vdPGvfTybxySc8NVjOSuiLTn2uKDzMtFi5
        7bH/z0ghcUYDdl3oYa9kN8+9cvYcZK8=
Date:   Fri, 26 May 2023 09:09:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     tony.luck@intel.com, naoya.horiguchi@nec.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        akpm@linux-foundation.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v2] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Message-ID: <20230526070952.GAZHBbQNAWZJP6tOXv@nazgul.local>
References: <20230526063242.133656-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230526063242.133656-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 26, 2023 at 02:32:42PM +0800, Kefeng Wang wrote:
> The best way to fix them is set MCE_IN_KERNEL_COPYIN for MC-Safe Copy,
> then let the core do_machine_check() to isolate corrupted page instead
> of doing it one-by-one.

No, this whole thing is confused.

 * Indicates an MCE that happened in kernel space while copying data
 * from user.

#define MCE_IN_KERNEL_COPYIN

This is a very specific exception type: EX_TYPE_COPY which got added by

  278b917f8cb9 ("x86/mce: Add _ASM_EXTABLE_CPY for copy user access")

but Linus then removed all such user copy exception points in

  034ff37d3407 ("x86: rewrite '__copy_user_nocache' function")

So now that EX_TYPE_COPY never happens.

And what you're doing is lumping the handling for
EX_TYPE_DEFAULT_MCE_SAFE and EX_TYPE_FAULT_MCE_SAFE together and saying
that the MCE happened while copying data from user.

And XSTATE_OP() is one example where this is not really the case.

So no, this is not correct.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
