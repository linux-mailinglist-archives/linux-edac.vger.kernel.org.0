Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8A5FCBAA
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 21:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJLToN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJLToK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 15:44:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571C78237;
        Wed, 12 Oct 2022 12:44:09 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44D151EC04E2;
        Wed, 12 Oct 2022 21:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665603844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0lkbuGF1cUc6jdBP5s8VreY4VLDUfdNY1Y4avB/6+Kc=;
        b=lIgRfrrcOA6GN8T/OhYp3mma1hONKAs0CScRwn7Z/L6qwqZS2gZKUkQrq4km+3dpjVHSp6
        R2C3FzXWdYJceWU9a7UQCk4NLVJb+AM//DMcIgYVYoev0MRASbBi4gc9fyhBPKbYbovpvw
        W0KAMcsrbzNZlBBON/8R/bY8FyUZt7o=
Date:   Wed, 12 Oct 2022 21:44:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
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
Subject: Re: [PATCH RESEND v3 14/17] EDAC/synopsys: Detach Zynq DDRC
 controller support
Message-ID: <Y0cZAGhUAzH6S9vI@zn.tnic>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-15-Sergey.Semin@baikalelectronics.ru>
 <YzcAV2I/rhILfhwR@zn.tnic>
 <20221006121740.ksugoodbagr45fky@mobilestation>
 <Yz7XVqeopgGVR7+3@zn.tnic>
 <20221008004224.owqbzbdctclua2hb@mobilestation>
 <Y0b5UAMXPWbDC6HK@zn.tnic>
 <20221012192743.ihy4nidkzxweqebj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012192743.ihy4nidkzxweqebj@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 12, 2022 at 10:27:43PM +0300, Serge Semin wrote:
> ... inter-device parts of the core. The registration procedure is
> protected by the mutex and RCU. So it seems as the EDAC core developer

Seems, schmeems. As I said already, EDAC has always had a single
chipset-specific driver. Period. So if one needs to run more than one
chipset-specific driver concurrently, then the whole code needs to be
audited because this hasn't been done before.

> If it has never needed to, then please explain why did you let the
> Synopsys EDAC driver being accepted like that then? 

I think I already did.

> In my case it's a single EDAC driver per-chip. There can be several
> DDR-controllers installed on the same SoC, but all of them of the same
> type (Synopsys DW uMCTL2 v2.61a).

Good.

I'll look at your patches as time allows.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
