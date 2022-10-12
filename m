Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBBF5FCC53
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 22:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiJLUpd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 16:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJLUpD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 16:45:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F0340568;
        Wed, 12 Oct 2022 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665607502; x=1697143502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eJJh0s3iMgt2kMH+jx8omA4PulLj6HDFZDLgshKql8s=;
  b=OOFZa/K5za/rwFe7aaZFPZFPVWWO9sUYj6tV4Q8p0p1lboqjhMmDMINQ
   z1GUPhIlYaihdGAucBkVaSx+qFVIynnJFCW6A5aXSxkls47ySHnkZeita
   qtCpT7k6ZctNpQR53n91myiamVPuTwem9zR0nnE6Ic4OmVe1Vhq6bKv/t
   A1X6h740ychTPLL/zXAt3OIlprRBFziOXe4gTyelqrIIfO9EnhWIL8IhA
   qYkUM4J18j5lWv92NTHwQMDjYGo9LfeTqUgPi00TidvS1wnlQZcJyRNRL
   npF8O6Rd2oogquM/wrs6l2bX/hhC7CQ8UGto+CiILznSWTd7UxW627Dq0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="302517887"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="302517887"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 13:45:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="604697827"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="604697827"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 13:45:01 -0700
Date:   Wed, 12 Oct 2022 13:44:59 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 13/17] EDAC/mc: Add MC unique index allocation
 procedure
Message-ID: <Y0cnS0uOtjmYL7fQ@agluck-desk3.sc.intel.com>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
 <Y0b5cq4evSg1nfb0@zn.tnic>
 <20221012200154.7fq3i7igbgkcy2mx@mobilestation>
 <Y0ckn5r3KN416Jeg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ckn5r3KN416Jeg@zn.tnic>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 12, 2022 at 10:33:35PM +0200, Borislav Petkov wrote:
> On Wed, Oct 12, 2022 at 11:01:54PM +0300, Serge Semin wrote:

> "A new special MC index is introduced here. It's defined by the
> EDAC_AUTO_MC_NUM macro with a value specifically chosen as the least
> probable value used for the real MC index. In case if the EDAC_AUTO_MC_NUM
> index is specified by the EDAC LLDD, the MC index will be either retrieved
> from the MC device OF-node alias index ("mc[:number:]") or automatically
> generated as the next-free MC index found by the ID allocation procedure."

Just curious.If I have an EDAC driver using EDAC_AUTO_MC_NUM, and I
unload and reload the driver a bunch of times. Do I get the same memory
controller numbers each reload, or get an ever increasing set each time?

-Tony
