Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8762E642913
	for <lists+linux-edac@lfdr.de>; Mon,  5 Dec 2022 14:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiLENQ3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Dec 2022 08:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiLENQ0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Dec 2022 08:16:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9824C11C0A;
        Mon,  5 Dec 2022 05:16:25 -0800 (PST)
Received: from zn.tnic (p200300ea9733e72f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97C481EC0531;
        Mon,  5 Dec 2022 14:16:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670246183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LebK9vlxoxcDxyhwhYhootxASRZx+GLX1jsVAwpEJA0=;
        b=cwR7RWJXOTlMHRiqIiOkofWod1zLKpp2yvb22/rbqlSzCUZBZimjsdqGDrBt2LpjyO9tUZ
        d3V2YPZzwSIriARxl9aDB7BUXKi6P9t44BJQl7KgvnwpysEOsx2EpaIQFU9V/yo8MrorfS
        /b1jp8OZSqoI5lx+l5T9sjaVGmg/jdE=
Date:   Mon, 5 Dec 2022 14:16:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
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
        "git (AMD-Xilinx)" <git@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Message-ID: <Y43vJECWJI99tc1x@zn.tnic>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
 <20221102070655.247511-3-sai.krishna.potthuri@amd.com>
 <Y4DbXaan258cZK+q@zn.tnic>
 <BY5PR12MB42582EA4A4ACEA56367544E6DB189@BY5PR12MB4258.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR12MB42582EA4A4ACEA56367544E6DB189@BY5PR12MB4258.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 05, 2022 at 10:20:11AM +0000, Potthuri, Sai Krishna wrote:
> As we communicated earlier for ZynqMP platform we have both Synopsys
> (for DDRMC) and zynqmp_ocm_edac (for OCM) drivers. Just to be clear
> about what this driver is targeted for, we used ocm as part of file
> name. Ok, zynqmp_edac.c looks fine, will update.

Yeah, we can always rename later, when another driver is needed. For
now, let's keep things simple.

> Ok, will update API documentation like below.
> echo <fault_injection count> > /sys/kernel/debug/edac/ff960000.memory-controller/inject_fault_count
							^^^^^^^^^^^^^^^^^^^^^^^^^^

Any particular reason this should not be called simply "mc0" or so?

At least this is how we call them on x86...

> echo <bit pos0> <bit pos1> > /sys/kernel/debug/edac/ff960000.memory-controller/inject_ue_bitpos

echo <bit0>,<bit1> > ...

I guess.

The ',' or ':' or some other separator which is not blank space would
make it more obvious that the two bits belong together and you won't
have to scan further for the second value but simply have a single
string which you split at the separator.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
