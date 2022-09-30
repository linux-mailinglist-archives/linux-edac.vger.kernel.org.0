Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8975F0D89
	for <lists+linux-edac@lfdr.de>; Fri, 30 Sep 2022 16:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiI3O3o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 10:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiI3O3n (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 10:29:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C8F10FF4;
        Fri, 30 Sep 2022 07:29:40 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE75C1EC0628;
        Fri, 30 Sep 2022 16:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664548175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CYorfwR0HGBgsRUXFErd442wKe8z+K0hQS8ajZqruqc=;
        b=HHyyxuazb2ivTCxfuOguohE2/1mRjiDx63EcGsiM+m17T+bb+V4xQTCC3zxMkYWkUKpZDO
        YHXrWFW1JPzfS+CAl8dzTIkX+IsNgVbhMttcGo9hRrcvktFySFdAQ2UVGCuxvMreEgkFfa
        vOibY9wKaYCoEUevpdJbhTpG7nPQOCQ=
Date:   Fri, 30 Sep 2022 16:29:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 00/17] EDAC/mc/synopsys: Various fixes and
 cleanups
Message-ID: <Yzb9SyWh31rPCFJV@zn.tnic>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 30, 2022 at 02:26:55AM +0300, Serge Semin wrote:
> This patchset is a first one in the series created in the framework of
> my Baikal-T1 DDRC-related work:
> 
> [1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
> Link: ---you are looking at it---
> [2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
> Link: https://lore.kernel.org/linux-edac/20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru
> [3: In-progress] EDAC/synopsys: Add generic resources and Baikal-T1 support
> Link: https://lore.kernel.org/linux-edac/20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru
> 
> Note the patchsets above must be merged in the same order as they are
> placed in the list in order to prevent conflicts. Nothing prevents them
> from being reviewed synchronously though. Any tests are very welcome.
> Thanks in advance.

So I'd take a look slowly but I'd like for this driver's maintainer -
Michal Simek - to have a look first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
