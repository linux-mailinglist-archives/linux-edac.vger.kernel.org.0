Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959896C6FE0
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWSBC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 14:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCWSBB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 14:01:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A111158;
        Thu, 23 Mar 2023 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679594460; x=1711130460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v0ftauUrjiaR6pvZo2Poj+0io1VoaItaW/Z2mkjM9AU=;
  b=f3TU0B/yxJULIcy/UVJErCUfHQApoe/MqiIk9Q7jbqG5HMgqrOsGk6Pw
   LeNFAi7EXSo0g43Mwmlq3wG86NrbLjZd3O0pvzV/zkzzdI8cKuUIXEC+v
   jBruVpbkjEXblJ0hDaAcj9GDo0VGwLa7V/rrIZlRoVdxEjhrFrU79P70Q
   B2dna41R6tgJHPLz6BZeycB5rAw4oVn+IdDAmkEmYFe1iWkszML3b6HY0
   9whYv4sKziJlFa0qItoWNtlA/GIKS1VfF7vbP/umxGaELI7CRK4sbwETV
   yhnNCQgriONjMzHlCVRTh7MkglNTuNhp90tZbn/i4YMNyV2P9+feYXBb/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402156738"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="402156738"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856583768"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="856583768"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:00:56 -0700
Date:   Thu, 23 Mar 2023 11:00:55 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 3/5] x86/mce: Introduce mce_handle_storm() to deal
 with begin/end of storms
Message-ID: <ZByT1x+WFBU0jjRb@agluck-desk3.sc.intel.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
 <20230317172042.117201-4-tony.luck@intel.com>
 <ZBxurh8ZC39pzZ0a@yaz-khff.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxurh8ZC39pzZ0a@yaz-khff.amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 23, 2023 at 11:22:22AM -0400, Yazen Ghannam wrote:
> On Fri, Mar 17, 2023 at 10:20:40AM -0700, Tony Luck wrote:
> > +void mce_intel_handle_storm(int bank, bool on)
> > +{
> > +	if (on)
> > +		cmci_set_threshold(bank, cmci_threshold[bank]);
> > +	else
> > +		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
> 
> I think these conditions are reversed. When storm handling is 'on' we should
> use CMCI_STORM_THRESHOLD, and when off use the saved bank threshold.
> 
> > +}
> > +
> >  static void cmci_storm_begin(int bank)
> >  {
> >  	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
> > @@ -211,13 +219,13 @@ void track_cmci_storm(int bank, u64 status)
> >  		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
> >  			return;
> >  		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
> > -		cmci_set_threshold(bank, cmci_threshold[bank]);
> > +		mce_handle_storm(bank, true);
> 
> Should be 'false' when the storm subsides.
> 
> >  		cmci_storm_end(bank);
> >  	} else {
> >  		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
> >  			return;
> >  		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
> > -		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
> > +		mce_handle_storm(bank, false);
> 
> Should be 'true' when the storm starts.
> 
> >  		cmci_storm_begin(bank);
> >  	}
> >  }

There's a saying that two wrongs do not make a right (but three lefts do).

My code was working, but only because the second mistake cancelled
out the first.

Changing them both as you suggest (diff below) and the code still
works, and makes sense too!

Thanks

-Tony

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 74b560476424..c3e1bb790680 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -677,13 +677,13 @@ void track_cmci_storm(int bank, u64 status)
 		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
 			return;
 		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
-		mce_handle_storm(bank, true);
+		mce_handle_storm(bank, false);
 		cmci_storm_end(bank);
 	} else {
 		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
 			return;
 		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
-		mce_handle_storm(bank, false);
+		mce_handle_storm(bank, true);
 		cmci_storm_begin(bank);
 	}
 }
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 6cc9aa97c092..20c2143a68c1 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -134,9 +134,9 @@ static void cmci_set_threshold(int bank, int thresh)
 void mce_intel_handle_storm(int bank, bool on)
 {
 	if (on)
-		cmci_set_threshold(bank, cmci_threshold[bank]);
-	else
 		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+	else
+		cmci_set_threshold(bank, cmci_threshold[bank]);
 }
 
 /*
