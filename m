Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE85A8EF7
	for <lists+linux-edac@lfdr.de>; Thu,  1 Sep 2022 09:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiIAHAP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Sep 2022 03:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiIAHAA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Sep 2022 03:00:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2B612779;
        Wed, 31 Aug 2022 23:59:49 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C72F1EC0409;
        Thu,  1 Sep 2022 08:59:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662015583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mZKc6wmNg1eKrRkSc0tVYSpR5yDgCQZI71NJKLH/SRY=;
        b=DzUVkwEI1DtVr+EOHpO+sOLT2Iej7olVzcv9IKdxyOonl9C4m2P7qqv5eNpqofQATP+lMY
        o9rYL01guwcnuzUyQnJjUHI0FmTViAPgNqTlr7GQZITddfrsHVzNXlR/tvJktZ+dwTS5F+
        xxVBliA1IAcQRbWFYPIvVl6iN/TwliI=
Date:   Thu, 1 Sep 2022 08:59:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags
 definition
Message-ID: <YxBYWeIywtpblJ+h@nazgul.tnic>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220822190730.27277-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 22, 2022 at 10:07:22PM +0300, Serge Semin wrote:
> Currently the memory type macros are partly defined with the multiple
> spaces between the macro name and its definition. Let's replace the spaces
> with tabs as the kernel coding style requires.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  include/linux/edac.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
