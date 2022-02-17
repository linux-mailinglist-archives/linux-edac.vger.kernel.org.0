Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A02C4BA71B
	for <lists+linux-edac@lfdr.de>; Thu, 17 Feb 2022 18:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiBQR20 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Feb 2022 12:28:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiBQR2Z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Feb 2022 12:28:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52124CCF9;
        Thu, 17 Feb 2022 09:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645118891; x=1676654891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R3RAa0snBFN25UYoIFfCG9a4yp7xLIu18JkBJbhdzeQ=;
  b=FGRyJFo4LvwrxRM1ZhF12tPBiUfa2s0fiedcBnzAkFVmCD17POgzk61E
   0cmvjZCCHPFAlA4HXoYOFiQI+XC44Sq2aoahB5ewWgnqYTHo8ATRtkvMv
   y83zFePyIn8IjBL0ok2EDVratAbPa+Jt5SwCCJs2EhbGBubK45i9CwNa2
   XiWcbvI5lTIQ5n64Hb4TIAJPHYPaGGG/kxcPyUfvLBZ6uFUt39DXsL/PU
   nOBf6ldhb//WJYLBAqTEyPCGPcjqGlzLWrc73B8eEI4++rdSjKrXiqyKY
   PaiyomSLWHCX5FhDeE7JE6rjXuB+AuUBk1IK5qvL110lauc+vJBImdQgX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="314193666"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="314193666"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 09:28:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="530382515"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 09:28:10 -0800
Date:   Thu, 17 Feb 2022 09:28:09 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [RFC PATCH 1/2] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 17, 2022 at 08:16:08AM -0600, Smita Koralahalli wrote:
> Extend the logic of handling CMCI storms to AMD threshold interrupts.
> 
> Similar to CMCI storm handling, keep track of the rate at which each
> processor sees interrupts. If it exceeds threshold, disable interrupts
> and switch to polling of machine check banks.

I've been sitting on some partially done patches to re-work
storm handling for Intel ... which rips out all the existing
storm bits and replaces with something all new. I'll post the
2-part series as replies to this.

Two-part motivation:

1) Disabling CMCI globally is an overly big hammer (as you note
in your patches which to a more gentle per-CPU disable.

2) Intel signals some UNCORRECTED errors using CMCI (yes, turns
out that was a poorly chosen name given the later evolution of
the architecture). Since we don't want to miss those, the proposed
storm code just bumps the threshold to (almost) maximum to mitigate,
but not eliminate the storm. Note that the threshold only applies
to corrected errors.

-Tony
