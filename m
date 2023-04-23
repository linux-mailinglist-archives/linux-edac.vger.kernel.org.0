Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2EA6EBFA1
	for <lists+linux-edac@lfdr.de>; Sun, 23 Apr 2023 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDWM5E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 23 Apr 2023 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDWM5D (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 23 Apr 2023 08:57:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E410D0;
        Sun, 23 Apr 2023 05:57:02 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DA021EC026E;
        Sun, 23 Apr 2023 14:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682254621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iqWPXK6WhJr8FmpOmcimT3w+sZg3NlhU3hwJtHK1lsI=;
        b=plJJLKGO6M5H3c89CV8FMFWVwSM3fK0oKvRHzUPpshpE6+Hv7DxoIcXvrkTOsILcyjNYNs
        5fb5up+ipUgXtybP8zTPumvESKuVutpttvX42Qu6rFF2076djWIsBjp091p4W6fWx9N9wP
        UL9zsVZWvfEV9Q07RJyBS5VaocV2+RA=
Date:   Sun, 23 Apr 2023 14:56:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ruliang Lin <u202112092@hust.edu.cn>
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: ras: cec: return value check of `d`
Message-ID: <20230423125657.GCZEUrGT7uhqNHTaLm@fat_crate.local>
References: <20230423122932.31274-1-u202112092@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230423122932.31274-1-u202112092@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Apr 23, 2023 at 08:29:32PM +0800, Ruliang Lin wrote:
> According to the documentation of the debugfs_create_dir() function, 
> there is no need to check the return value of this function.

" * Drivers should generally work fine even if debugfs fails to init anyway."

Except that this particular driver won't if there is no debugfs
hierarchy created.

> Just delete the dead code.

So no, in this case it is not dead code but very much alive.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
