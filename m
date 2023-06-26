Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152F173EEAC
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jun 2023 00:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFZWco (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Jun 2023 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZWcn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Jun 2023 18:32:43 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B28E5A
        for <linux-edac@vger.kernel.org>; Mon, 26 Jun 2023 15:32:40 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 9395F53150; Mon, 26 Jun 2023 18:32:39 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 29601529A0;
        Mon, 26 Jun 2023 18:32:21 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id B22E7220039; Mon, 26 Jun 2023 18:32:20 -0400 (EDT)
Date:   Mon, 26 Jun 2023 18:32:20 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        aris@redhat.com
Subject: Re: [PATCH v2] mce: prevent concurrent polling of MCE events
Message-ID: <20230626223220.GX4090740@cathedrallabs.org>
References: <20230626203712.GW4090740@cathedrallabs.org>
 <ZJn8lbn5DzV0k+UR@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJn8lbn5DzV0k+UR@agluck-desk3>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 26, 2023 at 02:01:09PM -0700, Tony Luck wrote:
> It is already possible to associate a CPU with a package. The problem
> here is knowing which CPUs are sharing which banks.

Then this patch can be improved to have one lock per package instead one
for the entire system. How do I know which package the current CPU
belongs?

> Is mce_timer_fn() used on AMD? I think it is (mcheck_cpu_init() calls
> __mcheck_cpu_setup_timer() apparently unconditionally). So this code is
> OK if CONFIG_X86_MCE_INTEL=n because that's an empty stub. But with
> both CONFIG_X86_MCE_INTEL=y and CONFIG_X86_MCE_AMD=y you'll call this
> function on AMD systems.
> 
> Or is this OK because this will always return false on AMD?

That was my intention. I could use a static to only call
cmci_supported_hw() once (that in fact could be useful for users of
cmci_supported() that actually just want cmci_supported_hw() but I didn't
want to mix it with this change) if you prefer:

+bool intel_cmci_poll_lock(void)
{
	static bool supported = cmci_supported_hw();

	if (!supported)
		return false;

	spin_lock(&cmci_poll_lock);

	return true;
}

Still a call and comparison for everyone (although it's likely
intel_cmci_poll_{,un}lock() will be inlined). You prefer this or have
a different idea?

Thanks

-- 
Aristeu

