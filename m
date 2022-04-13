Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50394FFAD1
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiDMQCH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Apr 2022 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiDMQCG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Apr 2022 12:02:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D7BC0F;
        Wed, 13 Apr 2022 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649865584; x=1681401584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IOuTa9C4rsATqdYchXRtejTgep66H9EsizaX+99YlhU=;
  b=cIfCKeaSBsEVu3uR8roEDnz3fosyM+MPaZhWOYB+ddqKtWn0UHHUDwXL
   /H1aS9Nd2qKBfSyz4QbC27TurefQQJbuWdaYw0A1iwobgWHaWh5fUxL1x
   CjUauUiq4w5BgyuLaZ+lICZ5Eivhg69dBA6KYrclEyU56MYtjbexetVg3
   hHgPQbiaDE53Uo90bmzx6MA+wFlhxE2zvSUVQsmNfhVt5XomXVpWL+e0t
   I4wRKrJ9wJvnEpUNAhxSmkP4VOeidup8roieIBdJTJ5PiwXrp5KQHOEvq
   BEee7ZkdDPCudrUMpTB9o484LtHwwVoP/iHD5KavVaysME4nk7Ct6cTzo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="325612082"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="325612082"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:59:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="590805753"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:59:43 -0700
Date:   Wed, 13 Apr 2022 08:59:41 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
 <YlakNe012hhErszh@zn.tnic>
 <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlbkCK9LU2KdXZUG@zn.tnic>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 13, 2022 at 04:54:00PM +0200, Borislav Petkov wrote:
> +	if (!mca_cfg.bootlog)
> +		m_fl = MCP_DONTLOG;
>  
> -/*
> - * Do a final check to see if there are any unused/RAZ banks.
> - *
> - * This must be done after the banks have been initialized and any quirks have
> - * been applied.
> - *
> - * Do not call this from any user-initiated flows, e.g. CPU hotplug or sysfs.
> - * Otherwise, a user who disables a bank will not be able to re-enable it
> - * without a system reboot.
> - */
> -static void __mcheck_cpu_check_banks(void)
> -{
> -	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> -	u64 msrval;
> -	int i;
> +	/*
> +	 * Log the machine checks left over from the previous reset. Log them
> +	 * only, do not start processing them. That will happen in mcheck_late_init()
> +	 * when all consumers have been registered on the notifier chain.
> +	 */
> +	bitmap_fill(all_banks, MAX_NR_BANKS);
> +	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);

If MCP_DONTLOG bit is set, then this does little. It will find
banks with valid records, NOT log them, clear them. But then we
loop and clear all banks.

So maybe do:

	if (mca_cfg.bootlog) {
		bitmap_fill(all_banks, MAX_NR_BANKS);
		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
	}


>  	__mcheck_cpu_init_clear_banks();

This will a new name to indicate that it is logging as well as init & clear.

Otherwise seeems fine.

-Tony
