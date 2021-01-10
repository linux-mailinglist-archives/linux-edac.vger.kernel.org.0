Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3C2F07F7
	for <lists+linux-edac@lfdr.de>; Sun, 10 Jan 2021 16:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAJPaa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Jan 2021 10:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJPaa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 Jan 2021 10:30:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB1C061786;
        Sun, 10 Jan 2021 07:29:50 -0800 (PST)
Received: from zn.tnic (p200300ec2f2419000d5a5c9aae6c8621.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:1900:d5a:5c9a:ae6c:8621])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 922F81EC0373;
        Sun, 10 Jan 2021 16:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610292587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J++e0pCFh0P0dhTSaHkFCyfIM/VgKJXc35RHr0WgpOc=;
        b=fxcnigIzAAR5OX06JfpOhVzxd4oiUTGch/KcqisPooB5r9ikOJ+0bT87cLpa01u1TaxEb7
        Dwm37cPwIHQd0EABQRzNSaAWImttz+NItxNjKX65dfWD4OgvUqSmSYNbPd+mGQRumKGO7/
        sx6Gt8dLwW3PZiW4Ojd/azQaMIfvLb8=
Date:   Sun, 10 Jan 2021 16:29:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, baicar@os.amperecomputing.com,
        saiprakash.ranjan@codeaurora.org, bjorn.andersson@linaro.org
Subject: Re: EDAC driver for ARMv8 RAS extension is being worked on
Message-ID: <20210110152943.GD22211@zn.tnic>
References: <20210110151149.GA15624@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210110151149.GA15624@thinkpad>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jan 10, 2021 at 08:41:49PM +0530, Manivannan Sadhasivam wrote:
> I've collected the feedback on those submissions and came up with the idea of
> a single "armv8_ras_edac" driver which will work for both Devicetree and ACPI

"ras" and "edac" both is too much. Just call it armv8_edac or arm64_edac or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
