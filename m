Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC487502DCA
	for <lists+linux-edac@lfdr.de>; Fri, 15 Apr 2022 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiDOQkf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Apr 2022 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355858AbiDOQke (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Apr 2022 12:40:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08691C681D;
        Fri, 15 Apr 2022 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650040685; x=1681576685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpehSo+Yn1FEBq+S4w2h8XLNT3XV05KHiZHdNjCxEY4=;
  b=c3Nmr33FdPxbk2KlvxU5eN50ApentVJYcf404rE0zFgcIhu/+jk1lAty
   eoQd9QnVNCXcmXAW2YeNrGtWbXUoalYm1Za9ha9Z4OevaMqBbQc35+Wcc
   zFbNXsHX9zS3Cre+HoaPLt8aJEp/D1kcH80N81eUnW4dCNhoHaJhdMR/f
   JUenNG3GkM42z333FrftWrq4GHTUcVku17lyk0oGb9+uHIFTiDoYSC184
   9o0DVuIqO2qBxiVUj7uPfQBewz/tTSxm5MMpeo26RQjaVibr/8IxDBPIG
   yqRGfeTUkQKiFO7O0I5+GVXNgZmb7wnOGEXPUbdcw/JZiX78L4HD2aQkz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243768343"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="243768343"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 09:38:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="646108786"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 09:37:59 -0700
Date:   Fri, 15 Apr 2022 09:37:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     bp@alien8.de,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YlmfZU2Bg5cRk07J@agluck-desk3.sc.intel.com>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
 <YlakNe012hhErszh@zn.tnic>
 <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
 <Ylb3/4oi6KAjdsJW@zn.tnic>
 <YlcnN2q9ducdvsUZ@yaz-ubuntu>
 <YlflJfyQR/j/eRkn@zn.tnic>
 <YlmHtlKABn9W0pu5@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlmHtlKABn9W0pu5@yaz-ubuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Apr 15, 2022 at 02:56:54PM +0000, Yazen Ghannam wrote:
> 3) OS, or optionally BIOS, polls MCA banks and logs any valid errors.
>    a) Since MCi_CTL, etc. are cleared due to reset, any errors detected are
>       from before the reset.

On Intel not quite any error. H/w can still log to a bank but MCi_STATUS.EN bit
will be zero. We've also had some BIOS code that did things that logged errors
and then left them for the OS to find during boot.

But this sequence does give more confidence that errors found in banks duing
boot are "old".

> I agree. The Intel SDM and AMD APM have the following procedure, in summary.
> 
> 1) Set MCG_CTL
> 2) Set MCi_CTL for all banks
> 3) Read MCi_STATUS and log valid errors.
> 4) Clear MCi_STATUS
> 5) Set CR4.MCE

Yes. That's what the pseudo-code in Intel SDM Example 15-1 says :-(
> 
> I don't know of a reason why STATUS needs to be cleared after MCi_CTL is set.
> The only thing I can think of is that enabling MCi_CTL may cause spurious info
> logged in MCi_STATUS, and that needs to be cleared out. I'm asking AMD folks
> about it.
> 
> Of course, this contradicts the flow I outlined above, and also the flow given
> in the AMD Processor Programming Reference (PPR). I wonder if the
> architectural documents have gotten stale compared to current guidelines. I'm
> asking about this too.

I will ask architects about this sequence too.

-Tony
