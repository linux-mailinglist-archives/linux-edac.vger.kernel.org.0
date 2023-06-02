Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7295A7206BC
	for <lists+linux-edac@lfdr.de>; Fri,  2 Jun 2023 18:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjFBQB6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Jun 2023 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjFBQBs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Jun 2023 12:01:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18081B1;
        Fri,  2 Jun 2023 09:01:43 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37DD71EC0138;
        Fri,  2 Jun 2023 18:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685721702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yXwINzbU9Zs+L0XJla9Sp6go4vxnlnsmfbOc7yeYTlg=;
        b=XjzTNN9dGShPCHk2P3RO/MYH8qxFqVPSbpqSrH0vbSD7bZkoRW072+rG7QuGewjGkRIlYN
        KYjPwC2zLJdjp33UgxK8HIeMnftgmaPJUet3aj1uKf8P7nInqVhsakdfHTL6UaepT4yy9y
        B0qgrT+QAEQDhSgThggjTlEdVZx9XR0=
Date:   Fri, 2 Jun 2023 18:01:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "chu, jane" <jane.chu@oracle.com>
Subject: Re: [PATCH v2] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Message-ID: <20230602160138.GDZHoSYsWoPAinMszk@fat_crate.local>
References: <20230526063242.133656-1-wangkefeng.wang@huawei.com>
 <20230526070952.GAZHBbQNAWZJP6tOXv@nazgul.local>
 <e816734d-e6f5-b990-c86d-ac7d5f1c94c0@huawei.com>
 <fa272c15-9f7c-df9c-41dd-bffc19acbf85@huawei.com>
 <SJ1PR11MB6083343FF74CAB54FC2B916AFC4EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083343FF74CAB54FC2B916AFC4EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 02, 2023 at 03:12:30PM +0000, Luck, Tony wrote:
> > As mentioned above, I am focus on copy_mc_XXX calling, it will
> > abort if the exception fires when accessing the source, and we
> > want to isolate the corrupted src page, maybe we could a new flag
> > to indicate this scenario, the *Final Goals* is to let core
> > do_machine_check to deal with the corrupted src page.
> 
> A new flag seems like a good direction.

Before anything happens here, the fate of the now unused EX_TYPE_COPY
needs to be decided first. Then new stuff.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
