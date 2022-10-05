Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474D85F575D
	for <lists+linux-edac@lfdr.de>; Wed,  5 Oct 2022 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJEPWE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Oct 2022 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiJEPWE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Oct 2022 11:22:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906F48E82
        for <linux-edac@vger.kernel.org>; Wed,  5 Oct 2022 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664983323; x=1696519323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KPCSxquOQf/e8YuO+dXRNc7Q1ss7JIRkLg20+rfAdTI=;
  b=g4RH/yIYyNGIZNOBr6/WU79YI8qpk8+SDLupqHM377OYqnVKJQ2FDt0p
   3XejLumLt+R4+SucrASEgLZqmlo0393CpN2O1jK8TfZDjLLnWz7VOdjrL
   mzZX3jCzwnr244Y7k8ULAuZd1H7uhag1czrJJ4HBFiHDIUziSCRZUSOQc
   ZAC1lXsOTagmgR5SD980LsbSWqxEIKhiBoZMmddN8NeoLQTe7+Lx/Sm2A
   Wwyz6agI8kSMI+rDXoqUdthZDdk2JyZfnUwEpuW7JONJQF7VdVn5EQG/m
   UOvv2S+gyYAFuKDWpOIyPrq6qhRT638iha9bngbWNFe1GWhKCSrhm3Yg5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304754637"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="304754637"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 08:21:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="655200786"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="655200786"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 08:21:55 -0700
Date:   Wed, 5 Oct 2022 08:21:53 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Christian Lorenz <Christian.Lorenz@gromeck.de>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: EDAC support for 'Rocket Lake'
Message-ID: <Yz2hEY9XFlNJudfw@agluck-desk3.sc.intel.com>
References: <1b2f0acd-c03a-9403-406e-3c7dea7b84f5@gromeck.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b2f0acd-c03a-9403-406e-3c7dea7b84f5@gromeck.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 05, 2022 at 02:13:13PM +0200, Christian Lorenz wrote:
> Hi,
> 
> we are using the EDAC interface on Linux for our internal ECC DIMM
> hardware monitoring.
> 
> With Sky Lake CPUs, the kernel driver in use is 'skx_edac'.
> 
> We have now received servers with the following CPUs, for which there
> does not seem to be kernel EDAC support:
> 
>   processor       : 11
>   vendor_id       : GenuineIntel
>   cpu family      : 6
>   model           : 167
>   model name      : Intel(R) Xeon(R) E-2386G CPU @ 3.50GHz
>   external link   : see [1] at the end of this mail
> 
> We have observed that there seems to be no EDAC support for this CPU,
> /sys/devices/system/edac is not populated, tools like edac-utils or
> rasdaemon do not function without it.
> 
> We have tested this with the same result on:
> 
>   - RHEL 8.6 -- kernel version 4.18.0-372
>   - AlmaLinux 8.6 -- kernel version 4.18.0-372
>   - RHEL 9.0 -- kernel version 5.14.0
> 
> According to documentation, the E-2386G codename is 'formerly Rocket Lake'.
> 
> Our question: Is there or will there be EDAC support for this 'Rocket Lake'
> Xeon E-23XX CPU?

Christian,

Historically Intel has provided EDAC drivers for the "big" Xeon
systems (formery "-E5" and "-E7", currently "-SP" Xeon models).

Support for the Xeon-E3 models had been provided by members of
the community. Most recent update for the ie31200_edac driver
to support Kaby Lake was from Jason Baron (added to this e-mail).

Jason: Are you looking at Rocket Lake?

-Tony
