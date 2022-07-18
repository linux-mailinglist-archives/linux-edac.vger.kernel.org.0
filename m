Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D988578CF1
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jul 2022 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiGRVii (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jul 2022 17:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiGRVi2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Jul 2022 17:38:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E7032B88;
        Mon, 18 Jul 2022 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658180296; x=1689716296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4MDpTNrZVOEj5WSRtU1vgmEx0jrQ6p/FbPvAvILaUFE=;
  b=N9DWiOIlnSdAIIPoY3fOa8wC342sEMyVAP+6xkBnMVMZnRHMYryJV5Oc
   9lV1mhin83pNF3piyuCWrWUkE6VzrlUiIMv3KaFa5TKdLuafCtkkMQ9HY
   cxKIFbYB37ULDjHWbE/QfE1l99R/oymux7+Oy5UBTDmFFqXGeslyj6e/P
   9x+PYz2rGC9rdaYguRSumZ+QEn4972sX/w+6zR2l2oK8sSHLGQdbxFj9O
   nIfcQB4i7l31wJgVUwkt7SBDGcT/S3Wh88LKoDaNqbci5+/WKNXPHiQIf
   aeN2CxcTsovqM1WhoN2J7FooszJh3UQbDlyxeH1rFUK20qh4UjjHBgy19
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="372633079"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="372633079"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 14:37:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="572578880"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 14:37:54 -0700
Date:   Mon, 18 Jul 2022 14:37:53 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3] x86/mce: retrieve poison range from hardware
Message-ID: <YtXSsUmh5XcVXGa3@agluck-desk3.sc.intel.com>
References: <20220717234805.1084386-1-jane.chu@oracle.com>
 <41db4a4b17a848798e487a058a2bc237@intel.com>
 <62d5b13b2cf1a_9291929433@dwillia2-xfh.jf.intel.com.notmuch>
 <797a2b64ed0949b6905b3c3e8f049a23@intel.com>
 <5a92e418-9f50-8212-92a0-4ac39cefa9ef@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a92e418-9f50-8212-92a0-4ac39cefa9ef@oracle.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 18, 2022 at 09:11:33PM +0000, Jane Chu wrote:
> On 7/18/2022 12:22 PM, Luck, Tony wrote:
> >> It appears the kernel is trusting that ->physical_addr_mask is non-zero
> >> in other paths. So this is at least equally broken in the presence of a
> >> broken BIOS. The impact is potentially larger though with this change,
> >> so it might be a good follow-on patch to make sure that
> >> ->physical_addr_mask gets fixed up to a minimum mask value.
> > 
> > Agreed. Separate patch to sanitize early, so other kernel code can just use it.
> > 
> 
> Is it possible that with
>    if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> the ->physical_addr_mask is still untrustworthy?

The validation_bits just show which fields the BIOS *says* it filled in.
If a validation bit isn't set, then Linux should certainly ignore that
field. But if it is set, then Linux needs to decide whether to use the
value, or do a sanity check first.

-Tony
