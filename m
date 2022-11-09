Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD8862320E
	for <lists+linux-edac@lfdr.de>; Wed,  9 Nov 2022 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKISIx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Nov 2022 13:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKISIw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Nov 2022 13:08:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94956193CE;
        Wed,  9 Nov 2022 10:08:51 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7e8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7e8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E15D91EC04A9;
        Wed,  9 Nov 2022 19:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668017330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PoJfs6m+Yo3Woc2HoBxAsDpuO65KE5P6Pwjr/1uhG40=;
        b=eYdKWovH7KXjaBI1+r15CkEsdLLh+UthXyX+LD1Gjdviup1NciZmN9EBAyiTgz2Tyny17G
        9CM5KcIk/8rrPY3vIr9wrOdECwQThJzCrvBH8skP0mbsuGCwXWVjW3ZEZpsDG0pxoqto4i
        At7+U/tXcB16+R62jg9LUw9JbnYfSTQ=
Date:   Wed, 9 Nov 2022 19:08:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Message-ID: <Y2vsrDMrGSW0ZPv6@zn.tnic>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
 <20221102070655.247511-3-sai.krishna.potthuri@amd.com>
 <Y2qiRoiYepte/R4W@zn.tnic>
 <BY5PR12MB4258CB67B70D71F107EC1E9DDB3E9@BY5PR12MB4258.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR12MB4258CB67B70D71F107EC1E9DDB3E9@BY5PR12MB4258.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 09, 2022 at 11:21:41AM +0000, Potthuri, Sai Krishna wrote:
> > On Wed, Nov 02, 2022 at 12:36:55PM +0530, Sai Krishna Potthuri wrote:
> > > Add EDAC support for Xilinx ZynqMP OCM Controller, this driver
> > 
> > So a while ago you said that this driver is for the on chip memory controller.
> > Is it possible for such a system to have another memory controller too for
> > which another EDAC driver gets loaded?
> > 
> > Because the EDAC core - at least on x86 - assumes that a single driver runs on
> > the system and I don't think I've ever had the case where we need multiple
> > drivers. And in such case to audit it for concurrency issues.
> > 
> > So I guess the question is, can a system have zynqmp_ocm_edac and say,
> > synopsys_edac or some other EDAC driver loaded at the same time?
> Yes, we have this scenario on Xilinx ZynqMP platform where we have both
> the drivers (zynqmp_ocm_edac - OCM Controller and synopsys_edac - DDR
> Memory Controller) probed at the same time.

Ok, Shubhrajyoti is on Cc too. I asked him the same question - what the
possible drivers configuration would be and he gave me:

Platform	| Drivers / Controllers	|
------------------------------------------------------------ 
 ZynqMP	| Synopsys and OCM	|
Versal		| DDRMC and OCM	|

The ZynqMP platform needs Synopsys which is, let's say for simplicity,
the main EDAC driver using edac_mc* etc.

Looking at the patches, Versal is similar and uses the same APIs.

OCM uses the edac_device* stuff so that should be ok. I say "should"
because, again, I haven't played with multiple EDAC drivers system. But
we'll see where that gets us.

Ok, I guess architecture-wise this looks ok, I'll review the drivers
later and we'll see.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
