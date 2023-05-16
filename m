Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E2704C32
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjEPLUE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjEPLT5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 07:19:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBD61BF0;
        Tue, 16 May 2023 04:19:48 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1AE71EC051E;
        Tue, 16 May 2023 13:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684235987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O97Kez14uS113laxfdeSJhpmFj7tLBqrH+ovA5IxkBs=;
        b=sFWrnOaMlPzCkBx1sn5x+TSgoInr15VVsrp5vPAEHPa6My0AbEiMoVdhLeZcKKiJgSENvJ
        /2/9k74Ch47jkZHBReAIkHaaED8H6EZ237Cs6xDxCHf8jA/HbSRUANUITAS4lghNEXaJGA
        v6WGW5XbKlNVP2p9xjxoj5bVEShwmn8=
Date:   Tue, 16 May 2023 13:19:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
Message-ID: <20230516111942.GCZGNmzu3Abd4KmZu3@fat_crate.local>
References: <20230516103403.GBZGNcG7Q1sdtUpcHW@fat_crate.local>
 <20230516080748.3155788-1-yajun.deng@linux.dev>
 <e930d9a3efd6d99d2badc7bdff713afd@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e930d9a3efd6d99d2badc7bdff713afd@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 16, 2023 at 11:07:11AM +0000, Yajun Deng wrote:
> It will help users to confirm which MC belongs to which node if there
> are multiple MCs. Therefore, we can also know how many dimm on each
> node.

There are physical nodes, logical nodes, NUMA nodes, interleaving
between nodes...

Is there any practical use case and need behind this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
