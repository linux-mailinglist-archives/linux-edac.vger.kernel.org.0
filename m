Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0B73F123
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jun 2023 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjF0DFr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Jun 2023 23:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0DFq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Jun 2023 23:05:46 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C04BB
        for <linux-edac@vger.kernel.org>; Mon, 26 Jun 2023 20:05:42 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id B811753150; Mon, 26 Jun 2023 23:05:41 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 7C7CC529A0;
        Mon, 26 Jun 2023 23:05:23 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 57DC6220039; Mon, 26 Jun 2023 23:05:23 -0400 (EDT)
Date:   Mon, 26 Jun 2023 23:05:23 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [PATCH v2] mce: prevent concurrent polling of MCE events
Message-ID: <20230627030523.GY4090740@cathedrallabs.org>
References: <20230626203712.GW4090740@cathedrallabs.org>
 <ZJn8lbn5DzV0k+UR@agluck-desk3>
 <20230626223220.GX4090740@cathedrallabs.org>
 <SJ1PR11MB6083D9C80B75F32AAB52A939FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D9C80B75F32AAB52A939FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 26, 2023 at 10:52:01PM +0000, Luck, Tony wrote:
> topology_physical_package_id(cpu);
> 
> But it seems like that adds a lot of work to find out how many packages there
> are and initialize a spin lock for each one. Just to reduce what is likely to be
> quite low contention on a lock in a rare code path.

OK, I'll update the description then.

> > Or is this OK because this will always return false on AMD?
> >
> > That was my intention. I could use a static to only call
> > cmci_supported_hw() once (that in fact could be useful for users of
> > cmci_supported() that actually just want cmci_supported_hw() but I didn't
> > want to mix it with this change) if you prefer:
> 
> Maybe the function just needs a better name. Calling something
> with an "intel_cmci_" prefix from generic code is what's causing me
> to step back.
> 
> What if the code read:
> 
> 	if (mce_available(this_cpu_ptr(&cpu_info))) {
> +		bool locked = serialize_mc_bank_access();
>  		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> +		unserialize_mc_bank_access(locked);
> 
> As an intermediate functions. With core.c declaring:
> 
> static bool serialize_mc_bank_access(void)
> {
> 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> 		return false;
> 
> 	return intel_cmci_poll_lock();
> }
> 
> static void unserialize_mc_bank_access(bool locked)
> {
> 	if (!locked || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> 		return false;
> 
> 	return intel_cmci_poll_unlock();
> }
> 
> That would be in-lined and almost all disappear for CONFIG_X86_MCE_INTEL=n

Ah, I see. Makes sense. I'll update and send it tomorrow.

-- 
Aristeu

