Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9786E6F1C05
	for <lists+linux-edac@lfdr.de>; Fri, 28 Apr 2023 17:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjD1Pz0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Apr 2023 11:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjD1PzZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Apr 2023 11:55:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D672D51
        for <linux-edac@vger.kernel.org>; Fri, 28 Apr 2023 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682697324; x=1714233324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vWQ6HuHvMfoZwIRbm0AfKIPepmhNW+hfiTMObR9wbaE=;
  b=UroVtqXHShCr87MZj5eA4ccxgjn55l9jqQc/MAm+/W2AO+2JZxo+CNF5
   RzxKaE6ukKflCQTvdFQK3CiD/LWztVewBiT92BKAvYD5Z6MDls/xUAmtz
   U3ssJhrWzlMplgesRCt0Fortoq2uvtpco6YNFyHmgZ83wmV13reM4DkGJ
   LQvqBuNhW9tOvKA380yhHjK0+7mL/v94C7/Rv+fwTKx+Tzqg/wQwYdrI7
   3Ktx39rkhf9ImaiDM+N2p4BwLngFXVnFK47cw3XOHhH8mA+6HGcUQY6Lz
   wFxrGw+3ea4H55SoHfKLyT0NqOrRWKnCTfYQKW04fV/kn8VmHghoAyf8D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="332100751"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="332100751"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="645184887"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="645184887"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:55:23 -0700
Date:   Fri, 28 Apr 2023 08:55:22 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     linux-edac@vger.kernel.org
Subject: Re: ECC DDR5 ram with i9-12950HX
Message-ID: <ZEvsamYDRi7wZr/b@agluck-desk3.sc.intel.com>
References: <b14a8fd2-4c11-1d76-f27d-e9d10c94ca9d@wetzel-home.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14a8fd2-4c11-1d76-f27d-e9d10c94ca9d@wetzel-home.de>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Apr 15, 2023 at 10:21:07PM +0200, Alexander Wetzel wrote:
> Hello,
> 
> I've problems getting ECC ram working in a Thinkpad P16.
> 
> The processor is a i9-12950HX with ECC ram but at least a 6.2.11 kernel is
> not detecting the memory controller:
> 
> # edac-util
> edac-util: Error: No memory controller data found.
> 
> The only reference to edac on kernel boot is that here:
> [    1.237414] EDAC MC: Ver: 3.0.0
> 
> For my understanding this here looks like the memory controller:
> 0000:00:14.2 RAM memory: Intel Corporation Alder Lake-S PCH Shared SRAM (rev
> 11)
> 
> But there is no driver for the device (8086:7aa7) in 6.2.11 I can find.
> I was assuming that igen6_edac is supporting Alder Lake CPUs but even when
> loaded manually it's not working...
> 
> Is there a way to get ECC working with linux? Are there any patches I could
> apply?

Alexander

You don't need an EDAC driver to turn on ECC. Your BIOS should have
done all the necessary memory controller and chipset magic to enable
ECC. So you should already be getting the extra reliability that
ECC memory provides.

EDAC driver serve two purposes:

1) To provide an accurate enumeration of which size/type DIMMs are in
each slot. This is required by large HPC clusters to check that the
DIMM configuration on every node of the thousands in their cluster
without having to physically open each machine.

2) When there are memory errors, translate the physical address recorded
by the CPU to the specific DIMM that was the source of the error (to
speed up diagnosis of the problem and fixing it in one try).

I'm sorry that there isn't an EDAC driver for your system. Most
of the effort here goes to EDAC for server systems.

-Tony
